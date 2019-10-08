module Freedom.Renderer
  ( Renderer
  , createRenderer
  , render
  ) where

import Prelude

import Control.Monad.Free.Trans (hoistFreeT, runFreeT)
import Control.Monad.Reader (ReaderT, ask, local, runReaderT, withReaderT)
import Data.Array (take, (!!), (:))
import Data.Maybe (Maybe(..), fromMaybe)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Console (error)
import Effect.Ref (Ref, modify, new, read, write)
import Freedom.Renderer.Diff (diff)
import Freedom.Renderer.Util (class Affable, class IsRenderEnv)
import Freedom.Renderer.Util as Util
import Freedom.Styler (Styler)
import Freedom.TransformF.Type (TransformF)
import Freedom.VNode (BridgeFoot, VElement(..), VNode(..), VRender, VRenderEnv(..), bridge, fromBridgeFoot, runVRender)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM.Element as E
import Web.DOM.Node (Node, appendChild, insertBefore, removeChild)
import Web.DOM.ParentNode (QuerySelector(..), querySelector)
import Web.DOM.Text as T
import Web.HTML (window)
import Web.HTML.HTMLDocument (toParentNode)
import Web.HTML.Window (document, requestAnimationFrame)

newtype Renderer f state = Renderer
  { container :: Maybe Node
  , view :: state -> VNode f state
  , renderFlagRef :: Ref Boolean
  , historyRef :: Ref (Array (VNode f state))
  , transformF :: TransformF f state
  , getState :: Effect state
  , styler :: Styler
  }

createRenderer
  :: forall f state
   . String
  -> (state -> VNode f state)
  -> TransformF f state
  -> Effect state
  -> Styler
  -> Effect (Renderer f state)
createRenderer selector view transformF getState styler = do
  parentNode <- toParentNode <$> (window >>= document)
  container <- map E.toNode <$> querySelector (QuerySelector selector) parentNode
  renderFlagRef <- new false
  historyRef <- new []
  pure $ Renderer
    { container
    , view
    , renderFlagRef
    , historyRef
    , transformF
    , getState
    , styler
    }

render
  :: forall f state
   . Functor (f state)
  => Renderer f state
  -> Effect Unit
render (Renderer r@{ transformF, getState, styler }) =
  case r.container of
    Nothing -> error "Received selector is not found."
    Just node -> do
      renderFlag <- read r.renderFlagRef
      when (not renderFlag) do
        write true r.renderFlagRef
        void $ window >>= requestAnimationFrame do
          write false r.renderFlagRef
          state <- getState
          history <- flip modify r.historyRef \h -> take 2 $ r.view state : h
          flip runReaderT (RenderEnv { transformF, styler, isSVG: false }) $ patch
            { current: history !! 1
            , next: history !! 0
            , realParentNode: node
            , realNodeIndex: 0
            , moveIndex: Nothing
            }

newtype RenderEnv f state = RenderEnv
  { styler :: Styler
  , transformF :: TransformF f state
  , isSVG :: Boolean
  }

newtype Operator f state = Operator
  { styler :: Styler
  , transformF :: TransformF f state
  , isSVG :: Boolean
  , operationRef :: Ref (Array (Array (VNode f state)))
  , originChildren :: Array (VNode f state)
  }

type Render f state a = ReaderT (RenderEnv f state) Effect a

type OperativeRender f state a = ReaderT (Operator f state) Effect a

type PatchArgs f state =
  { current :: Maybe (VNode f state)
  , next :: Maybe (VNode f state)
  , realParentNode :: Node
  , realNodeIndex :: Int
  , moveIndex :: Maybe Int
  }

patch
  :: forall f state
   . Functor (f state)
  => PatchArgs f state
  -> Render f state Unit
patch { current, next, realParentNode, realNodeIndex, moveIndex } =
  case current, next of
    Nothing, Nothing -> pure unit

    Nothing, Just (VNode _ next') -> switchContextIfSVG next' do
      newNode <- operateCreating next'
      maybeNode <- liftEffect $ Util.childNode realNodeIndex realParentNode
      liftEffect do
        void case maybeNode of
          Nothing -> appendChild newNode realParentNode
          Just node -> insertBefore newNode node realParentNode
      runDidCreate newNode next'

    Just (VNode _ current'), Nothing -> switchContextIfSVG current' do
      maybeNode <- liftEffect $ Util.childNode realNodeIndex realParentNode
      case maybeNode of
        Nothing -> pure unit
        Just node -> do
          operateDeleting node current'
          liftEffect $ void $ removeChild node realParentNode
          runDidDelete node current'

    Just (VNode _ current'), Just (VNode _ next') -> switchContextIfSVG next' do
      maybeNode <- liftEffect $ Util.childNode realNodeIndex realParentNode
      case maybeNode of
        Nothing -> pure unit
        Just node -> do
          case moveIndex of
            Nothing -> pure unit
            Just mi -> liftEffect do
              let adjustedIdx = if realNodeIndex < mi then mi + 1 else mi
              maybeAfterNode <- Util.childNode adjustedIdx realParentNode
              void case maybeAfterNode of
                Nothing -> appendChild node realParentNode
                Just afterNode -> insertBefore node afterNode realParentNode
          operateUpdating node current' next'

switchContextIfSVG
  :: forall f state
   . VElement f state
  -> Render f state Unit
  -> Render f state Unit
switchContextIfSVG (Text _) m = m
switchContextIfSVG (Element element) m =
  local (changeSVGContext $ element.tag == "svg") m
switchContextIfSVG (OperativeElement _ element) m =
  local (changeSVGContext $ element.tag == "svg") m

changeSVGContext :: forall f state. Boolean -> RenderEnv f state -> RenderEnv f state
changeSVGContext isSVG (RenderEnv r) =
  if r.isSVG
    then RenderEnv r
    else RenderEnv r { isSVG = isSVG }

operateCreating
  :: forall f state
   . Functor (f state)
  => VElement f state
  -> Render f state Node
operateCreating (Text text) =
  liftEffect $ Util.createText_ text >>= T.toNode >>> pure
operateCreating (OperativeElement bf element) = do
  operator <- genOperator bf element.children
  withReaderT (const operator) $ E.toNode <$> Util.createElement_ element
operateCreating (Element element) = do
  el <- Util.createElement_ element
  let node = E.toNode el
  diff patch node [] element.children
  pure node

runDidCreate
  :: forall f state
   . Functor (f state)
  => Node
  -> VElement f state
  -> Render f state Unit
runDidCreate node (OperativeElement bf element) = do
  operator <- genOperator bf element.children
  withReaderT (const operator) $ Util.runLifecycle $ element.didCreate $ unsafeCoerce node
runDidCreate node (Element element) =
  Util.runLifecycle $ element.didCreate $ unsafeCoerce node
runDidCreate _ _ = pure unit

operateDeleting
  :: forall f state
   . Functor (f state)
  => Node
  -> VElement f state
  -> Render f state Unit
operateDeleting node (Element element) =
  diff patch node element.children []
operateDeleting _ _ = pure unit

runDidDelete
  :: forall f state
   . Functor (f state)
  => Node
  -> VElement f state
  -> Render f state Unit
runDidDelete node (OperativeElement bf element) = do
  operator <- genOperator bf []
  withReaderT (const operator) $ Util.runLifecycle $ element.didDelete $ unsafeCoerce node
runDidDelete node (Element element) =
  Util.runLifecycle $ element.didDelete $ unsafeCoerce node
runDidDelete _ _ = pure unit

operateUpdating
  :: forall f state
   . Functor (f state)
  => Node
  -> VElement f state
  -> VElement f state
  -> Render f state Unit
operateUpdating node (Text c) (Text n) =
  liftEffect $ Util.updateText_ c n node
operateUpdating node (OperativeElement cbf c) (OperativeElement nbf n) = do
  liftEffect $ bridge cbf nbf
  operator <- genOperator nbf n.children
  withReaderT (const operator) do
    let el = unsafeCoerce node
    Util.updateElement_ c n el
    Util.runLifecycle $ n.didUpdate el
operateUpdating node (Element c) (Element n) = do
  let el = unsafeCoerce node
  Util.updateElement_ c n el
  diff patch node c.children n.children
  Util.runLifecycle $ n.didUpdate el
operateUpdating _ _ _ = pure unit

genOperator
  :: forall f state
   . BridgeFoot f state
  -> Array (VNode f state)
  -> Render f state (Operator f state)
genOperator bf originChildren = do
  operationRef <- liftEffect $ fromBridgeFoot bf
  RenderEnv { transformF, styler, isSVG } <- ask
  pure $ Operator
    { transformF
    , styler
    , isSVG
    , operationRef
    , originChildren
    }

instance affableAff :: Functor (f state) => Affable (RenderEnv f state) f state Aff where
  toAff (RenderEnv r) = runFreeT r.transformF

instance affableVRender :: Functor (f state) => Affable (Operator f state) f state (VRender f state) where
  toAff (Operator r) = runFreeT r.transformF <<< hoistFreeT nt
    where
      getOriginChildren = pure r.originChildren
      getLatestRenderedChildren =
        fromMaybe [] <$> (_ !! 0) <$> read r.operationRef
      renderChildren node children = do
        history <- flip modify r.operationRef \h -> take 2 $ children : h
        flip runReaderT renderEnv do
          diff patch node
            (fromMaybe [] $ history !! 1)
            (fromMaybe [] $ history !! 0)

      renderEnv = RenderEnv
        { transformF: r.transformF
        , styler: r.styler
        , isSVG: r.isSVG
        }

      nt :: VRender f state ~> Aff
      nt = flip runVRender $ VRenderEnv
        { getOriginChildren
        , getLatestRenderedChildren
        , renderChildren
        }

instance isRenderEnvRenderEnv :: IsRenderEnv (RenderEnv f state) where
  toStyler (RenderEnv r) = r.styler
  toIsSVG (RenderEnv r) = r.isSVG

instance isRenderEnvOperator :: IsRenderEnv (Operator f state) where
  toStyler (Operator r) = r.styler
  toIsSVG (Operator r) = r.isSVG

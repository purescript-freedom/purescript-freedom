module Freedom.UI
  ( Subscription
  , Renderer
  , Operation
  , VNode
  , keyed
  , renderingManually
  , t
  , tag
  , kids
  , prop
  , handle
  , didCreate
  , didUpdate
  , didDelete
  , UI
  , createUI
  , renderUI
  ) where

import Prelude

import Control.Monad.Reader (ReaderT, ask, local, runReaderT)
import Control.Safely as Safe
import Data.Array (filter, notElem, snoc, take, union, (!!), (:))
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Nullable (null)
import Data.String as S
import Data.String.Regex (Regex, replace, test)
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.Traversable (sequence)
import Data.Tuple (Tuple(..), fst, uncurry)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (error)
import Effect.Ref (Ref, modify, new, read, write)
import Foreign (Foreign, unsafeToForeign)
import Foreign.Object (Object)
import Foreign.Object as Object
import Freedom.Store (Query)
import Freedom.Styler (Styler, registerStyle)
import Freedom.UI.Class (class HasKey)
import Freedom.UI.Diff (diff)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM.DOMTokenList as DTL
import Web.DOM.Document (Document, createElement, createElementNS, createTextNode)
import Web.DOM.Element (Element)
import Web.DOM.Element as E
import Web.DOM.Node (Node, appendChild, childNodes, insertBefore, removeChild, setTextContent)
import Web.DOM.NodeList (item)
import Web.DOM.ParentNode (QuerySelector(..), querySelector)
import Web.DOM.Text (Text)
import Web.DOM.Text as T
import Web.Event.Event (Event)
import Web.Event.EventTarget (eventListener)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toDocument, toParentNode)
import Web.HTML.HTMLElement (classList, fromElement)
import Web.HTML.Window (document, requestAnimationFrame)



-- User interfaces

-- | The type of subscription.
-- |
-- | Hooks of events that aren't related a specific node like window events, timers and so on.
type Subscription state = Query state -> Effect Unit

-- | The type of rendering operations.
-- |
-- | - `getLatestRenderedChildren`: Get children already rendered.
-- | - `renderChildren`: Patch passed children with previous rendered children.
type Renderer state =
  { getLatestRenderedChildren :: Effect (Array (VNode state))
  , renderChildren :: Node -> Array (VNode state) -> Effect Unit
  }

-- | The type of operations.
-- |
-- | - `query`: Operations for application state.
-- | - `renderer`: Operations for rendering.
type Operation state =
  { query :: Query state
  , renderer :: Renderer state
  }

type VObject state =
  { tagName :: String
  , props :: Object String
  , handlers :: Object (Event -> Operation state -> Effect Unit)
  , children :: Array (VNode state)
  , didCreate :: Element -> Operation state -> Effect Unit
  , didUpdate :: Element -> Operation state -> Effect Unit
  , didDelete :: Element -> Operation state -> Effect Unit
  }

data VElement state
  = Text String
  | Element Boolean (VObject state)

-- | The type of virtual node.
data VNode state = VNode String (VElement state)

instance hasKeyVNode :: HasKey (VNode state) where
  getKey idx (VNode k velement) =
    case velement of
      Text _ ->
        "text_" <> identifier
      Element isManual { tagName } ->
        "element_" <> show isManual <> "_" <> tagName <> "_" <> identifier
    where
      identifier = if k == "" then show idx else k

-- | Add a key to `VNode`.
keyed :: forall state. String -> VNode state -> VNode state
keyed k (VNode _ velement) = VNode k velement

-- | If you want to render children manually, you should use this.
renderingManually :: forall state. VNode state -> VNode state
renderingManually (VNode k (Element _ vobject)) =
  VNode k $ Element true vobject
renderingManually vnode = vnode

-- | Create a `VNode` of text.
t :: forall state. String -> VNode state
t = VNode "" <<< Text

-- | Create a `VNode` of specified tag element.
tag :: forall state. String -> VNode state
tag tagName = VNode "" $ Element false
  { tagName
  , props: Object.empty
  , handlers: Object.empty
  , children: []
  , didCreate: const $ const $ pure unit
  , didUpdate: const $ const $ pure unit
  , didDelete: const $ const $ pure unit
  }

-- | Add children.
kids
  :: forall state
   . Array (VNode state)
  -> VNode state
  -> VNode state
kids children = mapVObject _ { children = children }

-- | Add a property.
prop
  :: forall state
   . String
  -> String
  -> VNode state
  -> VNode state
prop name val = mapVObject \vobject ->
  vobject { props = Object.insert name val vobject.props }

-- | Bind an event handler.
handle
  :: forall state
   . String
  -> (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
handle name h = mapVObject \vobject ->
  vobject { handlers = Object.insert name h vobject.handlers }

-- | Bind `didCreate` lifecycle.
didCreate
  :: forall state
   . (Element -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
didCreate h = mapVObject _ { didCreate = h }

-- | Bind `didUpdate` lifecycle.
didUpdate
  :: forall state
   . (Element -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
didUpdate h = mapVObject _ { didUpdate = h }

-- | Bind `didDelete` lifecycle.
didDelete
  :: forall state
   . (Element -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
didDelete h = mapVObject _ { didDelete = h }

mapVObject
  :: forall state
   . (VObject state -> VObject state)
  -> VNode state
  -> VNode state
mapVObject updator (VNode k velement) =
  VNode k case velement of
    Element isManual vobject ->
      Element isManual $ updator vobject
    text -> text



-- For rendering history bridging

type History state =
  Array (Array (Tuple (VNode state) (HistoryRef state)))

newtype HistoryRef state = HistoryRef (Ref (Ref (History state)))

newHistoryRef :: forall state. Effect (HistoryRef state)
newHistoryRef = HistoryRef <$> (new [] >>= new)

addToHistoryRef
  :: forall state
   . Array (Tuple (VNode state) (HistoryRef state))
  -> HistoryRef state
  -> Effect (History state)
addToHistoryRef result (HistoryRef ref) =
  read ref >>= modify \h -> take 2 $ result : h

readHistoryRef
  :: forall state
   . HistoryRef state
  -> Effect (History state)
readHistoryRef (HistoryRef ref) = read ref >>= read

bridgeHistoryRef
  :: forall state
   . HistoryRef state
  -> HistoryRef state
  -> Effect Unit
bridgeHistoryRef (HistoryRef from) (HistoryRef to) =
  read from >>= flip write to



-- For UI constructor

-- | This is for internal. Do not use it.
newtype UI state = UI
  { container :: Maybe Node
  , view :: state -> VNode state
  , renderFlagRef :: Ref Boolean
  , historyRef :: HistoryRef state
  , query :: Query state
  , styler :: Styler
  }

-- | This is for internal. Do not use it.
createUI
  :: forall state
   . String
  -> (state -> VNode state)
  -> Query state
  -> Styler
  -> Effect (UI state)
createUI selector view query styler = do
  parentNode <- toParentNode <$> (window >>= document)
  container <- map E.toNode <$> querySelector (QuerySelector selector) parentNode
  renderFlagRef <- new false
  historyRef <- newHistoryRef
  pure $ UI
    { container
    , view
    , renderFlagRef
    , historyRef
    , query
    , styler
    }

-- | This is for internal. Do not use it.
renderUI
  :: forall state
   . UI state
  -> Effect Unit
renderUI (UI r@{ historyRef, query, styler }) =
  case r.container of
    Nothing -> error "Received selector is not found."
    Just node -> do
      renderFlag <- read r.renderFlagRef
      when (not renderFlag) do
        write true r.renderFlagRef
        void $ window >>= requestAnimationFrame do
          write false r.renderFlagRef
          state <- query.select
          grandHistoryRef <- newHistoryRef
          history <-
            addToHistoryRef
              [ Tuple (r.view state) grandHistoryRef ]
              historyRef
          flip runReaderT { historyRef, query, styler, isSVG: false }
            $ diff patch node
                (fromMaybe [] $ history !! 1)
                (fromMaybe [] $ history !! 0)



-- For rendering process

type UIContext state =
  { historyRef :: HistoryRef state
  , query :: Query state
  , styler :: Styler
  , isSVG :: Boolean
  }

type PatchArgs state =
  { current :: Maybe (Tuple (VNode state) (HistoryRef state))
  , next :: Maybe (Tuple (VNode state) (HistoryRef state))
  , realParentNode :: Node
  , realNodeIndex :: Int
  , moveIndex :: Maybe Int
  }

patch
  :: forall state
   . PatchArgs state
  -> ReaderT (UIContext state) Effect Unit
patch { current, next, realParentNode, realNodeIndex, moveIndex } =
  case current, next of
    Nothing, Nothing -> pure unit

    Nothing, Just (Tuple (VNode _ next') nextHistoryRef) ->
      switchContext nextHistoryRef next' do
        newNode <- operateCreating next'
        maybeNode <- liftEffect $ childNode realNodeIndex realParentNode
        liftEffect do
          void case maybeNode of
            Nothing -> appendChild newNode realParentNode
            Just node -> insertBefore newNode node realParentNode
        runDidCreate newNode next'

    Just (Tuple (VNode _ current') currentHistoryRef), Nothing ->
      switchContext currentHistoryRef current' do
        maybeNode <- liftEffect $ childNode realNodeIndex realParentNode
        case maybeNode of
          Nothing -> pure unit
          Just node -> do
            operateDeleting node current'
            liftEffect $ void $ removeChild node realParentNode
            runDidDelete node current'

    Just (Tuple (VNode _ current') currentHistoryRef), Just (Tuple (VNode _ next') nextHistoryRef) -> do
      liftEffect $ bridgeHistoryRef currentHistoryRef nextHistoryRef
      switchContext nextHistoryRef next' do
        maybeNode <- liftEffect $ childNode realNodeIndex realParentNode
        case maybeNode of
          Nothing -> pure unit
          Just node -> do
            case moveIndex of
              Nothing -> pure unit
              Just mi -> liftEffect do
                let adjustedIdx = if realNodeIndex < mi then mi + 1 else mi
                maybeAfterNode <- childNode adjustedIdx realParentNode
                void case maybeAfterNode of
                  Nothing -> appendChild node realParentNode
                  Just afterNode -> insertBefore node afterNode realParentNode
            operateUpdating node current' next'

switchContext
  :: forall state
   . HistoryRef state
  -> VElement state
  -> ReaderT (UIContext state) Effect Unit
  -> ReaderT (UIContext state) Effect Unit
switchContext _ (Text _) m = m
switchContext historyRef (Element _ vobject) m =
  flip local m
    $ (changeSVGContext $ vobject.tagName == "svg")
    >>> _ { historyRef = historyRef }

changeSVGContext
  :: forall state
   . Boolean
  -> UIContext state
  -> UIContext state
changeSVGContext isSVG ctx =
  if ctx.isSVG then ctx else ctx { isSVG = isSVG }

operateCreating
  :: forall state
   . VElement state
  -> ReaderT (UIContext state) Effect Node
operateCreating (Text text) =
  liftEffect $ createText_ text >>= T.toNode >>> pure
operateCreating (Element isManual vobject) = do
  el <- createElement_ vobject
  let node = E.toNode el
  when (not isManual) do
    { renderer } <- ask <#> toOperation
    liftEffect $ renderer.renderChildren node vobject.children
  pure node

runDidCreate
  :: forall state
   . Node
  -> VElement state
  -> ReaderT (UIContext state) Effect Unit
runDidCreate node (Element _ vobject) =
  runLifecycle $ vobject.didCreate $ unsafeCoerce node
runDidCreate _ _ = pure unit

operateDeleting
  :: forall state
   . Node
  -> VElement state
  -> ReaderT (UIContext state) Effect Unit
operateDeleting node (Element isManual _) =
  when (not isManual) do
    { renderer } <- ask <#> toOperation
    liftEffect $ renderer.renderChildren node []
operateDeleting _ _ = pure unit

runDidDelete
  :: forall state
   . Node
  -> VElement state
  -> ReaderT (UIContext state) Effect Unit
runDidDelete node (Element _ vobject) =
  runLifecycle $ vobject.didDelete $ unsafeCoerce node
runDidDelete _ _ = pure unit

operateUpdating
  :: forall state
   . Node
  -> VElement state
  -> VElement state
  -> ReaderT (UIContext state) Effect Unit
operateUpdating node (Text c) (Text n) =
  liftEffect $ updateText_ c n node
operateUpdating node (Element _ c) (Element isManual n) = do
  let el = unsafeCoerce node
  updateElement_ c n el
  when (not isManual) do
    { renderer } <- ask <#> toOperation
    liftEffect $ renderer.renderChildren node n.children
  runLifecycle $ n.didUpdate el
operateUpdating _ _ _ = pure unit

toOperation :: forall state. UIContext state -> Operation state
toOperation ctx =
  { query: ctx.query
  , renderer:
      { getLatestRenderedChildren
      , renderChildren
      }
  }
  where
    getLatestRenderedChildren =
      map fst <$> fromMaybe [] <$> (_ !! 0) <$> readHistoryRef ctx.historyRef
    renderChildren node children = do
      result <- sequence $ children <#> \c -> Tuple c <$> newHistoryRef
      history <- addToHistoryRef result ctx.historyRef
      flip runReaderT ctx do
        diff patch node
          (fromMaybe [] $ history !! 1)
          (fromMaybe [] $ history !! 0)



-- Rendering utilities

childNode :: Int -> Node -> Effect (Maybe Node)
childNode i node = childNodes node >>= item i

createText_ :: String -> Effect Text
createText_ text = doc >>= createTextNode text

updateText_ :: String -> String -> Node -> Effect Unit
updateText_ current next node =
  when (current /= next) $ setTextContent next node

createElement_
  :: forall state
   . VObject state
  -> ReaderT (UIContext state) Effect Element
createElement_ { tagName, props, handlers } = do
  { isSVG } <- ask
  el <- liftEffect if isSVG
    then doc >>= createElementNS svgNameSpace tagName
    else doc >>= createElement tagName
  let props' :: Array (Tuple String String)
      props' = Object.toUnfoldable props
      handlers' :: Array (Tuple String (Event -> Operation state -> Effect Unit))
      handlers' = Object.toUnfoldable handlers
  Safe.for_ props' $ uncurry \name val -> setProp name val el
  Safe.for_ handlers' $ uncurry \name h -> setHandler name h el
  pure el

updateElement_
  :: forall state
   . VObject state
  -> VObject state
  -> Element
  -> ReaderT (UIContext state) Effect Unit
updateElement_ current next el = do
  updateProps current.props next.props el
  updateHandlers current.handlers next.handlers el

runLifecycle
  :: forall state
   . (Operation state -> Effect Unit)
  -> ReaderT (UIContext state) Effect Unit
runLifecycle lifecycle = do
  ctx <- ask
  liftEffect $ lifecycle $ toOperation ctx

removeHandler :: String -> Element -> Effect Unit
removeHandler name = setForeign name (unsafeToForeign null)

setHandler
  :: forall state
   . String
  -> (Event -> Operation state -> Effect Unit)
  -> Element
  -> ReaderT (UIContext state) Effect Unit
setHandler name h el = do
  ctx <- ask
  listener <- liftEffect $ eventListener $ flip h $ toOperation ctx
  liftEffect $ setForeign name (unsafeToForeign listener) el

updateHandlers
  :: forall state
   . Object (Event -> Operation state -> Effect Unit)
  -> Object (Event -> Operation state -> Effect Unit)
  -> Element
  -> ReaderT (UIContext state) Effect Unit
updateHandlers currents nexts el =
  Safe.for_ names updateByName
  where
    names = union (Object.keys currents) (Object.keys nexts)
    updateByName name =
      case Object.lookup name currents, Object.lookup name nexts of
        Nothing, Nothing -> pure unit
        Just _, Nothing -> liftEffect $ removeHandler name el
        _, Just h -> setHandler name h el

removeProp
  :: forall state
   . String
  -> String
  -> Element
  -> ReaderT (UIContext state) Effect Unit
removeProp "css" _ el = do
  maybeClassName <- liftEffect $ E.getAttribute stylerAttributeName el
  case maybeClassName of
    Nothing -> pure unit
    Just generatedClassName ->
      removeClass generatedClassName el
removeProp "class" val el = removeProp "className" val el
removeProp "className" val el =
  Safe.for_ (classNames val) $ flip removeClass el
removeProp "style" _ el = liftEffect $ E.removeAttribute "style" el
removeProp "list" _ el = liftEffect $ E.removeAttribute "list" el
removeProp "form" _ el = liftEffect $ E.removeAttribute "form" el
removeProp "dropzone" _ el = liftEffect $ E.removeAttribute "dropzone" el
removeProp name _ el = do
  { isSVG } <- ask
  liftEffect if isSVG && hasXlinkPrefix name
    then
      removeAttributeNS xlinkNameSpace (replace xlinkRegex "" name) el
    else do
      when (isProperty name el && not isSVG)
        $ setForeign name (unsafeToForeign "") el
      E.removeAttribute name el

setProp
  :: forall state
   . String
  -> String
  -> Element
  -> ReaderT (UIContext state) Effect Unit
setProp "css" val el = do
  { styler } <- ask
  generatedClassName <- liftEffect $ registerStyle val styler
  removeProp "css" "dummyVal" el
  liftEffect $ E.setAttribute stylerAttributeName generatedClassName el
  addClass generatedClassName el
setProp "class" val el = setProp "className" val el
setProp "className" val el =
  Safe.for_ (classNames val) $ flip addClass el
setProp "style" val el =
  liftEffect $ E.setAttribute "style" val el
setProp "list" val el =
  liftEffect $ E.setAttribute "list" val el
setProp "form" val el =
  liftEffect $ E.setAttribute "form" val el
setProp "dropzone" val el =
  liftEffect $ E.setAttribute "dropzone" val el
setProp name val el = do
  { isSVG } <- ask
  liftEffect if isProperty name el && not isSVG
    then
      if isBoolean name el
        then setForeign name (unsafeToForeign $ not $ val == "false") el
        else setForeign name (unsafeToForeign val) el
    else
      if isSVG && hasXlinkPrefix name
        then
          setAttributeNS xlinkNameSpace (replace xlinkRegex "" name) val el
        else
          E.setAttribute name val el

updateProps
  :: forall state
   . Object String
  -> Object String
  -> Element
  -> ReaderT (UIContext state) Effect Unit
updateProps currents nexts el =
  Safe.for_ names updateByName
  where
    names = union (Object.keys currents) (Object.keys nexts)
    updateByName name =
      case Object.lookup name currents, Object.lookup name nexts of
        Nothing, Nothing -> pure unit
        Just c, Nothing -> removeProp name c el
        Nothing, Just n -> setProp name n el
        Just c, Just n
          | c == n -> pure unit
          | notElem name [ "class", "className" ] -> setProp name n el
          | otherwise ->
              let currentClasses = classNames c
                  nextClasses = classNames n
                  removeTargets = filter (flip notElem nextClasses) currentClasses
                  addTargets = filter (flip notElem currentClasses) nextClasses
               in do
                  removeProp name (S.joinWith " " removeTargets) el
                  setProp name (S.joinWith " " addTargets) el

addClass
  :: forall state
   . String
  -> Element
  -> ReaderT (UIContext state) Effect Unit
addClass val el = do
  { isSVG } <- ask
  liftEffect if isSVG then addSVGContext else add
  where
    add =
      case fromElement el of
        Nothing -> pure unit
        Just html ->
          classList html >>= flip DTL.add val
    addSVGContext = do
      maybeClassName <- E.getAttribute "class" el
      flip (E.setAttribute "class") el case maybeClassName of
        Nothing -> val
        Just current ->
          S.joinWith " " $ snoc (classNames current) val

removeClass
  :: forall state
   . String
  -> Element
  -> ReaderT (UIContext state) Effect Unit
removeClass val el = do
  { isSVG } <- ask
  liftEffect if isSVG then removeSVGContext else remove
  where
    remove =
      case fromElement el of
        Nothing -> pure unit
        Just html ->
          classList html >>= flip DTL.remove val
    removeSVGContext = do
      maybeClassName <- E.getAttribute "class" el
      case maybeClassName of
        Nothing -> pure unit
        Just current ->
          flip (E.setAttribute "class") el
            $ S.joinWith " " $ filter (_ /= val) $ classNames current

classNames :: String -> Array String
classNames val = filter (not <<< S.null) $ S.split (S.Pattern " ") val

hasXlinkPrefix :: String -> Boolean
hasXlinkPrefix = test xlinkRegex

xlinkRegex :: Regex
xlinkRegex = unsafeRegex "^xlink:" noFlags

doc :: Effect Document
doc = window >>= document >>= toDocument >>> pure

svgNameSpace :: Maybe String
svgNameSpace = Just "http://www.w3.org/2000/svg"

xlinkNameSpace :: String
xlinkNameSpace = "http://www.w3.org/1999/xlink"

stylerAttributeName :: String
stylerAttributeName = "data-freedom-styler-class"

foreign import setForeign :: String -> Foreign -> Element -> Effect Unit

foreign import setAttributeNS :: String -> String -> String -> Element -> Effect Unit

foreign import removeAttributeNS :: String -> String -> Element -> Effect Unit

foreign import isProperty :: String -> Element -> Boolean

foreign import isBoolean :: String -> Element -> Boolean

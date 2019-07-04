module Freedom.Renderer.Util
  ( class IsRenderEnv
  , toStyler
  , toIsSVG
  , class Affable
  , toAff
  , childNode
  , createText_
  , updateText_
  , createElement_
  , updateElement_
  , runLifecycle
  ) where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Control.Monad.Reader (ReaderT, ask)
import Control.Monad.Rec.Class (class MonadRec)
import Control.Safely as Safe
import Data.Array (filter, notElem, snoc, union)
import Data.Maybe (Maybe(..))
import Data.Nullable (null)
import Data.String.Common as S
import Data.String.Pattern (Pattern(..))
import Data.String.Regex (Regex, replace, test)
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.Tuple (Tuple, uncurry)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Foreign (Foreign, unsafeToForeign)
import Foreign.Object (Object)
import Foreign.Object as Object
import Freedom.Styler (Styler, registerStyle)
import Freedom.VNode (VObject)
import Web.DOM.DOMTokenList as DTL
import Web.DOM.Document (Document, createElement, createElementNS, createTextNode)
import Web.DOM.Element (Element)
import Web.DOM.Element as E
import Web.DOM.Node (Node, childNodes, setTextContent)
import Web.DOM.NodeList (item)
import Web.DOM.Text (Text)
import Web.Event.Event (Event)
import Web.Event.EventTarget (eventListener)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toDocument)
import Web.HTML.HTMLElement (classList, fromElement)
import Web.HTML.Window (document)

class IsRenderEnv a where
  toStyler :: a -> Styler
  toIsSVG :: a -> Boolean

class (Functor (f state), MonadRec m, IsRenderEnv r) <= Affable r f state m where
  toAff :: r -> FreeT (f state) m Unit -> Aff Unit

childNode :: Int -> Node -> Effect (Maybe Node)
childNode i node = childNodes node >>= item i

createText_ :: String -> Effect Text
createText_ text = doc >>= createTextNode text

updateText_
  :: String
  -> String
  -> Node
  -> Effect Unit
updateText_ current next node =
  when (current /= next) $ setTextContent next node

createElement_
  :: forall r f state m
   . Affable r f state m
  => VObject f state m
  -> ReaderT r Effect Element
createElement_ { tag, props, handlers } = do
  isSVG <- toIsSVG <$> ask
  el <- liftEffect if isSVG
    then doc >>= createElementNS svgNameSpace tag
    else doc >>= createElement tag
  let props' :: Array (Tuple String String)
      props' = Object.toUnfoldable props
      handlers' :: Array (Tuple String (Event -> FreeT (f state) m Unit))
      handlers' = Object.toUnfoldable handlers
  Safe.for_ props' $ uncurry \name val -> setProp name val el
  Safe.for_ handlers' $ uncurry \name h -> setHandler name h el
  pure el

updateElement_
  :: forall r f state m
   . Affable r f state m
  => VObject f state m
  -> VObject f state m
  -> Element
  -> ReaderT r Effect Unit
updateElement_ current next el = do
  updateProps current.props next.props el
  updateHandlers current.handlers next.handlers el

runLifecycle
  :: forall r f state m
   . Affable r f state m
  => FreeT (f state) m Unit
  -> ReaderT r Effect Unit
runLifecycle lifecycle = do
  r <- ask
  liftEffect $ launchAff_ $ toAff r lifecycle

removeHandler :: String -> Element -> Effect Unit
removeHandler name = setForeign name (unsafeToForeign null)

setHandler
  :: forall r f state m
   . Affable r f state m
  => String
  -> (Event -> FreeT (f state) m Unit)
  -> Element
  -> ReaderT r Effect Unit
setHandler name h el = do
  r <- ask
  listener <- liftEffect $ eventListener $ launchAff_ <<< toAff r <<< h
  liftEffect $ setForeign name (unsafeToForeign listener) el

updateHandlers
  :: forall r f state m
   . Affable r f state m
  => Object (Event -> FreeT (f state) m Unit)
  -> Object (Event -> FreeT (f state) m Unit)
  -> Element
  -> ReaderT r Effect Unit
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
  :: forall r
   . IsRenderEnv r
  => String
  -> String
  -> Element
  -> ReaderT r Effect Unit
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
  isSVG <- toIsSVG <$> ask
  liftEffect if isSVG && hasXlinkPrefix name
    then
      removeAttributeNS xlinkNameSpace (replace xlinkRegex "" name) el
    else do
      when (isProperty name el && not isSVG)
        $ setForeign name (unsafeToForeign "") el
      E.removeAttribute name el

setProp
  :: forall r
   . IsRenderEnv r
  => String
  -> String
  -> Element
  -> ReaderT r Effect Unit
setProp "css" val el = do
  styler <- toStyler <$> ask
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
  isSVG <- toIsSVG <$> ask
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
  :: forall r
   . IsRenderEnv r
  => Object String
  -> Object String
  -> Element
  -> ReaderT r Effect Unit
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

classNames :: String -> Array String
classNames val = filter (not <<< S.null) $ S.split (Pattern " ") val

addClass
  :: forall r
   . IsRenderEnv r
  => String
  -> Element
  -> ReaderT r Effect Unit
addClass val el = do
  isSVG <- toIsSVG <$> ask
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
  :: forall r
   . IsRenderEnv r
  => String
  -> Element
  -> ReaderT r Effect Unit
removeClass val el = do
  isSVG <- toIsSVG <$> ask
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

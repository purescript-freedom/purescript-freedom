module Freedom.UI.Util
  ( findContainerNode
  , raf
  , childNode
  , createText_
  , updateText_
  , createElement_
  , createElementNS_
  , setAttributeNS_
  , removeAttributeNS_
  , getStylerAttribute
  , setStylerAttribute
  , classNames
  , hasXlinkPrefix
  , setForeign
  , isProperty
  , isBoolean
  ) where

import Prelude

import Data.Array (filter)
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), null, split)
import Data.String.Regex (Regex, replace, test)
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Effect (Effect)
import Foreign (Foreign)
import Web.DOM.Document (Document, createElement, createElementNS, createTextNode)
import Web.DOM.Element as E
import Web.DOM.Node (Node, childNodes, setTextContent)
import Web.DOM.NodeList (item)
import Web.DOM.ParentNode (QuerySelector(..), querySelector)
import Web.DOM.Text as T
import Web.HTML (window)
import Web.HTML.HTMLDocument (toDocument, toParentNode)
import Web.HTML.Window (document, requestAnimationFrame)

findContainerNode :: String -> Effect (Maybe Node)
findContainerNode selector = do
  parentNode <- window >>= document <#> toParentNode
  map E.toNode <$> querySelector q parentNode
  where
    q = QuerySelector selector

raf :: Effect Unit -> Effect Unit
raf f = void $ window >>= requestAnimationFrame f

childNode :: Int -> Node -> Effect (Maybe Node)
childNode i node = childNodes node >>= item i

createText_ :: String -> Effect Node
createText_ text = doc >>= createTextNode text <#> T.toNode

updateText_ :: String -> String -> Node -> Effect Unit
updateText_ current next node =
  when (current /= next) $ setTextContent next node

createElement_ :: String -> Effect E.Element
createElement_ tagName =
  doc >>= createElement tagName

createElementNS_ :: String -> Effect E.Element
createElementNS_ tagName =
  doc >>= createElementNS svgNameSpace tagName

setAttributeNS_ :: String -> String -> E.Element -> Effect Unit
setAttributeNS_ name val el =
  setAttributeNS xlinkNameSpace (replace xlinkRegex "" name) val el

removeAttributeNS_ :: String -> E.Element -> Effect Unit
removeAttributeNS_ name el =
  removeAttributeNS xlinkNameSpace (replace xlinkRegex "" name) el

getStylerAttribute :: E.Element -> Effect (Maybe String)
getStylerAttribute = E.getAttribute stylerAttributeName

setStylerAttribute :: String -> E.Element -> Effect Unit
setStylerAttribute = E.setAttribute stylerAttributeName

classNames :: String -> Array String
classNames val = filter (not <<< null) $ split (Pattern " ") val

hasXlinkPrefix :: String -> Boolean
hasXlinkPrefix = test xlinkRegex

xlinkRegex :: Regex
xlinkRegex = unsafeRegex "^xlink:" noFlags

doc :: Effect Document
doc = window >>= document <#> toDocument

svgNameSpace :: Maybe String
svgNameSpace = Just "http://www.w3.org/2000/svg"

xlinkNameSpace :: String
xlinkNameSpace = "http://www.w3.org/1999/xlink"

stylerAttributeName :: String
stylerAttributeName = "data-freedom-styler-class"

foreign import setForeign :: String -> Foreign -> E.Element -> Effect Unit

foreign import setAttributeNS :: String -> String -> String -> E.Element -> Effect Unit

foreign import removeAttributeNS :: String -> String -> E.Element -> Effect Unit

foreign import isProperty :: String -> E.Element -> Boolean

foreign import isBoolean :: String -> E.Element -> Boolean

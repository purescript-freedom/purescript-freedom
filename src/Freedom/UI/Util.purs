module Freedom.UI.Util
  ( findContainerNode
  , raf
  , childNode
  , createText_
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
import Data.Function.Uncurried (Fn2, runFn2)
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), null, split)
import Data.String.Regex (Regex, replace, test)
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Effect (Effect)
import Effect.Uncurried (EffectFn3, EffectFn4, runEffectFn3, runEffectFn4)
import Foreign (Foreign)
import Web.DOM.Document (Document, createElement, createElementNS, createTextNode)
import Web.DOM.Element as E
import Web.DOM.Node (Node, childNodes)
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

setForeign :: String -> Foreign -> E.Element -> Effect Unit
setForeign name x element =
  runEffectFn3 setForeignImpl name x element

setAttributeNS :: String -> String -> String -> E.Element -> Effect Unit
setAttributeNS ns name val element =
  runEffectFn4 setAttributeNSImpl ns name val element

removeAttributeNS :: String -> String -> E.Element -> Effect Unit
removeAttributeNS ns name element =
  runEffectFn3 removeAttributeNSImpl ns name element

isProperty :: String -> E.Element -> Boolean
isProperty name element =
  runFn2 isPropertyImpl name element

isBoolean :: String -> E.Element -> Boolean
isBoolean name element =
  runFn2 isBooleanImpl name element

foreign import setForeignImpl :: EffectFn3 String Foreign E.Element Unit
foreign import setAttributeNSImpl :: EffectFn4 String String String E.Element Unit
foreign import removeAttributeNSImpl :: EffectFn3 String String E.Element Unit
foreign import isPropertyImpl :: Fn2 String E.Element Boolean
foreign import isBooleanImpl :: Fn2 String E.Element Boolean

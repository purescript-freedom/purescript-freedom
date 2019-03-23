module Freedom.Styler
  ( Styler
  , createStyler
  , registerStyle
  ) where

import Prelude

import Data.Char (toCharCode)
import Data.Foldable (foldr)
import Data.Int (base36, toStringAs)
import Data.Int.Bits (xor, zshr)
import Data.Maybe (Maybe(..), fromJust)
import Data.String (Pattern(..), Replacement(..), joinWith, replaceAll, trim)
import Data.String.CodeUnits (toCharArray)
import Data.String.Regex (replace)
import Data.String.Regex.Flags (global)
import Data.String.Regex.Unsafe (unsafeRegex)
import Effect (Effect)
import Effect.Ref (Ref, modify_, new, read)
import Foreign.Object (Object, empty, insert, member, values)
import Partial.Unsafe (unsafePartial)
import SimpleEmitter (Emitter, createEmitter, emit, subscribe)
import Web.DOM.Document (createElement)
import Web.DOM.Element as E
import Web.DOM.Node (Node, appendChild, setTextContent)
import Web.DOM.ParentNode (QuerySelector(..), querySelector)
import Web.HTML (window)
import Web.HTML.HTMLDocument (body, toDocument, toParentNode)
import Web.HTML.HTMLElement (toNode)
import Web.HTML.Window (document)

data Event = Register

derive instance eqEvent :: Eq Event

derive instance ordEvent :: Ord Event

newtype Styler = Styler
  { emitter :: Emitter Event
  , stylesRef :: Ref (Object String)
  }

createStyler :: Effect Styler
createStyler = do
  emitter <- createEmitter
  stylesRef <- new empty
  flip (subscribe Register) emitter do
    styles <- joinWith "" <<< values <$> read stylesRef
    getStyleNode >>= setTextContent styles
  pure $ Styler { emitter, stylesRef }

registerStyle :: String -> Styler -> Effect String
registerStyle style (Styler s) = do
  let minified = minify style
      name = "d" <> generateHash minified
  styles <- read s.stylesRef
  unless (member name styles) do
    let output = replaceToken name minified
    modify_ (insert name output) s.stylesRef
    emit Register s.emitter
  pure name

replaceToken :: String -> String -> String
replaceToken instead target =
  replaceAll (Pattern "&") (Replacement instead) target

minify :: String -> String
minify = trim >>> replaceReturns >>> replaceWhitespaces
  where
    replaceReturns = replaceAll (Pattern "\n") (Replacement "")
    replaceWhitespaces = replace (unsafeRegex "\\s\\s+" global) " "

getStyleNode :: Effect Node
getStyleNode = do
  maybeElement <- window >>= document <#> toParentNode >>= querySelector (QuerySelector $ "." <> className)
  case maybeElement of
    Just el -> pure $ E.toNode el
    Nothing -> do
      el <- window >>= document <#> toDocument >>= createElement "style"
      E.setClassName className el
      body' <- unsafePartial $ fromJust <$> (window >>= document >>= body) <#> toNode
      appendChild (E.toNode el) body'

className :: String
className = "freedom-styler"

generateHash :: String -> String
generateHash str = toStringAs base36 $ zshr seed 0
  where
    culc char value = xor (value * 33) (toCharCode char)
    seed = foldr culc 5381 $ toCharArray str

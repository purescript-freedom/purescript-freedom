module Freedom.Markup.Prop where

import Prelude

import Data.String.CodeUnits (singleton)
import Data.String.Common (joinWith)
import Freedom.UI (VNode, prop)

-- | Define styles with CSS string.
-- |
-- | It generates a hash string as class name from CSS string, and the generated class name is used automatically.
-- |
-- | ```purescript
-- | justDiv :: forall state. VNode state
-- | justDiv =
-- |   H.div # H.css styles
-- |
-- | styles :: String
-- | styles =
-- |   """
-- |   .& {
-- |     width: 100px;
-- |     height: 100px;
-- |   }
-- |   .&:hover {
-- |     width: 100px;
-- |     height: 100px;
-- |   }
-- |   .&:hover .selected {
-- |     color: blue;
-- |   }
-- |   """
-- | ```
-- |
-- | `&` in the CSS string is replaced with the generated class name, and output it as stylesheet.
-- |
-- | Like this:
-- |
-- | ```css
-- | .dz66dqm {
-- |   width: 100px;
-- |   height: 100px;
-- | }
-- | .dz66dqm:hover {
-- |   width: 100px;
-- |   height: 100px;
-- | }
-- | .dz66dqm:hover .selected {
-- |   color: blue;
-- | }
-- | ```
css
  :: forall state
   . String
  -> VNode state
  -> VNode state
css = prop "css"

style
  :: forall state
   . String
  -> VNode state
  -> VNode state
style = prop "style"

className
  :: forall state
   . String
  -> VNode state
  -> VNode state
className = prop "className"

classNames
  :: forall state
   . Array String
  -> VNode state
  -> VNode state
classNames = joinWith " " >>> className

id
  :: forall state
   . String
  -> VNode state
  -> VNode state
id = prop "id"

title
  :: forall state
   . String
  -> VNode state
  -> VNode state
title = prop "title"

hidden
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
hidden = show >>> prop "hidden"

type_
  :: forall state
   . String
  -> VNode state
  -> VNode state
type_ = prop "type"

value
  :: forall state
   . String
  -> VNode state
  -> VNode state
value = prop "value"

defaultValue
  :: forall state
   . String
  -> VNode state
  -> VNode state
defaultValue = prop "defaultValue"

checked
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
checked = show >>> prop "checked"

placeholder
  :: forall state
   . String
  -> VNode state
  -> VNode state
placeholder = prop "placeholder"

selected
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
selected = show >>> prop "selected"

accept
  :: forall state
   . String
  -> VNode state
  -> VNode state
accept = prop "accept"

acceptCharset
  :: forall state
   . String
  -> VNode state
  -> VNode state
acceptCharset = prop "acceptCharset"

action
  :: forall state
   . String
  -> VNode state
  -> VNode state
action = prop "action"

autocomplete
  :: forall state
   . String
  -> VNode state
  -> VNode state
autocomplete = prop "autocomplete"

autofocus
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
autofocus = show >>> prop "autofocus"

disabled
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
disabled = show >>> prop "disabled"

enctype
  :: forall state
   . String
  -> VNode state
  -> VNode state
enctype = prop "enctype"

formAction
  :: forall state
   . String
  -> VNode state
  -> VNode state
formAction = prop "formAction"

list
  :: forall state
   . String
  -> VNode state
  -> VNode state
list = prop "list"

maxLength
  :: forall state
   . Int
  -> VNode state
  -> VNode state
maxLength = show >>> prop "maxLength"

minLength
  :: forall state
   . Int
  -> VNode state
  -> VNode state
minLength = show >>> prop "minLength"

method
  :: forall state
   . String
  -> VNode state
  -> VNode state
method = prop "method"

multiple
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
multiple = show >>> prop "multiple"

name
  :: forall state
   . String
  -> VNode state
  -> VNode state
name = prop "name"

noValidate
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
noValidate = show >>> prop "noValidate"

pattern
  :: forall state
   . String
  -> VNode state
  -> VNode state
pattern = prop "pattern"

readOnly
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
readOnly = show >>> prop "readOnly"

required
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
required = show >>> prop "required"

size
  :: forall state
   . Int
  -> VNode state
  -> VNode state
size = show >>> prop "size"

htmlFor
  :: forall state
   . String
  -> VNode state
  -> VNode state
htmlFor = prop "htmlFor"

form
  :: forall state
   . String
  -> VNode state
  -> VNode state
form = prop "form"

max
  :: forall state
   . String
  -> VNode state
  -> VNode state
max = prop "max"

min
  :: forall state
   . String
  -> VNode state
  -> VNode state
min = prop "min"

step
  :: forall state
   . String
  -> VNode state
  -> VNode state
step = prop "step"

cols
  :: forall state
   . Int
  -> VNode state
  -> VNode state
cols = show >>> prop "cols"

rows
  :: forall state
   . Int
  -> VNode state
  -> VNode state
rows = show >>> prop "rows"

wrap
  :: forall state
   . String
  -> VNode state
  -> VNode state
wrap = prop "wrap"

href
  :: forall state
   . String
  -> VNode state
  -> VNode state
href = prop "href"

target
  :: forall state
   . String
  -> VNode state
  -> VNode state
target = prop "target"

download
  :: forall state
   . String
  -> VNode state
  -> VNode state
download = prop "download"

hreflang
  :: forall state
   . String
  -> VNode state
  -> VNode state
hreflang = prop "hreflang"

media
  :: forall state
   . String
  -> VNode state
  -> VNode state
media = prop "media"

ping
  :: forall state
   . String
  -> VNode state
  -> VNode state
ping = prop "ping"

rel
  :: forall state
   . String
  -> VNode state
  -> VNode state
rel = prop "rel"

isMap
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
isMap = show >>> prop "isMap"

useMap
  :: forall state
   . String
  -> VNode state
  -> VNode state
useMap = prop "useMap"

shape
  :: forall state
   . String
  -> VNode state
  -> VNode state
shape = prop "shape"

coords
  :: forall state
   . String
  -> VNode state
  -> VNode state
coords = prop "coords"

src
  :: forall state
   . String
  -> VNode state
  -> VNode state
src = prop "src"

height
  :: forall state
   . Int
  -> VNode state
  -> VNode state
height = show >>> prop "height"

width
  :: forall state
   . Int
  -> VNode state
  -> VNode state
width = show >>> prop "width"

alt
  :: forall state
   . String
  -> VNode state
  -> VNode state
alt = prop "alt"

autoplay
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
autoplay = show >>> prop "autoplay"

controls
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
controls = show >>> prop "controls"

loop
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
loop = show >>> prop "loop"

preload
  :: forall state
   . String
  -> VNode state
  -> VNode state
preload = prop "preload"

poster
  :: forall state
   . String
  -> VNode state
  -> VNode state
poster = prop "poster"

default
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
default = show >>> prop "default"

kind_
  :: forall state
   . String
  -> VNode state
  -> VNode state
kind_ = prop "kind"

srclang
  :: forall state
   . String
  -> VNode state
  -> VNode state
srclang = prop "srclang"

sandbox
  :: forall state
   . String
  -> VNode state
  -> VNode state
sandbox = prop "sandbox"

srcdoc
  :: forall state
   . String
  -> VNode state
  -> VNode state
srcdoc = prop "srcdoc"

reversed
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
reversed = show >>> prop "reversed"

start
  :: forall state
   . Int
  -> VNode state
  -> VNode state
start = show >>> prop "start"

colSpan
  :: forall state
   . Int
  -> VNode state
  -> VNode state
colSpan = show >>> prop "colSpan"

rowSpan
  :: forall state
   . Int
  -> VNode state
  -> VNode state
rowSpan = show >>> prop "rowSpan"

headers
  :: forall state
   . String
  -> VNode state
  -> VNode state
headers = prop "headers"

scope
  :: forall state
   . String
  -> VNode state
  -> VNode state
scope = prop "scope"

accessKey
  :: forall state
   . Char
  -> VNode state
  -> VNode state
accessKey = singleton >>> prop "accessKey"

contentEditable
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
contentEditable = show >>> prop "contentEditable"

dir
  :: forall state
   . String
  -> VNode state
  -> VNode state
dir = prop "dir"

draggable
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
draggable = show >>> prop "draggable"

dropzone
  :: forall state
   . String
  -> VNode state
  -> VNode state
dropzone = prop "dropzone"

lang
  :: forall state
   . String
  -> VNode state
  -> VNode state
lang = prop "lang"

spellcheck
  :: forall state
   . Boolean
  -> VNode state
  -> VNode state
spellcheck = show >>> prop "spellcheck"

tabIndex
  :: forall state
   . Int
  -> VNode state
  -> VNode state
tabIndex = show >>> prop "tabIndex"

cite
  :: forall state
   . String
  -> VNode state
  -> VNode state
cite = prop "cite"

dateTime
  :: forall state
   . String
  -> VNode state
  -> VNode state
dateTime = prop "dateTime"

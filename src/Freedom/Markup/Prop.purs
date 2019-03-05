module Freedom.Markup.Prop where

import Prelude

import Data.String.CodeUnits (singleton)
import Data.String.Common (joinWith)
import Freedom.Markup.Common (prop)
import Freedom.VNode (VNode)

css
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
css = prop "css"

style
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
style = prop "style"

className
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
className = prop "className"

classNames
  :: forall f state
   . Functor (f state)
  => Array String
  -> VNode f state
  -> VNode f state
classNames = joinWith " " >>> className

id
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
id = prop "id"

title
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
title = prop "title"

hidden
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
hidden = show >>> prop "hidden"

type_
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
type_ = prop "type"

value
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
value = prop "value"

defaultValue
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
defaultValue = prop "defaultValue"

checked
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
checked = show >>> prop "checked"

placeholder
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
placeholder = prop "placeholder"

selected
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
selected = show >>> prop "selected"

accept
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
accept = prop "accept"

acceptCharset
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
acceptCharset = prop "acceptCharset"

action
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
action = prop "action"

autocomplete
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
autocomplete = prop "autocomplete"

autofocus
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
autofocus = show >>> prop "autofocus"

disabled
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
disabled = show >>> prop "disabled"

enctype
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
enctype = prop "enctype"

formAction
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
formAction = prop "formAction"

list
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
list = prop "list"

maxLength
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
maxLength = show >>> prop "maxLength"

minLength
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
minLength = show >>> prop "minLength"

method
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
method = prop "method"

multiple
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
multiple = show >>> prop "multiple"

name
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
name = prop "name"

noValidate
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
noValidate = show >>> prop "noValidate"

pattern
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
pattern = prop "pattern"

readOnly
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
readOnly = show >>> prop "readOnly"

required
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
required = show >>> prop "required"

size
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
size = show >>> prop "size"

htmlFor
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
htmlFor = prop "htmlFor"

form
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
form = prop "form"

max
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
max = prop "max"

min
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
min = prop "min"

step
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
step = prop "step"

cols
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
cols = show >>> prop "cols"

rows
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
rows = show >>> prop "rows"

wrap
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
wrap = prop "wrap"

href
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
href = prop "href"

target
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
target = prop "target"

download
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
download = prop "download"

hreflang
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
hreflang = prop "hreflang"

media
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
media = prop "media"

ping
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
ping = prop "ping"

rel
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
rel = prop "rel"

isMap
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
isMap = show >>> prop "isMap"

useMap
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
useMap = prop "useMap"

shape
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
shape = prop "shape"

coords
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
coords = prop "coords"

src
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
src = prop "src"

height
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
height = show >>> prop "height"

width
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
width = show >>> prop "width"

alt
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
alt = prop "alt"

autoplay
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
autoplay = show >>> prop "autoplay"

controls
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
controls = show >>> prop "controls"

loop
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
loop = show >>> prop "loop"

preload
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
preload = prop "preload"

poster
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
poster = prop "poster"

default
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
default = show >>> prop "default"

kind_
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
kind_ = prop "kind"

srclang
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
srclang = prop "srclang"

sandbox
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
sandbox = prop "sandbox"

srcdoc
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
srcdoc = prop "srcdoc"

reversed
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
reversed = show >>> prop "reversed"

start
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
start = show >>> prop "start"

colSpan
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
colSpan = show >>> prop "colSpan"

rowSpan
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
rowSpan = show >>> prop "rowSpan"

headers
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
headers = prop "headers"

scope
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
scope = prop "scope"

accessKey
  :: forall f state
   . Functor (f state)
  => Char
  -> VNode f state
  -> VNode f state
accessKey = singleton >>> prop "accessKey"

contentEditable
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
contentEditable = show >>> prop "contentEditable"

dir
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
dir = prop "dir"

draggable
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
draggable = show >>> prop "draggable"

dropzone
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
dropzone = prop "dropzone"

lang
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
lang = prop "lang"

spellcheck
  :: forall f state
   . Functor (f state)
  => Boolean
  -> VNode f state
  -> VNode f state
spellcheck = show >>> prop "spellcheck"

tabIndex
  :: forall f state
   . Functor (f state)
  => Int
  -> VNode f state
  -> VNode f state
tabIndex = show >>> prop "tabIndex"

cite
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
cite = prop "cite"

dateTime
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
  -> VNode f state
dateTime = prop "dateTime"

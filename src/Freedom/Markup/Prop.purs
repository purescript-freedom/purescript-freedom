module Freedom.Markup.Prop where

import Prelude

import Control.Monad.Rec.Class (class MonadRec)
import Data.String.CodeUnits (singleton)
import Data.String.Common (joinWith)
import Freedom.Markup.Common (prop)
import Freedom.VNode (VObject)

css
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
css = prop "css"

style
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
style = prop "style"

className
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
className = prop "className"

classNames
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Array String
  -> VObject f state m
  -> VObject f state m
classNames = joinWith " " >>> className

id
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
id = prop "id"

title
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
title = prop "title"

hidden
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
hidden = show >>> prop "hidden"

type_
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
type_ = prop "type"

value
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
value = prop "value"

defaultValue
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
defaultValue = prop "defaultValue"

checked
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
checked = show >>> prop "checked"

placeholder
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
placeholder = prop "placeholder"

selected
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
selected = show >>> prop "selected"

accept
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
accept = prop "accept"

acceptCharset
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
acceptCharset = prop "acceptCharset"

action
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
action = prop "action"

autocomplete
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
autocomplete = prop "autocomplete"

autofocus
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
autofocus = show >>> prop "autofocus"

disabled
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
disabled = show >>> prop "disabled"

enctype
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
enctype = prop "enctype"

formAction
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
formAction = prop "formAction"

list
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
list = prop "list"

maxLength
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
maxLength = show >>> prop "maxLength"

minLength
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
minLength = show >>> prop "minLength"

method
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
method = prop "method"

multiple
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
multiple = show >>> prop "multiple"

name
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
name = prop "name"

noValidate
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
noValidate = show >>> prop "noValidate"

pattern
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
pattern = prop "pattern"

readOnly
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
readOnly = show >>> prop "readOnly"

required
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
required = show >>> prop "required"

size
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
size = show >>> prop "size"

htmlFor
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
htmlFor = prop "htmlFor"

form
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
form = prop "form"

max
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
max = prop "max"

min
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
min = prop "min"

step
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
step = prop "step"

cols
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
cols = show >>> prop "cols"

rows
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
rows = show >>> prop "rows"

wrap
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
wrap = prop "wrap"

href
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
href = prop "href"

target
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
target = prop "target"

download
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
download = prop "download"

hreflang
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
hreflang = prop "hreflang"

media
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
media = prop "media"

ping
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
ping = prop "ping"

rel
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
rel = prop "rel"

isMap
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
isMap = show >>> prop "isMap"

useMap
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
useMap = prop "useMap"

shape
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
shape = prop "shape"

coords
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
coords = prop "coords"

src
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
src = prop "src"

height
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
height = show >>> prop "height"

width
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
width = show >>> prop "width"

alt
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
alt = prop "alt"

autoplay
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
autoplay = show >>> prop "autoplay"

controls
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
controls = show >>> prop "controls"

loop
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
loop = show >>> prop "loop"

preload
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
preload = prop "preload"

poster
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
poster = prop "poster"

default
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
default = show >>> prop "default"

kind_
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
kind_ = prop "kind"

srclang
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
srclang = prop "srclang"

sandbox
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
sandbox = prop "sandbox"

srcdoc
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
srcdoc = prop "srcdoc"

reversed
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
reversed = show >>> prop "reversed"

start
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
start = show >>> prop "start"

colSpan
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
colSpan = show >>> prop "colSpan"

rowSpan
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
rowSpan = show >>> prop "rowSpan"

headers
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
headers = prop "headers"

scope
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
scope = prop "scope"

accessKey
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Char
  -> VObject f state m
  -> VObject f state m
accessKey = singleton >>> prop "accessKey"

contentEditable
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
contentEditable = show >>> prop "contentEditable"

dir
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
dir = prop "dir"

draggable
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
draggable = show >>> prop "draggable"

dropzone
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
dropzone = prop "dropzone"

lang
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
lang = prop "lang"

spellcheck
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Boolean
  -> VObject f state m
  -> VObject f state m
spellcheck = show >>> prop "spellcheck"

tabIndex
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Int
  -> VObject f state m
  -> VObject f state m
tabIndex = show >>> prop "tabIndex"

cite
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
cite = prop "cite"

dateTime
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
  -> VObject f state m
dateTime = prop "dateTime"

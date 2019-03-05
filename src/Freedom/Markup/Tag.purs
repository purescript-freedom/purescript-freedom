module Freedom.Markup.Tag where

import Prelude

import Control.Monad.Rec.Class (class MonadRec)
import Freedom.Markup.Common (tag)
import Freedom.VNode (VObject)

h1 :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
h1 = tag "h1"

h2 :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
h2 = tag "h2"

h3 :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
h3 = tag "h3"

h4 :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
h4 = tag "h4"

h5 :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
h5 = tag "h5"

h6 :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
h6 = tag "h6"

div :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
div = tag "div"

p :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
p = tag "p"

hr :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
hr = tag "hr"

pre :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
pre = tag "pre"

blockquote :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
blockquote = tag "blockquote"

span :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
span = tag "span"

a :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
a = tag "a"

code :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
code = tag "code"

em :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
em = tag "em"

strong :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
strong = tag "strong"

i :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
i = tag "i"

b :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
b = tag "b"

u :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
u = tag "u"

sub :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
sub = tag "sub"

sup :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
sup = tag "sup"

br :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
br = tag "br"

ol :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
ol = tag "ol"

ul :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
ul = tag "ul"

li :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
li = tag "li"

dl :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
dl = tag "dl"

dt :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
dt = tag "dt"

dd :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
dd = tag "dd"

img :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
img = tag "img"

iframe :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
iframe = tag "iframe"

canvas :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
canvas = tag "canvas"

math :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
math = tag "math"

form :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
form = tag "form"

input :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
input = tag "input"

textarea :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
textarea = tag "textarea"

button :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
button = tag "button"

select :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
select = tag "select"

option :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
option = tag "option"

section :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
section = tag "section"

nav :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
nav = tag "nav"

article :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
article = tag "article"

aside :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
aside = tag "aside"

header :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
header = tag "header"

footer :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
footer = tag "footer"

address :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
address = tag "address"

main_ :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
main_ = tag "main"

figure :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
figure = tag "figure"

figcaption :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
figcaption = tag "figcaption"

table :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
table = tag "table"

caption :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
caption = tag "caption"

colgroup :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
colgroup = tag "colgroup"

col :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
col = tag "col"

tbody :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
tbody = tag "tbody"

thead :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
thead = tag "thead"

tfoot :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
tfoot = tag "tfoot"

tr :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
tr = tag "tr"

td :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
td = tag "td"

th :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
th = tag "th"

fieldset :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
fieldset = tag "fieldset"

legend :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
legend = tag "legend"

label :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
label = tag "label"

datalist :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
datalist = tag "datalist"

optgroup :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
optgroup = tag "optgroup"

output :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
output = tag "output"

progress :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
progress = tag "progress"

meter :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
meter = tag "meter"

audio :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
audio = tag "audio"

video :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
video = tag "video"

source :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
source = tag "source"

track :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
track = tag "track"

embed :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
embed = tag "embed"

object :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
object = tag "object"

param :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
param = tag "param"

ins :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
ins = tag "ins"

del :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
del = tag "del"

small :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
small = tag "small"

cite :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
cite = tag "cite"

dfn :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
dfn = tag "dfn"

abbr :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
abbr = tag "abbr"

time :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
time = tag "time"

var :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
var = tag "var"

samp :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
samp = tag "samp"

kbd :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
kbd = tag "kbd"

s :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
s = tag "s"

q :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
q = tag "q"

mark :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
mark = tag "mark"

ruby :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
ruby = tag "ruby"

rt :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
rt = tag "rt"

rp :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
rp = tag "rp"

bdi :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
bdi = tag "bdi"

bdo :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
bdo = tag "bdo"

wbr :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
wbr = tag "wbr"

details :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
details = tag "details"

summary :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
summary = tag "summary"

menu :: forall f state m. Functor (f state) => MonadRec m => VObject f state m
menu = tag "menu"

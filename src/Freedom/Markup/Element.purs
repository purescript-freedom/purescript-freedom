module Freedom.Markup.Element where

import Prelude

import Freedom.Markup.Common (element)
import Freedom.VNode (VNode)

h1 :: forall f state. Functor (f state) => VNode f state
h1 = element "h1"

h2 :: forall f state. Functor (f state) => VNode f state
h2 = element "h2"

h3 :: forall f state. Functor (f state) => VNode f state
h3 = element "h3"

h4 :: forall f state. Functor (f state) => VNode f state
h4 = element "h4"

h5 :: forall f state. Functor (f state) => VNode f state
h5 = element "h5"

h6 :: forall f state. Functor (f state) => VNode f state
h6 = element "h6"

div :: forall f state. Functor (f state) => VNode f state
div = element "div"

p :: forall f state. Functor (f state) => VNode f state
p = element "p"

hr :: forall f state. Functor (f state) => VNode f state
hr = element "hr"

pre :: forall f state. Functor (f state) => VNode f state
pre = element "pre"

blockquote :: forall f state. Functor (f state) => VNode f state
blockquote = element "blockquote"

span :: forall f state. Functor (f state) => VNode f state
span = element "span"

a :: forall f state. Functor (f state) => VNode f state
a = element "a"

code :: forall f state. Functor (f state) => VNode f state
code = element "code"

em :: forall f state. Functor (f state) => VNode f state
em = element "em"

strong :: forall f state. Functor (f state) => VNode f state
strong = element "strong"

i :: forall f state. Functor (f state) => VNode f state
i = element "i"

b :: forall f state. Functor (f state) => VNode f state
b = element "b"

u :: forall f state. Functor (f state) => VNode f state
u = element "u"

sub :: forall f state. Functor (f state) => VNode f state
sub = element "sub"

sup :: forall f state. Functor (f state) => VNode f state
sup = element "sup"

br :: forall f state. Functor (f state) => VNode f state
br = element "br"

ol :: forall f state. Functor (f state) => VNode f state
ol = element "ol"

ul :: forall f state. Functor (f state) => VNode f state
ul = element "ul"

li :: forall f state. Functor (f state) => VNode f state
li = element "li"

dl :: forall f state. Functor (f state) => VNode f state
dl = element "dl"

dt :: forall f state. Functor (f state) => VNode f state
dt = element "dt"

dd :: forall f state. Functor (f state) => VNode f state
dd = element "dd"

img :: forall f state. Functor (f state) => VNode f state
img = element "img"

iframe :: forall f state. Functor (f state) => VNode f state
iframe = element "iframe"

canvas :: forall f state. Functor (f state) => VNode f state
canvas = element "canvas"

math :: forall f state. Functor (f state) => VNode f state
math = element "math"

form :: forall f state. Functor (f state) => VNode f state
form = element "form"

input :: forall f state. Functor (f state) => VNode f state
input = element "input"

textarea :: forall f state. Functor (f state) => VNode f state
textarea = element "textarea"

button :: forall f state. Functor (f state) => VNode f state
button = element "button"

select :: forall f state. Functor (f state) => VNode f state
select = element "select"

option :: forall f state. Functor (f state) => VNode f state
option = element "option"

section :: forall f state. Functor (f state) => VNode f state
section = element "section"

nav :: forall f state. Functor (f state) => VNode f state
nav = element "nav"

article :: forall f state. Functor (f state) => VNode f state
article = element "article"

aside :: forall f state. Functor (f state) => VNode f state
aside = element "aside"

header :: forall f state. Functor (f state) => VNode f state
header = element "header"

footer :: forall f state. Functor (f state) => VNode f state
footer = element "footer"

address :: forall f state. Functor (f state) => VNode f state
address = element "address"

main_ :: forall f state. Functor (f state) => VNode f state
main_ = element "main"

figure :: forall f state. Functor (f state) => VNode f state
figure = element "figure"

figcaption :: forall f state. Functor (f state) => VNode f state
figcaption = element "figcaption"

table :: forall f state. Functor (f state) => VNode f state
table = element "table"

caption :: forall f state. Functor (f state) => VNode f state
caption = element "caption"

colgroup :: forall f state. Functor (f state) => VNode f state
colgroup = element "colgroup"

col :: forall f state. Functor (f state) => VNode f state
col = element "col"

tbody :: forall f state. Functor (f state) => VNode f state
tbody = element "tbody"

thead :: forall f state. Functor (f state) => VNode f state
thead = element "thead"

tfoot :: forall f state. Functor (f state) => VNode f state
tfoot = element "tfoot"

tr :: forall f state. Functor (f state) => VNode f state
tr = element "tr"

td :: forall f state. Functor (f state) => VNode f state
td = element "td"

th :: forall f state. Functor (f state) => VNode f state
th = element "th"

fieldset :: forall f state. Functor (f state) => VNode f state
fieldset = element "fieldset"

legend :: forall f state. Functor (f state) => VNode f state
legend = element "legend"

label :: forall f state. Functor (f state) => VNode f state
label = element "label"

datalist :: forall f state. Functor (f state) => VNode f state
datalist = element "datalist"

optgroup :: forall f state. Functor (f state) => VNode f state
optgroup = element "optgroup"

output :: forall f state. Functor (f state) => VNode f state
output = element "output"

progress :: forall f state. Functor (f state) => VNode f state
progress = element "progress"

meter :: forall f state. Functor (f state) => VNode f state
meter = element "meter"

audio :: forall f state. Functor (f state) => VNode f state
audio = element "audio"

video :: forall f state. Functor (f state) => VNode f state
video = element "video"

source :: forall f state. Functor (f state) => VNode f state
source = element "source"

track :: forall f state. Functor (f state) => VNode f state
track = element "track"

embed :: forall f state. Functor (f state) => VNode f state
embed = element "embed"

object :: forall f state. Functor (f state) => VNode f state
object = element "object"

param :: forall f state. Functor (f state) => VNode f state
param = element "param"

ins :: forall f state. Functor (f state) => VNode f state
ins = element "ins"

del :: forall f state. Functor (f state) => VNode f state
del = element "del"

small :: forall f state. Functor (f state) => VNode f state
small = element "small"

cite :: forall f state. Functor (f state) => VNode f state
cite = element "cite"

dfn :: forall f state. Functor (f state) => VNode f state
dfn = element "dfn"

abbr :: forall f state. Functor (f state) => VNode f state
abbr = element "abbr"

time :: forall f state. Functor (f state) => VNode f state
time = element "time"

var :: forall f state. Functor (f state) => VNode f state
var = element "var"

samp :: forall f state. Functor (f state) => VNode f state
samp = element "samp"

kbd :: forall f state. Functor (f state) => VNode f state
kbd = element "kbd"

s :: forall f state. Functor (f state) => VNode f state
s = element "s"

q :: forall f state. Functor (f state) => VNode f state
q = element "q"

mark :: forall f state. Functor (f state) => VNode f state
mark = element "mark"

ruby :: forall f state. Functor (f state) => VNode f state
ruby = element "ruby"

rt :: forall f state. Functor (f state) => VNode f state
rt = element "rt"

rp :: forall f state. Functor (f state) => VNode f state
rp = element "rp"

bdi :: forall f state. Functor (f state) => VNode f state
bdi = element "bdi"

bdo :: forall f state. Functor (f state) => VNode f state
bdo = element "bdo"

wbr :: forall f state. Functor (f state) => VNode f state
wbr = element "wbr"

details :: forall f state. Functor (f state) => VNode f state
details = element "details"

summary :: forall f state. Functor (f state) => VNode f state
summary = element "summary"

menu :: forall f state. Functor (f state) => VNode f state
menu = element "menu"

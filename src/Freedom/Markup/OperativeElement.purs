module Freedom.Markup.OperativeElement where

import Prelude

import Freedom.Markup.Common (operative)
import Freedom.VNode (VNode)

h1 :: forall f state. Functor (f state) => VNode f state
h1 = operative "h1"

h2 :: forall f state. Functor (f state) => VNode f state
h2 = operative "h2"

h3 :: forall f state. Functor (f state) => VNode f state
h3 = operative "h3"

h4 :: forall f state. Functor (f state) => VNode f state
h4 = operative "h4"

h5 :: forall f state. Functor (f state) => VNode f state
h5 = operative "h5"

h6 :: forall f state. Functor (f state) => VNode f state
h6 = operative "h6"

div :: forall f state. Functor (f state) => VNode f state
div = operative "div"

p :: forall f state. Functor (f state) => VNode f state
p = operative "p"

hr :: forall f state. Functor (f state) => VNode f state
hr = operative "hr"

pre :: forall f state. Functor (f state) => VNode f state
pre = operative "pre"

blockquote :: forall f state. Functor (f state) => VNode f state
blockquote = operative "blockquote"

span :: forall f state. Functor (f state) => VNode f state
span = operative "span"

a :: forall f state. Functor (f state) => VNode f state
a = operative "a"

code :: forall f state. Functor (f state) => VNode f state
code = operative "code"

em :: forall f state. Functor (f state) => VNode f state
em = operative "em"

strong :: forall f state. Functor (f state) => VNode f state
strong = operative "strong"

i :: forall f state. Functor (f state) => VNode f state
i = operative "i"

b :: forall f state. Functor (f state) => VNode f state
b = operative "b"

u :: forall f state. Functor (f state) => VNode f state
u = operative "u"

sub :: forall f state. Functor (f state) => VNode f state
sub = operative "sub"

sup :: forall f state. Functor (f state) => VNode f state
sup = operative "sup"

br :: forall f state. Functor (f state) => VNode f state
br = operative "br"

ol :: forall f state. Functor (f state) => VNode f state
ol = operative "ol"

ul :: forall f state. Functor (f state) => VNode f state
ul = operative "ul"

li :: forall f state. Functor (f state) => VNode f state
li = operative "li"

dl :: forall f state. Functor (f state) => VNode f state
dl = operative "dl"

dt :: forall f state. Functor (f state) => VNode f state
dt = operative "dt"

dd :: forall f state. Functor (f state) => VNode f state
dd = operative "dd"

img :: forall f state. Functor (f state) => VNode f state
img = operative "img"

iframe :: forall f state. Functor (f state) => VNode f state
iframe = operative "iframe"

canvas :: forall f state. Functor (f state) => VNode f state
canvas = operative "canvas"

math :: forall f state. Functor (f state) => VNode f state
math = operative "math"

form :: forall f state. Functor (f state) => VNode f state
form = operative "form"

input :: forall f state. Functor (f state) => VNode f state
input = operative "input"

textarea :: forall f state. Functor (f state) => VNode f state
textarea = operative "textarea"

button :: forall f state. Functor (f state) => VNode f state
button = operative "button"

select :: forall f state. Functor (f state) => VNode f state
select = operative "select"

option :: forall f state. Functor (f state) => VNode f state
option = operative "option"

section :: forall f state. Functor (f state) => VNode f state
section = operative "section"

nav :: forall f state. Functor (f state) => VNode f state
nav = operative "nav"

article :: forall f state. Functor (f state) => VNode f state
article = operative "article"

aside :: forall f state. Functor (f state) => VNode f state
aside = operative "aside"

header :: forall f state. Functor (f state) => VNode f state
header = operative "header"

footer :: forall f state. Functor (f state) => VNode f state
footer = operative "footer"

address :: forall f state. Functor (f state) => VNode f state
address = operative "address"

main_ :: forall f state. Functor (f state) => VNode f state
main_ = operative "main"

figure :: forall f state. Functor (f state) => VNode f state
figure = operative "figure"

figcaption :: forall f state. Functor (f state) => VNode f state
figcaption = operative "figcaption"

table :: forall f state. Functor (f state) => VNode f state
table = operative "table"

caption :: forall f state. Functor (f state) => VNode f state
caption = operative "caption"

colgroup :: forall f state. Functor (f state) => VNode f state
colgroup = operative "colgroup"

col :: forall f state. Functor (f state) => VNode f state
col = operative "col"

tbody :: forall f state. Functor (f state) => VNode f state
tbody = operative "tbody"

thead :: forall f state. Functor (f state) => VNode f state
thead = operative "thead"

tfoot :: forall f state. Functor (f state) => VNode f state
tfoot = operative "tfoot"

tr :: forall f state. Functor (f state) => VNode f state
tr = operative "tr"

td :: forall f state. Functor (f state) => VNode f state
td = operative "td"

th :: forall f state. Functor (f state) => VNode f state
th = operative "th"

fieldset :: forall f state. Functor (f state) => VNode f state
fieldset = operative "fieldset"

legend :: forall f state. Functor (f state) => VNode f state
legend = operative "legend"

label :: forall f state. Functor (f state) => VNode f state
label = operative "label"

datalist :: forall f state. Functor (f state) => VNode f state
datalist = operative "datalist"

optgroup :: forall f state. Functor (f state) => VNode f state
optgroup = operative "optgroup"

output :: forall f state. Functor (f state) => VNode f state
output = operative "output"

progress :: forall f state. Functor (f state) => VNode f state
progress = operative "progress"

meter :: forall f state. Functor (f state) => VNode f state
meter = operative "meter"

audio :: forall f state. Functor (f state) => VNode f state
audio = operative "audio"

video :: forall f state. Functor (f state) => VNode f state
video = operative "video"

source :: forall f state. Functor (f state) => VNode f state
source = operative "source"

track :: forall f state. Functor (f state) => VNode f state
track = operative "track"

embed :: forall f state. Functor (f state) => VNode f state
embed = operative "embed"

object :: forall f state. Functor (f state) => VNode f state
object = operative "object"

param :: forall f state. Functor (f state) => VNode f state
param = operative "param"

ins :: forall f state. Functor (f state) => VNode f state
ins = operative "ins"

del :: forall f state. Functor (f state) => VNode f state
del = operative "del"

small :: forall f state. Functor (f state) => VNode f state
small = operative "small"

cite :: forall f state. Functor (f state) => VNode f state
cite = operative "cite"

dfn :: forall f state. Functor (f state) => VNode f state
dfn = operative "dfn"

abbr :: forall f state. Functor (f state) => VNode f state
abbr = operative "abbr"

time :: forall f state. Functor (f state) => VNode f state
time = operative "time"

var :: forall f state. Functor (f state) => VNode f state
var = operative "var"

samp :: forall f state. Functor (f state) => VNode f state
samp = operative "samp"

kbd :: forall f state. Functor (f state) => VNode f state
kbd = operative "kbd"

s :: forall f state. Functor (f state) => VNode f state
s = operative "s"

q :: forall f state. Functor (f state) => VNode f state
q = operative "q"

mark :: forall f state. Functor (f state) => VNode f state
mark = operative "mark"

ruby :: forall f state. Functor (f state) => VNode f state
ruby = operative "ruby"

rt :: forall f state. Functor (f state) => VNode f state
rt = operative "rt"

rp :: forall f state. Functor (f state) => VNode f state
rp = operative "rp"

bdi :: forall f state. Functor (f state) => VNode f state
bdi = operative "bdi"

bdo :: forall f state. Functor (f state) => VNode f state
bdo = operative "bdo"

wbr :: forall f state. Functor (f state) => VNode f state
wbr = operative "wbr"

details :: forall f state. Functor (f state) => VNode f state
details = operative "details"

summary :: forall f state. Functor (f state) => VNode f state
summary = operative "summary"

menu :: forall f state. Functor (f state) => VNode f state
menu = operative "menu"

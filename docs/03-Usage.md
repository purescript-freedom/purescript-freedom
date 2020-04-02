# Usage

This document explains the usage of `purescript-freedom`.

Overview:

- How to run UI
- State
- Subscription
- VNode

## How to run UI

`purescript-freedom` needs `Config`.

The type of `Config` is below:

```purescript
type Config state =
  { selector :: String
  , initialState :: state
  , view :: state -> VNode state
  , subscriptions :: Array (Subscription state)
  }
```

`selector` is the selector of rendering target.

`initialState` is initial state for your application.

`view` is a pure function that is received your application state and returns `VNode`.

`subscriptions` are hooks of events that aren't related a specific node like window events, timers and so on.

You can run UI by passing `Config` to `run` function.

Minimum example:

```purescript
import Prelude

import Effect (Effect)
import Freedom as Freedom
import Freedom.Markup as H
import Freedom.UI (Subscription, VNode)

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState
  , view
  , subscriptions
  }

initialState :: Int
initialState = 0

view :: Int -> VNode Int
view x = H.p # H.kids [ H.t $ show x ]

subscriptions :: Array (Subscription Int)
subscriptions = []
```

## State

In `purescript-freedom`, whole of app state is managed in single state, and you can decide the type of state.

In event handlers and subscriptions, you can update the state using pure functions that have a type `state -> state`.
(I'll explain about that later.)

NOTE: The state shape is very important for your productivity, so you should consider it seriously.

NOTE: If you will implement complex UI, check [purescript-identy](https://github.com/oreshinya/purescript-identy).

## Subscription

`Subscription` is hooks of events that aren't related a specific node like window events, timers and so on.

The type of `Subscription` is below:

```purescript
type Subscription state = Query state -> Effect Unit
```

`Query` is the accessor to your application state, and the type is below:

```purescript
type Query state =
  { select :: Effect state
  , reduce :: (state -> state) -> Effect Unit
  }
```

- `select` is the state selector.
- `reduce` is the state updater.

The point is that you can call effects with state accessors.

Let's look at the router example with [purescript-freedom-router](https://github.com/purescript-freedom/purescript-freedom-router).

Here is a part of its implementation.

```purescript
router
  :: forall state
   . (String -> Query state -> Effect Unit)
  -> Subscription state
router effect query = do
  effectByPath
  listener <- eventListener $ const effectByPath
  window <#> toEventTarget >>= addEventListener popstate listener false
  where
    effectByPath = do
      l <- window >>= location
      path <- (<>) <$> pathname l <*> search l
      effect path query
```

The points of this implementation are below:

- Passed effect is called once with query and path from location.
- Register same effect as listener for History API event.

The reason of this implementation is because of subscriptions are called only once when initializing your application.

Here is how to use this router subscription.

```purescript
data Route
  = Home
  | User Int
  | Users String
  | NotFound

type State = Route

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState: Home
  , subscriptions: [ router' ]
  , view
  }

router' :: Subscription State
router' = router \url query -> query.reduce $ const $ route url
  where
    route url = fromMaybe NotFound $ match url $
      Home <$ end
      <|>
      Users <$> (lit "users" *> param "name") <* end
      <|>
      User <$> (lit "users" *> int) <* end
```

The point is that you can pass multiple subscriptions to `run`.

See [another example of `Subscription`](https://github.com/purescript-freedom/purescript-freedom-window-resize) if you like.

## VNode

You can implement views with `VNode`.

There are 2 kinds as `VNode`.

- Text
  - Just a text node.
- Element
  - A element like `div`, `p` and so on.

### Text

You can construct a text node with `t` function.

```purescript
import Freedom.Markup as H
import Freedom.UI (VNode)

view :: forall state. VNode state
view = H.t "Sample Text"
```

### Element

#### Tag

##### Basic

You can construct any element with tag helpers.

`Freedom.Markup` module has many tag helpers, so you can implement views by using them basically.

The `div` example is below:

```purescript
import Freedom.Markup as H
import Freedom.UI (VNode)

view :: forall state. VNode state
view = H.div
```

##### If you can't find any helper you want

If you can't find any helper you want, you can use `tag` function.

```purescript
import Freedom.Markup as H
import Freedom.UI (VNode)

view :: forall state. VNode state
view = H.tag "svg"
```

#### Children

You can set child elements to an element with `kids` function.

```purescript
import Freedom.Markup as H
import Freedom.UI (VNode)

view :: forall state. VNode state
view =
  H.ul # H.kids
    [ H.li # H.kids [ H.t "List Item 1" ]
    , H.li # H.kids [ H.t "List Item 2" ]
    ]
```

#### Property

##### Basic

You can set properties to an element with property helpers.

`Freedom.Markup` module has many property helpers, so you can implement views by using them basically.

The `href` example is below:

```purescript
import Freedom.Markup as H
import Freedom.UI (VNode)

view :: forall state. VNode state
view =
  H.a
    # H.href "https://github.com"
    # H.kids [ H.t "GitHub" ]
```

##### CSS

`purescript-freedom` has the mechanism **CSS in PS**.

How to use:

```purescript
import Freedom.Markup as H
import Freedom.UI (VNode)

view :: forall state. VNode state
view =
  H.div # H.css styles
  where
    styles =
      """
      .& {
        width: 100%;
        height: 100%;
        animation: & 2s infinite linear;
      }
      @keyframes & {
        from { width: 30%; } 
        to { width: 100%; }
      }
      """
```

You can write CSS passing CSS string to `css` function.

The mechanism is very simple.

`purescript-freedom` emulates scoped CSS by generating hash from passed CSS string, and it is used as `class`, and it replaces `&` in CSS string with generated hash, then outputs styles.

It evaluates styles gradually as each node is rendered because styles evaluation is incorporated in rendering process.

##### If you can't find any helper you want

If you can't find any helper you want, you can use `prop` function.

```purescript
import Freedom.Markup as H
import Freedom.UI (VNode)

view :: forall state. VNode state
view = H.tag "svg" # H.prop "viewBox" "0 0 400 400"
```

#### Event handler

You can bind event handlers to an element with helper functions.

`Freedom.Markup` module has many helpers, so you can implement views by using them.

The `onChange` example is below:

```purescript
import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Freedom.Markup as H
import Freedom.UI (VNode, Operation)
import Web.Event.Event (Event, target)
import Web.HTML.HTMLInputElement as Input

type State = String

view :: State -> VNode State
view name =
  H.input
    # H.type_ "text"
    # H.value name
    # H.onChange changeName

changeName :: Event -> Operation State -> Effect Unit
changeName evt { query } =
  case join (Input.fromEventTarget <$> target evt) of
    Nothing -> pure unit
    Just el -> do
      name <- Input.value el
      query.reduce $ const name
```

The type of `Operation` is below:

```purescript
type Operation state =
  { query :: Query state
  , renderer :: Renderer state
  }
```

`query` is the state accessor.

The point is that you can access your application state in event handlers.

`renderer` is the renderer for child nodes, and I'll explain about that later.

#### Lifecycle

You can bind lifecycle handlers to an element.

- `didCreate`
  - Trigger when created a node
- `didUpdate`
  - Trigger when updated a node
- `didDelete`
  - Trigger when deleted a node

```purescript
import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Freedom.Markup as H
import Freedom.UI (VNode, Operation)
import Web.DOM.Element (Element)
import Web.HTML.HTMLElement (focus, fromElement)

type State = String

view :: State -> VNode State
view name =
  H.input
    # H.type_ "text"
    # H.value name
    # H.didCreate didCreate

didCreate :: Element -> Operation State -> Effect Unit 
didCreate element _ =
  case fromElement element of
    Nothing -> pure unit
    Just htmlEl -> focus htmlEl
```

#### Key

**This section is very important.**

Key helps `purescript-freedom` identify which child nodes have changed, are added, or are removed.

**Keys must be unique among siblings.**

You can add a key to an element with `key` function.

```purescript
import Freedom.Markup as H
import Freedom.UI (VNode)

view :: forall state. Array Int -> VNode state
view xs =
  H.ul # H.kids (listItem <$> xs)

listItem :: forall state. Int -> VNode state
listItem x =
  H.li
    # H.key (show x)
    # H.kids [ H.t $ show x ]
```

You can write codes without keys, **but `purescript-freedom` recommends using keys when map `Array a` to `Array (VNode state)`**.

For your reference, if you do not add keys, `purescript-freedom` generates key from tag name and index of array.

`purescript-freedom` indentify `VNode` by keys, lifecycle mechanism is supported by it.

If Lifecycle is not triggered correctly, you should consider using keys.

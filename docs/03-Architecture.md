# Architecture

This document explains the architecure of `purescript-freedom`.

Following is overview:

- State
  - Whole of app state definition and pure functions to update it
- Action
  - Effects that are triggered by various events
- Subscription
  - Hooks of events that aren't related a specific node like window events, timers and so on
- View
  - UI as a mapping of app state

## State

In `purescript-freedom`, whole of app state is managed in single state.

`State` has type definition, initialState, and pure functions to update.

For example:

```purescript
type State =
  { isLoading :: Boolean
  , users :: Array User
  }

initialState :: State
initialState =
  { isLoading: false
  , users: []
  }

load :: State -> State
load = _ { isLoading = true }

unload :: State -> State
unload = _ { isLoading = false }

setUsers :: Array User -> State -> State
setUsers users = _ { users = users }
```

And you can initialize `purescript-freedom` with `initialState`.

```purescript
import Prelude

import Effect (Effect)
import Freedom as Freedom
import State (initialState)
import View (view)

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState -- initialState is here.
  , subscriptions: []
  , view
  }
```

Pure functions to update are used in `Action`.

NOTE: The state shape is very important for your productivity, so you should consider it seriously.

NOTE: If you will implement complex UI, check [purescript-identy](https://github.com/oreshinya/purescript-identy).

## Action

The role of `Action` is that it runs effects such as communicate with server or browser, get current app state, modify app state and so on.

`Action` can be registered as event handlers and lifecycles of `View`, also, it can be run in `Subscription`.

Example:

```purescript
fetchCount :: forall state. Operation state -> Effect Unit
fetchCount { query } = launchAff_ do
  res <- API.get "/count"
  case res of
    Right count ->
      liftEffect $ query.reduce _ { count = count }
    _ ->
      liftEffect $ query.reduce _ { failure = true }
```

The type of `operation.query` is `Query state`.
This is accessor to app state, and the type is following:

```purescript
type Query state =
  { select :: Effect state
  , reduce :: (state -> state) -> Effect Unit
  }
```

## Subscription

`Subscription` is hooks of events that aren't related a specific node like window events, timers and so on.

Let's look at the router example with [purescript-freedom-router](https://github.com/purescript-freedom/purescript-freedom-router).

Here is how to implement `Subscription`.

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

You can pass multiple subscriptions to `Freedom.run`.

And subscriptions are run once when initializing app.

See [another example of `Subscription`](https://github.com/purescript-freedom/purescript-freedom-window-resize) if you like.

## View

Here is the detail about `View`.

The idea in purescript-freedom is that the essence of the application is the state itself.

So `View` is just a mapping of `State` like `state -> VNode state`.

### Kind of `VNode`

`VNode` are 2 kinds.

- `Text`
  - Just a text content
- `Element`
  - A Element like `div`, `p` and so on

Constructors are provided by `Freedom.Markup`.

#### How to construct

##### `Text`

You can use `Text` with `t` function.

```purescript
import Prelude

import Freedom.Markup as H
import Freedom.UI (VNode)

type State = Array Int

sampleText :: VNode State
sampleText = H.t "Sample text"
```

##### `Element`

You can use tag functions like `div`.

And you can set children to `VNode` with `kids` function.

Like this:

```purescript
import Prelude

import Freedom.Markup as H
import Freedom.UI (VNode)

type State = Array Int

sampleList :: State -> VNode State
sampleList xs =
  H.ul # H.kids (sampleListItem <$> xs)

sampleListItem :: Int -> VNode State
sampleListItem x =
  H.keyed (show x) $ H.li # H.kids [ H.t $ show x ]
```

### Lifecycles

`Element` have following lifecycles:

- `didCreate`
  - Trigger when created a node
- `didUpdate`
  - Trigger when updated a node
- `didDelete`
  - Trigger when deleted a node

#### Example

This is an example that an element is focused when created.

```purescript
import Prelude

import Data.Maybe (Maybe(..))
import Freedom.Markup as H
import Freedom.UI (VNode)
import Web.DOM.Element (Element)
import Web.HTML.HTMLElement (focus, fromElement)

type State = String

nameField :: State -> VNode State
nameField name =
  H.input
    # H.didCreate didCreate
    # H.onChange changeName
    # H.type_ "text"
    # H.value name

didCreate :: Element -> Operation State -> Effect Unit 
didCreate element _ =
  case fromElement element of
    Nothing -> pure unit
    Just htmlEl -> focus htmlEl
```

### Event handlers

You can bind event handlers to `Element`.

Here is an example:

```purescript
import Prelude

import Data.Maybe (Maybe(..))
import Freedom.Markup as H
import Freedom.UI (VNode)
import Web.DOM.Element (Element)
import Web.Event.Event (Event, target)
import Web.HTML.HTMLElement (focus, fromElement)
import Web.HTML.HTMLInputElement as Input

type State = String

nameField :: State -> VNode State
nameField name =
  H.input
    # H.didCreate didCreate
    # H.onChange changeName
    # H.type_ "text"
    # H.value name

changeName :: Event -> Operation State -> Effect Unit
changeName evt { query } =
  case Input.fromEventTarget <$> target evt of
    Just (Just el) -> do
      name <- Input.value el
      query.reduce $ const name
    _ -> pure unit

didCreate :: Element -> Operation State -> Effect Unit
didCreate element _ =
  case fromElement element of
    Nothing -> pure unit
    Just htmlEl -> focus htmlEl
```

`Freedom.Markup` provides many event handler helpers.

### Props

`Freedom.Markup` provides many propery helpers such as `type_`, `value` and so on.

You can write codes with them like this:

```purescript
nameField :: State -> VNode State
nameField name =
  H.input
    # H.didCreate didCreate
    # H.onChange changeName
    # H.type_ "text" -- This is "type" prop
    # H.value name -- This is "value" prop
```

NOTE: Some helpers have underscores in function names due to PureScript reserved words, like `main_`, `type_` and `kind_`.

#### CSS

`purescript-freedom` has the mechanism "CSS in PS".

How to use:

```purescript
justDiv :: VNode State
justDiv =
  H.div # H.css styles

styles :: String
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

You can write CSS passing css string to `css` function.

The mechanism is very simple.

`purescript-freedom` emulates scoped CSS by generating hash from passed css string, and it is used as `class`. And it replaces `&` in css string with generated hash, then outputs styles.

It evaluates styles gradually as each node is rendered because styles evaluation is incorporated in rendering process.

### Key

`Key` helps `purescript-freedom` identify which items have changed, are added, or are removed.

It is very important in Virtual DOM.

**Keys must only be unique among siblings.**

You can add a key to `VNode` with `keyed` function.

```purescript
import Prelude

import Freedom.Markup as H
import Freedom.UI (VNode)

type State = Array Int

sampleList :: State -> VNode State
sampleList xs =
  H.ul # H.kids (sampleListItem <$> xs)

sampleListItem :: Int -> VNode State
sampleListItem x =
  H.keyed (show x) $ H.li # H.kids [ H.t $ show x ]
```

You can write codes without keys, **but `purescript-freedom` recommends using keys when map `Array a` to `Array (VNode state)`**.

For your reference, if you do not add keys, `purescript-freedom` generates key from tag name and index of array.

`purescript-freedom` indentify `VNode` by keys, lifecycle mechanism is supported by it.

If Lifecycle is not triggered correctly, you should consider using keys.

### Where is a markup helper I want ?

When you write some codes, markup helpers that you want may be not in `Freedom.Markup`.

Even if so, there are helpers for such a case in `Freedom.Markup`.

- `tag`
  - For tags
- `prop`
  - For properties
- `handle`
  - For event handlers

Please use them if you want.

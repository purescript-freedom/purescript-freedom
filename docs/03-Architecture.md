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
import Freedom.TransformF.Simple (transformF)
import State (initialState)
import View (view)

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState -- initialState is here.
  , subscriptions: []
  , transformF
  , view
  }
```

Pure functions to update are used in `Action`.

NOTE: The state shape is very important for your productivity, so you should consider it seriously.

NOTE: If you will implement complex UI, check [purescript-identy](https://github.com/oreshinya/purescript-identy).

## Action

The role of `Action` is that it runs effects such as communicate with server or browser, get current app state, modify app state and so on.

`Action` can be registered as event handlers of `View`, also, it can be run in `Subscription`.

Now then, the type of `Action` is `FreeT (f state) m Unit`.

Therefore, you can implement your `Action` DSL with `Functor`.

The reason that `purescript-freedom` adopts `FreeT` is to make `Action` testable easy.

Example:

```purescript
module Freedom.TransformF.Simple where

import Prelude

import Control.Monad.Free.Trans (FreeT, liftFreeT)
import Effect.Class (liftEffect)
import Freedom.Store (Query)
import Freedom.TransformF.Type (TransformF)

data VQueryF state a
  = Select (state -> a)
  | Reduce (state -> state) a

type VQuery state = FreeT (VQueryF state)

derive instance functorVQuery :: Functor (VQueryF state)

select :: forall state m. Monad m => VQuery state m state
select = liftFreeT $ Select identity

reduce :: forall state m. Monad m => (state -> state) -> VQuery state m Unit
reduce f = liftFreeT $ Reduce f unit

transformF :: forall state. Query state -> TransformF VQueryF state
transformF query (Select k) =
  liftEffect $ k <$> query.select
transformF query (Reduce f next) = do
  liftEffect $ query.reduce f
  pure next
```

This is `Functor` that `purescript-freedom` provides as default.

`select` is DSL for getting app state, and `reduce` is DSL for modifying app state.

For running `FreeT`, it wants an interpreter.

`transformF` is the interpreter.

`Query state` is accessor to app state, and the type is following:

```purescript
type Query state =
  { select :: Effect state
  , reduce :: (state -> state) -> Effect Unit
  }
```

And you can initialize `purescript-freedom` like this:

```purescript
import Prelude

import Effect (Effect)
import Freedom as Freedom
import Freedom.TransformF.Simple (transformF)
import State (initialState)
import View (view)

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState
  , subscriptions: []
  , transformF
  , view
  }
```

Now, what is `m` in `FreeT (f state) m Unit` ?

As we will explain in more detail later, there are three virtual elements in `purescript-freedom`.

- `Text`
  - Just a text content
- `Element`
  - Render as DOM Element like `div`, `p` and so on
- `OperativeElement`
  - Render as DOM Element but is not rendered children of it automatically

In `OperativeElement`, you have to render children in lifecycles or event handlers.

You can bind `Action` to `Element` and `OperativeElement`, but its type is different, in other words, `m` is different.

In `Element`, `m` is `Aff`.

In `OperativeElement`, `m` is `VRender f state`.

Please keep this in the back of your head.

Here is examples.

- [`Action` example using default transformF](https://github.com/purescript-freedom/purescript-freedom/blob/master/examples/basic/src/PostsIndex/Action.purs#L19-L36)
- [`Action` example using user defined transformF](https://github.com/purescript-freedom/purescript-freedom/blob/master/examples/user-defined-transformF/src/PostsIndex/Action.purs#L17-L34)

## Subscription

`Subscription` is hooks of events that aren't related a specific node like window events, timers and so on.

Let's look at the router example with [purescript-freedom-router](https://github.com/purescript-freedom/purescript-freedom-router).

Here is how to implement `Subscription`.

```purescript
router
  :: forall f state
   . Functor (f state)
  => (String -> FreeT (f state) Aff Unit)
  -> Subscription f state
router matcher =
  subscription \transform -> do
    let handler = do
          l <- window >>= location
          path <- (<>) <$> pathname l <*> search l
          launchAff_ $ transform $ matcher path
    handler
    listener <- eventListener $ const handler
    window <#> toEventTarget >>= addEventListener popstate listener false
```

This registers an event handler to window with passed `Action`.

`subscription` is a constructor function for `Subscription`, which receives `transform` for `Action`.

So you can run `Action` when trigger events.

Here is how to use this router subscription.

```purescript
data Route
  = Home
  | User Int
  | Users String
  | NotFound

type State = Route

type Sub = Subscription VQueryF State

type Html = VNode VQueryF State

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState: Home
  , subscriptions: [ router' ]
  , transformF
  , view
  }

router' :: Sub
router' = router \url -> reduce $ const $ route url
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

So `View` is just a mapping of `State` like `state -> VNode f state`.

`f` is `Functor` for `FreeT`, and `state` is app state.

And `VNode` has key and `VElement`.

### VElement

`VElement` are 3 types.

- `Text`
  - Just a text content
- `Element`
  - Render as DOM Element like `div`, `p` and so on
- `OperativeElement`
  - Render as DOM Element but is not rendered children of it automatically
  - You have to render children in lifecycles or event handlers.

Constructors are provided by `Freedom.Markup`.

#### How to construct

##### `Text`

You can use `Text` with `t` function.

```purescript
import Prelude

import Freedom.Markup as H
import Freedom.TransformF.Simple (VQueryF)
import Freedom.VNode (VNode)

type State = Array Int

type Html = VNode VQueryF State

sampleText :: Html
sampleText = H.t "Sample text"
```

##### `Element`

You can use `Element` with `el` function and tag functions like `div`.

And you can set children to `VNode` with `kids` function.

Like this:

```purescript
import Prelude

import Freedom.Markup as H
import Freedom.TransformF.Simple (VQueryF)
import Freedom.VNode (VNode)

type State = Array Int

type Html = VNode VQueryF State

sampleList :: State -> Html
sampleList xs =
  H.el $ H.ul # H.kids (sampleListItem <$> xs)

sampleListItem :: Int -> Html
sampleListItem x =
  H.el $ H.li # H.kids [ H.t $ show x ]
```

##### `OperativeElement`

About `OperativeElement`, it is almost the same as `Element`.

The difference is using `op` function instead of `el` function.

```purescript
import Prelude

import Freedom.Markup as H
import Freedom.TransformF.Simple (VQueryF)
import Freedom.VNode (VNode)

type State = Array Int

type Html = VNode VQueryF State

sampleList :: State -> Html
sampleList xs =
  H.op $ H.ul # H.kids (sampleListItem <$> xs)

sampleListItem :: Int -> Html
sampleListItem x =
  H.el $ H.li # H.kids [ H.t $ show x ]
```

`OperativeElement` is advanced usage in `purescript-freedom`.

Children of `sampleList` are not rendered automatically.

You have to render them in lifecycles or event handlers.

I will explain later how to render children of `OperativeElement`.

### Lifecycles

`Element` and `OperativeElement` have following lifecycles:

- `didCreate`
  - Trigger when created a node
- `didUpdate`
  - Trigger when updated a node
- `didDelete`
  - Trigger when deleted a node

The type of these lifecycles is `Element -> FreeT (f state) m Unit` and this `Element` is not `Element` of `purescript-freedom` but `Element` of `Web.DOM.Element`.

When you can't avoid to touch real DOM elements, it will be useful that a real DOM element is passed to lifecycles.

#### Examples

##### `Element`

This is an example that an element is focused when created.

```purescript
import Prelude

import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Freedom.Markup as H
import Freedom.TransformF.Simple (VQueryF, VQuery)
import Freedom.VNode (VNode)
import Web.DOM.Element (Element)
import Web.HTML.HTMLElement (focus, fromElement)

type State = String

type Action = VQuery State Aff Unit

type Html = VNode VQueryF State

nameField :: State -> Html
nameField name =
  H.el $ H.input
    # H.didCreate didCreate
    # H.onChange changeName
    # H.type_ "text"
    # H.value name

didCreate :: Element -> Action
didCreate element =
  case fromElement element of
    Nothing -> pure unit
    Just htmlEl -> liftEffect $ focus htmlEl
```

##### `OperativeElement`

This is a simple example that an element just renders children in lifecycle.

```purescript
import Prelude

import Control.Monad.Trans.Class (lift)
import Effect.Class (liftEffect)
import Freedom.Markup as H
import Freedom.TransformF.Simple (VQueryF, VQuery)
import Freedom.VNode (VNode, VRender, operations)
import Web.DOM.Element (Element, toNode)

type State = Array Int

type Operation = VQuery State (VRender VQueryF State) Unit

type Html = VNode VQueryF State

sampleList :: State -> Html
sampleList xs =
  H.op $ H.ul
    # H.didCreate didCreate
    # H.didUpdate didUpdate
    # H.didDelete didDelete
    # H.kids (sampleListItem <$> xs)

sampleListItem :: Int -> Html
sampleListItem x =
  H.el $ H.li # H.kids [ H.t $ show x ]

didCreate :: Element -> Operation
didCreate element = do
  ops <- lift operations
  liftEffect $ ops.getOriginChildren >>= ops.renderChildren (toNode element)

didUpdate :: Element -> Operation
didUpdate element = do
  ops <- lift operations
  liftEffect $ ops.getOriginChildren >>= ops.renderChildren (toNode element)

didDelete :: Element -> Operation
didDelete element = do
  ops <- lift operations
  liftEffect $ ops.renderChildren (toNode element) []
```

In `OperativeElement`, you can get following operations for rendering children.

The oparations has following type.

```purescript
type Operations f state =
  { getOriginChildren :: Effect (Array (VNode f state))
  , getLatestRenderedChildren :: Effect (Array (VNode f state))
  , renderChildren :: Node -> Array (VNode f state) -> Effect Unit
  }
```

- `getOriginChildren`
  - Get children passed with `kids` of `OperativeElement`
- `getLatestRenderedChildren`
  - Get children already rendered
- `renderChildren`
  - Patch passed children with previous rendered children

With that in mind, let's look at the code above.

In `didCreate`, it gets original children and renders them.

In `didUpdate`, it gets original children and renders them, but `OperativeElement` stored rendering history, it patches children with previous rendered children.

In `didDelete`, it renders empty array as children.

What is this?

`renderChildren` is patching, so if it is received empty array, it means deletion.

**NOTE: When you use `OperativeElement`, you should call `renderChildren` in all lifecycles, because `OperativeElement` doesn't patch children by itself.**

If you want more examples, see following packages.

- [purescript-freedom-portal](https://github.com/purescript-freedom/purescript-freedom-portal)
- [purescript-freedom-transition](https://github.com/purescript-freedom/purescript-freedom-transition)
- [purescript-freedom-virtualized](https://github.com/purescript-freedom/purescript-freedom-virtualized)

### Event handlers

You can bind event handlers to `Element` and `OperativeElement`.

The type of event handlers is almost same as lifecycles, but an argment is not `Element` of `Web.DOM.Element` but `Event` of `Web.Event.Event`.
In other words, The type is `Event -> FreeT (f state) m Unit`.

Here is an example:

```purescript
import Prelude

import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Freedom.Markup as H
import Freedom.TransformF.Simple (VQueryF, VQuery)
import Freedom.VNode (VNode)
import Web.DOM.Element (Element)
import Web.Event.Event (Event, target)
import Web.HTML.HTMLElement (focus, fromElement)
import Web.HTML.HTMLInputElement as Input

type State = String

type Action = VQuery State Aff Unit

type Html = VNode VQueryF State

nameField :: State -> Html
nameField name =
  H.el $ H.input
    # H.didCreate didCreate
    # H.onChange changeName
    # H.type_ "text"
    # H.value name

changeName :: Event -> Action
changeName evt =
  case Input.fromEventTarget <$> target evt of
    Just (Just el) -> do
      name <- liftEffect $ Input.value el
      reduce $ const name
    _ -> pure unit

didCreate :: Element -> Action
didCreate element =
  case fromElement element of
    Nothing -> pure unit
    Just htmlEl -> liftEffect $ focus htmlEl
```

`Freedom.Markup` provides many event handler helpers.

### Props

`Freedom.Markup` provides many propery helpers such as `type_`, `value` and so on.

You can write codes with them like this:

```purescript
nameField :: State -> Html
nameField name =
  H.el $ H.input
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
justDiv :: Html
justDiv =
  H.el $ H.div # H.css styles

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
import Freedom.TransformF.Simple (VQueryF)
import Freedom.VNode (VNode)

type State = Array Int

type Html = VNode VQueryF State

sampleList :: State -> Html
sampleList xs =
  H.el $ H.ul # H.kids (sampleListItem <$> xs)

sampleListItem :: Int -> Html
sampleListItem x =
  H.keyed (show x) $ H.el $ H.li # H.kids [ H.t $ show x ]
```

You can write codes without keys, **but `purescript-freedom` recommends using keys when map `Array a` to `Array (VNode f state)`**.

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
- `on`
  - For event handlers

Please use them if you want.

## Official examples

- [Basic example](https://github.com/purescript-freedom/purescript-freedom/tree/master/examples/basic)
- [SVG example](https://github.com/purescript-freedom/purescript-freedom/tree/master/examples/svg)
- [User defined transform example](https://github.com/purescript-freedom/purescript-freedom/tree/master/examples/user-defined-transformF)

## Official packages

- [purescript-freedom-router](https://github.com/purescript-freedom/purescript-freedom-router)
- [purescript-freedom-portal](https://github.com/purescript-freedom/purescript-freedom-portal)
- [purescript-freedom-transition](https://github.com/purescript-freedom/purescript-freedom-transition)
- [purescript-freedom-virtualized](https://github.com/purescript-freedom/purescript-freedom-virtualized)
- [purescript-freedom-window-resize](https://github.com/purescript-freedom/purescript-freedom-window-resize)
- [purescript-freedom-now](https://github.com/purescript-freedom/purescript-freedom-now)

## Related packages

- [purescript-identy](https://github.com/oreshinya/purescript-identy)

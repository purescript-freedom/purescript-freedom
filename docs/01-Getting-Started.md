# Getting Started

`purescript-freedom` is one of the Virtual DOM.

It provides state management and css with auto-generated class, and has no npm dependency.

If you are wondering what to use for the Virtual DOM, it may be one of your good choices.

## Installation

### Bower

```
$ bower install --save purescript-freedom
```

### Spago

Now, `purescript-freedom` isn't included in `package-sets`.
You edit `packages.dhall` like [this](https://github.com/purescript-freedom/purescript-freedom/blob/master/examples/basic/packages.dhall), and you can install freedom.

```
$ spago install freedom
```

But I will add it to `package-sets`.

## Example

`purescript-freedom` manages the whole state of your application in single state.
And, for example, you can update state using `reduce` function and pure function that has `State -> State` type in a handler.
This is one of big difference other UI libraries that update state through algebraic data type.

Like this:

```purescript
module Main where

import Prelude

import Effect (Effect)
import Freedom as Freedom
import Freedom.Markup as H
import Freedom.TransformF.Simple (VQueryF, transformF, reduce)
import Freedom.VNode (VNode)

type State = Int

type Html = VNode VQueryF State

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState: 0
  , subscriptions: []
  , transformF
  , view
  }

increment :: State -> State
increment = (_ + 1)

decrement :: State -> State
decrement = (_ - 1)

view :: State -> Html
view state =
  H.el $ H.div # H.kids
    [ H.el $ H.div # H.kids [ H.t $ show state ]
    , H.el $ H.button
        # H.onClick (const $ reduce increment)
        # H.kids [ H.t "Increment" ]
    , H.el $ H.button
        # H.onClick (const $ reduce decrement)
        # H.kids [ H.t "Decrement" ]
    ]

```

If you are interested in `purescript-freedom`, please take a look at [other samples](https://github.com/purescript-freedom/purescript-freedom/tree/master/examples) or [some packages](https://github.com/purescript-freedom) ;)

## Next

Please let me explain the concept if you like.

[Concepts](https://github.com/purescript-freedom/purescript-freedom/tree/master/docs/02-Concepts.md)

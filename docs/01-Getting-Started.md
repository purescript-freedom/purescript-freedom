# Getting Started

`purescript-freedom` is one of the Virtual DOM.

It has no npm dependency.

## Installation

### Bower

```
$ bower install --save purescript-freedom
```

### Spago

```
$ spago install freedom
```

## Example

The counter example is below.

```purescript
module Main where

import Prelude

import Effect (Effect)
import Freedom as Freedom
import Freedom.Markup as H
import Freedom.UI (VNode, Operation)

type State = Int

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState: 0
  , subscriptions: []
  , view
  }

view :: State -> VNode State
view count =
  H.div # H.css containerStyles # H.kids
    [ H.button
        # H.css buttonStyles
        # H.onClick (const decrement)
        # H.kids [ H.t "-" ]
    , H.div
        # H.css countStyles
        # H.kids [ H.t $ show count ]
    , H.button
        # H.css buttonStyles
        # H.onClick (const increment)
        # H.kids [ H.t "+" ]
    ]
  where
    containerStyles = """
    body {
      margin: 0;
    }
    .& {
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    """
    buttonStyles = """
    .& {
      width: 32px;
      height: 32px;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 24px;
      cursor: pointer;
    }
    """
    countStyles = """
    .& {
      font-size: 48px;
      font-weight: bold;
      margin: 0 24px;
    }
    """

increment :: Operation State -> Effect Unit
increment operation =
  operation.query.reduce (_ + 1)

decrement :: Operation State -> Effect Unit
decrement operation =
  operation.query.reduce (_ - 1)
```

Points:
- It has single state as whole state of application.
- You can write css with auto-generated class.
- You can update state using `reduce` function and pure function as state updater.

If you are interested in `purescript-freedom`, please take a look at [other samples](https://github.com/purescript-freedom/purescript-freedom/tree/master/examples) or [some packages](https://github.com/purescript-freedom) ;)

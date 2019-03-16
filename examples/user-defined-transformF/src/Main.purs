module Main where

import Prelude

import Effect (Effect)
import Freedom as Freedom
import State (initialState)
import Subscription (subscriptions)
import TransformF (transformF)
import View (view)

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState
  , subscriptions
  , transformF
  , view
  }

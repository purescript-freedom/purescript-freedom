module Main where

import Prelude

import Effect (Effect)
import Freedom as Freedom
import Freedom.TransformF.Simple (transformF)
import State (initialState)
import Subscription (subscriptions)
import View (view)

main :: Effect Unit
main = Freedom.run
  { selector: "#app"
  , initialState
  , subscriptions
  , transformF
  , view
  }

module Subscription.Router where

import Prelude

import Freedom.Router (router)
import Freedom.TransformF.Simple (reduce)
import State (resetUIState)
import State.Route (fromURL)
import Type (Sub)

subscription :: Sub
subscription =
  router \url ->
    reduce $ resetUIState >>> _ { route = fromURL url }

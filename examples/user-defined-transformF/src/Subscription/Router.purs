module Subscription.Router where

import Freedom.Router (router)
import State.Route (fromURL)
import TransformF (reduce)
import Type (Sub)

subscription :: Sub
subscription =
  router \url ->
    reduce _ { route = fromURL url }

module Subscription.Router where

import Freedom.Router (router)
import Freedom.TransformF.Simple (reduce)
import State.Route (fromURL)
import Type (Sub)

subscription :: Sub
subscription =
  router \url ->
    reduce _ { route = fromURL url }

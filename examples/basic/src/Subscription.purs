module Subscription where

import Subscription.Router as Router
import Type (Sub)

subscriptions :: Array Sub
subscriptions =
  [ Router.subscription
  ]

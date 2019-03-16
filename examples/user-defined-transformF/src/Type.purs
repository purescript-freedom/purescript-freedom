module Type where

import Prelude

import Effect.Aff (Aff)
import Freedom.Subscription (Subscription)
import Freedom.VNode (VNode)
import State (State)
import TransformF (VQueryF, VQuery)

-- Note: The types in this file are used frequently in app.

type Html = VNode VQueryF State

type Sub = Subscription VQueryF State

type Action = VQuery State Aff Unit

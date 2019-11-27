module Type where

import Effect.Aff (Aff)
import Freedom.Subscription (Subscription)
import Freedom.TransformF.Simple (VQueryF, VQuery)
import Freedom.VNode (VNode)
import State (State)

-- Note: The types in this file are used frequently in app.

type Html = VNode VQueryF State

type Sub = Subscription VQueryF State

type Action = VQuery State Aff

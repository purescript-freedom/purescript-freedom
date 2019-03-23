module Freedom.Subscription
  ( Subscription
  , subscription
  , runSubscription
  ) where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Effect (Effect)
import Effect.Aff (Aff)

-- | The type of subscription
-- |
-- | Hooks of events that aren't related a specific node like window events, timers and so on.
newtype Subscription f state =
  Subscription ((FreeT (f state) Aff Unit -> Aff Unit) -> Effect Unit)

-- | A constructor function for `Subscription`.
subscription
  :: forall f state
   . Functor (f state)
  => ((FreeT (f state) Aff Unit -> Aff Unit) -> Effect Unit)
  -> Subscription f state
subscription = Subscription

-- | This is for internal. Do not use it.
runSubscription
  :: forall f state
   . Functor (f state)
  => (FreeT (f state) Aff Unit -> Aff Unit)
  -> Subscription f state
  -> Effect Unit
runSubscription transform (Subscription f) = f transform

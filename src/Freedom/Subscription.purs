module Freedom.Subscription
  ( Subscription
  , subscription
  , runSubscription
  ) where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Effect (Effect)
import Effect.Aff (Aff)

newtype Subscription f state =
  Subscription ((FreeT (f state) Aff Unit -> Aff Unit) -> Effect Unit)

subscription
  :: forall f state
   . Functor (f state)
  => ((FreeT (f state) Aff Unit -> Aff Unit) -> Effect Unit)
  -> Subscription f state
subscription = Subscription

runSubscription
  :: forall f state
   . Functor (f state)
  => (FreeT (f state) Aff Unit -> Aff Unit)
  -> Subscription f state
  -> Effect Unit
runSubscription transform (Subscription f) = f transform

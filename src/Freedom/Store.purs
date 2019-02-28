module Freedom.Store
  ( Store
  , Query
  , createStore
  , query
  , subscribe
  ) where

import Prelude

import Effect (Effect)
import Effect.Ref (Ref, modify_, new, read)
import SimpleEmitter as S

data Event = Emit

derive instance eqEvent :: Eq Event

derive instance ordEvent :: Ord Event

newtype Store state = Store
  { emitter :: S.Emitter Event
  , stateRef :: Ref state
  }

type Query state =
  { select :: Effect state
  , reduce :: (state -> state) -> Effect Unit
  }

createStore :: forall state. state -> Effect (Store state)
createStore state = do
  emitter <- S.createEmitter
  stateRef <- new state
  pure $ Store { emitter, stateRef }

query :: forall state. Store state -> Query state
query store =
  { select: select store
  , reduce: reduce store
  }

subscribe :: forall state. Effect Unit -> Store state -> Effect Unit
subscribe f (Store s) = S.subscribe Emit f s.emitter

select :: forall state. Store state -> Effect state
select (Store s) = read s.stateRef

reduce :: forall state. Store state -> (state -> state) -> Effect Unit
reduce (Store s) f = do
  modify_ f s.stateRef
  S.emit Emit s.emitter

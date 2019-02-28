module Freedom.TransformF.Simple where

import Prelude

import Control.Monad.Free.Trans (FreeT, liftFreeT)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Freedom.Store (Query)
import Freedom.TransformF.Type (TransformF)

data VQueryF state a
  = Select (state -> a)
  | Reduce (state -> state) a

type VQuery state = FreeT (VQueryF state)

derive instance functorVQuery :: Functor (VQueryF state)

select :: forall state. VQuery state Aff state
select = liftFreeT $ Select identity

reduce :: forall state. (state -> state) -> VQuery state Aff Unit
reduce f = liftFreeT $ Reduce f unit

transformF :: forall state. Query state -> TransformF VQueryF state
transformF query (Select k) =
  liftEffect $ k <$> query.select
transformF query (Reduce f next) = do
  liftEffect $ query.reduce f
  pure next

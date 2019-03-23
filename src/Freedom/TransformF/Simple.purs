module Freedom.TransformF.Simple where

import Prelude

import Control.Monad.Free.Trans (FreeT, liftFreeT)
import Effect.Class (liftEffect)
import Freedom.Store (Query)
import Freedom.TransformF.Type (TransformF)

data VQueryF state a
  = Select (state -> a)
  | Reduce (state -> state) a

type VQuery state = FreeT (VQueryF state)

derive instance functorVQuery :: Functor (VQueryF state)

-- | Get app state.
select :: forall state m. Monad m => VQuery state m state
select = liftFreeT $ Select identity

-- | Modify app state.
reduce :: forall state m. Monad m => (state -> state) -> VQuery state m Unit
reduce f = liftFreeT $ Reduce f unit

-- | An interpreter for `FreeT`.
transformF :: forall state. Query state -> TransformF VQueryF state
transformF query (Select k) =
  liftEffect $ k <$> query.select
transformF query (Reduce f next) = do
  liftEffect $ query.reduce f
  pure next

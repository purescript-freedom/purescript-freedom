module Freedom.TransformF.Type where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Effect.Aff (Aff)

type TransformF f state
  = f state (FreeT (f state) Aff Unit) -> Aff (FreeT (f state) Aff Unit)

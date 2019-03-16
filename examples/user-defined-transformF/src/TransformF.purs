module TransformF
  ( VQueryF(..)
  , VQuery
  , select
  , reduce
  , fetchGet
  , fetchPut
  , fetchPut_
  , fetchDelete_
  , transformF
  ) where

import Prelude

import Control.Monad.Free.Trans (FreeT, liftFreeT)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect.Aff (Aff, attempt)
import Effect.Class (liftEffect)
import Foreign (Foreign)
import Freedom.Store (Query)
import Freedom.TransformF.Type (TransformF)
import Milkis as M
import Milkis.Impl.Window (windowFetch)
import Simple.JSON (class ReadForeign, class WriteForeign, read, writeJSON)

data VQueryF state a
  = Select (state -> a)
  | Reduce (state -> state) a
  | Fetch M.URL M.Method (Maybe String) (Either Int Foreign -> a)

type VQuery state = FreeT (VQueryF state)

derive instance functorVQuery :: Functor (VQueryF state)

select :: forall state. VQuery state Aff state
select = liftFreeT $ Select identity

reduce :: forall state. (state -> state) -> VQuery state Aff Unit
reduce f = liftFreeT $ Reduce f unit

fetch
  :: forall state
   . M.URL
  -> M.Method
  -> Maybe String
  -> VQuery state Aff (Either Int Foreign)
fetch url method body = liftFreeT $ Fetch url method body identity

fetchGet :: forall state a. ReadForeign a => String -> VQuery state Aff (Either Int a)
fetchGet path =
  decode <$> fetch (toURL path) M.getMethod Nothing

fetchPut :: forall state a b. WriteForeign a => ReadForeign b => String -> a -> VQuery state Aff (Either Int b)
fetchPut path body =
  decode <$> fetchPut_ path body

fetchPut_ :: forall state a. WriteForeign a => String -> a -> VQuery state Aff (Either Int Foreign)
fetchPut_ path body =
  fetch (toURL path) M.putMethod $ Just $ writeJSON body

fetchDelete_ :: forall state. String -> VQuery state Aff (Either Int Foreign)
fetchDelete_ path =
  fetch (toURL path) M.deleteMethod Nothing

-- NOTE: This is dummy server.
toURL :: String -> M.URL
toURL path = M.URL $ "https://jsonplaceholder.typicode.com" <> path

-- NOTE: This is simple decoding for an example. Do not use it as it is for production. You should manage error detail in real world.
decode :: forall a. ReadForeign a => Either Int Foreign -> Either Int a
decode res =
  case res of
    Right res' ->
      case read res' of
        Right r -> Right r
        _ -> Left 499
    Left code -> Left code

transformF :: forall state. Query state -> TransformF VQueryF state
transformF query (Select k) =
  liftEffect $ k <$> query.select
transformF query (Reduce f next) = do
  liftEffect $ query.reduce f
  pure next
transformF _ (Fetch url method mBody k) = do
  res <- attempt case mBody of
    Nothing -> fetchImpl url { method, headers }
    Just body -> fetchImpl url { method, headers, body }
  case res of
    Left _ -> pure $ k $ Left 499
    Right res' ->
      if M.statusCode res' >= 400
        then pure $ k $ Left $ M.statusCode res'
        else k <<< Right <$> M.json res'
  where
    headers = M.makeHeaders { "Content-Type": "application/json" }

fetchImpl :: M.Fetch
fetchImpl = M.fetch windowFetch

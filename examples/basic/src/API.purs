module API
  ( get
  , put
  , put_
  , delete_
  ) where

import Prelude

import Data.Either (Either(..))
import Effect.Aff (Aff, attempt)
import Effect.Exception (Error)
import Milkis as M
import Milkis.Impl.Window (windowFetch)
import Simple.JSON (class ReadForeign, class WriteForeign, read, writeJSON)

get :: forall a. ReadForeign a => String -> Aff (Either Int a)
get path =
  (attempt $ fetch (toURL path) options) >>= decode
  where
    options =
      { method: M.getMethod
      , headers: M.makeHeaders { "Content-Type": "application/json" }
      }

put :: forall a b. WriteForeign a => ReadForeign b => String -> a -> Aff (Either Int b)
put path body =
  (attempt $ put_ path body) >>= decode

put_ :: forall a. WriteForeign a => String -> a -> Aff M.Response
put_ path body = fetch (toURL path) options
  where
    options =
      { method: M.putMethod
      , body: writeJSON body
      , headers: M.makeHeaders { "Content-Type": "application/json" }
      }

delete_ :: String -> Aff M.Response
delete_ path = fetch (toURL path) options
  where
    options =
      { method: M.deleteMethod
      , headers: M.makeHeaders { "Content-Type": "application/json" }
      }

-- NOTE: This is simple decoding for an example. Do not use it as it is for production. You should manage error detail in real world.
decode :: forall a. ReadForeign a => Either Error M.Response -> Aff (Either Int a)
decode res =
  case res of
    Right res' ->
      if M.statusCode res' >= 400
        then pure $ Left $ M.statusCode res'
        else do
          res_ <- M.json res'
          case read res_ of
            Right r -> pure $ Right r
            _ -> pure $ Left 499
    _ -> pure $ Left 499

fetch :: M.Fetch
fetch = M.fetch windowFetch

-- NOTE: This is dummy server.
toURL :: String -> M.URL
toURL path = M.URL $ "https://jsonplaceholder.typicode.com" <> path

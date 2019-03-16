module Entity.Request where

import Data.Maybe (Maybe(..))

type Request =
  { requesting :: Boolean
  , statusCode :: Maybe Int
  }

start :: Request -> Request
start = _ { requesting = true, statusCode = Nothing }

success :: Request -> Request
success = _ { requesting = false, statusCode = Nothing }

failure :: Int -> Request -> Request
failure statusCode = _ { requesting = false, statusCode = Just statusCode }

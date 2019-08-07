module Entity.Request where

import Prelude

data Request
  = Neutral
  | Requesting
  | Failure Int

derive instance eqRequest :: Eq Request

start :: Request -> Request
start = const Requesting

success :: Request -> Request
success = const Neutral

failure :: Int -> Request -> Request
failure statusCode = const $ Failure statusCode

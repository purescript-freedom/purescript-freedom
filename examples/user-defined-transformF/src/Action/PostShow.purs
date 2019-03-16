module Action.PostShow where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Entity.Request (start, success, failure)
import Record as R
import TransformF (reduce, fetchGet)
import Type (Action)

fetchPost :: Int -> Action
fetchPost postId = do
  reduce
    $ R.modify (SProxy :: _ "postShow")
    $ R.modify (SProxy :: _ "request")
    $ start
  res <- fetchGet $ "/posts/" <> show postId
  case res of
    Left statusCode ->
      reduce
        $ R.modify (SProxy :: _ "postShow")
        $ R.modify (SProxy :: _ "request")
        $ failure statusCode
    Right post ->
      reduce
        $ R.modify (SProxy :: _ "postShow")
        $ R.modify (SProxy :: _ "request") success
        >>> (R.set (SProxy :: _ "post") $ Just post)

module PostShow.Action where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Entity.Request (start, success, failure)
import PostShow.State (initialState)
import Record as R
import TransformF (reduce, fetchGet)
import Type (Action)

fetchPost :: Int -> Action
fetchPost postId = do
  reduce $ modifyRequest start
  res <- fetchGet $ "/posts/" <> show postId
  case res of
    Left statusCode ->
      reduce $ modifyRequest $ failure statusCode
    Right post ->
      reduce
        $ modifyRequest success
        >>> (setPost $ Just post)
  where
    modifyRequest =
      R.modify (SProxy :: _ "postShow")
        <<< R.modify (SProxy :: _ "request")
    setPost =
      R.modify (SProxy :: _ "postShow")
        <<< R.set (SProxy :: _ "post")

resetState :: Action
resetState =
  reduce _ { postShow = initialState }

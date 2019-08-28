module PostShow.Action where

import Prelude

import API as API
import Control.Monad.Trans.Class (lift)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Entity.Request (start, success, failure)
import Freedom.TransformF.Simple (reduce)
import Record as R
import Type (Action)

fetchPost :: Int -> Action
fetchPost postId = do
  reduce $ modifyRequest start
  res <- lift $ API.get $ "/posts/" <> show postId
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

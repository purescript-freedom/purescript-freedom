module Action.PostEdit where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Effect.Class (liftEffect)
import Entity.Request (start, success, failure)
import Freedom.Router (navigateTo)
import Record as R
import TransformF (select, reduce, fetchGet, fetchPut)
import Type (Action)

fetchPost :: Int -> Action
fetchPost postId = do
  reduce
    $ R.modify (SProxy :: _ "postEdit")
    $ R.modify (SProxy :: _ "request")
    $ start
  res <- fetchGet $ "/posts/" <> show postId
  case res of
    Left statusCode ->
      reduce
        $ R.modify (SProxy :: _ "postEdit")
        $ R.modify (SProxy :: _ "request")
        $ failure statusCode
    Right post ->
      reduce
        $ R.modify (SProxy :: _ "postEdit")
        $ R.modify (SProxy :: _ "request") success
        >>> (R.set (SProxy :: _ "post") $ Just post)

updatePost :: Action
updatePost = do
  maybePost <- select <#> _.postEdit.post
  case maybePost of
    Nothing -> pure unit
    Just post -> do
      reduce
        $ R.modify (SProxy :: _ "postEdit")
        $ R.modify (SProxy :: _ "update")
        $ start
      res <- fetchPut ("/posts/" <> show post.id) post
      case res of
        Left statusCode ->
          reduce
            $ R.modify (SProxy :: _ "postEdit")
            $ R.modify (SProxy :: _ "update")
            $ failure statusCode
        Right post' -> do
          reduce
            $ R.modify (SProxy :: _ "postEdit")
            $ R.modify (SProxy :: _ "update") success
            >>> (R.set (SProxy :: _ "post") $ Just post')
          liftEffect $ navigateTo $ "/posts/" <> show post'.id

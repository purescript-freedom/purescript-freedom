module Action.PostsIndex where

import Prelude

import Data.Array (delete)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Entity.Post (Post)
import Entity.Request (start, success, failure)
import Record as R
import TransformF (select, reduce, fetchGet, fetchDelete_)
import Type (Action)

fetchPosts :: Action
fetchPosts = do
  reduce
    $ R.modify (SProxy :: _ "postsIndex")
    $ R.modify (SProxy :: _ "request")
    $ start
  res <- fetchGet "/posts"
  case res of
    Left statusCode ->
      reduce
        $ R.modify (SProxy :: _ "postsIndex")
        $ R.modify (SProxy :: _ "request")
        $ failure statusCode
    Right posts ->
      reduce
        $ R.modify (SProxy :: _ "postsIndex")
        $ R.modify (SProxy :: _ "request") success
        >>> R.set (SProxy :: _ "posts") posts

deletePost :: Action
deletePost = do
  post <- select <#> _.postsIndex.deleteTargetPost
  case post of
    Nothing -> pure unit
    Just post' -> do
      reduce
        $ R.modify (SProxy :: _ "postsIndex")
        $ R.modify (SProxy :: _ "posts") (delete post')
        >>> R.set (SProxy :: _ "deleteTargetPost") Nothing
      void $ fetchDelete_ $ "/posts/" <> show post'.id

openDeleteDialog :: Post -> Action
openDeleteDialog post =
  reduce
    $ R.modify (SProxy :: _ "postsIndex")
    $ R.set (SProxy :: _ "deleteTargetPost") $ Just post

closeDeleteDialog :: Action
closeDeleteDialog =
  reduce
    $ R.modify (SProxy :: _ "postsIndex")
    $ R.set (SProxy :: _ "deleteTargetPost") Nothing

module PostsIndex.Action where

import Prelude

import API as API
import Control.Monad.Trans.Class (lift)
import Data.Array (delete)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Effect.Class (liftEffect)
import Entity.Post (Post)
import Entity.Request (start, success, failure)
import Freedom.TransformF.Simple (select, reduce)
import Record as R
import Type (Action)
import Web.Event.Event (Event, stopPropagation)

fetchPosts :: Action
fetchPosts = do
  reduce $ modifyRequest start
  res <- lift $ API.get "/posts"
  case res of
    Left statusCode ->
      reduce $ modifyRequest $ failure statusCode
    Right posts ->
      reduce
        $ modifyRequest success
        >>> setPosts posts
  where
    modifyRequest =
      R.modify (SProxy :: _ "postsIndex")
        <<< R.modify (SProxy :: _ "request")
    setPosts =
      R.modify (SProxy :: _ "postsIndex")
        <<< R.set (SProxy :: _ "posts")

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
      lift $ void $ API.delete_ $ "/posts/" <> show post'.id

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

blockEvent :: Event -> Action
blockEvent = liftEffect <<< stopPropagation

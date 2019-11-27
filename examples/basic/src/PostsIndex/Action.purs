module PostsIndex.Action where

import Prelude

import API as API
import Data.Array (delete)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Effect.Aff.Class (liftAff)
import Effect.Class (liftEffect)
import Entity.Post (Post)
import Entity.Request (start, success, failure)
import Freedom.TransformF.Simple (select, reduce)
import PostsIndex.State (initialState)
import Record as R
import Type (Action)
import Web.Event.Event (Event, stopPropagation)

fetchPosts :: Action Unit
fetchPosts = do
  reduce $ modifyRequest start
  res <- liftAff $ API.get "/posts"
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

deletePost :: Action Unit
deletePost = do
  post <- select <#> _.postsIndex.deleteTargetPost
  case post of
    Nothing -> pure unit
    Just post' -> do
      reduce
        $ R.modify (SProxy :: _ "postsIndex")
        $ R.modify (SProxy :: _ "posts") (delete post')
        >>> R.set (SProxy :: _ "deleteTargetPost") Nothing
      liftAff $ void $ API.delete_ $ "/posts/" <> show post'.id

openDeleteDialog :: Post -> Action Unit
openDeleteDialog post =
  reduce _ { postsIndex { deleteTargetPost = Just post } }

closeDeleteDialog :: Action Unit
closeDeleteDialog =
  reduce _ { postsIndex { deleteTargetPost = Nothing } }

blockEvent :: Event -> Action Unit
blockEvent = liftEffect <<< stopPropagation

resetState :: Action Unit
resetState =
  reduce _ { postsIndex = initialState }

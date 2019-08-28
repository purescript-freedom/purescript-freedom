module PostEdit.Action where

import Prelude

import API as API
import Control.Monad.Trans.Class (lift)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Effect.Class (liftEffect)
import Entity.Post (updateTitle, updateBody)
import Entity.Request (start, success, failure)
import Freedom.Router (navigateTo)
import Freedom.TransformF.Simple (select, reduce)
import Record as R
import Type (Action)
import Web.Event.Event (Event, target)
import Web.HTML.HTMLInputElement as Input
import Web.HTML.HTMLTextAreaElement as TextArea

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
      R.modify (SProxy :: _ "postEdit")
        <<< R.modify (SProxy :: _ "request")
    setPost =
      R.modify (SProxy :: _ "postEdit")
        <<< R.set (SProxy :: _ "post")

changeTitle :: Event -> Action
changeTitle evt =
  case Input.fromEventTarget <$> target evt of
    Just (Just el) -> do
      title <- liftEffect $ Input.value el
      reduce
        $ R.modify (SProxy :: _ "postEdit")
        $ R.modify (SProxy :: _ "post")
        $ map (updateTitle title)
    _ -> pure unit

changeBody :: Event -> Action
changeBody evt =
  case TextArea.fromEventTarget <$> target evt of
    Just (Just el) -> do
      body <- liftEffect $ TextArea.value el
      reduce
        $ R.modify (SProxy :: _ "postEdit")
        $ R.modify (SProxy :: _ "post")
        $ map (updateBody body)
    _ -> pure unit

updatePost :: Action
updatePost = do
  maybePost <- select <#> _.postEdit.post
  case maybePost of
    Nothing -> pure unit
    Just post -> do
      reduce $ modifyUpdate start
      res <- lift $ API.put ("/posts/" <> show post.id) post
      case res of
        Left statusCode ->
          reduce $ modifyUpdate $ failure statusCode
        Right post' -> do
          reduce
            $ modifyUpdate success
            >>> (setPost $ Just post')
          liftEffect $ navigateTo $ "/posts/" <> show post'.id
  where
    modifyUpdate =
      R.modify (SProxy :: _ "postEdit")
        <<< R.modify (SProxy :: _ "update")
    setPost =
      R.modify (SProxy :: _ "postEdit")
        <<< R.set (SProxy :: _ "post")
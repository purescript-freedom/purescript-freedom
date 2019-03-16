module View.PostShow
  ( view
  ) where

import Prelude

import API as API
import Control.Monad.Trans.Class (lift)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Entity.Request (start, success, failure)
import Freedom.Markup as H
import Freedom.Router (link)
import Freedom.TransformF.Simple (reduce)
import Record as R
import State.PostShow (State)
import Type (Html, Action)
import View.Common (withRequest)
import View.NotFound as NotFound

-- View

view :: Int -> State -> Html
view postId { request, post } =
  withRequest request (fetchPost postId)
    case post of
      Nothing -> NotFound.view
      Just post' ->
        H.el $ H.div # H.kids
          [ H.el $ H.h2 # H.kids [ H.t post'.title ]
          , H.el $ H.pre # H.css cssPre # H.kids [ H.t post'.body ]
          , H.el $ H.div # H.css cssBottom
              # H.kids
                  [ H.el $ link ("/posts/" <> show post'.id <> "/edit")
                      # H.css cssLink
                      # H.kids [ H.t "EDIT" ]
                  ]
          ]
  where
    cssPre = ".& { font-size: 16px; }"
    cssBottom =
      """
      .& {
        display: flex;
        justify-content: flex-end;
        align-items: center;
      }
      """
    cssLink = ".&:hover { color: #898989; }"

-- Action

fetchPost :: Int -> Action
fetchPost postId = do
  reduce
    $ R.modify (SProxy :: _ "postShow")
    $ R.modify (SProxy :: _ "request")
    $ start
  res <- lift $ API.get $ "/posts/" <> show postId
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

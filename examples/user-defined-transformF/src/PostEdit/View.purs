module PostEdit.View
  ( view
  ) where

import Prelude

import Common.NotFound.View as NotFound
import Common.Request.View as Request
import Data.Maybe (Maybe(..))
import Entity.Request (Request(..))
import Freedom.Markup as H
import Freedom.Router (link)
import PostEdit.Action (fetchPost, updatePost, changeTitle, changeBody, resetState)
import PostEdit.State (State)
import Type (Html)

view :: Int -> State -> Html
view postId { request, update, post } =
  Request.view request (fetchPost postId)
    case post of
      Nothing -> NotFound.view
      Just post' ->
        H.el $ H.div # H.didDelete (const resetState) # H.kids
          [ case update of
              Failure _ ->
                H.el $ H.p
                  # H.css cssErr
                  # H.kids [ H.t "Sorry..., something went wrong." ]
              _ -> H.el $ H.span
          , H.el $ H.h2 # H.kids
              [ H.el $ H.input
                  # H.onChange changeTitle
                  # H.css cssInput
                  # H.type_ "text"
                  # H.value post'.title
              ]
          , H.el $ H.textarea
              # H.value post'.body
              # H.onChange changeBody
              # H.css cssTextarea
          , H.el $ H.div
              # H.css cssBottom
              # H.kids
                  [ H.el $ link ("/posts/" <> show post'.id)
                      # H.css cssCancel
                      # H.kids [ H.t "CANCEL" ]
                  , H.el $ H.button
                      # H.onClick (const updatePost)
                      # H.kids [ H.t if update == Requesting then "SENDING..." else "SAVE" ]
                  ]
          ]
  where
    cssErr = ".& { color: #ED6D46; }"
    cssInput =
      """
      .& {
        font-size: 24px;
        font-weight: bold;
        width: 100%;
      }
      """
    cssTextarea =
      """
      .& {
        font-size: 16px;
        width: 100%;
        height: 50vh;
      }
      """
    cssCancel =
      """
      .& { margin-right: 8px; }
      .&:hover { color: #898989; }
      """
    cssBottom =
      """
      .& {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        padding: 16px 0;
      }
      """

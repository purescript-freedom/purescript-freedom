module PostShow.View
  ( view
  ) where

import Prelude

import Common.NotFound.View as NotFound
import Common.Request.View as Request
import Data.Maybe (Maybe(..))
import Freedom.Markup as H
import Freedom.Router (link)
import PostShow.Action (fetchPost, resetState)
import PostShow.State (State)
import Type (Html)

view :: Int -> State -> Html
view postId { request, post } =
  Request.view request (fetchPost postId)
    case post of
      Nothing -> NotFound.view
      Just post' ->
        H.el $ H.div # H.didDelete (const resetState) # H.kids
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

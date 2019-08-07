module View.Common
  ( withRequest
  ) where

import Prelude

import Entity.Request (Request(..))
import Freedom.Markup as H
import Type (Html, Action)

withRequest :: Request -> Action -> Html -> Html
withRequest request action html =
  H.el $ H.div
    # H.didCreate (const action)
    # H.kids [ content request html ]

content :: Request -> Html -> Html
content Neutral html = html
content Requesting _ = H.el $ H.p # H.kids [ H.t "Loading..." ]
content (Failure code) html
  | code < 500 = html
  | otherwise =
      H.el $ H.p # H.kids [ H.t "Error ! Please reload !" ]

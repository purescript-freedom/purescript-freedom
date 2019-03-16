module View.Common
  ( withRequest
  ) where

import Prelude

import Data.Maybe (Maybe(..))
import Entity.Request (Request)
import Freedom.Markup as H
import Type (Html, Action)
import View.NotFound as NotFound

withRequest :: Request -> Action -> Html -> Html
withRequest request action html =
  H.el $ H.div
    # H.didCreate (const action)
    # H.kids [ content request html ]

content :: Request -> Html -> Html
content request html =
  if request.requesting
    then H.el $ H.p # H.kids [ H.t "Loading..." ]
    else
      case request.statusCode of
        Nothing -> html
        Just code
          | code == 404 -> NotFound.view
          | otherwise ->
              H.el $ H.p # H.kids [ H.t "Error ! Please reload !" ]

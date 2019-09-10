module Common.NotFound.View
  ( view
  ) where

import Prelude

import Freedom.Markup as H
import Type (Html)

view :: Html
view =
  H.el $ H.div # H.kids
    [ H.el $ H.h1 # H.kids [ H.t "Not Found" ]
    ]

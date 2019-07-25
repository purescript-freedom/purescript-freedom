module View
  ( view
  ) where

import Prelude

import Freedom.Markup as H
import Freedom.Router (link)
import State (State)
import State.Route (Route(..))
import Type (Html)
import View.PostsIndex as PostsIndex
import View.PostShow as PostShow
import View.PostEdit as PostEdit
import View.NotFound as NotFound

view :: State -> Html
view state =
  H.el $ H.div
    # H.css cssContainer
    # H.kids
        [ H.el $ H.header # H.css cssHeader
            # H.kids
                [ H.el $ H.h1 # H.css cssTitle
                    # H.kids
                        [ H.el $ link "/" # H.kids [ H.t "Example" ]
                        ]
                ]
        , H.el $ H.main_ # H.css cssMain
            # H.kids [ route state ]
        ]
  where
    cssContainer =
      """
      body { margin: 0; }
      a { cursor: pointer; }
      button { cursor: pointer; }
      """
    cssHeader =
      """
      .& {
        background-color: #231815;
        height: 56px;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        padding-left: 24px;
      }
      """
    cssTitle =
      """
      .& {
        color: #FFF;
        font-size: 24px;
      }
      """
    cssMain =
      """
      .& {
        height: calc(100vh - 56px);
        overflow-y: scroll;
        color: #3E3A39;
        padding: 0 24px;
      }
      """

route :: State -> Html
route state =
  case state.route of
    PostsIndex ->
      H.keyed "postsIndex" $ PostsIndex.view state.postsIndex
    PostShow postId ->
      H.keyed ("postShow" <> show postId) $ PostShow.view postId state.postShow
    PostEdit postId ->
      H.keyed ("postEdit" <> show postId) $ PostEdit.view postId state.postEdit
    NotFound ->
      H.keyed "notFound" $ NotFound.view

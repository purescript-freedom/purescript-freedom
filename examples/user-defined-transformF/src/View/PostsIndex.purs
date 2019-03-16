module View.PostsIndex
  ( view
  ) where

import Prelude

import Action.PostsIndex (fetchPosts, deletePost, openDeleteDialog, closeDeleteDialog)
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import Entity.Post (Post)
import Freedom.Markup as H
import Freedom.Portal (portal)
import Freedom.Router (link)
import State.PostsIndex (State)
import Type (Html)
import View.Common (withRequest)
import Web.Event.Event (stopPropagation)

-- View

view :: State -> Html
view { request, posts, deleteTargetPost } =
  withRequest request fetchPosts
    $ H.el $ H.div # H.kids
        [ H.el $ H.h2 # H.kids [ H.t "Latest Posts" ]
        , H.el $ H.ul # H.css cssUl # H.kids (postItem <$> posts)
        , deleteDialog deleteTargetPost
        ]
  where
    cssUl = ".& { padding: 0; list-style-type: none; }"

postItem :: Post -> Html
postItem post =
  H.keyed (show post.id) $ H.el $ H.li
    # H.css cssLi
    # H.kids
        [ H.el $ link ("/posts/" <> show post.id)
            # H.css cssLink
            # H.kids [ H.t post.title ]
        , H.el $ H.button
            # H.onClick (const $ openDeleteDialog post)
            # H.kids [ H.t "DELETE" ]
        ]
  where
    cssLi =
      """
      .& {
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 52px;
        padding: 0 16px;
        transition: all 0.2s linear;
      }
      .&:hover {
        background-color: #EFEFEF;
      }
      """
    cssLink =
      """
      .& {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: 24px;
        width: calc(100% - 80px);
        height: 100%;
        transition: all 0.2s linear;
      }
      .&:hover {
        color: #898989;
      }
      """

deleteDialog :: Maybe Post -> Html
deleteDialog maybePost =
  case maybePost of
    Nothing -> H.el $ H.div
    Just post ->
      portal' $ H.el $ H.div
        # H.css overlayStyle
        # H.onClick (const closeDeleteDialog)
        # H.kids
            [ H.el $ H.div
                # H.onClick (liftEffect <<< stopPropagation)
                # H.css boxStyle
                # H.kids
                    [ H.el $ H.h3 # H.kids [ H.t "Do you delete ?" ]
                    , H.el $ H.p # H.kids [ H.t post.title ]
                    , H.el $ H.div
                        # H.css ".& { text-align: right; }"
                        # H.kids
                            [ H.el $ H.button
                                # H.onClick (const deletePost)
                                # H.kids [ H.t "DELETE" ]
                            ]
                    ]
            ]
  where
    portal' = portal { id: "delete-dialog-portal", z: 0 }
    overlayStyle =
      """
      .& {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,.1);
        display: flex;
        justify-content: center;
        align-items: center;
        animation-fill-mode: both;
        animation: & 0.2s ease-in;
      }
      @keyframes & {
        from { opacity: 0 }
        to { opacity: 1 }
      }
      """
    boxStyle =
      """
      .& {
        width: 40%;
        padding: 32px 48px;
        background-color: white;
        border: 1px solid #DDD;
        border-radius: 8px;
      }
      """

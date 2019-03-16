module State.PostsIndex where

import Data.Maybe (Maybe(..))
import Entity.Post (Post)
import Entity.Request (Request)

type State =
  { request :: Request
  , posts :: Array Post
  , deleteTargetPost :: Maybe Post
  }

initialState :: State
initialState =
  { request: { requesting: true, statusCode: Nothing }
  , posts: []
  , deleteTargetPost: Nothing
  }

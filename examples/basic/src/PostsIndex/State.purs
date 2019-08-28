module PostsIndex.State where

import Data.Maybe (Maybe(..))
import Entity.Post (Post)
import Entity.Request (Request(..))

type State =
  { request :: Request
  , posts :: Array Post
  , deleteTargetPost :: Maybe Post
  }

initialState :: State
initialState =
  { request: Requesting
  , posts: []
  , deleteTargetPost: Nothing
  }

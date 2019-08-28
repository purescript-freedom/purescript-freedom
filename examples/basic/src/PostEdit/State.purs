module PostEdit.State where

import Data.Maybe (Maybe(..))
import Entity.Post (Post)
import Entity.Request (Request(..))

type State =
  { request :: Request
  , update :: Request
  , post :: Maybe Post
  }

initialState :: State
initialState =
  { request: Requesting
  , update: Neutral
  , post: Nothing
  }

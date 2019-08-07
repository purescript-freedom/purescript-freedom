module State.PostShow where

import Data.Maybe (Maybe(..))
import Entity.Post (Post)
import Entity.Request (Request(..))

type State =
  { request :: Request
  , post :: Maybe Post
  }

initialState :: State
initialState =
  { request: Requesting
  , post: Nothing
  }

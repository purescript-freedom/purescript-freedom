module State.PostEdit where

import Data.Maybe (Maybe(..))
import Entity.Post (Post)
import Entity.Request (Request)

type State =
  { request :: Request
  , update :: Request
  , post :: Maybe Post
  }

initialState :: State
initialState =
  { request: { requesting: true, statusCode: Nothing }
  , update: { requesting: false, statusCode: Nothing }
  , post: Nothing
  }

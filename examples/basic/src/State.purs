module State where

import PostsIndex.State as PostsIndex
import PostShow.State as PostShow
import PostEdit.State as PostEdit
import State.Route as Route

-- NOTE: This state is simplified. For production, you should consider state shape.
type State =
  { route :: Route.State
  , postsIndex :: PostsIndex.State
  , postShow :: PostShow.State
  , postEdit :: PostEdit.State
  }

initialState :: State
initialState =
  { route: Route.initialState
  , postsIndex: PostsIndex.initialState
  , postShow: PostShow.initialState
  , postEdit: PostEdit.initialState
  }

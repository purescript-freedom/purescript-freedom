module State.Route where

import Prelude

import Control.Alt ((<|>))
import Data.Maybe (fromMaybe)
import Freedom.Router.Parser (match, lit, int, end)

data Route
  = PostsIndex
  | PostShow Int
  | PostEdit Int
  | NotFound

type State = Route

initialState :: State
initialState = PostsIndex

fromURL :: String -> Route
fromURL url =
  fromMaybe NotFound $ match url $
    PostsIndex <$ end
    <|>
    PostShow <$> (lit "posts" *> int) <* end
    <|>
    PostEdit <$> (lit "posts" *> int) <* lit "edit" <* end

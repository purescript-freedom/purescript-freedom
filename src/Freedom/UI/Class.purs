module Freedom.UI.Class where

import Prelude

class HasKey a where
  getKey :: Int -> a -> String

instance hasKeyInt :: HasKey Int where
  getKey _ = show

module Freedom.UI.Class where

import Prelude

import Data.Tuple (Tuple(..))

class HasKey a where
  getKey :: Int -> a -> String

instance hasKeyInt :: HasKey Int where
  getKey _ = show

instance hasKeyTuple :: (HasKey a) => HasKey (Tuple a b) where
  getKey idx (Tuple x _) = getKey idx x

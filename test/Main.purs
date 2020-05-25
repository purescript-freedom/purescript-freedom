module Test.Main where

import Prelude

import Effect (Effect)
import Test.UI.Diff (testDiff)
import Test.UI.Eq (testVNodeEq)
import Test.UI.Show (testVNodeShow)
import Test.UI.Example (testView)
import Test.Unit.Main (runTest)


main :: Effect Unit
main = runTest do
  testDiff
  testVNodeEq
  testVNodeShow
  testView

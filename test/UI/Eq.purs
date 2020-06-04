module Test.UI.Eq where

import Prelude

import Freedom.Markup as H
import Freedom.UI (VNode)
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert as Assert

testVNodeEq :: TestSuite
testVNodeEq = suite "Equalitiy of elements" do
  test "single element equal" do
    Assert.assert "should equal" (H.div == H.div)
    Assert.assert "should not equal" (H.h1 /= H.div)
  test "text equal" do
    Assert.assert "should not equal tag" (H.t "T" /= H.div)
    Assert.assert "should not equal different text" (H.t "T" /= H.t "D")
    Assert.assert "should equal same text" (H.t "T" == H.t "T")
  test "rendering manually" do
    Assert.assert "should not equal" $ (H.div # H.renderingManually) /= H.div
  test "fingerprint" do
    Assert.assert "should not equal" $ (H.div # H.fingerprint "fp") /= H.div
  test "no props" do
    Assert.assert "should not equal" $ (H.div # H.title "test") /= H.div
  test "same props different value" do
    Assert.assert "should not equal" $ (H.div # H.title "test") /= (H.div # H.title "other")
  test "same props same value" do
    Assert.assert "should equal" $ (H.div # H.title "test") == (H.div # H.title "test")
  test "more props" do
    Assert.assert "should not equal" $ (H.div # H.title "test" # H.id "id") /= (H.div # H.title "test")
  test "children" do
    Assert.assert "should not equal" $ (H.div # H.kids [H.div]) /= (H.div # H.kids [H.h1])

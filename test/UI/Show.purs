module Test.UI.Show where

import Prelude

import Freedom.Markup as H
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert as Assert

testVNodeShow :: TestSuite
testVNodeShow = suite "Showing dom elements" do
  test "single element" do
    Assert.equal
      "(VNode \"\" (Element false { tagName: \"div\", fingerprint: \"\", props: (fromFoldable []), children: []}))"
      (show H.div)
  test "is manual" do
    Assert.equal
      "(VNode \"\" (Element true { tagName: \"div\", fingerprint: \"\", props: (fromFoldable []), children: []}))"
      (show $ H.div # H.renderingManually)
  test "fingerprint" do
    Assert.equal
      "(VNode \"\" (Element false { tagName: \"div\", fingerprint: \"fp\", props: (fromFoldable []), children: []}))"
      (show $ H.div # H.fingerprint "fp")
  test "props" do
    Assert.equal
      "(VNode \"\" (Element false { tagName: \"div\", fingerprint: \"\", props: (fromFoldable [(Tuple \"id\" \"id\")]), children: []}))"
      (show $ H.div # H.id "id")
  test "kids" do
    let expected =
          "(VNode \"\" (Element false { tagName: \"div\", fingerprint: \"\", "
            <> "props: (fromFoldable []), children: [(VNode \"\" (Element false "
            <> "{ tagName: \"div\", fingerprint: \"\", props: (fromFoldable []), children: []}))]}))"
    Assert.equal expected (show $ H.div # H.kids [ H.div ])

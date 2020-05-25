module Test.UI.Show where


import Prelude (discard, show, ($), (<>))
import Freedom.Markup as H
import Freedom.UI (fingerprint, renderingManually)
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert as Assert


testVNodeShow :: TestSuite
testVNodeShow = suite "Showing dom elements" do
  test "single element" do
     Assert.equal ("Vnode:  Element (isManual: false; VObject (tagName: div; fingerprint: ; "
        <> "props: (fromFoldable []); children: []))") (show H.div)
  test "is manual" do
     Assert.equal ("Vnode:  Element (isManual: true; VObject (tagName: div; fingerprint: ; "
     <> "props: (fromFoldable []); children: []))") (show $ renderingManually H.div)
  test "fingerprint" do
     Assert.equal ("Vnode:  Element (isManual: false; VObject (tagName: div; fingerprint: fp; "
     <> "props: (fromFoldable []); children: []))") (show $ fingerprint "fp" H.div)
  test "props" do
     Assert.equal ("Vnode:  Element (isManual: false; VObject (tagName: div; fingerprint: ; "
     <> "props: (fromFoldable [(Tuple \"id\" \"id\")]); children: []))") (show $ H.id "id" H.div)
  test "kids" do
     Assert.equal ("Vnode:  Element (isManual: false; VObject (tagName: div; fingerprint: ; "
     <> "props: (fromFoldable []); children: [Vnode:  Element (isManual: false; "
     <> "VObject (tagName: div; fingerprint: ; props: (fromFoldable []); children: []))]))") 
         (show $ H.kids [H.div] H.div)
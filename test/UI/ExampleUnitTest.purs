module Test.UI.Example where

import Prelude ((#), Unit, (-), (+), const, ($), show)

import Effect (Effect)
import Test.Unit.Assert as Assert
import Test.Unit (TestSuite, suite, test)
import Freedom.UI (VNode, Operation)
import Freedom.Markup as H


type State = Int


testView :: TestSuite
testView = suite "Example for Testing rendering function in unit test" do
  test "test view with state 1" do
    Assert.equal expected $ view 1
        where 
            expected = H.div # H.kids
                [ 
                    H.button # H.kids [ H.t "-" ]
                    , H.div # H.kids [ H.t "1"]
                    , H.button # H.kids [ H.t "+" ]
                ]


-- view function from the counter example
view :: State -> VNode State
view count =
  H.div # H.kids
    [ H.button
        # H.onClick (const decrement)
        # H.kids [ H.t "-" ]
    , H.div
        # H.kids [ H.t $ show count ]
    , H.button
        # H.onClick (const increment)
        # H.kids [ H.t "+" ]
    ]


increment :: Operation State -> Effect Unit
increment operation =
  operation.query.reduce (_ + 1)

decrement :: Operation State -> Effect Unit
decrement operation =
  operation.query.reduce (_ - 1)
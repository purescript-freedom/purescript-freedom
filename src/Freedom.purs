module Freedom
  ( Config
  , run
  ) where

import Prelude

import Control.Monad.Free.Trans (runFreeT)
import Data.Foldable (sequence_)
import Effect (Effect)
import Freedom.Renderer (createRenderer, render)
import Freedom.Store (Query, createStore, query, subscribe)
import Freedom.Styler (createStyler)
import Freedom.Subscription (Subscription, runSubscription)
import Freedom.TransformF.Type (TransformF)
import Freedom.VNode (VNode)

-- | The type of config
type Config f state =
  { selector :: String
  , initialState :: state
  , view :: state -> VNode f state
  , subscriptions :: Array (Subscription f state)
  , transformF :: Query state -> TransformF f state
  }

-- | Launch app
run :: forall f state. Functor (f state) => Config f state -> Effect Unit
run { selector, initialState, view, subscriptions, transformF } = do
  styler <- createStyler
  store <- createStore initialState
  let query' = query store
      transformF' = transformF query'
  sequence_ $ runSubscription (runFreeT transformF') <$> subscriptions
  renderer <- createRenderer selector view transformF' query'.select styler
  subscribe (render renderer) store
  render renderer

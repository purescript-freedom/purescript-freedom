module Freedom
  ( Config
  , run
  ) where

import Prelude

import Data.Foldable (sequence_)
import Effect (Effect)
import Freedom.Store (createStore, query, subscribe)
import Freedom.Styler (createStyler)
import Freedom.UI (Subscription, VNode, createUI, renderUI)

-- | The type of config.
type Config state =
  { selector :: String
  , initialState :: state
  , view :: state -> VNode state
  , subscriptions :: Array (Subscription state)
  }

-- | Launch app.
run :: forall state. Config state -> Effect Unit
run { selector, initialState, view, subscriptions } = do
  styler <- createStyler
  store <- createStore initialState
  sequence_ $ subscriptions <#> (\s -> s $ query store)
  ui <- createUI selector view (query store) styler
  subscribe (renderUI ui) store
  renderUI ui

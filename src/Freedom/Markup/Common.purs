module Freedom.Markup.Common
  ( kids
  , prop
  , handle
  , didCreate
  , didUpdate
  , didDelete
  ) where

import Prelude

import Effect (Effect)
import Foreign.Object (insert)
import Freedom.UI (Operation, VNode, mapVObject)
import Web.DOM.Element (Element)
import Web.Event.Event (Event)

-- | Add children.
kids
  :: forall state
   . Array (VNode state)
  -> VNode state
  -> VNode state
kids children = mapVObject _ { children = children }

-- | Add a property.
prop
  :: forall state
   . String
  -> String
  -> VNode state
  -> VNode state
prop name val = mapVObject \vobject ->
  vobject { props = insert name val vobject.props }

-- | Bind an event handler.
handle
  :: forall state
   . String
  -> (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
handle name h = mapVObject \vobject ->
  vobject { handlers = insert name h vobject.handlers }

-- | Bind `didCreate` lifecycle.
didCreate
  :: forall state
   . (Element -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
didCreate h = mapVObject _ { didCreate = h }

-- | Bind `didUpdate` lifecycle.
didUpdate
  :: forall state
   . (Element -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
didUpdate h = mapVObject _ { didUpdate = h }

-- | Bind `didDelete` lifecycle.
didDelete
  :: forall state
   . (Element -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
didDelete h = mapVObject _ { didDelete = h }

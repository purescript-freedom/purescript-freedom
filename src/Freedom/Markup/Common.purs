module Freedom.Markup.Common
  ( t
  , el
  , op
  , keyed
  , tag
  , kids
  , prop
  , on
  , didCreate
  , didUpdate
  , didDelete
  ) where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Control.Monad.Rec.Class (class MonadRec)
import Effect.Aff (Aff)
import Foreign.Object (empty, insert)
import Freedom.VNode (VElement(..), VNode(..), VObject, VRender, createBridgeFoot)
import Web.DOM.Element (Element)
import Web.Event.Event (Event)

-- | Create `VNode` of `Text`
t :: forall f state. String -> VNode f state
t = VNode "" <<< Text

-- | Create `VNode` of `Element` from `VObject`
el
  :: forall f state
   . Functor (f state)
  => VObject f state Aff
  -> VNode f state
el = VNode "" <<< Element

-- | Create `VNode` of `OperativeElement` from `VObject`
op
  :: forall f state
   . Functor (f state)
  => VObject f state (VRender f state)
  -> VNode f state
op = VNode "" <<< OperativeElement (createBridgeFoot unit)

-- | Add a key to `VNode`
keyed :: forall f state. String -> VNode f state -> VNode f state
keyed key (VNode _ x) = VNode key x

-- | Create `VObject` with passed tag
tag
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> VObject f state m
tag tag' =
  { tag: tag'
  , props: empty
  , handlers: empty
  , children: []
  , didCreate: const $ pure unit
  , didUpdate: const $ pure unit
  , didDelete: const $ pure unit
  }

-- | Add children to `VObject`
kids
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Array (VNode f state)
  -> VObject f state m
  -> VObject f state m
kids children = _ { children = children }

-- | Add a property to `VObject`
prop
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> String
  -> VObject f state m
  -> VObject f state m
prop name val obj =
  obj { props = insert name val obj.props }

-- | Bind an event handler to `VObject`
on
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => String
  -> (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
on name h obj =
  obj { handlers = insert name h obj.handlers }

-- | Bind `didCreate` lifecycle to `VObject`
didCreate
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Element -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
didCreate h = _ { didCreate = h }

-- | Bind `didUpdate` lifecycle to `VObject`
didUpdate
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Element -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
didUpdate h = _ { didUpdate = h }

-- | Bind `didDelete` lifecycle to `VObject`
didDelete
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Element -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
didDelete h = _ { didDelete = h }

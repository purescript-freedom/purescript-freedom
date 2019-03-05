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
import Freedom.VNode (VObject, VRender, VElement(..), VNode(..), createBridgeFoot)
import Foreign.Object (empty, insert)
import Web.DOM.Element (Element)
import Web.Event.Event (Event)

t :: forall f state. String -> VNode f state
t = VNode "" <<< Text

el
  :: forall f state
   . Functor (f state)
  => VObject f state Aff
  -> VNode f state
el = VNode "" <<< Element

op
  :: forall f state
   . Functor (f state)
  => VObject f state (VRender f state)
  -> VNode f state
op = VNode "" <<< OperativeElement (createBridgeFoot unit)

keyed :: forall f state. String -> VNode f state -> VNode f state
keyed key (VNode _ x) = VNode key x

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
  , didDelete: pure unit
  }

kids
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => Array (VNode f state)
  -> VObject f state m
  -> VObject f state m
kids children = _ { children = children }

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

didCreate
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Element -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
didCreate h = _ { didCreate = h }

didUpdate
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Element -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
didUpdate h = _ { didUpdate = h }

didDelete
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => FreeT (f state) m Unit
  -> VObject f state m
  -> VObject f state m
didDelete h = _ { didDelete = h }

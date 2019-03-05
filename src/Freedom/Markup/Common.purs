module Freedom.Markup.Common
  ( keyed
  , text
  , element
  , operative
  , kids
  , prop
  , class IsHandler
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

keyed :: forall f state. String -> VNode f state -> VNode f state
keyed key (VNode _ velement) = VNode key velement

text :: forall f state. String -> VNode f state
text = VNode "" <<< Text

element
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
element = VNode "" <<< Element <<< tag

operative
  :: forall f state
   . Functor (f state)
  => String
  -> VNode f state
operative = VNode "" <<< OperativeElement (createBridgeFoot unit) <<< tag

tag
  :: forall f state m
   . Functor (f state)
  => Monad m
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
  :: forall f state
   . Functor (f state)
  => Array (VNode f state)
  -> VNode f state
  -> VNode f state
kids children (VNode key (Element r)) =
  VNode key $ Element r { children = children }
kids children (VNode key (OperativeElement bf r)) =
  VNode key $ OperativeElement bf r { children = children }
kids _ vnode = vnode

prop
  :: forall f state
   . Functor (f state)
  => String
  -> String
  -> VNode f state
  -> VNode f state
prop name val (VNode key (Element r)) =
  VNode key $ Element r { props = insert name val r.props }
prop name val (VNode key (OperativeElement bf r)) =
  VNode key $ OperativeElement bf r { props = insert name val r.props }
prop _ _ vnode = vnode

class (Functor (f state), MonadRec m) <= IsHandler f state m where
  didCreate :: (Element -> FreeT (f state) m Unit) -> VNode f state -> VNode f state
  didUpdate :: (Element -> FreeT (f state) m Unit) -> VNode f state -> VNode f state
  didDelete :: FreeT (f state) m Unit -> VNode f state -> VNode f state
  on :: String -> (Event -> FreeT (f state) m Unit) -> VNode f state -> VNode f state

instance isHandlerAff :: Functor (f state) => IsHandler f state Aff where
  didCreate h (VNode key (Element r)) = VNode key $ Element r { didCreate = h }
  didCreate _ vnode = vnode

  didUpdate h (VNode key (Element r)) = VNode key $ Element r { didUpdate = h }
  didUpdate _ vnode = vnode

  didDelete h (VNode key (Element r)) = VNode key $ Element r { didDelete = h }
  didDelete _ vnode = vnode

  on name h (VNode key (Element r)) = VNode key $ Element r { handlers = insert name h r.handlers }
  on _ _ vnode = vnode

instance isHandlerVRender :: Functor (f state) => IsHandler f state (VRender f state) where
  didCreate h (VNode key (OperativeElement bf r)) = VNode key $ OperativeElement bf r { didCreate = h }
  didCreate _ vnode = vnode

  didUpdate h (VNode key (OperativeElement bf r)) = VNode key $ OperativeElement bf r { didUpdate = h }
  didUpdate _ vnode = vnode

  didDelete h (VNode key (OperativeElement bf r)) = VNode key $ OperativeElement bf r { didDelete = h }
  didDelete _ vnode = vnode

  on name h (VNode key (OperativeElement bf r)) = VNode key $ OperativeElement bf r { handlers = insert name h r.handlers }
  on _ _ vnode = vnode

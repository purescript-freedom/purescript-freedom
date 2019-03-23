module Freedom.VNode
  ( VObject
  , VElement(..)
  , VNode(..)
  , BridgeFoot
  , createBridgeFoot
  , bridge
  , fromBridgeFoot
  , Operations
  , VRenderEnv(..)
  , VRender
  , operations
  , runVRender
  ) where

import Prelude

import Control.Alt (class Alt)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Free.Trans (FreeT)
import Control.Monad.Reader (class MonadAsk, ReaderT, ask, runReaderT)
import Control.Monad.Rec.Class (class MonadRec)
import Control.Plus (class Plus)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Exception (Error)
import Effect.Ref (Ref, new, read, write)
import Effect.Unsafe (unsafePerformEffect)
import Foreign.Object (Object)
import Web.DOM.Element (Element)
import Web.DOM.Node (Node)
import Web.Event.Event (Event)

-- | The representation for `Element` and `OperativeElement`
type VObject f state m =
  { tag :: String
  , props :: Object String
  , handlers :: Object (Event -> FreeT (f state) m Unit)
  , children :: Array (VNode f state)
  , didCreate :: Element -> FreeT (f state) m Unit
  , didUpdate :: Element -> FreeT (f state) m Unit
  , didDelete :: Element -> FreeT (f state) m Unit
  }

-- | The type of virtual elements
-- |
-- | - `Text`: Just a text content
-- | - `Element`: Render as DOM Element like `div`, `p` and so on
-- | - `OperativeElement`: Render as DOM Element but is not rendered children of it automatically
data VElement f state
  = Text String
  | Element (VObject f state Aff)
  | OperativeElement (BridgeFoot f state) (VObject f state (VRender f state))

-- | The type of virtual node. This has key and `VElement`
data VNode f state = VNode String (VElement f state)

-- | The type for bridging rendering history from previous element to next element.
newtype BridgeFoot f state = BridgeFoot (Ref (Ref (Array (Array (VNode f state)))))

-- | This is for internal. Do not use it.
createBridgeFoot :: forall f state. Unit -> BridgeFoot f state
createBridgeFoot _ = BridgeFoot $ unsafePerformEffect $ new [] >>= new

-- | This is for internal. Do not use it.
bridge :: forall f state. BridgeFoot f state -> BridgeFoot f state -> Effect Unit
bridge (BridgeFoot from) (BridgeFoot to) = read from >>= flip write to

-- | This is for internal. Do not use it.
fromBridgeFoot
  :: forall f state
   . BridgeFoot f state
  -> Effect (Ref (Array (Array (VNode f state))))
fromBridgeFoot (BridgeFoot ref) = read ref

-- | Operations for rendering children by `OperativeElement`
-- |
-- | - `getOriginChildren`: Get children passed with `kids` of `OperativeElement`
-- | - `getLatestRenderedChildren`: Get children already rendered
-- | - `renderChildren`: Patch passed children with previous rendered children
type Operations f state =
  { getOriginChildren :: Effect (Array (VNode f state))
  , getLatestRenderedChildren :: Effect (Array (VNode f state))
  , renderChildren :: Node -> Array (VNode f state) -> Effect Unit
  }

-- | This is for internal. Do not use it.
newtype VRenderEnv f state = VRenderEnv (Operations f state)

-- | Monad for event handlers and lifecycles for `OperativeElement`
newtype VRender f state a =
  VRender (ReaderT (VRenderEnv f state) Aff a)

derive newtype instance functorVRender :: Functor (VRender f state)
derive newtype instance applyVRender :: Apply (VRender f state)
derive newtype instance applicativeVRender :: Applicative (VRender f state)
derive newtype instance altVRender :: Alt (VRender f state)
derive newtype instance plusVRender :: Plus (VRender f state)
derive newtype instance bindVRender :: Bind (VRender f state)
derive newtype instance monadVRender :: Monad (VRender f state)
derive newtype instance semigroupVRender :: Semigroup a => Semigroup (VRender f state a)
derive newtype instance monoidVRender :: Monoid a => Monoid (VRender f state a)
derive newtype instance monadEffectVRender :: MonadEffect (VRender f state)
derive newtype instance monadAffVRender :: MonadAff (VRender f state)
derive newtype instance monadThrowVRender :: MonadThrow Error (VRender f state)
derive newtype instance monadErrorVRender :: MonadError Error (VRender f state)
derive newtype instance monadAskVRender :: MonadAsk (VRenderEnv f state) (VRender f state)
derive newtype instance monadRecVRender :: MonadRec (VRender f state)

-- | Get operations
operations :: forall f state. VRender f state (Operations f state)
operations = do
  VRenderEnv r <- ask
  pure r

-- | This is for internal. Do not use it.
runVRender
  :: forall f state a
   . VRender f state a
  -> VRenderEnv f state
  -> Aff a
runVRender (VRender r) = runReaderT r

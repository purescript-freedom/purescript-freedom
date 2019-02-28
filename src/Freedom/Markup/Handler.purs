module Freedom.Markup.Handler where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Control.Monad.Rec.Class (class MonadRec)
import Freedom.Markup.Common (on)
import Freedom.VNode (VObject)
import Web.Event.Event (Event)

onAbort
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onAbort = on "onabort"

onBlur
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onBlur = on "onblur"

onCancel
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onCancel = on "oncancel"

onCanPlay
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onCanPlay = on "oncanplay"

onCanPlayThrough
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onCanPlayThrough = on "oncanplaythrough"

onChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onChange = on "onchange"

onClick
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onClick = on "onclick"

onContextMenu
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onContextMenu = on "oncontextmenu"

onCueChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onCueChange = on "oncuechange"

onDoubleClick
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDoubleClick = on "ondblclick"

onDrag
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDrag = on "ondrag"

onDragEnd
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragEnd = on "ondragend"

onDragEnter
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragEnter = on "ondragenter"

onDragLeave
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragLeave = on "ondragleave"

onDragOver
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragOver = on "ondragover"

onDragStart
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragStart = on "ondragstart"

onDrop
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDrop = on "ondrop"

onDurationChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDurationChange = on "ondurationchange"

onEmptied
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onEmptied = on "onemptied"

onEnded
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onEnded = on "onended"

onError
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onError = on "onerror"

onFocus
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onFocus = on "onfocus"

onInput
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onInput = on "oninput"

onInvalid
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onInvalid = on "oninvalid"

onKeyDown
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onKeyDown = on "onkeydown"

onKeyPress
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onKeyPress = on "onkeypress"

onKeyUp
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onKeyUp = on "onkeyup"

onLoad
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onLoad = on "onload"

onLoadedData
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onLoadedData = on "onloadeddata"

onLoadedMetadata
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onLoadedMetadata = on "onloadedmetadata"

onLoadStart
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onLoadStart = on "onloadstart"

onMouseDown
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseDown = on "onmousedown"

onMouseEnter
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseEnter = on "onmouseenter"

onMouseLeave
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseLeave = on "onmouseleave"

onMouseMove
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseMove = on "onmousemove"

onMouseOut
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseOut = on "onmouseout"

onMouseOver
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseOver = on "onmouseover"

onMouseUp
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseUp = on "onmouseup"

onPause
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPause = on "onpause"

onPlay
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPlay = on "onplay"

onPlaying
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPlaying = on "onplaying"

onProgress
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onProgress = on "onprogress"

onRateChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onRateChange = on "onratechange"

onReset
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onReset = on "onreset"

onScroll
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onScroll = on "onscroll"

onSeeked
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSeeked = on "onseeked"

onSeeking
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSeeking = on "onseeking"

onSelect
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSelect = on "onselect"

onStalled
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onStalled = on "onstalled"

onSubmit
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSubmit = on "onsubmit"

onSuspend
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSuspend = on "onsuspend"

onTimeUpdate
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onTimeUpdate = on "ontimeupdate"

onToggle
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onToggle = on "ontoggle"

onVolumeChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onVolumeChange = on "onvolumechange"

onWaiting
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onWaiting = on "onwaiting"

onWheel
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onWheel = on "onwheel"

onPointerDown
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerDown = on "onpointerdown"

onPointerMove
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerMove = on "onpointermove"

onPointerUp
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerUp = on "onpointerup"

onPointerCancel
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerCancel = on "onpointercancel"

onPointerOver
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerOver = on "onpointerover"

onPointerOut
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerOut = on "onpointerout"

onPointerEnter
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerEnter = on "onpointerenter"

onPointerLeave
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerLeave = on "onpointerleave"

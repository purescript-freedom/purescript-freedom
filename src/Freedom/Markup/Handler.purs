module Freedom.Markup.Handler where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Control.Monad.Rec.Class (class MonadRec)
import Freedom.Markup.Common (handle)
import Freedom.VNode (VObject)
import Web.Event.Event (Event)

onAbort
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onAbort = handle "onabort"

onBlur
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onBlur = handle "onblur"

onCancel
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onCancel = handle "oncancel"

onCanPlay
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onCanPlay = handle "oncanplay"

onCanPlayThrough
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onCanPlayThrough = handle "oncanplaythrough"

onChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onChange = handle "onchange"

onClick
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onClick = handle "onclick"

onContextMenu
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onContextMenu = handle "oncontextmenu"

onCueChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onCueChange = handle "oncuechange"

onDoubleClick
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDoubleClick = handle "ondblclick"

onDrag
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDrag = handle "ondrag"

onDragEnd
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragEnd = handle "ondragend"

onDragEnter
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragEnter = handle "ondragenter"

onDragLeave
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragLeave = handle "ondragleave"

onDragOver
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragOver = handle "ondragover"

onDragStart
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDragStart = handle "ondragstart"

onDrop
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDrop = handle "ondrop"

onDurationChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onDurationChange = handle "ondurationchange"

onEmptied
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onEmptied = handle "onemptied"

onEnded
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onEnded = handle "onended"

onError
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onError = handle "onerror"

onFocus
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onFocus = handle "onfocus"

onInput
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onInput = handle "oninput"

onInvalid
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onInvalid = handle "oninvalid"

onKeyDown
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onKeyDown = handle "onkeydown"

onKeyPress
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onKeyPress = handle "onkeypress"

onKeyUp
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onKeyUp = handle "onkeyup"

onLoad
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onLoad = handle "onload"

onLoadedData
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onLoadedData = handle "onloadeddata"

onLoadedMetadata
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onLoadedMetadata = handle "onloadedmetadata"

onLoadStart
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onLoadStart = handle "onloadstart"

onMouseDown
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseDown = handle "onmousedown"

onMouseEnter
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseEnter = handle "onmouseenter"

onMouseLeave
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseLeave = handle "onmouseleave"

onMouseMove
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseMove = handle "onmousemove"

onMouseOut
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseOut = handle "onmouseout"

onMouseOver
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseOver = handle "onmouseover"

onMouseUp
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onMouseUp = handle "onmouseup"

onPause
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPause = handle "onpause"

onPlay
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPlay = handle "onplay"

onPlaying
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPlaying = handle "onplaying"

onProgress
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onProgress = handle "onprogress"

onRateChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onRateChange = handle "onratechange"

onReset
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onReset = handle "onreset"

onScroll
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onScroll = handle "onscroll"

onSeeked
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSeeked = handle "onseeked"

onSeeking
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSeeking = handle "onseeking"

onSelect
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSelect = handle "onselect"

onStalled
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onStalled = handle "onstalled"

onSubmit
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSubmit = handle "onsubmit"

onSuspend
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onSuspend = handle "onsuspend"

onTimeUpdate
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onTimeUpdate = handle "ontimeupdate"

onToggle
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onToggle = handle "ontoggle"

onVolumeChange
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onVolumeChange = handle "onvolumechange"

onWaiting
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onWaiting = handle "onwaiting"

onWheel
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onWheel = handle "onwheel"

onPointerDown
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerDown = handle "onpointerdown"

onPointerMove
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerMove = handle "onpointermove"

onPointerUp
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerUp = handle "onpointerup"

onPointerCancel
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerCancel = handle "onpointercancel"

onPointerOver
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerOver = handle "onpointerover"

onPointerOut
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerOut = handle "onpointerout"

onPointerEnter
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerEnter = handle "onpointerenter"

onPointerLeave
  :: forall f state m
   . Functor (f state)
  => MonadRec m
  => (Event -> FreeT (f state) m Unit)
  -> VObject f state m
  -> VObject f state m
onPointerLeave = handle "onpointerleave"

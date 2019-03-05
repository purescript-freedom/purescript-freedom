module Freedom.Markup.Handler where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Freedom.Markup.Common (class IsHandler, on)
import Freedom.VNode (VNode)
import Web.Event.Event (Event)

onAbort
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onAbort = on "onabort"

onBlur
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onBlur = on "onblur"

onCancel
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onCancel = on "oncancel"

onCanPlay
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onCanPlay = on "oncanplay"

onCanPlayThrough
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onCanPlayThrough = on "oncanplaythrough"

onChange
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onChange = on "onchange"

onClick
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onClick = on "onclick"

onContextMenu
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onContextMenu = on "oncontextmenu"

onCueChange
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onCueChange = on "oncuechange"

onDoubleClick
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onDoubleClick = on "ondblclick"

onDrag
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onDrag = on "ondrag"

onDragEnd
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onDragEnd = on "ondragend"

onDragEnter
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onDragEnter = on "ondragenter"

onDragLeave
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onDragLeave = on "ondragleave"

onDragOver
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onDragOver = on "ondragover"

onDragStart
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onDragStart = on "ondragstart"

onDrop
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onDrop = on "ondrop"

onDurationChange
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onDurationChange = on "ondurationchange"

onEmptied
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onEmptied = on "onemptied"

onEnded
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onEnded = on "onended"

onError
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onError = on "onerror"

onFocus
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onFocus = on "onfocus"

onInput
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onInput = on "oninput"

onInvalid
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onInvalid = on "oninvalid"

onKeyDown
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onKeyDown = on "onkeydown"

onKeyPress
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onKeyPress = on "onkeypress"

onKeyUp
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onKeyUp = on "onkeyup"

onLoad
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onLoad = on "onload"

onLoadedData
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onLoadedData = on "onloadeddata"

onLoadedMetadata
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onLoadedMetadata = on "onloadedmetadata"

onLoadStart
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onLoadStart = on "onloadstart"

onMouseDown
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onMouseDown = on "onmousedown"

onMouseEnter
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onMouseEnter = on "onmouseenter"

onMouseLeave
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onMouseLeave = on "onmouseleave"

onMouseMove
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onMouseMove = on "onmousemove"

onMouseOut
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onMouseOut = on "onmouseout"

onMouseOver
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onMouseOver = on "onmouseover"

onMouseUp
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onMouseUp = on "onmouseup"

onPause
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPause = on "onpause"

onPlay
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPlay = on "onplay"

onPlaying
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPlaying = on "onplaying"

onProgress
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onProgress = on "onprogress"

onRateChange
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onRateChange = on "onratechange"

onReset
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onReset = on "onreset"

onScroll
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onScroll = on "onscroll"

onSeeked
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onSeeked = on "onseeked"

onSeeking
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onSeeking = on "onseeking"

onSelect
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onSelect = on "onselect"

onStalled
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onStalled = on "onstalled"

onSubmit
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onSubmit = on "onsubmit"

onSuspend
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onSuspend = on "onsuspend"

onTimeUpdate
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onTimeUpdate = on "ontimeupdate"

onToggle
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onToggle = on "ontoggle"

onVolumeChange
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onVolumeChange = on "onvolumechange"

onWaiting
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onWaiting = on "onwaiting"

onWheel
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onWheel = on "onwheel"

onPointerDown
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPointerDown = on "onpointerdown"

onPointerMove
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPointerMove = on "onpointermove"

onPointerUp
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPointerUp = on "onpointerup"

onPointerCancel
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPointerCancel = on "onpointercancel"

onPointerOver
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPointerOver = on "onpointerover"

onPointerOut
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPointerOut = on "onpointerout"

onPointerEnter
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPointerEnter = on "onpointerenter"

onPointerLeave
  :: forall f state m
   . IsHandler f state m
  => (Event -> FreeT (f state) m Unit)
  -> VNode f state
  -> VNode f state
onPointerLeave = on "onpointerleave"

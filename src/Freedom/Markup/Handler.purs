module Freedom.Markup.Handler where

import Prelude

import Effect (Effect)
import Freedom.Markup.Common (handle)
import Freedom.UI (Operation, VNode)
import Web.Event.Event (Event)

onAbort
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onAbort = handle "onabort"

onBlur
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onBlur = handle "onblur"

onCancel
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onCancel = handle "oncancel"

onCanPlay
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onCanPlay = handle "oncanplay"

onCanPlayThrough
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onCanPlayThrough = handle "oncanplaythrough"

onChange
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onChange = handle "onchange"

onClick
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onClick = handle "onclick"

onContextMenu
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onContextMenu = handle "oncontextmenu"

onCueChange
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onCueChange = handle "oncuechange"

onDoubleClick
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onDoubleClick = handle "ondblclick"

onDrag
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onDrag = handle "ondrag"

onDragEnd
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onDragEnd = handle "ondragend"

onDragEnter
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onDragEnter = handle "ondragenter"

onDragLeave
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onDragLeave = handle "ondragleave"

onDragOver
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onDragOver = handle "ondragover"

onDragStart
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onDragStart = handle "ondragstart"

onDrop
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onDrop = handle "ondrop"

onDurationChange
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onDurationChange = handle "ondurationchange"

onEmptied
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onEmptied = handle "onemptied"

onEnded
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onEnded = handle "onended"

onError
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onError = handle "onerror"

onFocus
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onFocus = handle "onfocus"

onInput
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onInput = handle "oninput"

onInvalid
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onInvalid = handle "oninvalid"

onKeyDown
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onKeyDown = handle "onkeydown"

onKeyPress
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onKeyPress = handle "onkeypress"

onKeyUp
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onKeyUp = handle "onkeyup"

onLoad
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onLoad = handle "onload"

onLoadedData
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onLoadedData = handle "onloadeddata"

onLoadedMetadata
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onLoadedMetadata = handle "onloadedmetadata"

onLoadStart
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onLoadStart = handle "onloadstart"

onMouseDown
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onMouseDown = handle "onmousedown"

onMouseEnter
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onMouseEnter = handle "onmouseenter"

onMouseLeave
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onMouseLeave = handle "onmouseleave"

onMouseMove
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onMouseMove = handle "onmousemove"

onMouseOut
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onMouseOut = handle "onmouseout"

onMouseOver
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onMouseOver = handle "onmouseover"

onMouseUp
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onMouseUp = handle "onmouseup"

onPause
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPause = handle "onpause"

onPlay
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPlay = handle "onplay"

onPlaying
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPlaying = handle "onplaying"

onProgress
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onProgress = handle "onprogress"

onRateChange
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onRateChange = handle "onratechange"

onReset
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onReset = handle "onreset"

onScroll
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onScroll = handle "onscroll"

onSeeked
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onSeeked = handle "onseeked"

onSeeking
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onSeeking = handle "onseeking"

onSelect
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onSelect = handle "onselect"

onStalled
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onStalled = handle "onstalled"

onSubmit
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onSubmit = handle "onsubmit"

onSuspend
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onSuspend = handle "onsuspend"

onTimeUpdate
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onTimeUpdate = handle "ontimeupdate"

onToggle
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onToggle = handle "ontoggle"

onVolumeChange
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onVolumeChange = handle "onvolumechange"

onWaiting
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onWaiting = handle "onwaiting"

onWheel
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onWheel = handle "onwheel"

onPointerDown
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPointerDown = handle "onpointerdown"

onPointerMove
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPointerMove = handle "onpointermove"

onPointerUp
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPointerUp = handle "onpointerup"

onPointerCancel
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPointerCancel = handle "onpointercancel"

onPointerOver
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPointerOver = handle "onpointerover"

onPointerOut
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPointerOut = handle "onpointerout"

onPointerEnter
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPointerEnter = handle "onpointerenter"

onPointerLeave
  :: forall state
   . (Event -> Operation state -> Effect Unit)
  -> VNode state
  -> VNode state
onPointerLeave = handle "onpointerleave"

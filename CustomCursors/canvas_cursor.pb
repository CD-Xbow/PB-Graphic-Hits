OpenWindow(0, 270, 100, 300, 300, "Custom cursor in CanvasGadget")
CanvasGadget(0, 80, 80, 130, 130)

;Canvas cursor

; #PB_Cursor_Default        : Default arrow cursor
;   #PB_Cursor_Cross          : crosshair cursor YES
;   #PB_Cursor_IBeam          : I-cursor used For text selection YES
;   #PB_Cursor_Hand           : hand cursor  YES
;   #PB_Cursor_Busy           : hourglass Or watch cursor
;   #PB_Cursor_Denied         : slashed circle Or X cursor
;   #PB_Cursor_Arrows         : arrows in all direction (Not available on Mac OSX) YES -
;   #PB_Cursor_LeftRight      : left And right arrows
;   #PB_Cursor_UpDown         : up And down arrows
;   #PB_Cursor_LeftUpRightDown: diagonal arrows (Windows only); YES - resize
;   #PB_Cursor_LeftDownRightUp: diagonal arrows (Windows only)
;   #PB_Cursor_Invisible      : hides the cursor

SetGadgetAttribute(0, #PB_Canvas_Cursor, #PB_Cursor_LeftUpRightDown); YES - resize

Repeat
Until WaitWindowEvent() = #PB_Event_CloseWindow
; IDE Options = PureBasic 6.10 LTS (Windows - x64)
; CursorPosition = 11
; EnableXP
; DPIAware
EnableExplicit

#HotspotX = 4
#HotspotY = 4

UsePNGImageDecoder()

Define CustomCursor.I

If LoadImage(0, #PB_Compiler_Home + "examples/sources/Data/world.png") = 0
  MessageRequester("Error", "Unable to load image world.png!")
  End
EndIf

CompilerSelect #PB_Compiler_OS
  CompilerCase #PB_OS_Linux
    CustomCursor = gdk_cursor_new_from_pixbuf_(gdk_display_get_default_(),
      ImageID(0), #HotspotX, #HotspotY)
  CompilerCase #PB_OS_MacOS
    Define Hotspot.NSPoint

    Hotspot\x = #HotspotX
    Hotspot\y = #HotspotY
    CustomCursor = CocoaMessage(0, 0, "NSCursor alloc")
    CocoaMessage(0, CustomCursor,
      "initWithImage:", ImageID(0),
      "hotSpot:@", @Hotspot)
  CompilerCase #PB_OS_Windows
    Define Cursor.ICONINFO
    
    Cursor\fIcon = #False
    Cursor\xHotspot = #HotspotX
    Cursor\yHotspot = #HotspotY
    Cursor\hbmColor = ImageID(0)
    Cursor\hbmMask = ImageID(0)
    CustomCursor = CreateIconIndirect_(Cursor)
CompilerEndSelect

OpenWindow(0, 270, 100, 250, 250, "Canvas with custom cursor")
CanvasGadget(0, 60, 60, 130, 130, #PB_Canvas_Border)
SetGadgetAttribute(0, #PB_Canvas_CustomCursor, CustomCursor)

Repeat
Until WaitWindowEvent() = #PB_Event_CloseWindow
; IDE Options = PureBasic 6.10 LTS (Windows - x64)
; CursorPosition = 43
; FirstLine = 13
; EnableXP
; DPIAware
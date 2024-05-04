; ImageScrambler.pb
; by BasicallyPure
; 5/30/2015
; tested with PureBasic 5.31 and 6.10 win
; OS = All (not tested on Mac)
; https://www.purebasic.fr/english/viewtopic.php?t=62346
;
EnableExplicit

;{ procedure declarations
Declare COPY()       : Declare RESIZE_IMAGE()   : Declare UNSCRAMBLE_VRT()
Declare GRAY()       : Declare SCRAMBLE_DGR()   : Declare UNSCRAMBLE_HOR()
Declare PASTE()      : Declare SCRAMBLE_HOR()   : Declare CANVAS_CALLBACK()
Declare MIRROR()     : Declare SCRAMBLE_VRT()   : Declare SET_CANVAS_CURSOR()
Declare NEGATIVE()   : Declare SCRAMBLE_DGL()   : Declare UPDATE_WINDOW_TITLE()
Declare BUILD_GUI()  : Declare REVERT_IMAGE()   : Declare UPDATE_CANVAS_IMAGE()
Declare SAVE_IMAGE() : Declare RESIZE_CANVAS()  : Declare SIZE_WINDOW_TO_IMAGE()
Declare LOAD_IMAGE() : Declare UNSCRAMBLE_DGR() : Declare RUN_ITERATION(pattern)
Declare EVENT_LOOP() : Declare UNSCRAMBLE_DGL() : Declare SEQUENCED_EFFECTS(effect) : ;}

;{ Main body
ExamineDesktops()
Global DH = DesktopHeight(0)
Global DW = DesktopWidth(0)
Global AspectRatio.f = DH / DW
Global WinWidth = DW / 1.5
Global MaxWinSize_X, MaxWinSize_Y
Global Xshift, Yshift, oversize, Run = #True
Global SourceFileName$ = "filename"
Global title$ = "Image Scrambler"

; windows
#WinMain = 0
#winResizeImage = 1

; gadgets
#Canvas = 0

; images
#Image  = 0
#Revert = 1

#Menu  = 0
#PopUp = 1

; menu items
Enumeration
   #Menu_Item_SC_HOR : #Menu_Item_US_HOR : #Menu_Item_SC_VRT   : #Menu_Item_US_VRT
   #Menu_Item_SC_DGL : #Menu_Item_US_DGL : #Menu_Item_SC_DGR   : #Menu_Item_US_DGR
   #Menu_Item_Load   : #Menu_Item_Quit   : #Menu_Item_Resize   : #Menu_Item_Negative
   #Menu_Item_Copy   : #Menu_Item_Mirror : #Menu_Item_Paste    : #Menu_Item_Unscramble
   #Menu_Item_Gray   : #Menu_Item_Revert : #Menu_Item_Scramble : #Menu_Item_Esc
   #Menu_Item_Save   : #Menu_Item_Colorise
   ; sequenced effects
   #Eff_scramble : #Eff_unscramble : #Eff_pencil : #Eff_noise : #Eff_diamond
   #Eff_X_factor : #Eff_scratch    : #Eff_glowie : #Eff_spacy : #Eff_phantom 
   #Eff_blush    : #Eff_spectrum   : #Eff_slash  : #Eff_Demon : #Eff_artist
   #Eff_Faded
   ; iterations
   #Menu_Item_Itr_HOR  : #Menu_Item_Itr_VRT
   #Menu_Item_Itr_DGLD : #Menu_Item_Itr_DGRD
EndEnumeration

If BUILD_GUI()
   EVENT_LOOP()
EndIf

End : ;}

Procedure BUILD_GUI()
   Protected x, y, c, result
   Protected flags = #PB_Window_ScreenCentered | #PB_Window_SystemMenu | #PB_Window_MaximizeGadget |
                     #PB_Window_SizeGadget     | #PB_Window_MinimizeGadget
   
   UsePNGImageDecoder() : UseJPEGImageDecoder()
   UsePNGImageEncoder() : UseJPEGImageEncoder()
   
   If OpenWindow(#WinMain, 0, 0, WinWidth, WinWidth*AspectRatio, title$, flags)
      SetWindowColor(#WinMain, $FCECCF)
      WindowBounds(#WinMain, 320, 320*AspectRatio, #PB_Ignore, #PB_Ignore)
      
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Control | #PB_Shortcut_C, #Menu_Item_Copy)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Control | #PB_Shortcut_G, #Menu_Item_Gray)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Control | #PB_Shortcut_Z, #Menu_Item_Revert)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Control | #PB_Shortcut_L, #Menu_Item_Load)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Control | #PB_Shortcut_M, #Menu_Item_Mirror)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Control | #PB_Shortcut_N, #Menu_Item_Negative)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Alt     | #PB_Shortcut_Q, #Menu_Item_Quit)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Control | #PB_Shortcut_R, #Menu_Item_Resize)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Control | #PB_Shortcut_S, #Menu_Item_Save)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_Control | #PB_Shortcut_V, #Menu_Item_Paste)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_F1, #Menu_Item_SC_HOR)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_F2, #Menu_Item_US_HOR)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_F3, #Menu_Item_SC_VRT)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_F4, #Menu_Item_US_VRT)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_F5, #Menu_Item_SC_DGL)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_F6, #Menu_Item_US_DGL)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_F7, #Menu_Item_SC_DGR)
      AddKeyboardShortcut(#WinMain,#PB_Shortcut_F8, #Menu_Item_US_DGR)

      If CreateMenu(#Menu,WindowID(#WinMain))
         MenuTitle("File")
            MenuItem(#Menu_Item_Load,"Load Image" + Chr(9) + "Ctrl+L")
            MenuItem(#Menu_Item_Save,"Save Image As..." + Chr(9) + "Ctrl+S")
            MenuBar()
            MenuItem(#Menu_Item_Quit,"Quit"       + Chr(9) + "Alt+Q")
            MenuTitle("Edit")
            MenuItem(#Menu_Item_Revert    , "Revert"     + Chr(9) + "Ctrl+Z")
            MenuBar()
            MenuItem(#Menu_Item_Copy      , "Copy"       + Chr(9) + "Ctrl+C")
            MenuItem(#Menu_Item_Paste     , "Paste"      + Chr(9) + "Ctrl+V")
         MenuTitle("Image")
            MenuItem(#Menu_Item_Scramble  , "Scramble")
            MenuItem(#Menu_Item_Unscramble, "UnscrambLe")
            MenuBar()
            MenuItem(#Menu_Item_Colorise, "Colorise")
            MenuBar()
            MenuItem(#Menu_Item_Negative  , "Negative"   + Chr(9) + "Ctrl+N")
            MenuItem(#Menu_Item_Mirror    , "Mirror"     + Chr(9) + "Ctrl+M")
            MenuItem(#Menu_Item_Gray      , "Grayscale"  + Chr(9) + "Ctrl+G")
            MenuBar()
            MenuItem(#Menu_Item_Resize    , "Resize"     + Chr(9) + "Ctrl+R")
        
            MenuTitle("Filters")
             MenuTitle("Effect")
            MenuItem(#Eff_pencil   , "Pencil")
            MenuItem(#Eff_artist   , "Artist")
            MenuItem(#Eff_noise    , "Noise up")
            MenuItem(#Eff_scratch  , "Scratch")
            MenuItem(#Eff_glowie   , "Glowie")
            MenuItem(#Eff_phantom  , "Phantom")
            MenuItem(#Eff_Demon    , "Demon")
            MenuItem(#Eff_Faded    , "Faded")
            MenuItem(#Eff_spacy    , "Spacy")
            MenuItem(#Eff_blush    , "Blush")
            MenuItem(#Eff_spectrum , "Spectrum")
            MenuItem(#Eff_slash    , "Slash")
            MenuItem(#Eff_diamond  , "Diamond")
            MenuItem(#Eff_X_factor , "X-factor")
         
         MenuTitle("Shift_pixels")
            MenuItem(#Menu_Item_SC_HOR, "Scramble_HOR" + Chr(9) + "F1")
            MenuItem(#Menu_Item_US_HOR, "/UnScram_HOR" + Chr(9) + "F2")
            MenuBar()
            MenuItem(#Menu_Item_SC_VRT, "Scramble_VRT" + Chr(9) + "F3")
            MenuItem(#Menu_Item_US_VRT, "/UnScram_VRT" + Chr(9) + "F4")
            MenuBar()
            MenuItem(#Menu_Item_SC_DGL, "scramble_DGL" + Chr(9) + "F5")
            MenuItem(#Menu_Item_US_DGL, "/UnScram_DGL" + Chr(9) + "F6")
            MenuBar()
            MenuItem(#Menu_Item_SC_DGR, "Scramble_DGR" + Chr(9) + "F7")
            MenuItem(#Menu_Item_US_DGR, "/UnScram_DGR" + Chr(9) + "F8")
           
         MenuTitle("Iterate")
            MenuItem(#Menu_Item_Itr_HOR , "/UnScram_Hor")
            MenuItem(#Menu_Item_Itr_VRT , "/UnScram_VRT")
            MenuItem(#Menu_Item_Itr_DGRD, "/UnScram_DGL")
            MenuItem(#Menu_Item_Itr_DGLD, "/UnScram_DGR")
           
      EndIf
      
      CreatePopupMenu(#PopUp)
         MenuItem(#Menu_Item_Revert, "Revert"           + Chr(9) + "Ctrl+Z")
         MenuBar()
         MenuItem(#Menu_Item_Load  , "Load Image"       + Chr(9) + "Ctrl+L")
         MenuItem(#Menu_Item_Save  , "Save Image As..." + Chr(9) + "Ctrl+S")
         MenuBar()
         MenuItem(#Menu_Item_Copy  , "Copy"  + Chr(9) + "Ctrl+C")
         MenuItem(#Menu_Item_Paste , "Paste" + Chr(9) + "Ctrl+V")
         MenuBar()
         MenuItem(#Menu_Item_Quit  , "Quit"  + Chr(9) + "Alt+Q")

      CanvasGadget(#Canvas, 0, 0, WinWidth, WinWidth*AspectRatio-MenuHeight())
      BindGadgetEvent(#Canvas,@CANVAS_CALLBACK())
      
      CreateImage(#Image,WinWidth, WinWidth*AspectRatio-MenuHeight(),32,0)
      
      StartDrawing(ImageOutput(#Image))
         DrawingMode(#PB_2DDrawing_AlphaBlend)
         For y = 0 To OutputHeight()-1
            For x = 0 To OutputWidth()-1
               c = (x ! y) & $FF
               Plot(x, y, RGBA(c&x,255-c,c&y,c<<1))
            Next
         Next
      StopDrawing()
      
      SEQUENCED_EFFECTS(#Eff_X_factor)
      UPDATE_CANVAS_IMAGE()
      CopyImage(#Image,#Revert)
      
      MaxWinSize_X = DW - (WindowWidth(#WinMain,#PB_Window_FrameCoordinate)  - WindowWidth(#WinMain))
      MaxWinSize_Y = DH - (WindowHeight(#WinMain,#PB_Window_FrameCoordinate) - WindowHeight(#WinMain))
      MaxWinSize_Y - MenuHeight()
      
      result = #True
   EndIf
   
   ProcedureReturn result
EndProcedure

Procedure EVENT_LOOP()
   
   While Run = #True
      Select WaitWindowEvent()
         Case #PB_Event_CloseWindow    : Run = #False
         Case #PB_Event_RightClick     : DisplayPopupMenu(#PopUp,WindowID(#WinMain))
         Case #PB_Event_MaximizeWindow : RESIZE_CANVAS()
         Case #PB_Event_SizeWindow     : RESIZE_CANVAS()
         Case #PB_Event_RestoreWindow  : SIZE_WINDOW_TO_IMAGE() : RESIZE_CANVAS()
            
         Case #PB_Event_Menu
            Select EventMenu()
               Case #Menu_Item_Quit       : Run = #False
               Case #Menu_Item_Load       : LOAD_IMAGE()
               Case #Menu_Item_Save       : SAVE_IMAGE()
               Case #Menu_Item_Resize     : RESIZE_IMAGE()
               Case #Menu_Item_SC_HOR     : SCRAMBLE_HOR()   : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_US_HOR     : UNSCRAMBLE_HOR() : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_SC_VRT     : SCRAMBLE_VRT()   : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_US_VRT     : UNSCRAMBLE_VRT() : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_SC_DGR     : SCRAMBLE_DGR()   : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_US_DGR     : UNSCRAMBLE_DGR() : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_SC_DGL     : SCRAMBLE_DGL()   : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_US_DGL     : UNSCRAMBLE_DGL() : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_Negative   : NEGATIVE()       : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_Mirror     : MIRROR()         : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_Gray       : GRAY()           : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_Scramble   : SEQUENCED_EFFECTS(#Eff_scramble)   : UPDATE_CANVAS_IMAGE()
               Case #Menu_Item_Unscramble : SEQUENCED_EFFECTS(#Eff_unscramble) : UPDATE_CANVAS_IMAGE()
               Case #Eff_diamond          : SEQUENCED_EFFECTS(#Eff_diamond)    : UPDATE_CANVAS_IMAGE()
               Case #Eff_noise            : SEQUENCED_EFFECTS(#Eff_noise)      : UPDATE_CANVAS_IMAGE()
               Case #Eff_pencil           : SEQUENCED_EFFECTS(#Eff_pencil)     : UPDATE_CANVAS_IMAGE()
               Case #Eff_scratch          : SEQUENCED_EFFECTS(#Eff_scratch)    : UPDATE_CANVAS_IMAGE()
               Case #Eff_X_factor         : SEQUENCED_EFFECTS(#Eff_X_factor)   : UPDATE_CANVAS_IMAGE()
               Case #Eff_glowie           : SEQUENCED_EFFECTS(#Eff_glowie)     : UPDATE_CANVAS_IMAGE()
               Case #Eff_phantom          : SEQUENCED_EFFECTS(#EFF_phantom)    : UPDATE_CANVAS_IMAGE()
               Case #Eff_Demon            : SEQUENCED_EFFECTS(#Eff_Demon)      : UPDATE_CANVAS_IMAGE()
               Case #Eff_Faded            : SEQUENCED_EFFECTS(#Eff_Faded)      : UPDATE_CANVAS_IMAGE()
               Case #Eff_spacy            : SEQUENCED_EFFECTS(#Eff_spacy)      : UPDATE_CANVAS_IMAGE()
               Case #Eff_blush            : SEQUENCED_EFFECTS(#Eff_blush)      : UPDATE_CANVAS_IMAGE()
               Case #Eff_spectrum         : SEQUENCED_EFFECTS(#Eff_spectrum)   : UPDATE_CANVAS_IMAGE()
               Case #Eff_slash            : SEQUENCED_EFFECTS(#Eff_slash)      : UPDATE_CANVAS_IMAGE()
               Case #Eff_artist           : SEQUENCED_EFFECTS(#Eff_artist)     : UPDATE_CANVAS_IMAGE()
               Case #menu_Item_Revert     : REVERT_IMAGE()
               Case #Menu_Item_Resize     : RESIZE_IMAGE()
               Case #Menu_Item_Copy       : COPY()
               Case #Menu_Item_Paste      : PASTE()
               Case #Menu_Item_Itr_HOR    : RUN_ITERATION(#Menu_Item_Itr_HOR)
               Case #Menu_Item_Itr_VRT    : RUN_ITERATION(#Menu_Item_Itr_VRT)
               Case #Menu_Item_Itr_DGLD   : RUN_ITERATION(#Menu_Item_Itr_DGLD)
               Case #Menu_Item_Itr_DGRD   : RUN_ITERATION(#Menu_Item_Itr_DGRD)
            EndSelect
      EndSelect
   Wend
   
EndProcedure

Procedure CANVAS_CALLBACK()
   Static drag, Xorg, Yorg
   Protected mx, my
   
   Select EventType()
      Case #PB_EventType_RightButtonUp : PostEvent(#PB_Event_RightClick)
      Case #PB_EventType_LeftButtonDown
         If oversize : drag = #True
            Xorg = GetGadgetAttribute(#Canvas,#PB_Canvas_MouseX)
            Yorg = GetGadgetAttribute(#Canvas,#PB_Canvas_MouseY)
         EndIf
      Case #PB_EventType_MouseMove
         If drag
            mx = GetGadgetAttribute(#Canvas,#PB_Canvas_MouseX)
            my = GetGadgetAttribute(#Canvas,#PB_Canvas_MouseY)
            Xshift + (mx - Xorg) : Xorg = mx
            Yshift + (my - Yorg) : Yorg = my
            UPDATE_CANVAS_IMAGE()
         EndIf
      Case #PB_EventType_LeftButtonUp
         drag = #False
   EndSelect
EndProcedure

Procedure LOAD_IMAGE()
   Protected m = #PB_Gadget_ContainerCoordinate
   Protected Pattern$ = "image (*.png, *.jpg, *.bmp)|*.png;*.jpg;*.bmp|image *.*|*.*"
   Protected FileName$, File$
   
   CompilerIf #PB_Compiler_OS = #PB_OS_Windows
      FileName$ = GetHomeDirectory() + "My Pictures\"
   CompilerElse
      FileName$ = GetHomeDirectory() + "Pictures/"
   CompilerEndIf
   
   File$ = OpenFileRequester("Select image to process", FileName$, Pattern$, 0)
   SourceFileName$ = GetFilePart(File$)
   
   If File$
      If LoadImage(#Image, File$)
         CopyImage(#Image,#Revert)
         Xshift = 0 : Yshift = 0
         SIZE_WINDOW_TO_IMAGE()
         UPDATE_CANVAS_IMAGE()
         UPDATE_WINDOW_TITLE()
      EndIf
   EndIf
   
EndProcedure

Procedure SAVE_IMAGE()
   Static YesNo = #PB_MessageRequester_YesNo, Yes = #PB_MessageRequester_Yes
   Protected F$, Pattern$
   Protected p, img, cancel = #False
   
   If IsImage(#Image) = 0 : ProcedureReturn 0 : EndIf
   
   Pattern$ = "image *.png|*.png|image *.jpg|*.jpg|image *.bmp|*.bmp"
   F$ = SaveFileRequester("Save image", GetFilePart(SourceFileName$,#PB_FileSystem_NoExtension), Pattern$, 0)
   
   If F$
      F$ = ReverseString(F$)
      p = FindString(F$,".")
      If p
         F$ = Right(F$,Len(F$)-p)
      EndIf
      F$ = ReverseString(F$)
      
      Select SelectedFilePattern()
         Case 0 : F$ + ".png"
         Case 1 : F$ + ".jpg"
         Case 2 : F$ + ".bmp"
      EndSelect
      
      If FileSize(F$) <> -1 ; file exists
         If MessageRequester("File Exists!", "Do you wish to overwrite?", YesNo) <> Yes
            cancel = #True
         EndIf
      EndIf
      
      If cancel = #False
         Select SelectedFilePattern()
            Case 0 : SaveImage(#Image, F$, #PB_ImagePlugin_PNG)
            Case 1 : SaveImage(#Image, F$, #PB_ImagePlugin_JPEG)
            Case 2 : SaveImage(#Image, F$, #PB_ImagePlugin_BMP)
         EndSelect
         SourceFileName$ = GetFilePart(F$)
         UPDATE_WINDOW_TITLE()
      EndIf
      
   EndIf
EndProcedure

Procedure RESIZE_IMAGE()
   Static flags = #PB_Window_Tool|#PB_Window_WindowCentered|#PB_Window_SystemMenu
   Protected ExitProcedure, strGad_1, strGad_2, btnCancel, btnOK, CheckBox
   Protected iw = ImageWidth(#Image), ih = ImageHeight(#Image)
   Protected AspRatio.f = ih / iw
   
   If OpenWindow(#winResizeImage,0,0,165,130,"resize image",flags,WindowID(#WinMain))
      SetWindowColor(#WinResizeImage,$FCECCF)
      strGad_1 = StringGadget(#PB_Any,10,10,60,25,Str(iw),#PB_String_Numeric)
      strGad_2 = StringGadget(#PB_Any,10,40,60,25,Str(ih),#PB_String_Numeric)
      SetGadgetColor(TextGadget(#PB_Any,75,15,50,25,"width"),#PB_Gadget_BackColor,$FCECCF)
      SetGadgetColor(TextGadget(#PB_Any,75,40,50,25,"Height"),#PB_Gadget_BackColor,$FCECCF)
      CheckBox = CheckBoxGadget(#PB_Any,10,70,145,25,"keep aspect ratio")
      SetGadgetState(CheckBox,1)
      btnOK     = ButtonGadget(#PB_Any,95,100,60,25,"OK")
      btnCancel = ButtonGadget(#PB_Any,10,100,60,25,"Cancel")
      
      AddKeyboardShortcut(#WinResizeImage, #PB_Shortcut_Return, 5)
      
      Repeat
         Select WaitWindowEvent()
            Case #PB_Event_CloseWindow
               Select EventWindow()
                  Case #WinResizeImage  : ExitProcedure = #True
                  Case #WinMain : ExitProcedure = #True : Run = #False
               EndSelect
            Case #PB_Event_Menu
               If EventMenu() = 5
                  PostEvent(#PB_Event_Gadget,#WinResizeImage,btnOK)
               EndIf
            Case #PB_Event_Gadget
               Select EventGadget()
                  Case strGad_1
                     If GetGadgetState(CheckBox) And EventType() = #PB_EventType_Change
                        SetGadgetText(strGad_2,Str(Val(GetGadgetText(strGad_1))*AspRatio))
                     EndIf
                  Case strGad_2
                     If GetGadgetState(CheckBox) And EventType() = #PB_EventType_Change
                        SetGadgetText(strGad_1,Str(Val(GetGadgetText(strGad_2))/AspRatio))
                     EndIf
                  Case btnCancel
                     ExitProcedure = #True
                  Case btnOK
                     iw = Val(GetGadgetText(strGad_1))
                     ih = Val(GetGadgetText(strGad_2))
                     If iw < 16 : iw = 16 : EndIf : If ih < 16 : ih = 16 : EndIf
                     If iw>4096 : iw=4096 : EndIf : If ih>4096 : ih=4096 : EndIf
                     
                     ResizeImage(#Image,iw,ih)
                     CopyImage(#Image,#Revert)
                     SIZE_WINDOW_TO_IMAGE()
                     UPDATE_CANVAS_IMAGE()
                     UPDATE_WINDOW_TITLE()
                     ExitProcedure = #True
               EndSelect
         EndSelect
      Until ExitProcedure = #True
      
      RemoveKeyboardShortcut(#WinResizeImage,#PB_Shortcut_Return)
      CloseWindow(#WinResizeImage)
   EndIf
   
EndProcedure

Procedure UPDATE_WINDOW_TITLE()
   Protected iw = ImageWidth(#Image)
   Protected ih = ImageHeight(#Image)
   
   SetWindowTitle(#WinMain,title$ + " | " + SourceFileName$ +
                           " | " + Str(iw) + " x " + Str(ih))
EndProcedure

Procedure SET_CANVAS_CURSOR()
   If oversize = #True
      CompilerIf #PB_Compiler_OS = #PB_OS_MacOS
         SetGadgetAttribute(#Canvas,#PB_Canvas_Cursor , #PB_Cursor_Hand)
      CompilerElse
         SetGadgetAttribute(#Canvas,#PB_Canvas_Cursor , #PB_Cursor_Arrows)
      CompilerEndIf
   Else
      SetGadgetAttribute(#Canvas,#PB_Canvas_Cursor , #PB_Cursor_Default)
   EndIf
   
EndProcedure

Procedure SCRAMBLE_HOR()   ; F1 Key
   ; complement To UNSCRAMBLE_HOR()
   
   Protected x, y, Xmax, Ymax
   
   If IsImage(#Image)
      
      StartDrawing(ImageOutput(#Image))
         Xmax = OutputWidth()  - 2
         Ymax = OutputHeight() - 2
         
         y = Ymax + 1
         For x = Xmax To 0 Step -1
            Plot(x,y,Point(x,y) ! Point(x+1,y))
         Next x
         
         For y = Ymax To 0 Step -1
            x = Xmax + 1
            Plot(x,y, Point(x,y) ! Point(0,y+1))
            For x = Xmax To 0 Step -1
               Plot(x,y,Point(x,y) ! Point(x+1,y))
            Next x
         Next y
         
      StopDrawing()
      
   EndIf
EndProcedure

Procedure UNSCRAMBLE_HOR() ; F2 Key
   ; complement to SCRAMBLE_HOR()
   
   Protected x, y, Xmax, Ymax
   
   If IsImage(#Image)
      
      StartDrawing(ImageOutput(#Image))
         Xmax = OutputWidth()  - 2
         Ymax = OutputHeight() - 2
         
         For y = 0 To Ymax
            For x = 0 To Xmax
               Plot(x,y, Point(x,y) ! Point(x+1,y))
            Next x
            Plot(x,y,Point(x,y) ! Point(0,y+1))
         Next y
         
         For x = 0 To Xmax
            Plot(x,y,Point(x,y) ! Point(x+1,y))
         Next x
         
      StopDrawing()
      
   EndIf
   
EndProcedure

Procedure SCRAMBLE_VRT()   ; F3 Key
   ; complement to UNSCRAMBLE(VRT)
   
   Protected x, y, Xmax, Ymax
   
   If IsImage(#Image)
      
      StartDrawing(ImageOutput(#Image))
         Xmax = OutputWidth()  - 2
         Ymax = OutputHeight() - 2
         
         x = Xmax + 1
         For y = Ymax To 0 Step -1
            Plot(x,y,Point(x,y) ! Point(x,y+1))
         Next y
         
         For x = Xmax To 0 Step -1
            y = Ymax + 1
            Plot(x,y,Point(x,y) ! Point(x+1,0))
            For y = Ymax To 0 Step -1
               Plot(x,y,Point(x,y) ! Point(x,y+1))
            Next y
         Next x
         
      StopDrawing()
      
   EndIf
   
 
EndProcedure

Procedure UNSCRAMBLE_VRT() ; F4 Key
   ; complement to SCRAMBLE_VRT()
   
   Protected x, y, Xmax, Ymax
   
   If IsImage(#Image)
      
      StartDrawing(ImageOutput(#Image))
          Xmax = OutputWidth()  - 2
          Ymax = OutputHeight() - 2
         
          For x = 0 To Xmax
             For y = 0 To Ymax
                Plot(x,y,Point(x,y) ! Point(x,y+1))
             Next y
             Plot(x,y,Point(x,y) ! Point(x+1,0))
          Next x
          
          For y = 0 To Ymax
             Plot(x,y,Point(x,y) ! Point(x,y+1))
          Next y
          
       StopDrawing()
       
   EndIf
EndProcedure

Procedure SCRAMBLE_DGL()   ; F5 Key
   ; complement to UNSCRAMBLE_DGL()
   
   Protected x, y, nx, ny, xs, ys, Xmax, Ymax
   
   If IsImage(#Image)
      
      StartDrawing(ImageOutput(#Image))
         Xmax = OutputWidth()  - 1
         Ymax = OutputHeight() - 1
         
         x  = 0 : y  = 0
         nx = 0 : ny = 1
         ys = 1
         
         While ys <= Ymax
            Plot(nx, ny, Point(nx, ny) ! Point(x, y))
            x = nx :  y = ny : nx + 1 : ny - 1
            If nx > Xmax Or ny < 0
               ys + 1 : ny = ys : nx = 0
            EndIf
         Wend
         
         nx = 1 : ny = Ymax : xs = nx
         
         While xs <= Xmax
            Plot(nx, ny, Point(nx, ny) ! Point(x, y))
            x = nx :  y = ny : nx + 1 : ny - 1
            If nx > Xmax Or ny < 0
               xs + 1 : nx = xs : ny = Ymax
            EndIf
         Wend
         
      StopDrawing()
      
   EndIf
EndProcedure

Procedure UNSCRAMBLE_DGL() ; F6 Key
   ; complement to SCRAMBLE_DGL()
   
   Protected x, y, nx, ny, ys, xs, Xmax, Ymax
   
   If IsImage(#Image)
      
      StartDrawing(ImageOutput(#Image))
         Xmax = OutputWidth()  - 1
         Ymax = OutputHeight() - 1
         
         x  = Xmax : y  = Ymax
         nx = Xmax : ny = Ymax - 1
         ys = ny
         
         While ys >= 0
            Plot(x, y, Point(x,y) ! Point(nx, ny))
            x = nx :  y = ny : nx - 1 : ny + 1
            If nx < 0 Or ny > Ymax
               ys-1 : ny = ys : nx = Xmax
            EndIf
         Wend
         
         nx = Xmax - 1 : ny = 0 : xs = nx
         
         While xs >= 0
            Plot(x, y, Point(x,y) ! Point(nx, ny))
            x = nx :  y = ny : nx - 1 : ny + 1
            If nx < 0 Or ny > Ymax
               xs - 1 : nx = xs : ny = 0
            EndIf
         Wend
         
      StopDrawing()
      
   EndIf
EndProcedure

Procedure SCRAMBLE_DGR()   ; F7 Key
   ; complement to UNSCRAMBLE_DGR()
   
   Protected x, y, nx, ny, xs, ys, Xmax, Ymax
   
   If IsImage(#Image)
      
      StartDrawing(ImageOutput(#Image))
         Xmax = OutputWidth()  - 1
         Ymax = OutputHeight() - 1
         
         x  = Xmax : y  = 0
         nx = Xmax : ny = 1
         ys = 1
         
         While ys <= Ymax
            Plot(nx, ny, Point(nx, ny) ! Point(x, y))
            x = nx :  y = ny : nx - 1 : ny - 1
            If nx < 0 Or ny < 0
               ys + 1 : ny = ys : nx = Xmax
            EndIf
         Wend
         
         nx = Xmax-1 : ny = Ymax : xs = nx
         
         While xs >= 0
            Plot(nx, ny, Point(nx, ny) ! Point(x, y))
            x = nx :  y = ny : nx - 1 : ny - 1
            If nx < 0 Or ny < 0
               xs - 1 : nx = xs : ny = Ymax
            EndIf
         Wend
         
      StopDrawing()
      
   EndIf
EndProcedure

Procedure UNSCRAMBLE_DGR() ; F8 Key
   ; complement to SCRAMBLE_DGR()
   
   Protected x, y, nx, ny, ys, xs, Xmax, Ymax
   
   If IsImage(#Image)
      
      StartDrawing(ImageOutput(#Image))
         Xmax = OutputWidth()  - 1
         Ymax = OutputHeight() - 1
         
         x  = 0 : y  = Ymax
         nx = 0 : ny = Ymax - 1
         ys = ny
         
         While ys >= 0
            Plot(x, y, Point(x,y) ! Point(nx, ny))
            x = nx :  y = ny : nx + 1 : ny + 1
            If nx > Xmax Or ny > Ymax
               ys-1 : ny = ys : nx=0
            EndIf
         Wend
         
         nx = 1 : ny = 0 : xs = 1
         
         While xs <= Xmax
            Plot(x, y, Point(x,y) ! Point(nx, ny))
            x = nx :  y = ny : nx + 1 : ny + 1
            If nx > Xmax Or ny > Ymax
               xs + 1 : nx = xs : ny = 0
            EndIf
         Wend
         
      StopDrawing()
      
   EndIf
EndProcedure

Procedure NEGATIVE() ; Ctrl+N
   ; produces a negative color image
   ; 0 --> 255, 1 --> 254, 2 --> 253 ...
   Protected x,y,Xmax,Ymax
   
   If IsImage(#Image)
      StartDrawing(ImageOutput(#Image))
         Xmax = OutputWidth() - 1
         Ymax = OutputHeight() - 1
         
         For y = 0 To Ymax
            For x = 0 To Xmax
               Plot(x,y, Point(x,y) ! $FFFFFF)
            Next x
         Next y
         
      StopDrawing()
      
   EndIf
   
EndProcedure

Procedure MIRROR()   ; Ctrl+M
   ; left becomes right, right becomes left
   Protected d,x,y,xp,Xmax,Ymax,Xlim
   
   If IsImage(#Image)
      StartDrawing(ImageOutput(#Image))
         
         Xmax = OutputWidth() - 1
         Xlim = OutputWidth() / 2 - 1
         Ymax = OutputHeight() - 1
         
         For y = 0 To Ymax
            xp = Xmax
            For x = 0 To Xlim
               xp - 1
               d = Point(x,y)
               Plot(x,y,Point(xp,y))
               Plot(xp,y,d)
            Next x
         Next y
         
      StopDrawing()
   EndIf
EndProcedure

Procedure GRAY()     ; Ctrl+G
   ; reduce colors to 256 grayscale
   ; color weights are R=0.286, G=0.571, B=0.143
   
   Static kb=$FF0000, kg=$00FF00, kr=$0000FF
   Protected x,y,d,Ymax,Xmax,lum
   
   If IsImage(#Image)
      
      StartDrawing(ImageOutput(#Image))
         Xmax = OutputWidth() - 1
         Ymax = OutputHeight() - 1
         
         For y = 0 To Ymax
            For x = 0 To Xmax
               d = Point(x,y)
               lum = ((d & kr)<<1 + (d & kg)>>6 + (d & kb)>>16) / 7
               Plot(x,y,lum<<16 | lum<<8 | lum)
            Next x
         Next y
      StopDrawing()
      
   EndIf
   
   EndProcedure
   
   Procedure UPDATE_CANVAS_IMAGE()
   Protected x, y, ow, oh, iw, ih, Llim, Rlim, Tlim, Blim
   
   If IsImage(#Image)
      StartDrawing(CanvasOutput(#Canvas))
         ow = OutputWidth()  : iw = ImageWidth(#Image)
         oh = OutputHeight() : ih = ImageHeight(#Image)
         
         Llim = ow-iw : If Llim > 0 : Llim = 0 : EndIf
         Rlim = ow-iw : If Rlim < 0 : Rlim = 0 : EndIf
         
         Tlim = oh-ih : If Tlim > 0 : Tlim = 0 : EndIf
         Blim = oh-ih : If Blim < 0 : Blim = 0 : EndIf
         
         Box(0,0,ow-1,oh-1,0)
         
         x = Xshift + (ow - iw) / 2
         y = Yshift + (oh - Ih) / 2
            
         If x < Llim : Xshift + (Llim - x) : x = Llim : EndIf
         If x > Rlim : Xshift - (x - Rlim) : x = Rlim : EndIf
         If y < Tlim : Yshift + (Tlim - y) : y = Tlim : EndIf
         If y > Blim : Yshift - (y - Blim) : y = Blim : EndIf
         
         DrawImage(ImageID(#Image),x,y)
      StopDrawing()
   EndIf
EndProcedure

Procedure RESIZE_CANVAS()
   ; resize to fit window
   Protected ww = WindowWidth(#WinMain,#PB_Window_InnerCoordinate)
   Protected wh = WindowHeight(#WinMain,#PB_Window_InnerCoordinate)-MenuHeight()
   Protected iw = ImageWidth(#Image)
   Protected ih = ImageHeight(#Image)
   
   ResizeGadget(#Canvas, 0, 0, ww, wh)
   
   If iw > ww Or ih > wh
      oversize = #True
      If iw > ww : Yshift = 0 : EndIf
      If ih > wh : Xshift = 0 : EndIf
   Else
      oversize = #False
      Xshift = 0 : Yshift = 0
   EndIf
   
   SET_CANVAS_CURSOR()
   UPDATE_CANVAS_IMAGE()
EndProcedure

Procedure SIZE_WINDOW_TO_IMAGE()
   Protected iw = ImageWidth(#Image)
   Protected ih = ImageHeight(#Image)
   
   If iw > MaxWinSize_X Or ih > MaxWinSize_Y
      oversize = #True
   Else
      oversize = #False
   EndIf
   
   If GetWindowState(#WinMain)= #PB_Window_Normal
      
      If iw > MaxWinSize_X : iw = MaxWinSize_X : EndIf
      If ih > MaxWinSize_Y : ih = MaxWinSize_Y : EndIf
      
      ResizeWindow(#WinMain,(MaxWinSize_X-iw)/2,(MaxWinSize_Y-ih)/2,iw,ih + MenuHeight())
   EndIf

   SET_CANVAS_CURSOR()

EndProcedure

Procedure REVERT_IMAGE()
   If IsImage(#Revert)
      CopyImage(#Revert, #Image)
      UPDATE_CANVAS_IMAGE()
   EndIf
EndProcedure

Procedure COPY()  ; Ctrl+C
   If IsImage(#Image)
      SetClipboardImage(#Image)
   EndIf
EndProcedure

Procedure PASTE() ; Ctrl+V
   If GetClipboardImage(#Image)
      CopyImage(#Image, #Revert)
      SIZE_WINDOW_TO_IMAGE()
      UPDATE_CANVAS_IMAGE()
      SourceFileName$ = "filename"
      UPDATE_WINDOW_TITLE()
   EndIf
EndProcedure

Procedure SEQUENCED_EFFECTS(effect)
   
   Select effect
      Case #Eff_scramble
         SCRAMBLE_HOR() : SCRAMBLE_DGL() : SCRAMBLE_VRT() : SCRAMBLE_DGR()
      Case #Eff_unscramble
         UNSCRAMBLE_DGR() : UNSCRAMBLE_VRT() : UNSCRAMBLE_DGL() : UNSCRAMBLE_HOR()
      Case #Eff_pencil
         UNSCRAMBLE_DGR() : UNSCRAMBLE_DGR() : GRAY() : NEGATIVE()
      Case #Eff_noise
         SCRAMBLE_DGR() : GRAY() : UNSCRAMBLE_DGR()
      Case #Eff_diamond
         UNSCRAMBLE_DGL() : NEGATIVE() : SCRAMBLE_DGL()
         UNSCRAMBLE_DGR() : NEGATIVE() : SCRAMBLE_DGR()
      Case #Eff_X_factor
         SCRAMBLE_DGR() : UNSCRAMBLE_DGL() : NEGATIVE() : SCRAMBLE_DGL() : UNSCRAMBLE_DGR()
         SCRAMBLE_DGL() : UNSCRAMBLE_DGR() : NEGATIVE() : SCRAMBLE_DGR() : UNSCRAMBLE_DGL()
      Case #Eff_scratch
         UNSCRAMBLE_VRT() : MIRROR() : SCRAMBLE_VRT()
         UNSCRAMBLE_HOR() : MIRROR() : SCRAMBLE_HOR()
      Case #Eff_glowie
         SCRAMBLE_VRT() : NEGATIVE() : UNSCRAMBLE_HOR() : UNSCRAMBLE_VRT() : SCRAMBLE_HOR()
      Case #EFF_phantom
         UNSCRAMBLE_DGR() : NEGATIVE() : SCRAMBLE_DGR()
      Case #Eff_spacy
         SCRAMBLE_HOR() : UNSCRAMBLE_VRT() : UNSCRAMBLE_HOR() : SCRAMBLE_VRT()
      Case #Eff_blush
         SCRAMBLE_HOR() : UNSCRAMBLE_VRT() : UNSCRAMBLE_HOR() : UNSCRAMBLE_VRT()
         SCRAMBLE_VRT() : SCRAMBLE_VRT()   :  NEGATIVE()
      Case #Eff_spectrum
         UNSCRAMBLE_HOR() : UNSCRAMBLE_VRT() : SCRAMBLE_HOR()
         UNSCRAMBLE_DGL() : SCRAMBLE_VRT()
      Case #Eff_slash
         UNSCRAMBLE_DGL() : SCRAMBLE_DGR() : NEGATIVE()
         UNSCRAMBLE_DGR() : SCRAMBLE_DGL()
      Case #Eff_artist
         UNSCRAMBLE_DGL() : NEGATIVE()
      Case #Eff_Demon
         UNSCRAMBLE_HOR() : UNSCRAMBLE_HOR() : SCRAMBLE_VRT()
         SCRAMBLE_HOR()   : UNSCRAMBLE_VRT() : SCRAMBLE_HOR()
      Case #Eff_Faded
         SCRAMBLE_VRT()   : UNSCRAMBLE_HOR() : UNSCRAMBLE_HOR()
         UNSCRAMBLE_VRT() : SCRAMBLE_HOR()   : SCRAMBLE_HOR()
   EndSelect
   
EndProcedure

Procedure RUN_ITERATION(pattern)
   Static iterations = 256
   Protected x, it, event, abort, tempWin, txtGad
   Protected.s text = " Finished "
   Protected iw = ImageWidth(#Image)
   Protected ih = ImageHeight(#Image)
   
   iterations = Val(InputRequester("How many iterations?",
                    "Use Esc key to abort | Powers of 2 are recommended", Str(iterations)))
   
   tempWin = OpenWindow(#PB_Any, 0, 0, 300, 35, "Iterations completed",
                        #PB_Window_Tool|#PB_Window_WindowCentered,
                        WindowID(#WinMain))
   
   txtGad = TextGadget(#PB_Any, 0, 5, 300, 30, "", #PB_Text_Center )
    
   AddKeyboardShortcut(tempWin, #PB_Shortcut_Escape, #Menu_Item_Esc)
    
   For x = 1 To iterations
      Select pattern
         Case #Menu_Item_Itr_HOR  : UNSCRAMBLE_HOR()
         Case #Menu_Item_Itr_VRT  : UNSCRAMBLE_VRT()
         Case #Menu_Item_Itr_DGLD : UNSCRAMBLE_DGL()
         Case #Menu_Item_Itr_DGRD : UNSCRAMBLE_DGR()
      EndSelect
      
      Repeat
         event = WindowEvent()
         If event = #PB_Event_Menu
            If EventMenu() = #Menu_Item_Esc
               text = " Iteration process aborted @ "
               abort = #True
               Break 2
            EndIf
         EndIf
      Until event = 0
      
      Delay(1)
      
      If x & %11111 = %0 ; once evry 32 iterations
         UPDATE_CANVAS_IMAGE()
         SetGadgetText(txtGad," "+Str(x)+" ")
         it = x
         Delay(500)
      EndIf
   Next
   
   If abort = #False
      UPDATE_CANVAS_IMAGE()
      it = x-1
   Else
      StartDrawing(ImageOutput(#Image))
         DrawImage(GetGadgetAttribute(#Canvas,#PB_Canvas_Image),0,0)
      StopDrawing()
      UPDATE_CANVAS_IMAGE()
   EndIf
   
   text + Str(it) + " iterations. "
   SetGadgetText(txtGad, text)
   
   CompilerIf #PB_Compiler_OS = #PB_OS_Linux 
      While WindowEvent() : Wend
   CompilerEndIf
   
   Delay(3000)
   
   RemoveKeyboardShortcut(tempWin, #PB_Shortcut_Escape)
   CloseWindow(tempWin)
   
   ProcedureReturn
 EndProcedure
 
 ;-
 ;- Pixelations procxeedures
 
Procedure PIXELATE_IMAGE(image, value)
   Protected ImgW, ImgH, result
   
   If value < 1 : value = 1 : EndIf
   
   If IsImage(image)
      ImgW = ImageWidth(image)
      ImgH = ImageHeight(image)
      
      If ResizeImage(image, ImgW / value , ImgH / value)
         If ResizeImage(image,ImgW,ImgH,#PB_Image_Raw) ;<-- #PB_Image_Raw works best
            result = #True
         EndIf
      EndIf
   EndIf
   
   ProcedureReturn result
EndProcedure

; Procedure LOAD_IMAGE()
;    Protected result, File$
;    Static Path$ = ""
;    
;    File$ = OpenFileRequester("Please choose an image.", Path$, "*.jpg|*.jpg|*.png|*.png|*.bmp|*.bmp|*.*|*.*", 0)
;    If File$
;       result = LoadImage(#imgRef, File$)
;       If result
;          Path$ = GetPathPart(File$)
;          If IsImage(#imgPixelated) : FreeImage(#imgPixelated) : EndIf
;       EndIf
;    EndIf
;    
;    ProcedureReturn result
; EndProcedure

Procedure CHOOSE_VALUE()
   Static value = 10, value$ = "10"
   
   value$ = InputRequester("Choose value","Enter a pixelation value ",value$)
   If value$
      value = Val(value$)
   Else
      value$ = Str(value)
   EndIf
   
   ProcedureReturn value
EndProcedure

;-
 ;- Colorizationions procxeedures
; IDE Options = PureBasic 6.10 LTS (Windows - x64)
; CursorPosition = 1043
; FirstLine = 1014
; Folding = ------
; EnableXP
; DPIAware
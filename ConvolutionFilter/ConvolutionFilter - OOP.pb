; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; Project name : ConvolutionFilter
; FileName : ConvolutionFilter - OOP.pb
; File Version : 1.0.0
; Programmation : OK
; Programmé par : StarBootics
; Date : 24-11-2019
; Mise à jour : 24-11-2019
; Codé pour PureBasic : V5.71 LTS
; Plateforme : Windows, Linux, MacOS X
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; Programming notes
;
; Based on Keya original code :
;
; https://www.purebasic.fr/english/viewtopic.php?f=12&t=68204
;
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

DeclareModule ConvolutionFilter
  
  Enumeration
    #No_Flip
    #Vertical_Flip
    #Horizontal_Flip
  EndEnumeration
  
  Interface ConvolutionFilter
    
    SelectKernel.b(KernelName.s, FlipMatrix.b = #No_Flip)
    FilterImage.i(OriginalImageHandle)
    RestoreFlippedMatrix()
    Free()
    
  EndInterface
  
  Declare.i New()
  
EndDeclareModule

Module ConvolutionFilter
  
  ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ; <<<<< Structure declaration <<<<<
  
  Structure Private_Members
    
    VirtualTable.i
    Map Kernels.ConvolutionKernel::ConvolutionKernel()
    
  EndStructure
  
  ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ; <<<<< The ColorLimit macro <<<<<
  
  Macro ColorLimit(Color, Minimum, Maximum)
    
    If Color > Maximum
      Color = Maximum
    ElseIf Color < Minimum
      Color = Minimum
    EndIf
    
  EndMacro 
  
  ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ; <<<<< The Private_ConvolvePixel operator <<<<<
  
  Procedure.l Private_ConvolvePixel(*This.Private_Members, *imgbuf, X, Y, width, height, pitch, pixbytes)
    
    Protected r.f, g.f, b.f, ar.a, ab.a, ag.a
    
    *ConvolutionKernel.ConvolutionKernel::ConvolutionKernel = *This\Kernels()
    
    For yy = -1 To 1    ;\ Good candidates for unrolling
      For xx = -1 To 1  ;/
        
        filter.f = *ConvolutionKernel\GetMatrixElement(xx+1,yy+1)
        curx = X + xx
        cury = Y + yy
        
        If curx < 0
          curx = 0
        EndIf
        
        If curx => width
          curx = width-1
        EndIf
        
        If cury < 0
          cury = 0
        EndIf
        
        If cury => height
          cury = height-1
        EndIf       
        
        color.l = PeekL(*imgbuf + (cury * pitch) + (curx * pixbytes))
        r + (Red(color) * filter)
        g + (Green(color) * filter)
        b + (Blue(color) * filter)  
        
      Next
      
    Next
    
    If *ConvolutionKernel\GetScale()
      r / *ConvolutionKernel\GetScale()
      g / *ConvolutionKernel\GetScale()
      b / *ConvolutionKernel\GetScale()
    EndIf
    
    If *ConvolutionKernel\GetOffset()
      r + *ConvolutionKernel\GetOffset()
      g + *ConvolutionKernel\GetOffset()
      b + *ConvolutionKernel\GetOffset()
    EndIf
    
    ColorLimit(r, 0, 255)
    ColorLimit(g, 0, 255)
    ColorLimit(b, 0, 255)
    
    ar = Int(r)
    ab = Int(b)
    ag = Int(g)
    
    ProcedureReturn (ab << 16 | ag << 8 | ar) | $FF000000
  EndProcedure
  
  ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ; <<<<< The SelectKernel operator <<<<<
  
  Procedure.b SelectKernel(*This.Private_Members, KernelName.s, FlipMatrix.b = #No_Flip)
    
    If FindMapElement(*This\Kernels(), KernelName)
      
      *ConvolutionKernel.ConvolutionKernel::ConvolutionKernel = *This\Kernels()
      
      If FlipMatrix = #Vertical_Flip
        *Matrix.ConvolutionMatrix::ConvolutionMatrix = *ConvolutionKernel\GetMatrix()
        *Matrix\FlipVertically()
        *ConvolutionKernel\SetFlipped(ConvolutionKernel::#FLIPPED_VERTICALLY)
      ElseIf FlipMatrix = #Horizontal_Flip
        *Matrix.ConvolutionMatrix::ConvolutionMatrix = *ConvolutionKernel\GetMatrix()
        *Matrix\FlipHorizontally()
        *ConvolutionKernel\SetFlipped(ConvolutionKernel::#FLIPPED_HORIZONTALLY)
      EndIf
      
      Result.b = #True
      
    Else
      DebuggerError("ConvolutionFilter : Impossible to select the kernel : " + KernelName)
    EndIf

    ProcedureReturn Result
  EndProcedure
  
  ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ; <<<<< The FilterImage operator <<<<<  
  
  Procedure.i FilterImage(*This.Private_Members, OriginalImageHandle)
    
    Protected *buf, FilteredImageHandle, width, height
    
    If OriginalImageHandle And IsImage(OriginalImageHandle)
      If StartDrawing(ImageOutput(OriginalImageHandle))
        width = ImageWidth(OriginalImageHandle)
        height = ImageHeight(OriginalImageHandle)
        *buf = DrawingBuffer()
        depth = ImageDepth(OriginalImageHandle)
        StopDrawing()
      EndIf
    EndIf
    
    If *buf
      
      FilteredImageHandle = CreateImage(#PB_Any, width, height, depth)
      
      If FilteredImageHandle
        
        If StartDrawing(ImageOutput(FilteredImageHandle))
          
          pitch = DrawingBufferPitch()
          *out = DrawingBuffer()   
          Pixbytes = depth/8
          w = width-1
          h = height-1
          
          For y = 0 To h
            
            *pixelin = *buf + (y * pitch)
            *pixelout = *out + (y * pitch)
            
            For x = 0 To w       
              color.l = Private_ConvolvePixel(*This, *buf, X, Y, width, height, pitch, pixbytes)
              PokeL(*pixelout, color)
              *pixelin + Pixbytes
              *pixelout + Pixbytes
            Next
            
          Next
          
          StopDrawing()
          
        EndIf 
        
      EndIf
      
    EndIf
    
    ProcedureReturn FilteredImageHandle
  EndProcedure
  
  ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ; <<<<< The RestoreFlippedMatrix operator <<<<<
  
  Procedure RestoreFlippedMatrix(*This.Private_Members)
    
    *ConvolutionKernel.ConvolutionKernel::ConvolutionKernel = *This\Kernels()
    *Matrix.ConvolutionMatrix::ConvolutionMatrix = *ConvolutionKernel\GetMatrix()
    
    If *ConvolutionKernel\GetFlipped() = ConvolutionKernel::#FLIPPED_VERTICALLY
      *Matrix\FlipVertically()
      *ConvolutionKernel\SetFlipped(ConvolutionKernel::#FLIPPED_NOT_FLIPPED)
    EndIf
    
    If *ConvolutionKernel\GetFlipped() = ConvolutionKernel::#FLIPPED_HORIZONTALLY
      *Matrix\FlipHorizontally()
      *ConvolutionKernel\SetFlipped(ConvolutionKernel::#FLIPPED_NOT_FLIPPED)
    EndIf
    
  EndProcedure
  
  ; <<<<<<<<<<<<<<<<<<<<<<<<<<
  ; <<<<< The Destructor <<<<<
  
  Procedure Free(*This.Private_Members)
    
    ForEach *This\Kernels()
      If *This\Kernels() <> #Null
        *This\Kernels()\Free()
      EndIf
    Next
    
    ClearStructure(*This, Private_Members)
    FreeStructure(*This)
    
  EndProcedure
  
  ; <<<<<<<<<<<<<<<<<<<<<<<<<<<
  ; <<<<< The Constructor <<<<<

  Procedure.i New()
    
    *This.Private_Members = AllocateStructure(Private_Members)
    *This\VirtualTable = ?START_METHODS
    
    AddMapElement(*This\Kernels(), "IDENTITY")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0), 1.0, 0)
    
    Scale.f = 14.0
    E22.f = 2.0
    
    For Index = 2 To 10
      AddMapElement(*This\Kernels(), "GAUSSIAN_BLUR_" + Str(Index))
      *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(1.0,2.0,1.0,2.0, E22, 2.0,1.0,2.0,1.0), Scale, 0)
      E22 + 1.0
      Scale + 1.0
    Next
 
    AddMapElement(*This\Kernels(), "MOTION_BLUR_RIGHT")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "MOTION_BLUR_LEFT")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "MOTION_BLUR")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.3333, 0.0, 0.0, 0.0, 0.3333, 0.0, 0.0, 0.0, 0.3333), 1.0, 0)
    
    Scale = 13.0
    E22 = 5.0
    
    For Index = 1 To 4
      AddMapElement(*This\Kernels(), "SMOOTH_" + Str(Index))
      *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(1.0,1.0,1.0,1.0, E22, 1.0,1.0,1.0,1.0), Scale, 0)
      E22 - 1.0
      Scale - 1.0
    Next
    
    AddMapElement(*This\Kernels(), "MEAN_SMOOTH")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0), 9.0, 0)
    
    
    Ex.f = -0.125
    E22.f = 1.5
    
    For Index = 15 To 50 Step 5
      
      AddMapElement(*This\Kernels(), "SHARPEN_" + Str(Index))
      *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, Ex, 0.0, Ex, E22, Ex, 0.0, Ex, 0.0), 1.0, 0)
      E22 + 0.5
      Ex - 0.125
      
    Next

    AddMapElement(*This\Kernels(), "SHARPEN_MEAN_REMOVAL")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-1.0,-1.0,-1.0,-1.0, 9.0, -1.0, -1.0,-1.0,-1.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "EXTRUDE")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(1.0,1.0,1.0,1.0, -7.0, 1.0, 1.0,1.0,1.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "EMBOSS_V1")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-1.0,-1.0,0.0,-1.0, 0.0, 1.0, 0.0, 1.0, 1.0), 9.0, 128)
    
    AddMapElement(*This\Kernels(), "EMBOSS_V2")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0), 9.0, 128)
    
    AddMapElement(*This\Kernels(), "EMBOSS_V3")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(1.0,1.0,0.0, 1.0, 0.0, -1.0, 0.0, -1.0, -1.0), 9.0, 128)
    
    AddMapElement(*This\Kernels(), "EMBOSS_V4")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-2.0, -1.0, 0.0,-1.0, 1.0, 1.0, 0.0, 1.0, 2.0), 9.0, 128)
    
    AddMapElement(*This\Kernels(), "EMBOSS_V5")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-3.0, -2.0, -1.0,-2.0, 2.0, 2.0, 0.1, 2.0, 3.0), 9.0, 128)

    AddMapElement(*This\Kernels(), "RAISED")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, 0.0, 1.0, 0.0, 2.0, 0.0, -2.0, 0.0, 0.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "EDGE_DETECT_HV")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, 1.0, 0.0, 1.0, -4.0, 1.0, 0.0, 1.0, 0.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "EDGE_DETECT_H")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, -1.0, 0.0, 0.0, 2.0, 0.0, 0.0, -1.0, 0.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "EDGE_DETECT_V")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, 0.0, 0.0, -1.0, 2.0, -1.0, 0.0, 0.0, 0.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "EDGE_DETECT_DIFFERENTIAL")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-0.25, 0.0, 0.25, 0.0, 0.0, 0.0, 0.25, 0.0, -0.25), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "EDGE_ENHANCE_H")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, -1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "EDGE_ENHANCE_V")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, 0.0, 0.0, -1.0, 1.0, 0.0, 0.0, 0.0, 0.0), 1.0, 0)

    AddMapElement(*This\Kernels(), "PREWITT_H")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, -1.0, -1.0, -1.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "PREWITT_V")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(1.0, 0.0, -1.0, 1.0, 0.0, -1.0, 1.0, 0.0, -1.0), 1.0, 0)

    AddMapElement(*This\Kernels(), "SOBEL_H")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-1.0, -2.0, -1.0, 0.0, 0.0, 0.0, 1.0, 2.0, 1.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "SOBEL_V")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(1.0, 0.0, -1.0, 2.0, 0.0, -2.0, 1.0, 0.0, -1.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "SOBEL_FELDMAN_H")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(3.0, 10.0, 3.0, 0.0, 0.0, 0.0, -3.0, -10.0, -3.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "SOBEL_FELDMAN_V")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(3.0, 0.0, -3.0, 10.0, 0.0, -10.0, 3.0, 0.0, -3.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "LAPLACE")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, 1.0, 0.0, 1.0, -4.0, 1.0, 0.0, 1.0, 0.0), 1.0, 0)
        
    AddMapElement(*This\Kernels(), "LAPLACE_INV")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0, -1.0, 0.0, -1.0, 4.0, -1.0, 0.0, -1.0, 0.0), 1.0, 0)
        
    AddMapElement(*This\Kernels(), "LAPLACE_DIAGONAL")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.25, 0.5, 0.25, 0.5, -3.0, 0.5, 0.25, 0.5, 0.25), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "SCHARR_H")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(3.0, 0.0, -3.0, 10.0, 0.0, -10.0, 3.0, 0.0, -3.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "SCHARR_V")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-3.0, 0.0, 3.0, -10.0, 0.0, 10.0, 3.0, 0.0, -3.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "EDGE_360_KEYA")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-1.0, -1.0, -1.0, -1.0, 8.0, -1.0, -1.0, -1.0, -1.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "GRADIENT_DETECT_V")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-1.0, 0.0, 1.0, -1.0, 0.0, 1.0, -1.0, 0.0, 1.0), 1.0, 0)
    
    AddMapElement(*This\Kernels(), "GRADIENT_DETECT_H")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(-1.0, -1.0, -1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0), 1.0, 0)
    
    E22B.f = 1.1
    E22D.f = 0.9
    
    For Index = 1 To 9
      AddMapElement(*This\Kernels(), "BRIGHTEN_" + Str(Index))
      *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0,0.0,0.0,0.0,E22B,0.0,0.0,0.0,0.0), 1.0, 0)
      
      AddMapElement(*This\Kernels(), "DARKEN_" + Str(Index))
      *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0,0.0,0.0,0.0,E22D,0.0,0.0,0.0,0.0), 1.0, 0)
      E22B + 0.1
      E22D - 0.1
    Next
    
    AddMapElement(*This\Kernels(), "SPREAD_PIXEL")
    *This\Kernels() = ConvolutionKernel::New(ConvolutionMatrix::New(0.0,0.5,0.0,0.5,1.0,0.5,0.0,0.5,0.0), 1.0, 0)
    
    ProcedureReturn *This
  EndProcedure
  
  DataSection
    START_METHODS:
    Data.i @SelectKernel()
    Data.i @FilterImage()
    Data.i @RestoreFlippedMatrix()
    Data.i @Free()
    END_METHODS:
  EndDataSection
  
EndModule

; <<<<<<<<<<<<<<<<<<<<<<<
; <<<<< END OF FILE <<<<<
; <<<<<<<<<<<<<<<<<<<<<<<
; IDE Options = PureBasic 5.71 LTS (Linux - x64)
; Folding = ---
; EnableXP
; CompileSourceDirectory
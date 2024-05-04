; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; Project name : ConvolutionFilter
; File Name : ConvolutionFilter - Example.pb
; File version: 1.0.0
; Programming : OK
; Programmed by : StarBootics
; Date : 28-11-2019
; Last Update : 28-11-2019
; PureBasic code : V5.71 LTS
; Platform : Windows, Linux, MacOS X
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; GAUSSIAN_BLUR_2
; GAUSSIAN_BLUR_3
; GAUSSIAN_BLUR_4
; GAUSSIAN_BLUR_5
; GAUSSIAN_BLUR_6
; GAUSSIAN_BLUR_7
; GAUSSIAN_BLUR_8
; GAUSSIAN_BLUR_9
; GAUSSIAN_BLUR_10
; MOTION_BLUR_RIGHT
; MOTION_BLUR_LEFT
; MOTION_BLUR
; SMOOTH_1
; SMOOTH_2
; SMOOTH_3
; SMOOTH_4
; MEAN_SMOOTH
; SHARPEN_15
; SHARPEN_20
; SHARPEN_25
; SHARPEN_30
; SHARPEN_35
; SHARPEN_40
; SHARPEN_45
; SHARPEN_50
; SHARPEN_MEAN_REMOVAL
; EXTRUDE
; EMBOSS_V1
; EMBOSS_V2
; EMBOSS_V3
; EMBOSS_V4
; EMBOSS_V5
; RAISED
; EDGE_DETECT_HV
; EDGE_DETECT_H
; EDGE_DETECT_V
; EDGE_DETECT_DIFFERENTIAL
; EDGE_ENHANCE_H
; EDGE_ENHANCE_V
; PREWITT_H
; PREWITT_V
; SOBEL_H
; SOBEL_V
; SOBEL_FELDMAN_H
; SOBEL_FELDMAN_V
; LAPLACE
; LAPLACE_INV
; LAPLACE_DIAGONAL
; SCHARR_H
; SCHARR_V
; EDGE_360_KEYA
; GRADIENT_DETECT_H
; GRADIENT_DETECT_V
; BRIGHTEN_1
; BRIGHTEN_2
; BRIGHTEN_3
; BRIGHTEN_4
; BRIGHTEN_5
; BRIGHTEN_6
; BRIGHTEN_7
; BRIGHTEN_8
; BRIGHTEN_9
; DARKEN_1
; DARKEN_2
; DARKEN_3
; DARKEN_4
; DARKEN_5
; DARKEN_6
; DARKEN_7
; DARKEN_8
; DARKEN_9
; SPREAD_PIXEL
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; Programming notes
;
; Based on Keya original code :
;
; https://www.purebasic.fr/english/viewtopic.php?f=12&t=68204
;
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

IncludeFile "ConvolutionMatrix - OOP.pb"
IncludeFile "ConvolutionKernel - OOP.pb"
IncludeFile "ConvolutionFilter - OOP.pb"

Imgfile.s = #PB_Compiler_Home + "examples" + #PS$ + "sources" + #PS$ + "Data" + #PS$ + "PureBasicLogo.bmp" ;not very good for testing filters, use a photo!

ImageHandle00 = LoadImage(#PB_Any, Imgfile)

If Not ImageHandle00
  MessageRequester("Error","Couldnt load " + Imgfile)
  End
EndIf

ConvFilter.ConvolutionFilter::ConvolutionFilter = ConvolutionFilter::New()

If ConvFilter\SelectKernel("LAPLACE", ConvolutionFilter::#Horizontal_Flip)
  ImageHandle01 = ConvFilter\FilterImage(ImageHandle00)
  ConvFilter\RestoreFlippedMatrix()
  ImageHandle02 = ConvFilter\FilterImage(ImageHandle00)
Else
  MessageRequester("Error", "Invalid kernel Name")
  End
EndIf

Width = ImageWidth(ImageHandle00)
Height = ImageHeight(ImageHandle00)

If OpenWindow(0, 0, 0, (width)+20, (height*3)+40, "3x3 Convolution Filter", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
  ImageGadget(#PB_Any, 10, 10, width, height, ImageID(ImageHandle00)) 
  ImageGadget(#PB_Any, 10, 20+height, width, height, ImageID(ImageHandle01)) 
  ImageGadget(#PB_Any, 10, (15+height)*2, width, height, ImageID(ImageHandle02)) 
  Repeat
    Event = WaitWindowEvent()
  Until Event = #PB_Event_CloseWindow
EndIf

; <<<<<<<<<<<<<<<<<<<<<<<
; <<<<< END OF FILE <<<<<
; <<<<<<<<<<<<<<<<<<<<<<<
; IDE Options = PureBasic 6.10 LTS (Windows - x64)
; CursorPosition = 107
; FirstLine = 95
; EnableXP
; CompileSourceDirectory
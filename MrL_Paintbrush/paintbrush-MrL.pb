; simple painter
; 02/2024 Mr.L

EnableExplicit
UseJPEGImageDecoder()
UseJPEGImageEncoder()
UsePNGImageDecoder()
UsePNGImageEncoder()

Enumeration
	#g_canvas
	#g_palette
	#g_width
	#g_height
	#g_addPaint
	#g_smudge
	#g_smear
	#g_rotate
	#g_TxtSize
	#g_TxtSmear
	#g_TxtSmudge
	#g_TxtAddPaint
	#g_clearBrush
	#g_dryPainting
	
	#m_Popup
	#m_Undo
	#m_CleanBrush
	#m_Dry
	#m_Load
	#m_Save
EndEnumeration

#WindowWidth = 1024
#WindowHeight = 768
#MinValue = 0.1
#MaxUndo = 5
#MinStrokeDistance = 5
#BrushSize = 100
#BrushSizeH = #BrushSize / 2

Global RedrawTime
Global LeftButton

Structure PAINT
	r.d
	g.d
	b.d
	a.d
	f.d
EndStructure

Structure BRUSH
	widthOld.d
	heightOld.d
	width.l
	height.l
	widthH.l
	heightH.l
	fill.d
	
	angleOld.d
	xOld.l
	yOld.l
	
	x.l
	y.l
	smudge.d
	smear.d
	angle.d
	addPaint.d
	rotate.b
	scale.d
	
	Array mask.d(#BrushSize * 2, #BrushSize * 2)
	Array paint.PAINT(1, #BrushSize * 2, #BrushSize * 2)
EndStructure

Structure PAINTING
	canvas.i
	paper.i
	width.l
	height.l
	image.i
	
	backR.d
	backG.d
	backB.d
	
	locked.b
	modified.b
	key.l
	
	zoom.d
	scrollX.d
	scrollY.d
	
	*brush.BRUSH
	Array paint.PAINT(256, 256)
	Array grain.d(256, 256)
	
	List undo.PAINTING()
	List redo.PAINTING()
EndStructure

Global *Palette.PAINTING
Global *Painting.PAINTING

OpenWindow(0, 0,0 , #WindowWidth + 210, #WindowHeight, "SimplePaint", #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget  | #PB_Window_SizeGadget)
CanvasGadget(#g_canvas, 5, 5, #WindowWidth, #WindowHeight - 10, #PB_Canvas_Border | #PB_Canvas_Keyboard)
CanvasGadget(#g_palette, #WindowWidth + 15, 350, 180, #WindowHeight - 355, #PB_Canvas_Border | #PB_Canvas_Keyboard)
TextGadget(#g_TxtSize, #WindowWidth + 20, 10, 180, 25, "Size")
TrackBarGadget(#g_width, #WindowWidth + 15, 35, 180, 25, 0, 1000)
TrackBarGadget(#g_height, #WindowWidth + 15, 65, 180, 25, 0, 1000)
TextGadget(#g_TxtSmudge, #WindowWidth + 20,100, 180, 25, "Smudge")
TrackBarGadget(#g_smudge, #WindowWidth + 15, 125, 180, 25, 0, 1000)
TextGadget(#g_TxtSmear, #WindowWidth + 20,155, 180, 25, "Smear")
TrackBarGadget(#g_smear, #WindowWidth + 15, 180, 180, 25, 0, 1000)
TextGadget(#g_TxtAddPaint, #WindowWidth + 20,265, 200, 25, "Add Paint")
TrackBarGadget(#g_addPaint, #WindowWidth + 15, 290, 80, 25, 0, 1000)
CheckBoxGadget(#g_rotate, #WindowWidth + 15, 320, 80, 25, "rotate Brush")
ButtonGadget(#g_dryPainting, #WindowWidth + 115, 290, 80, 25, "dry Paint")
ButtonGadget(#g_clearBrush, #WindowWidth + 115, 320, 80, 25, "clear Brush")
SetActiveGadget(#g_canvas)

CreatePopupMenu(#m_Popup)
MenuItem(#m_Undo, "Undo")
MenuBar()
MenuItem(#m_CleanBrush, "clean brush")
MenuItem(#m_Dry, "dry painting")
MenuBar()
MenuItem(#m_Load, "Load...")
MenuItem(#m_Save, "Save...")

Declare Brush_SetColor(*brush.BRUSH, r.d, g.d, b.d, a.d, fill.d)
Declare Quit()

Procedure.d Clamp0(v.d, max.d)
	Static temp.d
	temp = v + max - Abs(v - max)
	ProcedureReturn (temp + Abs(temp)) * 0.25
EndProcedure

Procedure.d Clamp(v.d, min.d, max.d)
	If v < min
		ProcedureReturn min
	ElseIf v > max
		ProcedureReturn max
	EndIf
	ProcedureReturn v
EndProcedure

Procedure.d Max(v1.d, v2.d)
	If v1 > v2
		ProcedureReturn v1
	EndIf
	ProcedureReturn v2
EndProcedure

Procedure.d Min(v1.d, v2.d)
	If v1 < v2
		ProcedureReturn v1
	EndIf
	ProcedureReturn v2
EndProcedure

Procedure Painting_SetPaper(*painting.PAINTING, r.d, g.d, b.d, f.d, grain = 0, roughness.d = 0)
	RandomSeed(0)
	Protected x, y, i, c.d
	With *painting
		If grain
			For y = 1 To *painting\height - 2
				For x = 1 To *painting\width - 2
					If Random(grain) = 0 And (x % 5 = 1 Or y % 5 = 1)
						\grain(x, y) = roughness
					Else
						\grain(x, y) = 0
					EndIf
				Next
			Next
			For i = 0 To 0
				For y = 1 To *painting\height - 2
					For x = 1 To *painting\width - 2
						\grain(x, y) = Abs((\grain(x - 1, y) + \grain(x + 1, y) + \grain(x, y - 1) + \grain(x, y + 1)) * 0.25)
					Next
				Next
			Next
		EndIf
		
		\backR = r
		\backG = g
		\backB = b
		
		If StartDrawing(ImageOutput(*painting\image))
			For y = 1 To *painting\height - 2
				For x = 1 To *painting\width - 2
					\paint(x, y)\r = r
					\paint(x, y)\g = g
					\paint(x, y)\b = b
					\paint(x, y)\f = f
					c = 255 - ((\grain(x - 1, y - 1) - \grain(x + 1, y + 1)) * 25 + 15)
					c = Clamp0(c, 255)
					Plot(x, y, RGB(r * c, g * c, b * c))
				Next
			Next
			StopDrawing()
		EndIf
	EndWith
EndProcedure

Procedure Painting_PickColor(*painting.PAINTING, *brush.BRUSH, x, y, fill.d = -1)
	If x < 0 Or x > *painting\width - 1 Or y < 0 Or y > *painting\height - 1
		ProcedureReturn -1
	EndIf
	If fill = -1
		Brush_SetColor(*brush, *painting\paint(x, y)\r, *painting\paint(x, y)\g, *painting\paint(x, y)\b, *painting\paint(x, y)\a, *painting\paint(x, y)\f)
	Else
		Brush_SetColor(*brush, *painting\paint(x, y)\r, *painting\paint(x, y)\g, *painting\paint(x, y)\b, *painting\paint(x, y)\a, fill)
	EndIf
EndProcedure

Procedure Painting_New(canvas, width, height)
	Protected x, y
	Protected *painting.Painting = AllocateStructure(Painting)
	If *painting
		With *painting
			Dim \paint.PAINT(width, height)
			Dim \grain.d(width, height)
			\canvas = canvas
			\zoom = 1
			\scrollX = 0
			\scrollY = 0
			\width = width
			\height = height
			\image = CreateImage(#PB_Any, \width, \height, 32)
			\locked = #False
		EndWith
		SetGadgetData(canvas, *painting)
	EndIf
	ProcedureReturn *painting
EndProcedure

Procedure Painting_Clear(*painting.PAINTING)
	Dim *painting\paint.PAINT(*painting\width, *painting\height)
	Painting_SetPaper(*painting, *painting\backR, *painting\backG, *painting\backB, 0, 0, 0)
EndProcedure

Procedure Painting_Dry(*painting.PAINTING, amount.d)
	Protected x, y, i
	With *painting
		For y = 0 To \height - 1
			For x = 0 To \width - 1
				\paint(x, y)\f = amount
			Next
		Next
	EndWith	
EndProcedure

Procedure Painting_DrawBrushPreview(*painting.PAINTING, *brush.BRUSH)
	If *painting And *brush
		Protected xa, xb, ya, yb
		Protected fill.d, r.d, g.d, b.d, f.d, count
		With *brush
			For ya = -\heightH To \heightH - 1 Step 2
				yb = ya + #BrushSize
				For xa = -\widthH To \widthH - 1 Step 2
					xb = xa + #BrushSize
					fill = *brush\paint(0, xb, yb)\f
					If fill
						r + *brush\paint(0, xb, yb)\r
						g + *brush\paint(0, xb, yb)\g
						b + *brush\paint(0, xb, yb)\b
						f + fill
						count + 1
					EndIf
				Next
			Next
		EndWith	
		
		If count
			r = Clamp0((r / count) * 255, 255)
			g = Clamp0((g / count) * 255, 255)
			b = Clamp0((b / count) * 255, 255)
			f / count
		EndIf
		
		If *painting = *Palette
			AddPathBox(10, 110, 10, -100)
			VectorSourceColor(RGBA(255, 255, 255, 128))
			FillPath(#PB_Path_Preserve)
			VectorSourceColor(RGBA(0, 0, 0, 128))
			StrokePath(1)
			AddPathBox(10, 110, 10, -Min(f * 100, 100))
			VectorSourceColor(RGBA(r, g, b, 255))
			FillPath(#PB_Path_Preserve)
			VectorSourceColor(RGBA(0, 0, 0, 128))
			StrokePath(1)
		EndIf
		
		RotateCoordinates(*brush\x, *brush\y, Degree(*brush\angle - #PI / 2))
		AddPathEllipse(*brush\x, *brush\y, *brush\widthH * *painting\zoom, *brush\heightH * *painting\zoom)
		VectorSourceColor(RGBA(r, g, b, 255))
		StrokePath(6, #PB_Path_Preserve)
		VectorSourceColor(RGBA(0,0,0,255))
	EndIf
EndProcedure

Procedure Painting_Draw(*painting.PAINTING, *brush.BRUSH)
	If *painting = 0
		ProcedureReturn
	EndIf
	With *painting
		If StartVectorDrawing(CanvasVectorOutput(*painting\canvas))
			VectorSourceColor(RGBA(128,128,128,255))
			FillVectorOutput()
			
			SaveVectorState()
			ScaleCoordinates(*painting\zoom, *painting\zoom)
			TranslateCoordinates(*painting\scrollX, *painting\scrollY)
			
			VectorSourceColor(RGBA(80,80,80,255))
			MovePathCursor(8, *painting\height + 4)
			AddPathLine(*painting\width - 4, 0, #PB_Path_Relative)
			AddPathLine(0, -*painting\height + 4, #PB_Path_Relative)
			StrokePath(8)
			
			MovePathCursor(0, 0)
 			DrawVectorImage(ImageID(\image))
			; 			MovePathCursor(0, 0)
			; 			DrawVectorImage(ImageID(\paper))
			
			RestoreVectorState()
			
			Painting_DrawBrushPreview(*painting, *brush)
			
			StopVectorDrawing()
		EndIf
		
		\modified = #False
	EndWith
EndProcedure

Procedure Painting_Copy(*source.PAINTING, *target.PAINTING)
	If *source And *target
		CopyArray(*source\paint(), *target\paint())
		
		If IsImage(*target\image)
			FreeImage(*target\image)
		EndIf
		
		*target\image = CopyImage(*source\image, #PB_Any)
	EndIf
EndProcedure

Procedure Undo_Add(*painting.PAINTING)
	LastElement(*painting\undo())
	If AddElement(*painting\undo())
		Painting_Copy(*painting, *painting\undo())
	EndIf
	While ListSize(*painting\undo()) > #MaxUndo
		If FirstElement(*painting\undo())
			DeleteElement(*painting\undo())
		EndIf
	Wend
EndProcedure

Procedure Undo_Do(*painting.PAINTING)
	If LastElement(*painting\undo())
		Painting_Copy(*painting\undo(), *painting)
		If IsImage(*painting\undo()\image)
			FreeImage(*painting\undo()\image)
		EndIf
		DeleteElement(*painting\undo())
	EndIf
	*painting\modified = 1
EndProcedure

Procedure Brush_SetSize(*brush.Brush, width.d, height.d)
	Protected x, y, i, mask.d
	
	With *brush
		If width <> -1
			\width = Clamp(width, 10, #BrushSize)
			SetGadgetState(#g_width, (\width / (#BrushSize * 1.0)) * 1000)
		EndIf
		If height <> - 1
			\height = Clamp(height, 10, #BrushSize)
			SetGadgetState(#g_height, (\height / (#BrushSize * 1.0)) * 1000)
		EndIf
		SetGadgetText(#g_TxtSize, "Brush Size:  " + Str(\width) + " x " + Str(\height))
		
		\widthH = \width / 2
		\heightH = \height / 2
		
		Protected Dim bristle.d(\width)
		For x = 0 To \width - 1
			bristle(x) = Clamp(1.0 / (Random(10000) / 10000.0), 0.5, 2)
		Next
		
		For y = -\heightH To \heightH - 1
			For x = -\widthH To \widthH - 1
				mask = (x * x) / (\widthH * \widthH) + (y * y) / (\heightH * \heightH)
				If mask >= 0.95
					\mask(x + #BrushSize, y + #BrushSize) = 0
				Else;If Random(10) < 8
					\mask(x + #BrushSize, y + #BrushSize) = Clamp(bristle(x + \widthH), 0.5, 2)
				EndIf
			Next
		Next
		
		For i = 0 To 5
			For y = 1 To \height - 2
				For x = 1 To \width - 2 
 					\mask(x, y) = (\mask(x - 1, y) + \mask(x + 1, y) + \mask(x, y - 1) + \mask(x, y + 1)) * 0.25
				Next
			Next
		Next
		
		\angleOld = 999
	EndWith
EndProcedure

Procedure Brush_SetColor(*brush.BRUSH, r.d, g.d, b.d, a.d, fill.d)
	Protected d.d, i
	Protected f2.d = Min(fill, 1), f1.d = 1.0 - f2
	If fill < 0
		f1 = 1
		f2 = 0
	EndIf
	
	With *brush
		Protected x, y, xb, yb = -\heightH
		
		For y = -\heightH + 1  To \heightH - 1
			yb = y + #BrushSize
			For x = -\widthH + 1 To \widthH - 1
				xb = x + #BrushSize
 				If *brush\mask(xb, yb) And (r >= 0)
					For i = 0 To 1
						If fill
							If \paint(i, xb, yb)\f
								\paint(i, xb, yb)\r * f1 + r * f2
								\paint(i, xb, yb)\g * f1 + g * f2
								\paint(i, xb, yb)\b * f1 + b * f2
								\paint(i, xb, yb)\a * f1 + a * f2
							Else
								\paint(i, xb, yb)\r = r
								\paint(i, xb, yb)\g = g
								\paint(i, xb, yb)\b = b
								\paint(i, xb, yb)\a = a
							EndIf
							\paint(i, xb, yb)\f = Clamp(\paint(i, xb, yb)\f + fill, 0, 1)
						Else
							\paint(i, xb, yb)\r = 0
							\paint(i, xb, yb)\g = 0
							\paint(i, xb, yb)\b = 0
							\paint(i, xb, yb)\f = 0
						EndIf
					Next
					
				EndIf
			Next
		Next
	EndWith
EndProcedure

Procedure Brush_GetPaintingColor(*brush.BRUSH, *painting.PAINTING, amount.d)
	Protected a2.d = 1.0 - amount
	Protected xa, xb, xc, x = *brush\x
	Protected ya, yb, yc, y = *brush\x

	With *brush
		For ya = -\heightH To \heightH - 1
			yb = ya + *brush\y
			If yb >= 0 And yb < *painting\height
				For xa = -\widthH To \widthH - 1
					xb = xa + *brush\x
					If xb >= 0 And xb < *painting\width And *brush\mask(xa + #BrushSize, ya + #BrushSize)
						*brush\paint(0, xa + #BrushSize, ya + #BrushSize)\r * a2 + *painting\paint(xb, yb)\r * amount
						*brush\paint(0, xa + #BrushSize, ya + #BrushSize)\g * a2 + *painting\paint(xb, yb)\g * amount
						*brush\paint(0, xa + #BrushSize, ya + #BrushSize)\b * a2 + *painting\paint(xb, yb)\b * amount
						*brush\paint(0, xa + #BrushSize, ya + #BrushSize)\a * a2 + *painting\paint(xb, yb)\a * amount
						*brush\paint(0, xa + #BrushSize, ya + #BrushSize)\f * a2 + *painting\paint(xb, yb)\f * amount
						*brush\paint(1, xa + #BrushSize, ya + #BrushSize)\r = *brush\paint(0, xa + #BrushSize, ya + #BrushSize)\r
						*brush\paint(1, xa + #BrushSize, ya + #BrushSize)\g = *brush\paint(0, xa + #BrushSize, ya + #BrushSize)\g
						*brush\paint(1, xa + #BrushSize, ya + #BrushSize)\b = *brush\paint(0, xa + #BrushSize, ya + #BrushSize)\b
						*brush\paint(1, xa + #BrushSize, ya + #BrushSize)\a = *brush\paint(0, xa + #BrushSize, ya + #BrushSize)\a
						*brush\paint(1, xa + #BrushSize, ya + #BrushSize)\f = *brush\paint(0, xa + #BrushSize, ya + #BrushSize)\f
					EndIf
				Next
			EndIf
		Next
	EndWith
EndProcedure

Procedure Brush_SetParam(*brush.BRUSH, smudge.d, smear.d, fill.d, addPaint.d, rotate.b)
	With *brush
		If smudge >= 0
			\smudge = smudge
			SetGadgetState(#g_smudge, smudge * 1000)
		EndIf
		If smear >= 0
			\smear = 1 - smear
			SetGadgetState(#g_smear, smear * 1000)
		EndIf
		If addPaint >= 0
			\addPaint = addPaint
			SetGadgetState(#g_addPaint, addPaint * 1000)
		EndIf
		If rotate >= 0
			\rotate = rotate
			SetGadgetState(#g_rotate, rotate)
		EndIf
		
		SetGadgetText(#g_TxtSmudge, "Smudge: " + Str(\smudge * 100) + "%")
		SetGadgetText(#g_TxtSmear, "Smear: " + Str(100 - \smear * 100) + "%")
		SetGadgetText(#g_TxtAddPaint, "Add Paint: " + Str(\addPaint * 100) + "%")
	EndWith
EndProcedure

Procedure Brush_Erase(*painting.PAINTING, *brush.BRUSH, amount.d)
	Protected c.d
	Protected xa, ya, xb, yb, xc, yc
	Protected.PAINT *paintColor	
	
	If StartDrawing(ImageOutput(*painting\image))
		yc = #BrushSize - *brush\heightH
		yb = *brush\y - *brush\heightH
		For ya = 0 To *brush\height - 1
			If yb > 0 And yb < *painting\height - 1
				xc = #BrushSize - *brush\widthH
				xb = *brush\x - *brush\widthH
				For xa = 0 To *brush\width - 1
					If *brush\mask(xc, yc)
						If xb > 0 And xb < *painting\width - 1
							*paintColor = @*painting\paint(xb, yb)
							*paintColor\r = Clamp0(*paintColor\r + (*painting\backR - *paintColor\r) * amount, 1)
							*paintColor\g = Clamp0(*paintColor\g + (*painting\backG - *paintColor\g) * amount, 1)
							*paintColor\b = Clamp0(*paintColor\b + (*painting\backB - *paintColor\b) * amount, 1)
							*paintColor\f = Clamp0(*paintColor\f * (1 - amount), 1)
							
							c = 255 - ((*painting\grain(xb - 1, yb - 1) - *painting\grain(xb + 1, yb + 1)) * 25 + 15)
; 							c = Clamp0(c, 255)
							Plot(xb, yb, RGB(*paintColor\r * c, *paintColor\g * c, *paintColor\b * c))
						EndIf
					EndIf
					xb + 1
					xc + 1
				Next
			EndIf
			yb + 1
			yc + 1
		Next
		StopDrawing()
	EndIf	
	
	*painting\modified = #True
EndProcedure

Procedure Brush_Stroke(*painting.PAINTING, *brush.BRUSH, x1,y1, x2,y2, scale.d = 0.85)
	If *painting\locked
		ProcedureReturn
	EndIf
	
	Static oldH, oldW
	Static xo, yo
	Static w, h, w2, h2, i, x, y, xa, ya, da, xb, yb, b
	Static.d smudge, smear, amount, m1, m2, mask, dx, dy, di, a, d, f
	Static.PAINT *brushColor, *paintColor
	Static Dim BrushCoordX.d(#BrushSize, #BrushSize)
	Static Dim BrushCoordY(#BrushSize, #BrushSize)
	Static Dim BrushCoordXd.d(#BrushSize, #BrushSize)
	Static Dim BrushCoordYd.d(#BrushSize, #BrushSize)
	Protected i1 = 0, i2 = 1
		
	x1 / *painting\zoom - *painting\scrollX
	y1 / *painting\zoom - *painting\scrollY
	x2 / *painting\zoom - *painting\scrollX
	y2 / *painting\zoom - *painting\scrollY
	
	dx = x2 - x1
	dy = y2 - y1
	di = Sqr(dx * dx + dy * dy)	
	
	
	If di = 0
		ProcedureReturn
	EndIf
	
; 	scale = Clamp(1.0 - di / 200, 0.1, 0.85)
	
	dx / di
	dy / di
	
	w = *brush\width * scale
	h = *brush\height * scale
	w2 = w * 0.5;*brush\widthH * scale
	h2 = h * 0.5;*brush\heightH * scale
	
	smudge = *brush\smudge * 3.5
	smear = 1.0 - Pow(*brush\smear * 0.4, 3.5)
	
	da = #PI - Abs(Abs(*brush\angleOld - *brush\angle) - #PI)
	
	If (h <> oldH) Or (w <> oldW) Or (*brush\rotate = 0 Or *brush\angle <> *brush\angleOld)
		oldH = h
		oldW = w
		For y = 0 To h - 1
			Protected yc = y - h2
			For x = 0 To w - 1
				Protected xc = x - w2
				a = ATan2(xc, yc) - *brush\angleOld
				d = Sqr(xc * xc + yc * yc); * scale
				BrushCoordX(x, y) = Sin(a) * d
				BrushCoordY(x, y) = Cos(a) * d
				a + *brush\angleOld - *brush\angle
				BrushCoordXd(x, y) = (Sin(a) * d - BrushCoordX(x, y)) / di
				BrushCoordYd(x, y) = (Cos(a) * d - BrushCoordY(x, y)) / di
			Next
		Next
	EndIf
	
	If StartDrawing(ImageOutput(*painting\image))
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		For i = 0 To di - 1 Step 2
			x = x1 + dx * i
			y = y1 + dy * i
			yc = #BrushSize - h2
			For ya = 0 To h - 1
				xc = #BrushSize - w2
				For xa = 0 To w - 1 
					mask = *brush\mask(xc, yc)
					If mask
						xb = x + BrushCoordX(xa, ya) + BrushCoordXd(xa, ya) * i
						yb = y + BrushCoordY(xa, ya) + BrushCoordYd(xa, ya) * i
						If (xb > 0 And xb < *painting\width - 1) And (yb > 0 And yb < *painting\height - 1)
							*brushColor = @*brush\paint(i1, xc, yc)
							*paintColor = @*painting\paint(xb, yb)
							
							amount = (*brushColor\f + *paintColor\f) * mask - *painting\grain(xb, yb)
							If (amount * smudge) > #MinValue
								m1 = *brushColor\f / amount * smudge
								If m1 > 1
									m1 = 1
								EndIf
								
								m2 = 1 - m1
								*brushColor\r * m1 + *paintColor\r * m2
								*brushColor\g * m1 + *paintColor\g * m2
								*brushColor\b * m1 + *paintColor\b * m2
								*brushColor\f = (*brushColor\f * m1 + *paintColor\f * m2) * smear
								CopyStructure(*brushColor, *paintColor, PAINT)
								
								If (xb > 0 And xb < *painting\width - 1) And (yb > 0 And yb < *painting\height - 1)
									If (xb <> xo Or yb <> yo)
										xo = xb
										yo = yb
										
										f = (*painting\paint(xb + 1, yb + 1)\f - *painting\paint(xb - 1, yb - 1)\f +
										     *painting\paint(xb - 1, yb + 1)\f - *painting\paint(xb + 1, yb - 1)\f) * 0.35; * 0.75
										
										If f > 0.25
											f = 0.25
 										ElseIf f < -0.05
 											f = -0.05
 										EndIf
 										
 										Plot(xb, yb, RGBA(Clamp0(*paintColor\r + f, 1) * 255,
 										                  Clamp0(*paintColor\g + f, 1) * 255,
 										                  Clamp0(*paintColor\b + f, 1) * 255,
 										                  *paintColor\f * 255))
									EndIf
								EndIf

							Else
								*brushColor\f = 0
							EndIf
						EndIf
					EndIf
					xc + 1
				Next
				yc + 1
			Next
			Swap i1, i2
		Next
		StopDrawing()
	EndIf
	
	*painting\modified = #True
EndProcedure

Procedure Painting_Save(*painting.PAINTING, path.s)
	If IsImage(*painting\image) And path <> ""
		If GetExtensionPart(path) = ""
			path + ".png"
		EndIf
		
		Select LCase(GetExtensionPart(path))
			Case "jpg": SaveImage(*painting\image, path, #PB_ImagePlugin_JPEG)
			Case "png": SaveImage(*painting\image, path, #PB_ImagePlugin_PNG)
			Default: SaveImage(*painting\image, path, #PB_ImagePlugin_BMP)
		EndSelect
	EndIf
EndProcedure

Procedure Painting_Load(*painting.PAINTING, path.s)
	Protected x, y, col
	Protected image = LoadImage(#PB_Any, path)
	If IsImage(image)
		With *painting
			If IsImage(\image)
				FreeImage(\image)
			EndIf
			\image = image
			\width = ImageWidth(image)
			\height = ImageHeight(image)
			\scrollX = 0
			\scrollY = 0
			\zoom = 1
			Dim \paint(\width, \height)
			If StartDrawing(ImageOutput(\image))
				For y = 0 To \height - 1
					For x = 0 To \width - 1
						col = Point(x, y)
						\paint(x, y)\r = Red(col) / 255.0
						\paint(x, y)\g = Green(col) / 255.0
						\paint(x, y)\b = Blue(col) / 255.0
						\paint(x, y)\f = 0.25
					Next
				Next
				StopDrawing()
			EndIf
		EndWith
	EndIf
	LeftButton = 0
EndProcedure

Procedure Palette_Reset(*painting.PAINTING)
	Protected c, x, y, x1, y1, x2, y2, a, aa, r.d
	Protected brush.brush, *brush.brush = @brush
	
	*brush\smudge = 0.55
	*brush\smear = 0.5
	*brush\fill = 1.0
	*brush\rotate = #True
	
	Painting_Clear(*painting)
	For c = 0 To 9
		Brush_SetSize(*brush, 20, 15)
		Select c
			Case 0: Brush_SetColor(*brush, 1.000, 1.000, 1.000, 1.000, *brush\fill)
			Case 1: Brush_SetColor(*brush, 1.000, 0.784, 0.000, 1.000, *brush\fill)
			Case 2: Brush_SetColor(*brush, 1.000, 0.627, 0.078, 1.000, *brush\fill)
			Case 3: Brush_SetColor(*brush, 0.925, 0.255, 0.353, 1.000, *brush\fill)
			Case 4: Brush_SetColor(*brush, 0.643, 0.204, 0.314, 1.000, *brush\fill)
			Case 5: Brush_SetColor(*brush, 0.000, 0.000, 0.000, 1.000, *brush\fill)
			Case 6: Brush_SetColor(*brush, 0.000, 0.643, 0.784, 1.000, *brush\fill)
			Case 7: Brush_SetColor(*brush, 0.204, 0.302, 0.655, 1.000, *brush\fill)
			Case 8: Brush_SetColor(*brush, 0.843, 0.059, 0.059, 1.000, *brush\fill)
			Case 9: Brush_SetColor(*brush, 0.059, 0.588, 0.059, 0.50, *brush\fill)
		EndSelect
		
		aa = Random(360)
		x = 50 + Int(c / 5) * 100
		y = 50 + c * 100 - Int(c / 5) * 500
		
		For a = 1 To 360 * 3 Step 10
			x1 = x2
			y1 = y2
			r = a  * 0.035
			x2 = x + Sin(Radian(a+aa)) * r
			y2 = y + Cos(Radian(a+aa)) * r
			If a > 1
				*brush\angleOld = *brush\angle
				*brush\angle = ATan2(x1 - x2, y1 - y2)
				Brush_Stroke(*painting, *brush, x1, y1, x2, y2)
			EndIf
		Next
	Next
	Painting_Draw(*painting, 0)
	
	With *painting\brush
		Brush_SetSize(*painting\brush, \width, \height)
		Brush_SetParam(*painting\brush, \smudge, \smear, \fill, \addPaint, \rotate)
	EndWith
EndProcedure

Procedure EventHandler()
	Protected *painting.PAINTING = GetGadgetData(EventGadget())
	If *painting = #Null
		ProcedureReturn
	EndIf
	
	Protected *brush.BRUSH = *painting\brush
	Protected oldZoom.d = *painting\zoom
	Protected buttons = GetGadgetAttribute(EventGadget(), #PB_Canvas_Buttons)
	Protected modifiers = GetGadgetAttribute(EventGadget(), #PB_Canvas_Modifiers)
	
	Select EventType()
		Case #PB_EventType_KeyDown
			*painting\key = GetGadgetAttribute(EventGadget(), #PB_Canvas_Key)
			Select *painting\key
				Case #PB_Shortcut_Delete
					If *painting <> *Palette
						Painting_Clear(*painting)
					EndIf
				Case #PB_Shortcut_1
					If *painting <> *Palette
						Palette_Reset(*painting)
						*painting\modified = 1
					EndIf
				Case #PB_Shortcut_C
					Painting_PickColor(*painting, *brush, 0, 0, 0)
					*painting\modified = 1
				Case #PB_Shortcut_A
					Painting_PickColor(*painting, *brush, *brush\x / *painting\zoom - *painting\scrollX , *brush\y / *painting\zoom - *painting\scrollY, GetGadgetState(#g_addPaint) * 0.001)
					*painting\modified = 1
				Case #PB_Shortcut_Y
					Brush_SetColor(*brush, 0, 0, 0, 0, -GetGadgetState(#g_addPaint) * 0.001)
				Case #PB_Shortcut_G
					Brush_GetPaintingColor(*brush, *painting, 1)
				Case #PB_Shortcut_D
					Painting_Dry(*painting, 0)
				Case #PB_Shortcut_S
					If modifiers & #PB_Canvas_Control
						Painting_Save(*painting, SaveFileRequester("", "", "*.bmp;*.jpg;*.png|*.bmp;*.jpg;*.png",  1))
					EndIf
				Case #PB_Shortcut_L
					If modifiers & #PB_Canvas_Control
						Painting_Load(*painting, OpenFileRequester("", "", "*.bmp;*.jpg;*.png|*.bmp;*.jpg;*.png",  1))
						Painting_Draw(*painting, *brush)
						ProcedureReturn
					EndIf
				Case #PB_Shortcut_U
					Undo_Do(*painting)
				Case #PB_Shortcut_Add
					*painting\zoom = Clamp(*painting\zoom * 1.1, 0.5, 5)
				Case #PB_Shortcut_Subtract
					*painting\zoom = Clamp(*painting\zoom / 1.1, 0.5, 5)
				Case #PB_Shortcut_Pad0
					If modifiers & #PB_Canvas_Control
						oldZoom = 1
						*painting\zoom = 1
						*painting\scrollX = 0
						*painting\scrollY = 0
					EndIf
				Case #PB_Shortcut_Left
					*painting\scrollX = Min(*painting\scrollX + 50, 1 / *painting\zoom)
					*painting\modified = #True
				Case #PB_Shortcut_Right
 					*painting\scrollX = Max(*painting\scrollX - 50, (-*painting\width + DesktopScaledX(GadgetWidth(#g_canvas) - 15) / *painting\zoom))
 					*painting\modified = #True
 				Case #PB_Shortcut_Up
					*painting\scrollY = Min(*painting\scrollY + 50, 1 / *painting\zoom)
					*painting\modified = #True
				Case #PB_Shortcut_Down
 					*painting\scrollY = Max(*painting\scrollY - 50, (-*painting\height + DesktopScaledY(GadgetHeight(#g_canvas) - 15) / *painting\zoom))
					*painting\modified = #True
			EndSelect
			
			If *painting\zoom <> oldZoom
				*painting\scrollX + (*brush\x - *brush\x * (*painting\zoom / oldZoom)) / *painting\zoom
				*painting\scrollY + (*brush\y - *brush\y * (*painting\zoom / oldZoom)) / *painting\zoom
				*painting\modified = #True
			EndIf
		Case #PB_EventType_KeyUp
			*painting\key = 0
			Select GetGadgetAttribute(EventGadget(), #PB_Canvas_Key)
				Case #PB_Shortcut_Space
					Protected color = ColorRequester()
					If color <> -1
						Brush_SetColor(*brush, 0, 0, 0, 1.0, -1)
						Brush_SetColor(*brush, Red(color) / 255.0, Green(color) / 255.0, Blue(color) / 255.0, 1.0,  *brush\addPaint)
					EndIf
			EndSelect
			*painting\modified = #True
		Case #PB_EventType_RightButtonDown
			DisplayPopupMenu(#m_Popup, WindowID(0))
		Case #PB_EventType_LeftButtonDown
			If *painting = *Palette
				Painting_PickColor(*painting, *brush, *brush\x / *painting\zoom - *painting\scrollX , *brush\y / *painting\zoom - *painting\scrollY, GetGadgetState(#g_addPaint) * 0.001)
				*painting\modified = 1
			Else
				LeftButton = 1
				*brush\xOld = *brush\x
				*brush\yOld = *brush\y
				*brush\widthOld = *brush\width
				*brush\heightOld = *brush\height
				*brush\scale = 0
				
				Undo_Add(*painting)
			EndIf
		Case #PB_EventType_LeftButtonUp
			LeftButton = 0
		Case #PB_EventType_MouseMove
			SetGadgetAttribute(EventGadget(), #PB_Canvas_Cursor, #PB_Cursor_Invisible)
			
			*brush\x = GetGadgetAttribute(EventGadget(), #PB_Canvas_MouseX)
			*brush\y = GetGadgetAttribute(EventGadget(), #PB_Canvas_MouseY)
			
			If *painting = *Palette
				
				If buttons & #PB_Canvas_LeftButton
					Painting_PickColor(*painting, *brush, *brush\x / *painting\zoom - *painting\scrollX , *brush\y / *painting\zoom - *painting\scrollY, GetGadgetState(#g_addPaint) * 0.00002)
					*painting\modified = 1
				EndIf
				
			Else
				
				Protected distance.d = Sqr(Pow(*brush\xOld - *brush\x, 2) + Pow(*brush\yOld - *brush\y, 2))
				
				If *painting\key = #PB_Shortcut_E
					Brush_Erase(*painting, *brush, 0.25)
				ElseIf distance > #MinStrokeDistance
					*brush\angleOld = *brush\angle
					If *brush\rotate
						Protected newAngle.d = ATan2(*brush\xOld - *brush\x, *brush\yOld - *brush\y)
						Protected angDif.d = *brush\angleOld - newAngle
						If angDif > #PI
							angDif - 2 * #PI
						ElseIf angDif <= -#PI
							angDif + 2 * #PI
						EndIf
						
						If Abs(angDif) < #PI * 0.8 Or (buttons = 0)
							*brush\angle = newAngle
						EndIf
					Else
						*brush\angle = 0
					EndIf
					If LeftButton Or (*painting\key = #PB_Shortcut_M) Or (*painting\key = #PB_Shortcut_Right)
						Protected scale.d = Clamp(0.85 - (distance - #MinStrokeDistance) * 0.05, 0.1, 0.85)
						
						*brush\scale + (scale - *brush\scale) * 0.1
						Brush_Stroke(*painting, *brush, *brush\xOld, *brush\yOld, *brush\x, *brush\y, *brush\scale)
					EndIf
					*brush\xOld = *brush\x
					*brush\yOld = *brush\y
				EndIf
			EndIf
			
			*painting\modified = #True
		Case #PB_EventType_MouseWheel
			If GetGadgetAttribute(EventGadget(), #PB_Canvas_WheelDelta) > 0
				*brush\width = Clamp(*brush\width * 1.1, 5, #BrushSize)
				*brush\height = Clamp(*brush\height * 1.1, 5, #BrushSize)
			Else
				*brush\width = Clamp(*brush\width / 1.1, 5, #BrushSize)
				*brush\height = Clamp(*brush\height / 1.1, 5, #BrushSize)
			EndIf
			Brush_SetSize(*brush, *brush\width, *brush\height)
			*painting\modified = #True
		Case #PB_EventType_MouseEnter
			SetActiveGadget(*painting\canvas)
		Case #PB_EventType_MouseLeave
			Painting_Draw(*painting, 0)
	EndSelect
	
	If *painting\modified And ElapsedMilliseconds() > RedrawTime
		Painting_Draw(*painting, *brush)
		RedrawTime = ElapsedMilliseconds() + 25
	EndIf
EndProcedure

Procedure MenuEvent()
	If *Painting = #Null
		ProcedureReturn
	EndIf

	Protected *brush.BRUSH = *Painting\brush
	
	Select EventMenu()
		Case #m_Undo
			Undo_Do(*Painting)
		Case #m_CleanBrush
			Painting_PickColor(*Painting, *brush, *brush\x / *Painting\zoom - *Painting\scrollX , *brush\y / *Painting\zoom - *Painting\scrollY, 0)
			*Painting\modified = 1
		Case #m_Dry
			Painting_Dry(*Painting, 0)
		Case #m_Load
			Painting_Load(*Painting, OpenFileRequester("", "", "*.bmp;*.jpg;*.png|*.bmp;*.jpg;*.png",  1))
			Painting_Draw(*Painting, *brush)
		Case #m_Save
			Painting_Save(*Painting, SaveFileRequester("", "", "*.bmp;*.jpg;*.png|*.bmp;*.jpg;*.png",  1))
	EndSelect
EndProcedure

Procedure Quit()
	End
EndProcedure

DisableExplicit

Define brush.BRUSH

*Painting = Painting_New(#g_canvas, DesktopScaledX(1024), DesktopScaledY(768))
*Palette = Painting_New(#g_palette, 200, 500)

Painting_SetPaper(*Painting, 0.98, 0.98, 0.95, 0, 2, 0.75)
Painting_SetPaper(*Palette, 0.98, 0.98, 0.95, 0)
*Painting\brush = @brush
*Palette\brush = @brush

Palette_Reset(*Palette)

Brush_SetSize(@brush,75, 25)
Brush_SetParam(@brush, 0.65, 0.5, 1.0, 0.15, 1)
Brush_SetColor(@brush, 1, 1, 1, 1, 0)

BindGadgetEvent(#g_canvas, @EventHandler())
BindGadgetEvent(#g_palette, @EventHandler())
BindMenuEvent(#m_Popup, #m_Undo, @MenuEvent())
BindMenuEvent(#m_Popup, #m_CleanBrush, @MenuEvent())
BindMenuEvent(#m_Popup, #m_Dry, @MenuEvent())
BindMenuEvent(#m_Popup, #m_Load, @MenuEvent())
BindMenuEvent(#m_Popup, #m_Save, @MenuEvent())

Painting_Draw(*Painting, 0)

Repeat
	Select WaitWindowEvent()
		Case #PB_Event_CloseWindow
			Quit()
		Case #PB_Event_Gadget
			Select EventGadget()
				Case #g_width
					Brush_SetSize(brush, (GetGadgetState(#g_width) / 1000.0) * #BrushSize, -1)
					Brush_SetParam(brush, -1, -1, -1, -1, -1)
				Case #g_height
					Brush_SetSize(brush, -1, (GetGadgetState(#g_height) / 1000.0) * #BrushSize)
					Brush_SetParam(brush, -1, -1, -1, -1, -1)
				Case #g_smudge
					Brush_SetParam(brush, GetGadgetState(#g_smudge) / 1000.0, -1, -1, -1, -1)
				Case #g_smear
					Brush_SetParam(brush, -1, GetGadgetState(#g_smear) / 1000.0, -1, -1, -1)
				Case #g_addPaint
					Brush_SetParam(brush, -1, -1, -1, GetGadgetState(#g_addPaint) / 1000.0, -1)
				Case #g_rotate
					Brush_SetParam(brush, -1, -1, -1, -1, GetGadgetState(#g_rotate))
				Case #g_clearBrush
					PostEvent(#PB_Event_Menu, 0, #m_CleanBrush)
				Case #g_dryPainting
					PostEvent(#PB_Event_Menu, 0, #m_Dry)
			EndSelect
	EndSelect
ForEver

; IDE Options = PureBasic 6.10 LTS (Windows - x64)
; CursorPosition = 1021
; FirstLine = 551
; Folding = -----
; EnableXP
; DPIAware
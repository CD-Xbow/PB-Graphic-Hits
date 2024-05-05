;{ ************** initialisations/Declarations*********************************
UsePNGImageDecoder():UseJPEGImageDecoder()
UsePNGImageEncoder()

;{ ****************************************************
;-Tablette init 
;{ Tablette Declare



Global Tablette , Tablette_on=#False
Structure LOGCONTEXTA
	lcName.b[40];
	lcOptions.l;
	lcStatus.l;
	lcLocks.l;
	lcMsgBase.l;
	lcDevice.l;
	lcPktRate.l;
	lcPktData.l;
	lcPktMode.l;
	lcMoveMask.l;
	lcBtnDnMask.l;
	lcBtnUpMask.l;
	lcInOrgX.l;
	lcInOrgY.l;
	lcInOrgZ.l;
	lcInExtX.l;
	lcInExtY.l;
	lcInExtZ.l;
	lcOutOrgX.l;
	lcOutOrgY.l;
	lcOutOrgZ.l;
	lcOutExtX.l;
	lcOutExtY.l;
	lcOutExtZ.l;
	lcSensX.l;
	
	lcSensY.l;
	lcSensZ.l;
	lcSysMode.l;
	lcSysOrgX.l;
	lcSysOrgY.l;
	lcSysExtX.l;
	lcSysExtY.l;
	lcSysSensX.l;
	lcSysSensY.l;
EndStructure

Structure PACKET
	pkButtons.l
	pkX.l
	pkY.l
	pkZ.l
	pkNormalPressure.l
	pkTangentPressure.l
EndStructure

#WTI_DEFCTX    = 3
#WTI_DEFSYSCTX = 4


#CTX_NAME          = 1
#CTX_OPTIONS      = 2
#CTX_STATUS        = 3
#CTX_LOCKS        = 4
#CTX_MSGBASE      = 5
#CTX_DEVICE        = 6
#CTX_PKTRATE      = 7
#CTX_PKTDATA      = 8
#CTX_PKTMODE      = 9
#CTX_MOVEMASK     = 10
#CTX_BTNDNMASK   = 11
#CTX_BTNUPMASK   = 12
#CTX_INORGX        = 13
#CTX_INORGY        = 14
#CTX_INORGZ        = 15
#CTX_INEXTX        = 16
#CTX_INEXTY        = 17
#CTX_INEXTZ        = 18
#CTX_OUTORGX      = 19
#CTX_OUTORGY      = 20
#CTX_OUTORGZ      = 21
#CTX_OUTEXTX      = 22
#CTX_OUTEXTY      = 23
#CTX_OUTEXTZ      = 24
#CTX_SENSX        = 25
#CTX_SENSY        = 26
#CTX_SENSZ        = 27
#CTX_SYSMODE      = 28
#CTX_SYSORGX      = 29
#CTX_SYSORGY      = 30
#CTX_SYSEXTX      = 31
#CTX_SYSEXTY      = 32
#CTX_SYSSENSX     = 33
#CTX_SYSSENSY     = 34
#CTX_MAX           = 34

#CXO_MESSAGES  = 4

#WT_DEFBASE    = $7FF0
#WT_PACKET     = #WT_DEFBASE + 0
#WT_INFOCHANGE = #WT_DEFBASE + 6

#PK_BUTTONS           = $0040 ;/* button information */
#PK_X                 = $0080 ;/* x axis */
#PK_Y                 = $0100 ;/* y axis */
#PK_Z                 = $0200 ;/* z axis */
#PK_NORMAL_PRESSURE   = $0400 ;/* normal Or tip pressure */
#PK_TANGENT_PRESSURE  = $0800 ;/* tangential Or barrel pressure */
#lib_tablette=1

; ---------------------------------------
; ---------------------------------------²
; ---------------------------------------

Prototype.l WTInfo_(wCategory, nIndex, *lpOutput)
Prototype.l WTOpen_(hWnd, *lpLogCtx, fEnable)
Prototype.l WTPacket_(hCtx, wSerial, *lpPkt)
Prototype.l WTClose_(hCtx)



If OpenLibrary(#lib_tablette, "C:\Windows\System32\Wintab32.dll")
	
	Global WTInfo.WTInfo_     = GetFunction(#lib_tablette, "WTInfoA")
	Global WTOpen.WTOpen_     = GetFunction(#lib_tablette, "WTOpenA")
	Global WTPacket.WTPacket_ = GetFunction(#lib_tablette,"WTPacket")
	Global WTClose.WTClose_   = GetFunction(#lib_tablette,"WTClose")
	
	tablette_on=#True
	
EndIf


;}
; *****************************************************













Enumeration ; Window
	#window
EndEnumeration

Enumeration ; Gadget
	#Canvas
	#bouton_dessin
	#bouton_efface
	#bouton_charge_image
	#Gadget_text
	#bouton_Sauve
	#Gadget_scroll
	#Gadget_titre
	#Gadget_auteur
	#Gadget_list_style
	#Gadget_text_style 
	#Gadget_list_codeur
	#Gadget_text_codeur
	#Gadget_case
	#Gadget_nb_de_coup_de_peint
	#Gadget_t_nb_de_coup
	#Gadget_transparence
	#Gadget_t_transparence
	#Gadget_container
	#Gadget_t_taille_x
	#Gadget_taille_x
	#Gadget_t_taille_y
	#Gadget_taille_y
	#Gadget_warning
	#Gadget_annul
EndEnumeration

Enumeration ; Sprite
	#Pinceau
	#Pinceau3D
EndEnumeration
Enumeration ; Images
	#image_reference
	#image_Sortie
	#image_annule
	; Brush (images png)
	#brosse_1
	#brosse_1_co
	#brosse_2
	#brosse_2_co
	#brosse_3
	#brosse_3_co
	#brosse_4
	#brosse_4_co
	#brosse_5
	#brosse_5_co
	#brosse_6
	#brosse_6_co
	#brosse_7
	#brosse_7_co
	#brosse_8
	#brosse_8_co
	#brosse_9
	#brosse_9_co
	#brosse_10
	#brosse_10_co
	#brosse_11
	#brosse_11_co
	#brosse_12
	#brosse_12_co
	#brosse_13
	#brosse_13_co
	#brosse_14
	#brosse_14_co
	#brosse_15
	#brosse_15_co
	#brosse_16
	#brosse_16_co
	
	; Catch image
	#icone0
	#icone1
	#icone2
	#icone3
	#icone4
	#icone5
	#icone6
	#icone7
	#icone8
	#icone9
	#icone10
	#icone11
	#icone12
	#icone13
	#icone14
	#icone15
	#icone16
	#icone17
	#icone18
	#icone19
	#icone20
	#icone21
	#icone22
	#icone23
	#icone24
	#icone25
	#icone26
	#icone27
EndEnumeration
Enumeration ; Fonte
	#Font_Window_Text_titre
	#Font_Window_Auteur
	#Font_Window_Text_style
	#Font_Window_Text_codeur
EndEnumeration

;-include icones
CatchImage(#icone0, ?aquarelle)
CatchImage(#icone1, ?cederavic)
CatchImage(#icone2, ?croix)
CatchImage(#icone3, ?croix_creuse)
CatchImage(#icone4, ?flocon)
CatchImage(#icone5, ?impress)
CatchImage(#icone6, ?pointillism)
CatchImage(#icone7, ?pointillism_floue)
CatchImage(#icone8, ?pop_art)
CatchImage(#icone9, ?reel)
CatchImage(#icone10, ?Vermicelles)
CatchImage(#icone11,?Brosse_floue)
CatchImage(#icone12, ?Brush1)
CatchImage(#icone13, ?Brush2)
CatchImage(#icone14, ?Brush3)
CatchImage(#icone15, ?Brush4)
CatchImage(#icone16, ?Brush5)
CatchImage(#icone17, ?Brush6)
CatchImage(#icone18, ?Brush7)
CatchImage(#icone19, ?Brush8)
CatchImage(#icone20, ?Brush9)
CatchImage(#icone21, ?Brush10)
CatchImage(#icone22, ?Brush11)
CatchImage(#icone23, ?Brush12)
CatchImage(#icone24, ?Brush13)
CatchImage(#icone25, ?Brush14)
CatchImage(#icone26, ?Brush15)
CatchImage(#icone27, ?Brush16)


Global File_image$,Phase,Style
Global larg_fenetre=1024+200+50
Global haut_fenetre=768+70+50
Global x_image_origine
Global y_image_origine
Global Flag_bouton_on ; variable qui dit qu'on click avec le bouton gauche de la souris
Global state_case ; variable qui defini l'etat de la case semi auto
Global Flag_bouton_on
Global tablette ; variable qui active/desactive la tablette en fonctin de la proxymité du crayon .. (j'suis trop fort  LOL )
Global Style=0



;-Declarations
;-** declaration style

Declare  INIT(largeur,Hauteur, Array image_tab(2))
Declare  Expressionnisme1(largeur,Hauteur,Array image_tab(2))
Declare  croix(Largeur,Hauteur,Array image_tab(2))
Declare  Reel(Largeur,Hauteur,Array image_tab(2))
Declare  vermicelle(Largeur,Hauteur,Array image_tab(2))
Declare  croix2(Largeur,Hauteur,Array image_tab(2))
Declare  pointillism(largeur,Hauteur,Array image_tab(2))
Declare  aquarelle(largeur,Hauteur,Array image_tab(2))
Declare  Pop_art(largeur,Hauteur,Array image_tab(2))
Declare  Flocon(largeur,Hauteur,Array image_tab(2))
Declare  cederavic(Largeur,Hauteur,Array image_tab(2))
Declare  pointillism2(largeur,Hauteur,Array image_tab(2))
Declare  BrosseFloue(Largeur, HAuteur, Array image_tab(2))
Declare  brosse(Largeur, HAuteur, Array image_tab(2))
Declare  xxxxxxxxx(Largeur, HAuteur, Array image_tab(2))
Declare  peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence,Array image_tab(2))
Declare  peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage,Transparence ,Array image_tab(2)) ; le Pinceau Croix
Declare  peint_reel(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2)) ; le Pinceau Reel
Declare  peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2)) ; le Pinceau Croix
Declare  peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2)) ; le pinceau Croix2
Declare  peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
Declare  peint_aquarelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
Declare  peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
Declare  peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
Declare  peint_cederavic(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2)) ; le pinceau Cederavic
Declare  peint_pointillism2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
Declare  peint_BrosseFloue(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
Declare  peint_brosse(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
Declare  peint_xxxxxxxxx(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Array image_tab(2))
Declare  Write_preference()
Declare  Read_preference()
Declare  annule()
Declare  color_brush(image,couleur)
Declare  MyWindowCallback(WindowID, Message, wParam, lParam)





Global lpPoint.POINT ,  xx_mouse,yy_mouse
Global state_warning,flag_annule


; *********** Chargement Brush ********************
If LoadImage(#brosse_1,"Brush\brosse_1.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_1")
	End
EndIf 
If LoadImage(#brosse_2,"Brush\brosse_2.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_2")
	End
EndIf 

If LoadImage(#brosse_3,"Brush\brosse_3.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_3")
	End
EndIf 

If LoadImage(#brosse_4,"Brush\brosse_4.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_4")
	End
EndIf 

If LoadImage(#brosse_5,"Brush\brosse_5.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_5")
	End
EndIf 

If LoadImage(#brosse_6,"Brush\brosse_6.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_6")
	End
EndIf 
If LoadImage(#brosse_7,"Brush\brosse_7.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_7")
	End
EndIf 
If LoadImage(#brosse_8,"Brush\brosse_8.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_8")
	End
EndIf 
If LoadImage(#brosse_9,"Brush\brosse_9.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_9")
	End
EndIf 
If LoadImage(#brosse_10,"Brush\brosse_10.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_10")
	End
EndIf 
If LoadImage(#brosse_11,"Brush\brosse_11.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_11")
	End
EndIf 
If LoadImage(#brosse_12,"Brush\brosse_12.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_12")
	End
EndIf 
If LoadImage(#brosse_13,"Brush\brosse_13.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_13")
	End
EndIf 
If LoadImage(#brosse_14,"Brush\brosse_14.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_14")
	End
EndIf 
If LoadImage(#brosse_15,"Brush\brosse_15.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_15")
	End
EndIf 
If LoadImage(#brosse_16,"Brush\brosse_16.png")
	Else
	MessageRequester("Erreur","Je ne trouve pas le Brush_16")
	End
EndIf 

; ************************************************



;} ***********************************************************************





Read_preference()

OpenWindow(#window,win_x,win_y,larg_fenetre,haut_fenetre,"", #PB_Window_SystemMenu )
;{Tablette
;-tablette

If   tablette_on=#True And WTInfo(0, 0, 0)
	
	
	info.LOGCONTEXTA
	WTInfo(#WTI_DEFCTX,0,@info)
	
	#PACKETDATA = #PK_X | #PK_Y | #PK_Z | #PK_BUTTONS | #PK_NORMAL_PRESSURE | #PK_TANGENT_PRESSURE
	;#PACKETMODE = #PK_BUTTONS | #PK_NORMAL_PRESSURE | #PK_TANGENT_PRESSURE
	#PACKETMODE = 0
	
	info\lcOptions  = #CXO_MESSAGES
	info\lcMsgBase  = #WT_DEFBASE
	info\lcPktData  = #PACKETDATA
	info\lcPktMode  = #PACKETMODE
	info\lcMoveMask = #PACKETDATA
	info\lcBtnUpMask = info\lcBtnDnMask
	
	info\lcOutOrgX = 0
	info\lcOutOrgY = 0
	info\lcOutExtX = 10000
	info\lcOutExtY = 10000
	hCtx = WTOpen(WindowID(#Window),@info,1)
	tablette=#False ; desactive la reconnaissance par defaut ; c'est seulement la proxymité du crayon qui active la tablette :)
EndIf
;}




coul_fenetre=$1A341D
coul_text=$73CF6B
SetWindowColor(#window, coul_fenetre) 
;- openwindow
; Déclarez les gadgets ici...
Global y_bouton=90 : Global x_bouton=10

TextGadget(#Gadget_titre, x_bouton+500, 5, 300, 40, "Pure AutoPaint" )
SetGadgetFont(#Gadget_titre, LoadFont(#Font_Window_Text_titre, "Comic Sans MS", 20, 16))

TextGadget(#Gadget_auteur, x_bouton+800, 35, 350, 30, "Wacom Ready ;)" )
SetGadgetFont(#Gadget_auteur, LoadFont(#Font_Window_Auteur, "Comic Sans MS", 10, 16))

TextGadget(#Gadget_text_codeur, x_bouton, 5, 150, 40, "Les Codeurs" )
SetGadgetFont(#Gadget_text_codeur, LoadFont(#Font_Window_Text_codeur, "Comic Sans MS", 10, 16))
ComboBoxGadget(#Gadget_list_codeur,x_bouton+150, 5, 300, 30)
AddGadgetItem(#Gadget_list_codeur, -1, "Dobro : Createur ")
AddGadgetItem(#Gadget_list_codeur, -1, "Danilo: Tablette ")
AddGadgetItem(#Gadget_list_codeur, -1, "Graph100 : Optimiseur ")
AddGadgetItem(#Gadget_list_codeur, -1, "Cederavic : Styler ")
AddGadgetItem(#Gadget_list_codeur, -1, "BlendMan : Styler ")

SetGadgetState(#Gadget_list_codeur, 0)

ButtonGadget(#bouton_charge_image, x_bouton, y_bouton, 150, 30, "Load_image") 

TextGadget(#Gadget_text_style, x_bouton, y_bouton+60, 150, 40, "Styles" )
SetGadgetFont(#Gadget_text_style, LoadFont(#Font_Window_Text_style, "Comic Sans MS", 10, 16))
;;;;;;;;;;;;;;;;;;;;;ListViewGadget(#Gadget_list_style,x_bouton,y_bouton+90,180, 200 ) 
ListIconGadget(#Gadget_list_style,x_bouton,y_bouton+90,180, 200,"Liste des Styles",200 ) 
SetGadgetAttribute(#Gadget_list_style, #PB_ListIcon_DisplayMode, #PB_ListIcon_LargeIcon)

ButtonGadget(#bouton_dessin, x_bouton, y_bouton+320, 100, 30, "Draw")
ProgressBarGadget(#Gadget_scroll, x_bouton, y_bouton+350, 150,15, 0, 100)

TextGadget(#Gadget_text, x_bouton, y_bouton+410, 150, 30, "" )
ButtonGadget(#bouton_efface, x_bouton, y_bouton+380, 100, 30, "Clean") 


CheckBoxGadget(#Gadget_case, x_bouton, y_bouton+440, 130,30, "Mode semi-auto")


;ContainerGadget(#Gadget_container,x_bouton, y_bouton+450, 180, 200,#PB_Container_Single) 
TextGadget(#Gadget_t_nb_de_coup, x_bouton, y_bouton+470, 80,30, "Nb de coup")
StringGadget(#Gadget_nb_de_coup_de_peint,  x_bouton+130, y_bouton+470, 50,30, "1000",#PB_String_Numeric)

TextGadget(#Gadget_t_transparence, x_bouton, y_bouton+510, 180,30, "Transparence (0-255) 255=opaque")
StringGadget(#Gadget_transparence,  x_bouton+130, y_bouton+510, 50,30, "255",#PB_String_Numeric)

TextGadget(#Gadget_t_taille_x, x_bouton, y_bouton+550, 80,15, "Taille_x")
StringGadget(#Gadget_taille_x,  x_bouton+50, y_bouton+550, 40,20, "10",#PB_String_Numeric)
TextGadget(#Gadget_t_taille_y, x_bouton, y_bouton+590, 80,15, "Taille_y")
StringGadget(#Gadget_taille_y,  x_bouton+50, y_bouton+590, 40,20, "10",#PB_String_Numeric)
CheckBoxGadget(#Gadget_warning, x_bouton, y_bouton+670, 130,30, "stop Warning")
ButtonGadget(#Gadget_annul, x_bouton, y_bouton+630, 130,30, "Annule")
ButtonGadget(#bouton_Sauve, x_bouton, y_bouton+720, 130,30, "Sauve")

; ************** coloration Fond des Gadgets *********************

SetGadgetColor(#Gadget_titre,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_text_codeur,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_list_codeur,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_text_style,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_list_style,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_text,#PB_Gadget_BackColor,coul_fenetre)
;SetGadgetColor(#Gadget_case,#PB_Gadget_BackColor,coul_fenetre)  <---- ne marche pas avec les checkbox()
;SetGadgetColor(#Gadget_warning,#PB_Gadget_BackColor,coul_fenetre) <---- ne marche pas avec les checkbox()
SetGadgetColor(#Gadget_t_nb_de_coup,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_nb_de_coup_de_peint,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_t_taille_x,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_t_taille_y,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_auteur,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_transparence,#PB_Gadget_BackColor,coul_fenetre)
SetGadgetColor(#Gadget_t_transparence,#PB_Gadget_BackColor,coul_fenetre)
; ******************************************************************************

; ************** coloration text des Gadgets *********************

SetGadgetColor(#Gadget_titre,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_text_codeur,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_list_codeur,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_text_style,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_list_style,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_text,#PB_Gadget_FrontColor,coul_text)
;SetGadgetColor(#Gadget_case,#PB_Gadget_FrontColor,coul_fenetre)  <---- ne marche pas avec les checkbox()
;SetGadgetColor(#Gadget_warning,#PB_Gadget_FrontColor,coul_fenetre) <---- ne marche pas avec les checkbox()
SetGadgetColor(#Gadget_t_nb_de_coup,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_nb_de_coup_de_peint,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_t_taille_x,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_t_taille_y,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_auteur,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_transparence,#PB_Gadget_FrontColor,coul_text)
SetGadgetColor(#Gadget_t_transparence,#PB_Gadget_FrontColor,coul_text)
; ******************************************************************************


; ************** canvas *****************
CanvasGadget(#Canvas, 200,70,1024,768,#PB_Canvas_Border  |#PB_Canvas_ClipMouse    );
;;SetGadgetAttribute(#Canvas, #PB_Canvas_Cursor, #PB_Cursor_Cross)
StartDrawing(CanvasOutput(#Canvas))
	Box(1,1,1024,768,RGB(0,0,0))
StopDrawing()

; **************************************


:;CloseGadgetList() 

; cache les gadget
; cache les gadgets
HideGadget(#Gadget_nb_de_coup_de_peint, 1)
HideGadget(#Gadget_t_nb_de_coup, 1)
HideGadget(#Gadget_taille_x, 1)
HideGadget(#Gadget_t_taille_x, 1)
HideGadget(#Gadget_t_taille_y, 1)
HideGadget(#Gadget_taille_y, 1)
HideGadget(#Gadget_t_transparence, 1)
HideGadget(#Gadget_transparence, 1)







;{ *************** initialisations Graphique *********************************
InitSprite():InitMouse()

;OpenWindowedScreen(WindowID(#window),200,70,1024,768,0,50,50) ; l'ecran

SetWindowCallback(@MyWindowCallback())
; ***** Creation du pinceau ******
; CreateSprite(#pinceau,8,8)

;

;InitSprite3D()
;CreateSprite3D(#Pinceau3D, #Pinceau)

; *****************************
;-** list des styles

; CatchImage(#icone11, ?Brush1)
; CatchImage(#icone10, ?Vermicelles)
; CatchImage(#icone9, ?reel)
; CatchImage(#icone8, ?pop_art)
; CatchImage(#icone7, ?pointillism_floue)
; CatchImage(#icone6, ?pointillism)
; CatchImage(#icone5, ?impress)
; CatchImage(#icone4, ?flocon)
; CatchImage(#icone3, ?croix_creuse)
; CatchImage(#icone2, ?croix)
; CatchImage(#icone1, ?cederavic)
; CatchImage(#icone0, ?aquarelle)

; on va générer les icone pour la liste

imm0=CopyImage(#icone0,#PB_Any)
imm1=CopyImage(#icone1,#PB_Any) 
imm2=CopyImage(#icone2,#PB_Any) 
imm3=CopyImage(#icone3,#PB_Any) 
imm4=CopyImage(#icone4,#PB_Any) 
imm5=CopyImage(#icone5,#PB_Any) 
imm6=CopyImage(#icone6,#PB_Any) 
imm7=CopyImage(#icone7,#PB_Any) 
imm8=CopyImage(#icone8,#PB_Any) 
imm9=CopyImage(#icone9,#PB_Any) 
imm10=CopyImage(#icone10,#PB_Any) 
imm11=CopyImage(#icone11,#PB_Any) 
imm12=CopyImage(#icone12,#PB_Any) 
imm13=CopyImage(#icone13,#PB_Any)
imm14=CopyImage(#icone14,#PB_Any)
imm15=CopyImage(#icone15,#PB_Any)
imm16=CopyImage(#icone16,#PB_Any)
imm17=CopyImage(#icone17,#PB_Any)
imm18=CopyImage(#icone18,#PB_Any)
imm19=CopyImage(#icone19,#PB_Any)
imm20=CopyImage(#icone20,#PB_Any)
imm21=CopyImage(#icone21,#PB_Any)
imm22=CopyImage(#icone22,#PB_Any)
imm23=CopyImage(#icone23,#PB_Any)
imm24=CopyImage(#icone24,#PB_Any)
imm25=CopyImage(#icone25,#PB_Any)
imm26=CopyImage(#icone26,#PB_Any)
imm27=CopyImage(#icone27,#PB_Any)


AddGadgetItem(#Gadget_list_style, 0, "Impressionnism 1",ImageID(imm5))

AddGadgetItem(#Gadget_list_style, 1, "Croix ",ImageID(imm2))
AddGadgetItem(#Gadget_list_style, 2, "Croix creuse ",ImageID(imm3))
AddGadgetItem(#Gadget_list_style, 3, "Vermicelle ",ImageID(imm10))
AddGadgetItem(#Gadget_list_style, 4, "pointillisme",ImageID(imm6))
AddGadgetItem(#Gadget_list_style, 5, "Flocon",ImageID(imm4))
AddGadgetItem(#Gadget_list_style, 6, "Aquarelle",ImageID(imm0))
AddGadgetItem(#Gadget_list_style, 7, "Cederavic",ImageID(imm1))
AddGadgetItem(#Gadget_list_style, 8, "Pop_art",ImageID(imm8))
AddGadgetItem(#Gadget_list_style, 9, "Reel",ImageID(imm9))
AddGadgetItem(#Gadget_list_style, 10, "Pointillism floue ",ImageID(imm7))
AddGadgetItem(#Gadget_list_style, 11, "Brosse floue ",ImageID(imm11))
AddGadgetItem(#Gadget_list_style, 12, "Brosse 1 ",ImageID(imm12))
AddGadgetItem(#Gadget_list_style, 13, "Brosse 2 ",ImageID(imm13))
AddGadgetItem(#Gadget_list_style, 14, "Brosse 3 ",ImageID(imm14))
AddGadgetItem(#Gadget_list_style, 15, "Brosse 4 ",ImageID(imm15))
AddGadgetItem(#Gadget_list_style, 16, "Brosse 5 ",ImageID(imm16))
AddGadgetItem(#Gadget_list_style, 17, "Brosse 6 ",ImageID(imm17))
AddGadgetItem(#Gadget_list_style, 18, "Brosse 7 ",ImageID(imm18))
AddGadgetItem(#Gadget_list_style, 19, "Brosse 8 ",ImageID(imm19))
AddGadgetItem(#Gadget_list_style, 20, "Brosse 9 ",ImageID(imm20))
AddGadgetItem(#Gadget_list_style, 21, "Brosse 10 ",ImageID(imm21))
AddGadgetItem(#Gadget_list_style, 22, "Brosse 11 ",ImageID(imm22))
AddGadgetItem(#Gadget_list_style, 23, "Brosse 12 ",ImageID(imm23))
AddGadgetItem(#Gadget_list_style, 24, "Brosse 13 ",ImageID(imm24))
AddGadgetItem(#Gadget_list_style, 25, "Brosse 14 ",ImageID(imm25))
AddGadgetItem(#Gadget_list_style, 26, "Brosse 15 ",ImageID(imm26))
AddGadgetItem(#Gadget_list_style, 27, "Brosse 16 ",ImageID(imm27))


SetGadgetState(#Gadget_list_style, 0)


;} **********************************************************************
Dim image_tab(1024, 768)
;{ ********************* boucle principale ***********************************²
Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
;-Boucle principale
Repeat
	If Transparence<0:Transparence=0:EndIf
	If Transparence>255:Transparence=255:EndIf
	
	
	;ShowCursor_(0) ; montre le curseur !!
	
	Event=WaitWindowEvent(2)
	
	Select  Event
		Case #WT_PACKET
		;-Tablette boucle principale
		WTPacket(EventlParam(),EventwParam(), @pkt.PACKET)
		; *********** If pkt\pkButtons *******************
		; debug "bouton :"+ RSet(Hex(pkt\pkButtons),8,"0") 
		; ;EndIf
		;  debug "pkX: "               + Str(pkt\pkX               )
		; debug"pkY: "               + Str(pkt\pkY               )
		; debug "pkZ: "               + Str(pkt\pkZ               )
		; debug "pkNormalPressure: "  + Str(pkt\pkNormalPressure  )
		; debug "pkTangentPressure: " + Str(pkt\pkTangentPressure )
		; *************************************************
		If MulDiv_(pkt\pkZ ,1024,10000)=0 And pkt\pkButtons=0; si le Stylet est trop loin, et qu'il ,ne touche pas la tablette ,on desactive la reconnaisance de la tablette
			tablette=#False
			Flag_bouton_on=0
			Else
			tablette=#True
		EndIf
		If tablette=#True
			xx_mouse=MulDiv_(pkt\pkX,1024,10000)+WindowX(#window,#PB_Window_InnerCoordinate)+GadgetX(#canvas)
			yy_mouse=768-MulDiv_(pkt\pkY,768,10000)+WindowY(#window,#PB_Window_InnerCoordinate)+GadgetY(#canvas)
			If pkt\pkButtons=1 ; (bouton de mine)
				Flag_bouton_on=1 
				
				;taille_x=pkt\pkNormalPressure / 250
				;taille_y=pkt\pkNormalPressure / 250
				If flag_annule=0
					annule()
					flag_annule=1
				EndIf
				Else
				Flag_bouton_on=0
				flag_annule=0
				
			EndIf
			SetCursorPos_(xx_mouse,yy_mouse) 
		EndIf
		;debug xx_mouse  ; ************ OK !!
		;debug yy_mouse
		Case #PB_Event_Gadget
		
		Select EventGadget()
			; ******************************** Canvas ********************************************
			Case #canvas
			If GetGadgetAttribute(#Canvas, #PB_Canvas_Buttons) =#PB_Canvas_LeftButton
				If flag_annule=0
					annule()
					flag_annule=1
				EndIf
			EndIf
			Select EventType()
				
				;Case #PB_EventType_LeftButtonDown      
				
				Case #PB_EventType_MouseMove 
				If GetGadgetAttribute(#Canvas, #PB_Canvas_Buttons) =#PB_Canvas_LeftButton Or Flag_bouton_on=1 
					
					;-Dessin a main levée
					;if Flag_bouton_on=1 
					Flag_bouton_on=1 
					
					xx_mouse=GetGadgetAttribute(#Canvas, #PB_Canvas_MouseX)
					yy_mouse= GetGadgetAttribute(#Canvas, #PB_Canvas_MouseY)
					
					
					;debug xx_mouse
					;debug yy_mouse
					;EndIf
					If IsImage(#image_reference)
						Largeur=1024
						Hauteur=768
						delay_affichage=20
						Phase =Random(9)
						Select Style 
							
							Case 0 ; Expressionisme1
							
							nombre_de_coup_de_pinceau=10
							;Taille_x=random(3,1):Taille_y=random(5,1)
							If tablette=#False
								Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
								Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							EndIf
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, transparence,image_tab())
							Case 1 ; Croix
							nombre_de_coup_de_pinceau=10
							;Taille_x=random(3,1):Taille_y=random(3,1)
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage,  transparence, image_tab()) ; le Pinceau Croix
							Case 2 ;Croix2
							nombre_de_coup_de_pinceau=10
							;Taille_x=random(3,1):Taille_y=random(3,1)
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage,  transparence,image_tab()) ; le pinceau Croix2
							Case 3 ; Vermicelle
							phase=Random(7,1)
							
							nombre_de_coup_de_pinceau=5
							;Taille_x=random(1,1):Taille_y=random(1,1)
							Taille_x=Val(GetGadgetText(#Gadget_taille_x))/2
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) /2
							If Taille_x<1 :Taille_x=1:EndIf :If Taille_y<1:Taille_y=1:EndIf
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, transparence, image_tab()) ; le Pinceau Croix
							Case 4 ; Pointillisme
							nombre_de_coup_de_pinceau=1
							;Taille_x=random(3,1):Taille_y=random(3,1)
							
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage,  transparence,image_tab())
							Case 5 ; Flocon
							nombre_de_coup_de_pinceau=10
							;Taille_x=random(10,1):Taille_y=random(10,1)
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) *2
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) *2
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage,  transparence,image_tab())
							Case 6 ; Aquarelle
							nombre_de_coup_de_pinceau=10
							;Taille_x=random(15,2):Taille_y=random(15,2)
							If tablette=#False
								Taille_x=Val(GetGadgetText(#Gadget_taille_x)) *2
								Taille_y=Val(GetGadgetText(#Gadget_taille_y)) *2
								Else
								Taille_x=Val(GetGadgetText(#Gadget_taille_x)) *2
								Taille_y=Val(GetGadgetText(#Gadget_taille_y)) *2
							EndIf
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_aquarelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage,  transparence,image_tab())
							Case 7 ; Cederavic 
							phase=3
							nombre_de_coup_de_pinceau=1000
							;Taille_x=random(10,1):Taille_y=random(10,1)
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							delay_affichage=300
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_cederavic(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage,  transparence, image_tab()) ; le pinceau Cederavic
							Case 8 ; Pop_art
							;Taille_x=random(5,1):Taille_y=random(5,1)
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							nombre_de_coup_de_pinceau=2
							phase=0
							delay_affichage=20
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, transparence, image_tab())
							Case 9
							;Taille_x=10:Taille_y=10
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							nombre_de_coup_de_pinceau=1
							phase=1
							delay_affichage=20
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_reel(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage,  transparence, image_tab()) ; le Pinceau Reel
							Case 10
							phase=0
							nombre_de_coup_de_pinceau=10
							;Taille_x=random(10,1):Taille_y=random(10,1)
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							delay_affichage=20
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							Peint_pointillism2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300, transparence,image_tab())
							Case 11 ; Brosse Floue
							nombre_de_coup_de_pinceau=1
							;Taille_x=random(20,5):Taille_y=random(20,5)
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							delay_affichage=20
							phase=0
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_brossefloue(largeur,hauteur,nombre_de_coup_de_pinceau,taille_x,taille_y,delay_affichage, transparence,image_tab())
							Case 12 To 27  ;brosse_1
							
							nombre_de_coup_de_pinceau=1
							;Taille_x=random(20,5):Taille_y=random(20,5)
							Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
							Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
							delay_affichage=20
							phase=0
							Taille_x=Random(Taille_x,1):Taille_y=Random(Taille_y,1)
							Transparence=Val(GetGadgetText(#Gadget_transparence)) 
							peint_brosse(largeur,hauteur,nombre_de_coup_de_pinceau,taille_x,taille_y,delay_affichage, transparence,image_tab())
							
						EndSelect
						
					EndIf
					Flag_annul=1
				EndIf
				
				Case #PB_EventType_LeftButtonUp  
				flag_annule=0
				Flag_bouton_on=0
				Case #PB_EventType_LeftClick       ;Clic avec le bouton gauche de la souris
				
				
				;Flag_bouton_on=1 
				Case #PB_EventType_RightClick      ; Clic avec le bouton droit de la souris
				Case #PB_EventType_LeftDoubleClick ; Double-clic avec le bouton gauche de la souris
				Case #PB_EventType_RightDoubleClick ;Double-clic avec le bouton droit de la souris
				Case #PB_EventType_Focus           ;Obtention du focus.
				
				
				Case #PB_EventType_LostFocus       ; Perte du focus.
				
				Case #PB_EventType_Change          ;Le contenu a changé.
				Case #PB_EventType_DragStart       ; L'utilisateur a essayé de lancer Une opération Glisser & Déposer.
				
				
				
				
				; *************************************************************************************
			EndSelect
			Case #gadget_annul
			StartDrawing(CanvasOutput(#canvas))
				DrawImage(ImageID(#image_annule),0,0)
			StopDrawing()
			
			
			Case #Gadget_list_style ; on a choisi un style ?
			Style= GetGadgetState(#Gadget_list_style)
			
			Case #Gadget_warning
			state_warning=GetGadgetState(#Gadget_warning)
			
			Case #bouton_Sauve
			If StartDrawing(CanvasOutput(#canvas))
				If GrabDrawingImage(#image_sortie, 0, 0, 1024, 768)
				EndIf
			StopDrawing()
		EndIf
		If IsImage(#image_sortie)
			File_image$=ReplaceString(File_image$,".jpg",".png")
			
			File_image_save$ = SaveFileRequester("SavePicture", GetFilePart(File_image$), "*.png", 1)
			
			If File_image_save$<>""
				If Right(File_image_save$, 4) <> ".png" : File_image_save$ + ".png" : EndIf
				SaveImage(#image_sortie, File_image_save$, #PB_ImagePlugin_PNG)
				
				If LoadImage(#image_sortie,File_image_save$)
					ResizeImage(#image_sortie,x_image_origine,y_image_origine)
					SaveImage(#image_sortie,File_image_save$,#PB_ImagePlugin_PNG)
					FreeImage(#image_sortie)
				EndIf
			EndIf
		EndIf
		Case #bouton_charge_image
		
		File_image$=OpenFileRequester("Load Picture",File_image$,"*.jpg|*.jpg|*.png|*.png|*.bmp|*.bmp|*.*|*.*",0)
		If File_image$<>""
			LoadImage(#image_reference,File_image$)
			x_image_origine=ImageWidth(#image_reference)
			y_image_origine=ImageHeight(#image_reference)
			ResizeImage(#image_reference,1024,768)
			;StartDrawing(ScreenOutput())
			;DrawImage(ImageId(#image_reference),0,0)
			;StopDrawing()
			
			; *****ne pas toucher servira dans tout les Styles ******
			
			INIT(1024, 768,image_tab())
			; **************************************************
			Else
		EndIf
		Case #bouton_dessin
		
		If IsImage(#image_reference)
			;DisableDebugger
			
			SetGadgetText(#Gadget_text, "Phase 1/9")
			
			largeur=ImageWidth(#image_reference)
			Hauteur=ImageHeight(#image_reference)
			
			
			;CallDebugger
			;- **selection_style
			Select Style 
				Case 0 ; Expressionisme1
				Expressionnisme1(largeur,Hauteur,image_tab())
				Case 1 ; Croix
				Croix(Largeur,Hauteur,image_tab())
				Case 2 ;Croix2
				Croix2(Largeur,Hauteur,image_tab())
				Case 3 ; Vermicelle
				vermicelle(Largeur,Hauteur,image_tab())
				Case 4 ; Pointillisme
				pointillism(Largeur,Hauteur,image_tab())
				Case 5 ; Flocon
				flocon(Largeur,Hauteur,image_tab())
				Case 6 ; Pastel
				aquarelle(Largeur,Hauteur,image_tab())
				Case 7 ; Cederavic 
				cederavic(Largeur,Hauteur,image_tab())
				Case 8 ; Pop_art
				Pop_art(Largeur,Hauteur,image_tab())
				Case 9 ; Reel
				Reel(Largeur,Hauteur,image_tab())
				Case 10 ; Pointillism floue
				pointillism2(largeur,Hauteur, image_tab())
				Case 11 ; Brosse floue
				BrosseFloue(Largeur, Hauteur,  image_tab())
				Case 12  To 27 ; brosse_1
				brosse(largeur,hauteur,image_tab())
			EndSelect
		EndIf
		SetGadgetState(#Gadget_scroll, 0)
		Case #bouton_efface
		StartDrawing(CanvasOutput(#Canvas))
			Box(1,1,1024,768,RGB(0,0,0))
		StopDrawing()
		
		Case #Gadget_case
		state_case=GetGadgetState(#Gadget_case)
		If state_case=#PB_Checkbox_Checked
			; montre les gadgets
			HideGadget(#Gadget_nb_de_coup_de_peint, 0)
			HideGadget(#Gadget_t_nb_de_coup, 0)
			HideGadget(#Gadget_taille_x, 0)
			HideGadget(#Gadget_t_taille_x, 0)
			HideGadget(#Gadget_t_taille_y, 0)
			HideGadget(#Gadget_taille_y, 0)
			HideGadget(#Gadget_t_transparence, 0)
			HideGadget(#Gadget_transparence, 0)
			Else
			; cache les gadgets
			HideGadget(#Gadget_nb_de_coup_de_peint, 1)
			HideGadget(#Gadget_t_nb_de_coup, 1)
			HideGadget(#Gadget_taille_x, 1)
			HideGadget(#Gadget_t_taille_x, 1)
			HideGadget(#Gadget_t_taille_y, 1)
			HideGadget(#Gadget_taille_y, 1)
			HideGadget(#Gadget_t_transparence, 1)
			HideGadget(#Gadget_transparence, 1)
		EndIf
		
	EndSelect
EndSelect
Until  Event=#PB_Event_CloseWindow
;} *************** fin boucle principale ****************************************

Write_preference()

;- **************************** Zone des Procedures **************************************
;- Procedures Zone

Procedure INIT(largeur,Hauteur, Array image_tab(2))
; By Graph100
If IsImage(#image_reference)
	StartDrawing(ImageOutput(#image_reference))
		For a = 0 To largeur -1
			For b = 0 To Hauteur -1
				image_tab(a, b)=Point(a,b) ; recup la Couleur         
			Next b
		Next a
	StopDrawing()
EndIf
EndProcedure

;- *******************************************************************
;{- Les Styles font appel aux pinceaux
Procedure Expressionnisme1(largeur,Hauteur,Array image_tab(2))
;- le Style impres
; un Style defini le nombre  de Phase 
; chaque Phase peut etre vu comme l'utilisation d'un pinceau et/ou d'une taille de pinceau
; une phase comprends :,
;  le nombre de coup de pinceaux
; la taille du pinceau
; et fait appel a la procedure de dessin (le pinceau)
; cette procedure reçoit le numero de phase ;
; grace a cette information la procedure peut choisir de dessiner avec une forme, ou une autre, 
; de phase en phase, on peut ainsi changer la forme du pinceau 
;{ ***************** NE PAS TOUCHER *********************************************************

If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	annule()
	Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
EndIf
annule()
;} *********************************************************************************************
; ici libre : 

Phase=1
nombre_de_coup_de_pinceau=500
Taille_x=100:Taille_y=100
Transparence =255
Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 2/9")
Phase=2
nombre_de_coup_de_pinceau=1200
Taille_x=50:Taille_y=50
Transparence =200
Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 40,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 3/9")
Phase=3
nombre_de_coup_de_pinceau=4000
Taille_x=15:Taille_y=15
Transparence =200
Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 80,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 4/9")
Phase=4
nombre_de_coup_de_pinceau=3800
Taille_x=10:Taille_y=10
Transparence =220
Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 100,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 5/9")
Phase=5
nombre_de_coup_de_pinceau=8000
Taille_x=8:Taille_y=8
Transparence =220
Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 6/9")
Phase=6
nombre_de_coup_de_pinceau=15000
Taille_x=2:Taille_y=2
Transparence =255
Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 7/9")
Phase=7
nombre_de_coup_de_pinceau=17000
Taille_x=3:Taille_y=3
Transparence =180
Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 8/9")
Phase=8
nombre_de_coup_de_pinceau=15000
Taille_x=2:Taille_y=3
Transparence =150
Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 9/9")
Phase=9
nombre_de_coup_de_pinceau=15000
Taille_x=1:Taille_y=1
Transparence =255
Peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab())

Beep_(880,100)
;EnableDebugger
SetGadgetText(#Gadget_text, "Terminé !")

EndProcedure
Procedure croix(Largeur,Hauteur,Array image_tab(2))
;-le Style Croix
; by Dobro
;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	annule()
	peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20, Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
EndIf
annule()
;} *********************************************************************************************
; ici libre : 

Phase=1
nombre_de_coup_de_pinceau=400
Taille_x=100:Taille_y=100
Transparence =255
SetGadgetText(#Gadget_text, "Phase 1/7")
peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20, Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 2/7")
Phase=2
nombre_de_coup_de_pinceau=600
Taille_x=50:Taille_y=50
Transparence =180
Peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 40,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 3/7")
Phase=3
nombre_de_coup_de_pinceau=3000
Taille_x=20:Taille_y=20
Transparence =150
Peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 4/7")
Phase=4
nombre_de_coup_de_pinceau=4000
Taille_x=10:Taille_y=10
Transparence =100
Peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 5/7")
Phase=5
nombre_de_coup_de_pinceau=8000
Taille_x=4:Taille_y=4
Transparence =80
Peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 6/7")
Phase=6
nombre_de_coup_de_pinceau=10000
Taille_x=2:Taille_y=2
Transparence =50
Peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 7/7")
Phase=7
nombre_de_coup_de_pinceau=20000
Taille_x=1:Taille_y=1
Transparence =20
Peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 800,Transparence ,image_tab())
Beep_(880,100)
EndProcedure

Procedure Reel(Largeur,Hauteur,Array image_tab(2)) 
;-le Style Reel
; by Dobro
;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	annule()
	peint_reel(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence , image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
EndIf
annule()
;} *********************************************************************************************
; ici libre : 
Phase=1
nombre_de_coup_de_pinceau=10000
Taille_x=10:Taille_y=10
SetGadgetText(#Gadget_text, "Phase 1/7")
Transparence =255
peint_reel(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 100, Transparence ,image_tab())

EndProcedure


Procedure vermicelle(Largeur,Hauteur,Array image_tab(2)) 
;-le Style Vermicelle
; by Dobro
;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	Phase=Random(9)
	annule()
	peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20, Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
EndIf
annule()
;} *********************************************************************************************
; ici libre : 
Phase=1
nombre_de_coup_de_pinceau=40
Taille_x=100:Taille_y=100
Transparence =255
SetGadgetText(#Gadget_text, "Phase 1/7")
peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20, Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 2/7")
Phase=2
nombre_de_coup_de_pinceau=60
Taille_x=50:Taille_y=50
Transparence =200
Peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 40,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 3/7")
Phase=3
nombre_de_coup_de_pinceau=300
Taille_x=4:Taille_y=4
Transparence =180
Peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 4/7")
Phase=4
nombre_de_coup_de_pinceau=9000
Taille_x=3:Taille_y=3
Transparence =255
Peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 5/7")
Phase=5
nombre_de_coup_de_pinceau=9800
Taille_x=1:Taille_y=1
Transparence =255
Peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 6/7")
Phase=6
nombre_de_coup_de_pinceau=9800
Taille_x=1:Taille_y=1
Transparence =255
Peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())


Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 7/7")
Phase=7
nombre_de_coup_de_pinceau=50000
Taille_x=1:Taille_y=1
Transparence =200
Peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 800,Transparence ,image_tab())
Beep_(880,100)
EndProcedure

Procedure croix2(Largeur,Hauteur,Array image_tab(2))
;- Le Style Croix2
; by Dobro
;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	annule()
	peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20, Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
EndIf
annule()
;} *********************************************************************************************
; ici libre : 
Phase=1
nombre_de_coup_de_pinceau=400
Taille_x=100:Taille_y=100
Transparence =255
SetGadgetText(#Gadget_text, "Phase 1/7")
peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence , image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 2/7")
Phase=2
nombre_de_coup_de_pinceau=600
Taille_x=50:Taille_y=50
Transparence =255
Peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 40,Transparence ,image_tab())
Beep_(440,50)

SetGadgetText(#Gadget_text, "Phase 3/7")
Phase=3
nombre_de_coup_de_pinceau=3000
Taille_x=20:Taille_y=20
Transparence =200
Peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 4/7")
Phase=4
nombre_de_coup_de_pinceau=4000
Taille_x=10:Taille_y=10
Transparence =180
Peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 5/7")
Phase=5
nombre_de_coup_de_pinceau=8000
Taille_x=4:Taille_y=4
Peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
Transparence =190
SetGadgetText(#Gadget_text, "Phase 6/7")
Phase=6
nombre_de_coup_de_pinceau=10000
Taille_x=2:Taille_y=2
Peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 7/7")
Phase=7
nombre_de_coup_de_pinceau=50000
Taille_x=1:Taille_y=1
Transparence =255
Peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 800,Transparence ,image_tab())
Beep_(880,100)
EndProcedure



Procedure pointillism(largeur,Hauteur,Array image_tab(2))
;- le Style pointillisme
;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	annule()
	Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
EndIf
annule()
;} *********************************************************************************************
; ici libre : 
Phase=1
nombre_de_coup_de_pinceau=500
Taille_x=100:Taille_y=100
Transparence =255
Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 2/9")
Phase=2
nombre_de_coup_de_pinceau=1200
Taille_x=50:Taille_y=50
Transparence =255
Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 40,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 3/9")
Phase=3
nombre_de_coup_de_pinceau=2400
Taille_x=10:Taille_y=10
Transparence =200
Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 80,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 4/9")
Phase=4
nombre_de_coup_de_pinceau=3800
Taille_x=5:Taille_y=5
Transparence =180
Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 100,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 5/9")
Phase=5
nombre_de_coup_de_pinceau=5800
Taille_x=4:Taille_y=4
Transparence =150
Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 6/9")
Phase=6
nombre_de_coup_de_pinceau=6500
Taille_x=3:Taille_y=3
Transparence =180
Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 7/9")
Phase=7
nombre_de_coup_de_pinceau=7000
Taille_x=3:Taille_y=3
Transparence =255
Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 8/9")
Phase=8
nombre_de_coup_de_pinceau=9500
Taille_x=2:Taille_y=2
Transparence =255
Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 9/9")
Phase=9
nombre_de_coup_de_pinceau=100000
Taille_x=1:Taille_y=1
Transparence =255
Peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab())

Beep_(880,100)
;EnableDebugger
SetGadgetText(#Gadget_text, "Terminé !")

EndProcedure
Procedure aquarelle(largeur,Hauteur,Array image_tab(2))
;-le Style Aquarelle
; By Dobro
;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	annule()
	Peint_aquarelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
EndIf
annule()
;} *********************************************************************************************
; ici libre : 

SetGadgetText(#Gadget_text, "Phase 1")
Phase=1 ; ne compte pas ici
nombre_de_coup_de_pinceau=40000
Taille_x=10:Taille_y=3 ; ne compte pas ici
Transparence =50
Peint_aquarelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab())


;EnableDebugger
SetGadgetText(#Gadget_text, "Terminé !")

EndProcedure

Procedure Pop_art(largeur,Hauteur,Array image_tab(2))
;-le Style pop_art
; by Dobro

;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	annule()
	Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
EndIf
annule()
;} *********************************************************************************************
; ici libre : 
Beep_(440,50)
Phase=1
nombre_de_coup_de_pinceau=500
Taille_x=100:Taille_y=100
Transparence =255
Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 2/9")
Phase=2
nombre_de_coup_de_pinceau=1200
Taille_x=50:Taille_y=50
Transparence =255
Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 40,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 3/9")
Phase=3
nombre_de_coup_de_pinceau=2400
Taille_x=10:Taille_y=10
Transparence =255
Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 80,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 4/9")
Phase=4
nombre_de_coup_de_pinceau=3800
Taille_x=5:Taille_y=5
Transparence =255
Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 100,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 5/9")
Phase=5
nombre_de_coup_de_pinceau=5800
Taille_x=4:Taille_y=4
Transparence =255
Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 6/9")
Phase=6
nombre_de_coup_de_pinceau=6500
Taille_x=3:Taille_y=3
Transparence =255
Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 7/9")
Phase=7
nombre_de_coup_de_pinceau=7000
Taille_x=3:Taille_y=3
Transparence =255
Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 8/9")
Phase=8
nombre_de_coup_de_pinceau=39500
Taille_x=2:Taille_y=2
Transparence =255
Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 9/9")
Phase=9
nombre_de_coup_de_pinceau=300000
Taille_x=1:Taille_y=1
Transparence =5
Peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab())

Beep_(880,100)
;EnableDebugger
SetGadgetText(#Gadget_text, "Terminé !")

EndProcedure

Procedure Flocon(largeur,Hauteur,Array image_tab(2))
;- le Style Flocon
; by Dobro
;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	annule()
	Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
EndIf
annule()
;} *********************************************************************************************
; ici libre : 
Phase=1
nombre_de_coup_de_pinceau=1500
Taille_x=100:Taille_y=100
Transparence =255
Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 20,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 2/9")
Phase=2
nombre_de_coup_de_pinceau=1200
Taille_x=50:Taille_y=50
Transparence =255
Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 40,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 3/9")
Phase=3
nombre_de_coup_de_pinceau=2400
Taille_x=30:Taille_y=30
Transparence =255
Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 80,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 4/9")
Phase=4
nombre_de_coup_de_pinceau=13800
Taille_x=20:Taille_y=20
Transparence =255
Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 100,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 5/9")
Phase=5
nombre_de_coup_de_pinceau=15800
Taille_x=10:Taille_y=10
Transparence =255
Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 6/9")
Phase=6
nombre_de_coup_de_pinceau=16500
Taille_x=8:Taille_y=8
Transparence =255
Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 7/9")
Phase=7
nombre_de_coup_de_pinceau=17000
Taille_x=5:Taille_y=5
Transparence =255
Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 8/9")
Phase=8
nombre_de_coup_de_pinceau=19500
Taille_x=3:Taille_y=3
Transparence =255
Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 500,Transparence ,image_tab())
; *********
Beep_(440,50)
SetGadgetText(#Gadget_text, "Phase 9/9")
Phase=9
nombre_de_coup_de_pinceau=300
Taille_x=2:Taille_y=2
Transparence =255
Peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab())

Beep_(880,100)
;EnableDebugger
SetGadgetText(#Gadget_text, "Terminé !")

EndProcedure

Procedure cederavic(Largeur,Hauteur,Array image_tab(2))
;-le Style Cederavic
; by Cederavic
; NE PAS PRENDRE CE STYLE COMME MODEL !!!!
; Sa structure empeche l'utilisation en dessin a main levée !!!
;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	Phase=Random(3,2)
	annule()
	peint_cederavic(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 200,Transparence , image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
	
EndIf
annule()
;} *********************************************************************************************
; ici libre : 
Phase=1
nombre_de_coup_de_pinceau=200
SetGadgetText(#Gadget_text, "Phase 1/3")

peint_cederavic(largeur,Hauteur,nombre_de_coup_de_pinceau,128,32, 20, Transparence ,image_tab())
Beep_(440,50)

Phase=2
nombre_de_coup_de_pinceau=2000
SetGadgetText(#Gadget_text, "Phase 2/3")
peint_cederavic(largeur,Hauteur,nombre_de_coup_de_pinceau,24,128, 20,Transparence , image_tab())
Beep_(440,50)
Phase=3

nombre_de_coup_de_pinceau=32000
SetGadgetText(#Gadget_text, "Phase 3/3")
peint_cederavic(largeur,Hauteur,nombre_de_coup_de_pinceau,4,64, 20, Transparence ,image_tab())
Beep_(880,100)
EndProcedure



Procedure pointillism2(largeur,Hauteur,Array image_tab(2))
; by dobro, modified by blendman
;-Le style Pointillism floue
; NE PAS PRENDRE CE STYLE COMME MODEL !!!!
; Sa structure empeche l'utilisation en dessin a main levée !!!
;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	annule()
	Peint_pointillism2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300,Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	ProcedureReturn
	Else ; mode Automatique
	Taille_x=7
	Taille_y=7
	;phase=1
	annule()
	Peint_pointillism2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300,Transparence ,image_tab())
EndIf
annule()
;} *********************************************************************************************
Phase=2
nombre_de_coup_de_pinceau=800
SetGadgetText(#Gadget_text, "Phase 1/3")
Transparence =255
Peint_pointillism2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300,Transparence ,image_tab())
Beep_(440,50)

Phase=3
nombre_de_coup_de_pinceau=5000
SetGadgetText(#Gadget_text, "Phase 2/3")
Transparence =255
Peint_pointillism2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300,Transparence ,image_tab())
Beep_(440,50)
Phase=4

nombre_de_coup_de_pinceau=32000
SetGadgetText(#Gadget_text, "Phase 3/3")
Transparence =255
Peint_pointillism2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 300,Transparence ,image_tab())
Beep_(880,100)



SetGadgetText(#Gadget_text, "Terminé !")
EndProcedure

Procedure BrosseFloue(Largeur, HAuteur, Array image_tab(2))
;- Le style Brosse floue
; By blendman

;{ ***************** NE PAS TOUCHER *********************************************************
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	phase=0
	
	annule()
	Peint_BrosseFloue(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab())
	SetGadgetText(#Gadget_text, "Terminé !")
	;ProcedureReturn
	Else
	SetGadgetText(#Gadget_text, "Phase 1") ; mode Automatique
	Taille_x=60
	Taille_y=60
	phase=1
	nombre_de_coup_de_pinceau=15000
	Transparence=32
	annule()
	Peint_BrosseFloue(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab())
EndIf
;} *********************************************************************************************
SetGadgetText(#Gadget_text, "Terminé !")
EndProcedure

Procedure brosse(Largeur, HAuteur, Array image_tab(2))

;{ ***************** NE PAS TOUCHER *********************************************************
;-Le style brosse (universel , ce style utilise toute les brosses choisie )
; By Dobro
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) 
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence)) 
	phase=0 
	annule() 
	
	Peint_brosse(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab())  
	SetGadgetText(#Gadget_text, "Terminé !") ; <<<<<< c'est bien de préciser a l'utilisateur  ce qui se passe en interne :)
	ProcedureReturn
EndIf

SetGadgetText(#Gadget_text, "Phase 1/6")
Taille_x=128 ; c'est un brush (128x128)
Taille_y=128
Transparence =255
phase=1
nombre_de_coup_de_pinceau=500

annule()
Peint_brosse(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab()) 

SetGadgetText(#Gadget_text, "Phase 2/6")
Taille_x=128 ; c'est un brush (128x128)
Taille_y=32
Transparence =180
phase=2
nombre_de_coup_de_pinceau=3000
annule()
Peint_brosse(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab()) 

SetGadgetText(#Gadget_text, "Phase 3/6")
Taille_x=64; c'est un brush (128x128)
Taille_y=16
Transparence =180
phase=3
nombre_de_coup_de_pinceau=500
annule()
Peint_brosse(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab()) 

SetGadgetText(#Gadget_text, "Phase 4/6")
Taille_x=32 ; c'est un brush (128x128)
Taille_y=4
Transparence =230
phase=4
nombre_de_coup_de_pinceau=1500
annule()
Peint_brosse(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab()) 

SetGadgetText(#Gadget_text, "Phase reel") ; histoire de raméner un peu de cohérance
Phase=6
Transparence =100
nombre_de_coup_de_pinceau=9400
Taille_x=2:Taille_y=2
peint_reel(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab()) 

; SetGadgetText(#Gadget_text, "Phase 5/6")
; Taille_x=2 ; c'est un brush (128x128)
; Taille_y=8
; Transparence =250
; phase=5
; nombre_de_coup_de_pinceau=2600
; annule()
; Peint_brosse_1(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab()) 
; 
; SetGadgetText(#Gadget_text, "Phase 6/6")
; Phase=6
; Transparence =255
; nombre_de_coup_de_pinceau=10500
; Taille_x=2:Taille_y=2
; Peint_brosse_1(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,Transparence ,image_tab()) 



;} *********************************************************************************************
EndProcedure




;- ************************************************ 
Procedure xxxxxxxxx(Largeur, HAuteur, Array image_tab(2))
;-Style Modele préremplis
;{ ***************** NE PAS TOUCHER *********************************************************
;-Le style xxxxxxxxx  <<<<<<<  (mettre le nom de votre Style ****************************
; de : votre Pseudo
If state_case=#PB_Checkbox_Checked   ; semi mode automatique
	nombre_de_coup_de_pinceau=Val(GetGadgetText(#Gadget_nb_de_coup_de_peint))
	Taille_x=Val(GetGadgetText(#Gadget_taille_x)) ; <<<<<<<<<< la taille du pinceau en mode semi automatique est recupéré dans le Gadget de l'interface utilisateur
	Taille_y=Val(GetGadgetText(#Gadget_taille_y)) 
	If Taille_x<=0:Taille_x=1:EndIf  :If Taille_x>=largeur:Taille_x=1023:EndIf 
	If Taille_y<=0:Taille_y=1:EndIf ::If Taille_y>=Hauteur:Taille_y=767:EndIf 
	Transparence=Val(GetGadgetText(#Gadget_transparence))  ; <<<<<<<<<<<<<<<<< recupere la valeur de transparence
	phase=0 ; <<<<<<<<< ceci est une variable qui defini si votre style utilise plusieurs phase de dessin ( avec éventuellement des formes de pinceaux differentes )
	annule() ; <<<<<<<<<<< ceci sauve le contenu de la Toile en cours pour une annulation possible de la  derniere opération (bouton annule)
	Peint_xxxxxxxxx(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,image_tab())  ; <<<<<<< mettre ici le nom de la procedure de votre pinceau
	SetGadgetText(#Gadget_text, "Terminé !") ; <<<<<< c'est bien de préciser a l'utilisateur  ce qui se passe en interne :)
	ProcedureReturn
	Else
	SetGadgetText(#Gadget_text, "Phase 1")
	Taille_x=15 ;<<<<<<<<<< definir ici la taille de votre pinceau pour le demmarrage du mode automatique
	Taille_y=15
	Transparence =255
	phase=1
	nombre_de_coup_de_pinceau=500000 ; <<<<<<<<< definir le nombre de coup de pinceau pour le mode Automatique
	annule()
	Peint_xxxxxxxxx(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, 600,image_tab()) ; <<<<<<< mettre ici le nom de la procedure de votre pinceau
EndIf
;} *********************************************************************************************
EndProcedure


;}



;- ***************************************************************
;{- les Pinceaux (appelé par les Styles et par le mode Manuel)

Procedure peint_impres(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence,Array image_tab(2))
;- le pinceau impress
; By Dobro
; le pinceau est une procedure qui Reçois plusieurs information :
; Global phase , indique quelle phase de dessin est demandé , cela permet de scinder en plusieur Etape un dessin , par exempe en changeant de forme de pinceau
; largeur,Hauteur de l'image qu'on dessine
; nombre_de_coup_de_pinceau , comme son nom l'indique , le nombre de coup de pinceau dans la Phase Actuelle
;Taille_x,Taille_y : la taille du pinceau ( de preference plus la phase est grande , plus le pinceau devrai etre petit
; delay_affichage sert a ne pas afficher pendant un certain temps pour gagner en Vitesse d'execution

SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)

StartDrawing(CanvasOutput(#canvas))
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	For i=1 To nombre_de_coup_de_pinceau
		
		; ******** Entete Graph100**********************
		;{ ***************** NE PAS TOUCHER **********
		; ****** ne rien ajouter la dedans *****
		If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
		StopDrawing()
		ProcedureReturn
	EndIf
	If i%delay_affichage = 0
	StopDrawing()
	
	StartDrawing(CanvasOutput(#canvas))
	EndIf
	
	If flag_bouton_on=0
		x_source=Random(largeur-1) ;
		y_source=Random(hauteur-1)
		Else  ; mode Dessin main 
		x_source=xx_mouse
		y_source=yy_mouse
		
	EndIf
	If x_source<0 :x_source=1:EndIf
	If x_source>1023 :x_source=1023:EndIf
	If y_source<0 :y_source=1:EndIf
	If y_source>767 :y_source=767:EndIf
	
	Couleur_ref=image_tab(x_source,y_source) ; recup la Couleur  de l'image d'origine     (Mise en tableau   image_tab())
	Couleur_ref=RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)
	;  **********************************************************
	;   partir de là, on a en principe tout ce qu'il faut ..
	; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
	; les coordonées de la souris (x_source,y_source)
	;} **********************************************************
	
	
	
	De=Random(10) ; ici j'utilise un Dé , car de façon aléatoire mon pinceau va changer de forme
	If De =1
		;DrawingMode(#PB_2DDrawing_Default)
		Box(x_source,y_source,Taille_x,Taille_y,Couleur_ref) ;une boite
	EndIf
	
	If De >=2 And De<4
		;DrawingMode(#PB_2DDrawing_Default)
		Circle(x_source,y_source,Taille_x,Couleur_ref) ; un rond
	EndIf
	
	If De >=4 And De<6
		If Phase<>6
			DrawingMode(#PB_2DDrawing_Outlined | #PB_2DDrawing_AlphaBlend)
		EndIf
		Circle(x_source,y_source,Taille_x,Couleur_ref) ; un cercle
	EndIf
	
	If De >=6 And De<8
		If Phase<>6
			DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend )
		EndIf
		Ellipse(x_source,y_source,Taille_x*4,Taille_x,Couleur_ref) ; une ellipse creuse verticale
	EndIf
	
	If De >=8 And De<=10
		If Phase<>6
			DrawingMode(#PB_2DDrawing_Outlined |#PB_2DDrawing_AlphaBlend )
		EndIf
		Ellipse(x_source,y_source,Taille_x,Taille_x*4,Couleur_ref) ; une autre ellipse creuse horizontale
	EndIf
	While WindowEvent():Wend
	SetGadgetState   (#Gadget_scroll, i)
Next i

StopDrawing()
;
EndProcedure

Procedure peint_croix(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage,Transparence ,Array image_tab(2)) ; le Pinceau Croix
	;- le Pinceau Croix
	; By Dobro
	SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)
	
	StartDrawing(CanvasOutput(#canvas))
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		For i=1 To nombre_de_coup_de_pinceau
			;{ ***************** NE PAS TOUCHER **********
			; ****** ne rien ajouter la dedans *****
			
			If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
			StopDrawing()
			ProcedureReturn
		EndIf
		If i%delay_affichage = 0
		StopDrawing()
		
		StartDrawing(CanvasOutput(#Canvas))
			
		EndIf
		
		If flag_bouton_on=0
			x_source=Random(largeur-1) ; 
			y_source=Random(hauteur-1)
			Else  ; mode Dessin main 
			x_source=xx_mouse
			y_source=yy_mouse
			
		EndIf
		If x_source<0 :x_source=1:EndIf
		If x_source>1023 :x_source=1023:EndIf
		If y_source<0 :y_source=1:EndIf
		If y_source>767 :y_source=767:EndIf
		Couleur_ref=image_tab(x_source,y_source) ; recup la Couleur  de l'image d'origine 
		Couleur_ref=RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence) 
		
		; ***********************************************************
		;   partir de là, on a en principe tout ce qu'il faut ..
		; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
		; les coordonées de la souris (x_source,y_source)
		;} ***********************************************************
		
		De=Random(3,1)
		
		If De >=1
			;If Phase<>6
			;DrawingMode(#PB_2DDrawing_Outlined )
			;EndIf
			Ellipse(x_source,y_source,Taille_x*4,Taille_y,Couleur_ref)
		EndIf
		If De >=2 
			;If Phase<>6
			;DrawingMode(#PB_2DDrawing_Outlined )
			;EndIf
			Ellipse(x_source,y_source,Taille_x,Taille_y*4,Couleur_ref)
		EndIf
		While WindowEvent():Wend
		SetGadgetState   (#Gadget_scroll, i)
	Next i
	
StopDrawing()


EndProcedure
Procedure peint_reel(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2)) ; le Pinceau Reel
;- le Pinceau Reel
; By Dobro
SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)

StartDrawing(CanvasOutput(#canvas))
	
	For i=1 To nombre_de_coup_de_pinceau
		;{ ***************** NE PAS TOUCHER **********
		; ****** ne rien ajouter la dedans *****
		If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
		StopDrawing()
		ProcedureReturn
	EndIf
	If i%delay_affichage = 0
	StopDrawing()
	
	StartDrawing(CanvasOutput(#canvas))
	EndIf
	
	If flag_bouton_on=0
		x_source=Random(largeur-taille_x,taille_x) ; 
		y_source=Random(hauteur-taille_y,taille_y)
		
		Else  ; mode Dessin main 
		x_source=xx_mouse
		y_source=yy_mouse
		
	EndIf
	If x_source<0+taille_x :x_source=1+taille_x:EndIf
	If x_source>1023-taille_x :x_source=1023-taille_x:EndIf
	If y_source<1+taille_y  :y_source=1+taille_y :EndIf
	If y_source>767-taille_y  :y_source=767-taille_y :EndIf
	; **********************************************************
	;   partir de là, on a en principe tout ce qu'il faut ..
	; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
	; les coordonées de la souris (x_source,y_source)
	;} **********************************************************
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	For iiy=y_source-taille_y To y_source+taille_y
		For iix=x_source-taille_x To x_source+taille_x
			
			Couleur_ref=image_tab(iix,iiy) ; recup la Couleur  de l'image d'origine
			Couleur_ref=RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)
			Circle(iix,iiy,1,Couleur_ref)
			;;Ellipse(x_source,y_source,Taille_x,Taille_y*4,Couleur_ref)
		Next iix
	Next iiy
	
	While WindowEvent():Wend
	SetGadgetState   (#Gadget_scroll, i)
Next i

StopDrawing()


EndProcedure

Procedure peint_vermicelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2)) ; le Pinceau Croix
	;- le Pinceau vermicelle
	; By Dobro
	SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)
	
	StartDrawing(CanvasOutput(#canvas))
		
		For i=1 To nombre_de_coup_de_pinceau
			;{ ***************** NE PAS TOUCHER **********
			; ****** ne rien ajouter la dedans *****
			If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
			StopDrawing()
			ProcedureReturn
		EndIf
		If i%delay_affichage = 0
		StopDrawing()
		
		StartDrawing(CanvasOutput(#canvas))
		EndIf
		
		If flag_bouton_on=0
			x_source=Random(largeur-1) ;
			y_source=Random(hauteur-1)
			Else  ; mode Dessin main 
			x_source=xx_mouse
			y_source=yy_mouse
			
		EndIf
		If x_source<0 :x_source=1:EndIf
		If x_source>1023 :x_source=1023:EndIf
		If y_source<0 :y_source=1:EndIf
		If y_source>767 :y_source=767:EndIf
		Couleur_ref=image_tab(x_source,y_source) ; recup la Couleur  de l'image d'origine   
		Couleur_ref=RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence) 
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		; ***********************************************************
		;   partir de là, on a en principe tout ce qu'il faut ..
		; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
		; les coordonées de la souris (x_source,y_source)
		;} ***********************************************************
		De=Random(2,1)
		
		
		;De=1
		If phase>0 And phase<5
			If De =1
				
				For t=1 To 20
					x_source=x_source+Random(Taille_x)
					y_source=y_source+Random(Taille_y)
					Ellipse(x_source,y_source,Taille_x,taille_y,Couleur_ref)
				Next t
			EndIf
			
			If De =2
				For t=1 To 20
					x_source=x_source-Random(Taille_x)
					y_source=y_source+Random(Taille_y)
					Ellipse(x_source,y_source,Taille_x,taille_y,Couleur_ref)
				Next t
			EndIf
		EndIf
		
		If phase >4 And phase<6
			If De =1
				
				For t=1 To 40
					x_source=x_source+Random(Taille_x)
					y_source=y_source+Random(Taille_y)
					Ellipse(x_source,y_source,Taille_x,taille_y,Couleur_ref)
				Next t
			EndIf
			
			If De =2
				For t=1 To 10
					x_source=x_source-Random(Taille_x)
					y_source=y_source+Random(Taille_y)
					Ellipse(x_source,y_source,Taille_x,taille_y,Couleur_ref)
				Next t
			EndIf
		EndIf
		If phase >5 And phase<7
			If De =1
				
				For t=1 To 10
					x_source=x_source+Random(Taille_x)
					y_source=y_source+Random(Taille_y)
					Ellipse(x_source,y_source,Taille_x,taille_y,Couleur_ref)
				Next t
			EndIf
			
			If De =2
				For t=1 To 40
					x_source=x_source-Random(Taille_x)
					y_source=y_source+Random(Taille_y)
					Ellipse(x_source,y_source,Taille_x,taille_y,Couleur_ref)
				Next t
			EndIf
		EndIf
		If phase >6
			If De =1
				
				For t=1 To 20
					x_source=x_source+Random(Taille_x)
					y_source=y_source+Random(Taille_y)
					Ellipse(x_source,y_source,Taille_x,taille_y,Couleur_ref)
				Next t
			EndIf
			
			If De =2
				For t=1 To 20
					x_source=x_source-Random(Taille_x)
					y_source=y_source+Random(Taille_y)
					Ellipse(x_source,y_source,Taille_x,taille_y,Couleur_ref)
				Next t
			EndIf
		EndIf
		
		
		While WindowEvent():Wend
		SetGadgetState   (#Gadget_scroll, i)
	Next i
	
StopDrawing()


EndProcedure







Procedure peint_croix2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2)) ; le pinceau Croix2
;-le pinceau Croix2
; By Dobro
SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)

StartDrawing(CanvasOutput(#canvas))
	DrawingMode(#PB_2DDrawing_AlphaChannel)
	For i=1 To nombre_de_coup_de_pinceau
		;{ ***************** NE PAS TOUCHER **********
		; ****** ne rien ajouter la dedans *****
		If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
		StopDrawing()
		ProcedureReturn
	EndIf
	If i%delay_affichage = 0
	StopDrawing()
	
	StartDrawing(CanvasOutput(#canvas))
	EndIf
	
	If flag_bouton_on=0
		x_source=Random(largeur-1) ;
		y_source=Random(hauteur-1)
		Else  ; mode Dessin main 
		x_source=xx_mouse
		y_source=yy_mouse
		
	EndIf
	If x_source<0 :x_source=1:EndIf
	If x_source>1023 :x_source=1023:EndIf
	If y_source<0 :y_source=1:EndIf
	If y_source>767 :y_source=767:EndIf
	Couleur_ref=image_tab(x_source,y_source) ; recup la Couleur  de l'image d'origine   
	Couleur_ref=RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence) 
	; ****************************************************************************
	;   partir de là, on a en principe tout ce qu'il faut ..
	; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
	; les coordonées de la souris (x_source,y_source)
	;} ****************************************************************************
	
	De=Random(2,1)
	
	If De >=1
		;If Phase<>6
		DrawingMode(#PB_2DDrawing_Outlined |#PB_2DDrawing_AlphaBlend )
		;EndIf
		Ellipse(x_source,y_source,Taille_x*4,Taille_y,Couleur_ref)
	EndIf
	If De >=2 
		;If Phase<>6
		DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend )
		;EndIf
		Ellipse(x_source,y_source,Taille_x,Taille_y*4,Couleur_ref)
	EndIf
	While WindowEvent():Wend
	SetGadgetState   (#Gadget_scroll, i)
Next i

StopDrawing()


EndProcedure



Procedure peint_pointillism(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
	;- le pinceau pointillism
	; By Dobro
	SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)
	
	StartDrawing(CanvasOutput(#canvas))
		
		For i=1 To nombre_de_coup_de_pinceau
			;{ ***************** NE PAS TOUCHER **********
			; ****** ne rien ajouter la dedans *****
			If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked ; arret d'urgence
			StopDrawing()
			ProcedureReturn
		EndIf
		If i%delay_affichage = 0
		StopDrawing()
		
		StartDrawing(CanvasOutput(#canvas))
		EndIf
		
		If flag_bouton_on=0
			x_source=Random(largeur-1) ;
			y_source=Random(hauteur-1)
			Else  ; mode Dessin main 
			x_source=xx_mouse
			y_source=yy_mouse
			
		EndIf
		If x_source<0 :x_source=1:EndIf
		If x_source>1023 :x_source=1023:EndIf
		If y_source<0 :y_source=1:EndIf
		If y_source>767 :y_source=767:EndIf
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		Couleur_ref=image_tab(x_source,y_source) ; recup la Couleur  de l'image d'origine  
		Couleur_ref=RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)     
		; **************************************************************************
		;   partir de là, on a en principe tout ce qu'il faut ..
		; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
		; les coordonées de la souris (x_source,y_source)
		;} ****************************************************************************
		
		;De=Random(10)
		If Couleur_ref<RGBA(50,50,50,Transparence)
			DrawingMode(#PB_2DDrawing_AlphaBlend)
			;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref)/2,green(Couleur_ref)/2,blue(Couleur_ref)))
			For nb=1 To 6
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
			
			
		EndIf
		If Couleur_ref>RGBA(49,49,49,Transparence) And Couleur_ref<RGBA(100,100,100,Transparence)
			DrawingMode(#PB_2DDrawing_AlphaBlend)
			;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref)/2,green(Couleur_ref),blue(Couleur_ref)))
			For nb=1 To 6
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
		EndIf
		If Couleur_ref>RGBA(99,99,99,Transparence) And Couleur_ref<RGBA(150,150,150,Transparence)
			DrawingMode(#PB_2DDrawing_AlphaBlend)
			;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref),green(Couleur_ref)/2,blue(Couleur_ref)/2))
			For nb=1 To 5
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
		EndIf
		If Couleur_ref>RGBA(149,149,149,Transparence) And Couleur_ref<RGBA(200,200,200,Transparence)
			DrawingMode(#PB_2DDrawing_AlphaBlend)
			;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref/2),green(Couleur_ref),blue(Couleur_ref)/2))
			For nb=1 To 4
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
		EndIf
		If Couleur_ref>RGB(199,199,199) And Couleur_ref<RGB(255,255,255)
			DrawingMode(#PB_2DDrawing_AlphaBlend)
			;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref),green(Couleur_ref),blue(Couleur_ref)))
			For nb=1 To 4
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_x)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
			
		EndIf
		
		While WindowEvent():Wend
		SetGadgetState   (#Gadget_scroll, i)
	Next i
	
StopDrawing()



EndProcedure

Procedure peint_aquarelle(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
;- le pinceau Aquarelle
; By Dobro
SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)
; lance le mode pointillisme :)
If flag_bouton_on=0 And GetGadgetState(#Gadget_case)=#PB_Checkbox_Unchecked
	pointillism(largeur,Hauteur,image_tab()) ; une fois la toile dessinée,....
EndIf
SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)
; on Aquarellise !! 
StartDrawing(CanvasOutput(#canvas))
	SetGadgetText(#Gadget_text, "Aquarellisation !")
	For i=1 To nombre_de_coup_de_pinceau
		;{ ***************** NE PAS TOUCHER **********
		; ****** ne rien ajouter la dedans *****
		If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
		StopDrawing()
		ProcedureReturn
	EndIf
	If i%delay_affichage = 0
	StopDrawing()
	
	StartDrawing(CanvasOutput(#canvas))
		DrawingMode(#PB_2DDrawing_AlphaBlend )
	EndIf
	If flag_bouton_on=0
		x_source=Random(largeur-1) ; lit une couleur de l'image d'origine
		y_source=Random(hauteur-1)
		Else  ; mode Dessin main 
		x_source=xx_mouse
		y_source=yy_mouse
	EndIf
	
	
	If x_source<0 :x_source=1:EndIf
	If x_source>1023 :x_source=1023:EndIf
	If y_source<0 :y_source=1:EndIf
	If y_source>767 :y_source=767:EndIf
	; ***********************************************************************
	;   partir de là, on a en principe tout ce qu'il faut ..
	; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
	; les coordonées de la souris (x_source,y_source)
	;} ****************************************************************************
	
	DrawingMode(#PB_2DDrawing_AlphaBlend )
	If (x_source>5 And x_source< largeur-5) And  ( y_source>5 And  y_source<hauteur-5 )
		col1= Point(x_source,y_source) ; recupere la couleur de la toile qui viens d'etre peinte
		
		r=Red(col1)+10
		v=Green(col1)+10
		b=Blue(col1)+10
		
		If r>255 : r=255:EndIf
		If v>255 : v=255:EndIf
		If b>255 : b=255:EndIf
		If flag_bouton_on=0  And GetGadgetState(#Gadget_case)=#PB_Checkbox_Unchecked ; mode automatique
			If transparence>50 :Transparence=50:EndIf
			col1=RGBA(r,v,b,Transparence)  ; ajoute la transparence
			Else ; mode manuel ET semi-auto
			col1=RGBA(r,v,b,Transparence)  ; ajoute la transparence
		EndIf
		
		
		
		xxx=-3+Random(6); ajoute un tremblement horizontale
		Ellipse(x_source+xxx,y_source+xxx,taille_x,taille_y,col1)
	EndIf
	
	While WindowEvent():Wend
	SetGadgetState   (#Gadget_scroll, i)
Next i
StopDrawing()




EndProcedure

Procedure peint_pop_art(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
	;- le pinceau Pop_art
	; By Dobro
	SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)
	
	StartDrawing(CanvasOutput(#canvas))
		;DrawingMode(#PB_2DDrawing_Default )
		For i=1 To nombre_de_coup_de_pinceau
			;{ ***************** NE PAS TOUCHER **********
			; ****** ne rien ajouter la dedans *****
			If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
			StopDrawing()
			ProcedureReturn
		EndIf
		If i%delay_affichage = 0
		StopDrawing()
		
		StartDrawing(CanvasOutput(#canvas))
		EndIf
		
		If flag_bouton_on=0
			x_source=Random(largeur-1) ; lit une couleur de l'image d'origine
			y_source=Random(hauteur-1)
			Else  ; mode Dessin main 
			x_source=xx_mouse
			y_source=yy_mouse
			
		EndIf
		If x_source<0 :x_source=1:EndIf
		If x_source>1023 :x_source=1023:EndIf
		If y_source<0 :y_source=1:EndIf
		If y_source>767 :y_source=767:EndIf
		Couleur_ref=image_tab(x_source,y_source) ; recup la Couleur         
		; Couleur_ref=rgbA(red(Couleur_ref),green(Couleur_ref),blue(Couleur_ref),Transparence) ; ne sert pas ici
		If Phase >0
			DrawingMode(#PB_2DDrawing_AlphaBlend)
			Else
			
			DrawingMode(#PB_2DDrawing_Default)
		EndIf
		; *********************************************************
		;   partir de là, on a en principe tout ce qu'il faut ..
		; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
		; les coordonées de la souris (x_source,y_source)
		;} **********************************************************
		
		;De=Random(10)
		
		If Couleur_ref<RGB(50,50,50)
			
			dee=Random(3,1)
			If dee=1:Couleur_ref=RGB(Red(Couleur_ref),0,0):EndIf : If dee=2:Couleur_ref=RGB(0,Green(Couleur_ref),0):EndIf: If dee=3:Couleur_ref=RGB(0,0,Blue(Couleur_ref)):EndIf
			;DrawingMode(#PB_2DDrawing_AlphaBlend  )
			;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref)/2,green(Couleur_ref)/2,blue(Couleur_ref)))
			For nb=1 To 6
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),255))
			Next nb
		EndIf
		If Couleur_ref<RGB(26,26,26)
			Couleur_ref=0
			
			;DrawingMode(#PB_2DDrawing_AlphaBlend  )
			;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref)/2,green(Couleur_ref)/2,blue(Couleur_ref)))
			For nb=1 To 6
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),255))
			Next nb
		EndIf
		
		If Couleur_ref>RGB(25,25,25) And Couleur_ref<RGB(50,50,50)
			r=Red(Couleur_ref)
			v=Green(Couleur_ref)
			b=Blue(Couleur_ref)
			Couleur_ref=(r+v+b)/3
			;DrawingMode(#PB_2DDrawing_AlphaBlend  )
			Circle(x_source,y_source,Taille_x,RGB(Red(Couleur_ref)/2,Green(Couleur_ref)/2,Blue(Couleur_ref)))
			For nb=1 To 6
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
		EndIf
		
		If Couleur_ref>RGB(49,49,49) And Couleur_ref<RGB(100,100,100)
			Couleur_ref=RGB(0,0,Blue(Couleur_ref)) ;bleu
			;DrawingMode(#PB_2DDrawing_AlphaBlend   )
			Circle(x_source,y_source,Taille_x,RGB(Red(Couleur_ref)/2,Green(Couleur_ref),Blue(Couleur_ref)))
			For nb=1 To 6
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
		EndIf
		If Couleur_ref>RGB(99,99,99) And Couleur_ref<RGB(150,150,150)
			Couleur_ref=RGB(0,Green(Couleur_ref),0) ; vert
			;DrawingMode(#PB_2DDrawing_AlphaBlend   )
			Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref)/2,Blue(Couleur_ref)/2,Transparence))
			For nb=1 To 5
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
		EndIf
		If Couleur_ref>RGB(149,149,149) And Couleur_ref<RGB(200,200,200)
			Couleur_ref=RGB(Red(Couleur_ref),0,0) ;rouge
			;DrawingMode(#PB_2DDrawing_AlphaBlend   )
			Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref/2),Green(Couleur_ref),Blue(Couleur_ref)/2,Transparence))
			For nb=1 To 4
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
		EndIf
		
		If Couleur_ref>RGBA(199,199,199,Transparence) And Couleur_ref<RGBA(255,255,255,Transparence)
			Couleur_ref=RGBA(Red(Couleur_ref),Green(Couleur_ref),0,Transparence) ; jaune
			;DrawingMode(#PB_2DDrawing_AlphaBlend  )
			Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			For nb=1 To 4
				x_source=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x)
				y_source=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_x)
				Circle(x_source,y_source,Taille_x,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence))
			Next nb
			
		EndIf
		
		
		
		While WindowEvent():Wend
		SetGadgetState   (#Gadget_scroll, i)
	Next i
	
StopDrawing()


EndProcedure


Procedure peint_flocon(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
;- le pinceau flocon
; By Dobro
SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)

StartDrawing(CanvasOutput(#canvas))
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	For i=1 To nombre_de_coup_de_pinceau
		;{ ***************** NE PAS TOUCHER **********
		; ****** ne rien ajouter la dedans *****
		If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
		StopDrawing()
		ProcedureReturn
	EndIf
	If i%delay_affichage = 0
	StopDrawing()
	
	StartDrawing(CanvasOutput(#Canvas))
	EndIf
	
	If flag_bouton_on=0
		x_source=Random(largeur-1) ; lit une couleur de l'image d'origine
		y_source=Random(hauteur-1)
		Else  ; mode Dessin main 
		x_source=xx_mouse
		y_source=yy_mouse
		
	EndIf
	If x_source<0 :x_source=1:EndIf
	If x_source>1023 :x_source=1023:EndIf
	If y_source<0 :y_source=1:EndIf
	If y_source>767 :y_source=767:EndIf
	Couleur_ref=image_tab(x_source,y_source) ; recup la Couleur      
	Couleur_ref=RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)   
	; **********************************************************
	;   partir de là, on a en principe tout ce qu'il faut ..
	; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
	; les coordonées de la souris (x_source,y_source)
	;} ***********************************************************
	
	;De=Random(10)
	If Couleur_ref<RGBA(50,50,50,Transparence)
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref)/2,green(Couleur_ref)/2,blue(Couleur_ref)))
		For nb=1 To 6
			x_source2=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x*2)
			y_source2=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y*2)
			LineXY(x_source,y_source,x_source2,y_source2,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)   )
		Next nb
		
		
	EndIf
	If Couleur_ref>RGBA(49,49,49,Transparence) And Couleur_ref<RGBA(100,100,100,Transparence)
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref)/2,green(Couleur_ref),blue(Couleur_ref)))
		For nb=1 To 6
			x_source2=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x*2)
			y_source2=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y*2)
			LineXY(x_source,y_source,x_source2,y_source2,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)   )
		Next nb
	EndIf
	If Couleur_ref>RGBA(99,99,99,Transparence) And Couleur_ref<RGBA(150,150,150,Transparence)
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref),green(Couleur_ref)/2,blue(Couleur_ref)/2))
		For nb=1 To 5
			x_source2=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x*4)
			y_source2=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y*4)
			LineXY(x_source,y_source,x_source2,y_source2,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)   )
		Next nb
	EndIf
	If Couleur_ref>RGBA(149,149,149,Transparence) And Couleur_ref<RGBA(200,200,200,Transparence)
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref/2),green(Couleur_ref),blue(Couleur_ref)/2))
		For nb=1 To 2
			x_source2=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x*8)
			y_source2=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_y*8)
			LineXY(x_source,y_source,x_source2,y_source2,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)   )
		Next nb
	EndIf
	If Couleur_ref>RGBA(199,199,199,Transparence) And Couleur_ref<RGBA(255,255,255,Transparence)
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		;Circle(x_source,y_source,Taille_x,Rgb(red(Couleur_ref),green(Couleur_ref),blue(Couleur_ref)))
		For nb=1 To 8
			x_source2=x_source+Taille_x*Sin(nb*2 * 3.1415926/Taille_x*10)
			y_source2=y_source+Taille_x*Cos(nb*2 * 3.1415926/Taille_x*10)
			LineXY(x_source,y_source,x_source2,y_source2,RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)   )
		Next nb
		
	EndIf
	
	While WindowEvent():Wend
	SetGadgetState   (#Gadget_scroll, i)
Next i

StopDrawing()



EndProcedure
Procedure peint_cederavic(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2)) ; le pinceau Cederavic
	;-le pinceau Cederavic
	; By Cederavic
	;  NE PAS PRENRE CE PINCEAU COMME EXEMPLE DE CONSTUCTION DE PINCEAU
	img = CreateImage(#PB_Any, largeur,Hauteur, 32 | #PB_Image_Transparent)
	StartDrawing(CanvasOutput(#Canvas))
		img2 = GrabDrawingImage(#PB_Any, 0, 0, largeur,Hauteur)
	StopDrawing()
	StartDrawing(ImageOutput(img))
		If Phase = 1
			DrawImage(ImageID(#image_reference), 0, 0)
			Else
			DrawImage(ImageID(img2), 0, 0)
		EndIf
	StopDrawing()
	SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)
	StartDrawing(CanvasOutput(#Canvas))
		
		
		For i=1 To nombre_de_coup_de_pinceau
			If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
				
			StopDrawing()
			ProcedureReturn
		EndIf
		If i%delay_affichage = 0
		StopDrawing()
		StartDrawing(CanvasOutput(#Canvas)) : DrawingMode(#PB_2DDrawing_Default) : DrawImage(ImageID(img), 0, 0) : StopDrawing()
		
		StartDrawing(ImageOutput(img))
		EndIf
		
		DrawingMode(#PB_2DDrawing_AlphaBlend)
		; ************* ne pas toucher ***************************************
		If flag_bouton_on=0
			x_source=Random(largeur-1) ; lit une couleur de l'image d'origine
			y_source=Random(hauteur-1)
			Else ; mode Dessin main 
			x_source=xx_mouse
			y_source=yy_mouse
		EndIf
		If x_source<0 :x_source=1:EndIf
		If x_source>1023 :x_source=1023:EndIf
		If y_source<0 :y_source=1:EndIf
		If y_source>767 :y_source=767:EndIf
		; ****************************************************************
		
		maxRange.d = (1 - i / nombre_de_coup_de_pinceau) * Taille_y
		If size < 2 : size = 2 : EndIf
		
		angle.d = Random((#PI * 2) * 1000) / 1000
		angleDep.d = Random((#PI * 2) * 1000) / 100000 - ((#PI * 1000) / 100000)
		angleAdd.d = 0
		color = image_tab(x_source,y_source) ; recup la Couleur 
		
		For iRange = 1 To maxRange
			angleAdd + angleDep
			xC = x_source + Cos(angle + angleAdd) * iRange
			yC = y_source + Sin(angle + angleAdd) * iRange
			If xC >= 0 And xC <= largeur And yC >= 0 And yC <= Hauteur
				cS.d = (1 - iRange / maxRange) * Taille_x
				If cS < 1.6 : cS = 1.6 : EndIf
				cA.d = (1 - iRange / maxRange) * 4
				If cA < 1 : cA = 1 : EndIf
				
				
				r.d = Red(color) * 0.7 + Red(image_tab(xC, yC)) * 0.3
				g.d = Green(color) * 0.7 + Green(image_tab(xC, yC)) * 0.3
				b.d = Blue(color) * 0.7 + Blue(image_tab(xC, yC)) * 0.3
				
				Circle(xC, yC, cS, RGBA(r, g, b, cA))
			EndIf
		Next
		
		While WindowEvent():Wend
		SetGadgetState   (#Gadget_scroll, i)
	Next i
	
StopDrawing()


EndProcedure

Procedure peint_pointillism2(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
;- le pinceau pointillism floue
; modified by blendman

SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)

StartDrawing(CanvasOutput(#Canvas))
	
	
	If Phase = 1
		DrawImage(ImageID(#image_reference), 1, 1)
	EndIf
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	
	For i=1 To nombre_de_coup_de_pinceau
		;{ **************** Ne pas Toucher *************************************
		If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
		StopDrawing()
		ProcedureReturn
	EndIf
	If i%delay_affichage = 0
	StopDrawing()     
	StartDrawing(CanvasOutput(#Canvas))
		
	EndIf
	
	If flag_bouton_on=0
		x_source=Random(largeur-1) ; lit une couleur de l'image d'origine
		y_source=Random(hauteur-1)
		Else ; mode Dessin main 
		x_source=xx_mouse
		y_source=yy_mouse
	EndIf
	If x_source<0 :x_source=1:EndIf
	If x_source>1023 :x_source=1023:EndIf
	If y_source<0 :y_source=1:EndIf
	If y_source>767 :y_source=767:EndIf
	; ****************************************************************
	;   partir de là, on a en principe tout ce qu'il faut ..
	; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
	; les coordonées de la souris (x_source,y_source)
	;} ****************************************************************
	
	DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
	color = image_tab(x_source,y_source) ; recup la Couleur     
	
	BackColor(RGBA(Red(color),Green(color),Blue(color),30))
	FrontColor(RGBA(Red(color),Green(color),Blue(color),0))
	
	Ellipse(x_source+Taille_x,y_source+Taille_y, Taille_x/3*Random(4),Taille_y/3*Random(4))
	
	DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)
	CircularGradient(x_source+Taille_x,y_source+Taille_y, Taille_x)     
	Box(x_source,y_source,Taille_x*2,Taille_y*2)   
	While WindowEvent():Wend
	SetGadgetState   (#Gadget_scroll, i)
	
Next i 
StopDrawing()

; EndIf

EndProcedure
Procedure peint_BrosseFloue(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
	;-le pinceau Brosse Floue
	; BlendMan
	
	SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)
	
	StartDrawing(CanvasOutput(#canvas))
		;
		If phase=1
			DrawImage(ImageID(#image_reference),1,1)
		EndIf
		;;DrawingMode(#PB_2DDrawing_Alphablend)
		For i=1 To nombre_de_coup_de_pinceau
			;{ ***************** NE PAS TOUCHER **********
			; ****** ne rien ajouter la dedans *****
			If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
			StopDrawing()
			ProcedureReturn
		EndIf
		If i%delay_affichage = 0
		StopDrawing()
		
		StartDrawing(CanvasOutput(#canvas))
		EndIf
		
		If flag_bouton_on=0
			x_source=Random(largeur-1)
			y_source=Random(hauteur-1)
			phase=0
			Else  ; mode Dessin main 
			phase=0
			x_source=xx_mouse
			y_source=yy_mouse
			
		EndIf
		If x_source<0 :x_source=1:EndIf
		If x_source>1023 :x_source=1023:EndIf
		If y_source<0 :y_source=1:EndIf
		If y_source>767 :y_source=767:EndIf
		
		; **********************************************************
		;   partir de là, on a en principe tout ce qu'il faut ..
		; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
		; les coordonées de la souris (x_source,y_source)
		;} ***********************************************************
		
		DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)
		
		
		
		color = image_tab(x_source,y_source) ;  ; lit un pixel de l'image d'origine 
		
		BackColor(RGBA(Red(color),Green(color),Blue(color),Transparence))
		FrontColor(RGBA(Red(color),Green(color),Blue(color),0))
		CircularGradient(x_source,y_source, Taille_x)     
		;ellipse(x_source,y_source,Taille_x,Taille_y)   
		Box(x_source,y_source,Taille_x,Taille_y)
		
		;******* Ne pas toucher *****************************
		While WindowEvent():Wend
		SetGadgetState   (#Gadget_scroll, i)
		; ********************************************************
	Next i 
StopDrawing()

;EndIf
EndProcedure


Procedure peint_brosse(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Transparence ,Array image_tab(2))
;-Les pinceaux Brosses
; By dobro
SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)


StartDrawing(CanvasOutput(#canvas))
	
	For i=1 To nombre_de_coup_de_pinceau
		;{ ***************** NE PAS TOUCHER **********
		; ****** ne rien ajouter la dedans *****
		If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
		StopDrawing()
		ProcedureReturn
	EndIf
	If i%delay_affichage = 0
	StopDrawing()
	
	StartDrawing(CanvasOutput(#canvas))
	EndIf
	
	If flag_bouton_on=0
		x_source=Random(largeur-1) ; lit une couleur de l'image d'origine
		y_source=Random(hauteur-1)
		phase=0
		Else  ; mode Dessin main 
		phase=0
		x_source=xx_mouse
		y_source=yy_mouse
		
	EndIf
	If x_source<0 :x_source=1:EndIf
	If x_source>1023 :x_source=1023:EndIf
	If y_source<0 :y_source=1:EndIf
	If y_source>767 :y_source=767:EndIf
	Couleur_ref=image_tab(x_source,y_source) ; recup la Couleur     
	; **********************************************************
	;   partir de là, on a en principe tout ce qu'il faut ..
	; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
	; les coordonées de la souris (x_source,y_source)
	;} ***********************************************************
	
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	
	; ********************* ici vous avez le champs libre ********************************
	; ************ ne pas toucher ********************************
	
	Select Style 
		Case 12
		color_brush(#brosse_1,Couleur_ref)
		CopyImage(#brosse_1,#brosse_1_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_1_co); la copie a eu lieu
			ResizeImage(#brosse_1_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_1_co),x_source,y_source,Transparence)
		EndIf
		Case 13
		color_brush(#brosse_2,Couleur_ref)
		CopyImage(#brosse_2,#brosse_2_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_2_co); la copie a eu lieu
			ResizeImage(#brosse_2_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_2_co),x_source,y_source,Transparence)
		EndIf
		Case 14
		color_brush(#brosse_3,Couleur_ref)
		CopyImage(#brosse_3,#brosse_3_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_3_co); la copie a eu lieu
			ResizeImage(#brosse_3_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_3_co),x_source,y_source,Transparence)
		EndIf
		Case 15
		color_brush(#brosse_4,Couleur_ref)
		CopyImage(#brosse_4,#brosse_4_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_4_co); la copie a eu lieu
			ResizeImage(#brosse_4_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_4_co),x_source,y_source,Transparence)
		EndIf
		Case 16
		color_brush(#brosse_5,Couleur_ref)
		CopyImage(#brosse_5,#brosse_5_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_5_co); la copie a eu lieu
			ResizeImage(#brosse_5_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_5_co),x_source,y_source,Transparence)
		EndIf
		Case 17
		color_brush(#brosse_6,Couleur_ref)
		CopyImage(#brosse_6,#brosse_6_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_6_co); la copie a eu lieu
			ResizeImage(#brosse_6_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_6_co),x_source,y_source,Transparence)
		EndIf
		Case 18
		color_brush(#brosse_7,Couleur_ref)
		CopyImage(#brosse_7,#brosse_7_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_7_co); la copie a eu lieu
			ResizeImage(#brosse_7_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_7_co),x_source,y_source,Transparence)
		EndIf
		Case 19
		color_brush(#brosse_8,Couleur_ref)
		CopyImage(#brosse_8,#brosse_8_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_8_co); la copie a eu lieu
			ResizeImage(#brosse_8_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_8_co),x_source,y_source,Transparence)
		EndIf
		Case 20
		color_brush(#brosse_9,Couleur_ref)
		CopyImage(#brosse_9,#brosse_9_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_9_co); la copie a eu lieu
			ResizeImage(#brosse_9_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_9_co),x_source,y_source,Transparence)
		EndIf
		Case 21
		color_brush(#brosse_10,Couleur_ref)
		CopyImage(#brosse_10,#brosse_10_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_10_co); la copie a eu lieu
			ResizeImage(#brosse_10_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_10_co),x_source,y_source,Transparence)
		EndIf
		Case 22
		color_brush(#brosse_11,Couleur_ref)
		CopyImage(#brosse_11,#brosse_11_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_11_co); la copie a eu lieu
			ResizeImage(#brosse_11_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_11_co),x_source,y_source,Transparence)
		EndIf
		Case 23
		color_brush(#brosse_12,Couleur_ref)
		CopyImage(#brosse_12,#brosse_12_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_12_co); la copie a eu lieu
			ResizeImage(#brosse_12_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_12_co),x_source,y_source,Transparence)
		EndIf
		Case 24
		color_brush(#brosse_13,Couleur_ref)
		CopyImage(#brosse_13,#brosse_13_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_13_co); la copie a eu lieu
			ResizeImage(#brosse_13_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_13_co),x_source,y_source,Transparence)
		EndIf
		Case 25
		color_brush(#brosse_14,Couleur_ref)
		CopyImage(#brosse_14,#brosse_14_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_14_co); la copie a eu lieu
			ResizeImage(#brosse_14_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_14_co),x_source,y_source,Transparence)
		EndIf
		Case 26
		color_brush(#brosse_15,Couleur_ref)
		CopyImage(#brosse_15,#brosse_15_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_15_co); la copie a eu lieu
			ResizeImage(#brosse_15_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_15_co),x_source,y_source,Transparence)
		EndIf
		Case 27
		color_brush(#brosse_16,Couleur_ref)
		CopyImage(#brosse_16,#brosse_16_co) ; permet de garder l'image d'origine intact au resize
		; ***********************************************************
		If IsImage(#brosse_16_co); la copie a eu lieu
			ResizeImage(#brosse_16_co,taille_x,taille_y) ; on met le brush a la bonne taille
			DrawAlphaImage(ImageID(#brosse_16_co),x_source,y_source,Transparence)
		EndIf
	EndSelect
	
	
	
	
	
	; *******************************************************************************
	;******* Ne pas toucher *****************************
	While WindowEvent():Wend
	SetGadgetState   (#Gadget_scroll, i)
	; ********************************************************
Next i 
StopDrawing()
EndProcedure



;- *******************************************************
Procedure peint_xxxxxxxxx(largeur,Hauteur,nombre_de_coup_de_pinceau,Taille_x,Taille_y, delay_affichage, Array image_tab(2))
	;- Modele de pinceau de base .....
	SetGadgetAttribute(#Gadget_scroll, #PB_ProgressBar_Maximum, nombre_de_coup_de_pinceau)
	StartDrawing(CanvasOutput(#canvas))
		DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)
		For i=1 To nombre_de_coup_de_pinceau
			;{ ***************** NE PAS TOUCHER **********
			; ****** ne rien ajouter la dedans *****
			If GetGadgetState(#Gadget_warning)=#PB_Checkbox_Checked
			StopDrawing()
			ProcedureReturn
		EndIf
		If i%delay_affichage = 0
		StopDrawing()
		
		StartDrawing(CanvasOutput(#canvas))
		EndIf
		
		If flag_bouton_on=0
			x_source=Random(largeur-1) ; lit une couleur de l'image d'origine
			y_source=Random(hauteur-1)
			phase=0
			Else  ; mode Dessin main 
			phase=0
			x_source=xx_mouse
			y_source=yy_mouse
			
		EndIf
		If x_source<0 :x_source=1:EndIf
		If x_source>1023 :x_source=1023:EndIf
		If y_source<0 :y_source=1:EndIf
		If y_source>767 :y_source=767:EndIf
		Couleur_ref=image_tab(x_source,y_source) ; recup la Couleur   
		Couleur_ref=RGBA(Red(Couleur_ref),Green(Couleur_ref),Blue(Couleur_ref),Transparence)  ; ajoute un degres de transparence    
		; **********************************************************
		;   partir de là, on a en principe tout ce qu'il faut ..
		; la couleur du pixel de l'image sous la souris (ou les coordonées du hasard ) dans Couleur_ref
		; les coordonées de la souris (x_source,y_source)
		;} ***********************************************************
		
		
		
		; ********************* ici vous avez le champs libre ********************************
		
		
		
		
		
		
		
		
		
		
		
		; *******************************************************************************
		;******* Ne pas toucher *****************************
		While WindowEvent():Wend
		SetGadgetState   (#Gadget_scroll, i)
		; ********************************************************
	Next i 
StopDrawing()
EndProcedure





;}
;-******************************************************************
;  *************** les prefs ****************************
;-les Prefs
Procedure Write_preference()
If CreatePreferences("Pure_autopaint.prefs")
	PreferenceGroup("Info")
	WritePreferenceString("ApplicationName", "Pure_autopaint")
	WritePreferenceString("Version", "1.00")
	
	PreferenceGroup("Window")
	
	PreferenceComment(" Les Window dimensions")
	PreferenceComment("")
	WritePreferenceLong ("WindowX", WindowX(#window))
	WritePreferenceLong ("WindowY", WindowY(#window))
	WritePreferenceLong ("WindowX_larg", WindowWidth(#window))
	WritePreferenceLong ("WindowY_haut", WindowHeight(#window))
	PreferenceGroup("Path")
	WritePreferenceString("chemin image", File_image$)
	ClosePreferences()
EndIf
EndProcedure

Procedure Read_preference()
Shared win_x,win_y,File_image$
If OpenPreferences("Pure_autopaint.prefs")
	PreferenceGroup("Info")
	ReadPreferenceString("ApplicationName", "")
	ReadPreferenceString("Version", "")
	
	PreferenceGroup("Window")
	win_x=ReadPreferenceLong ("WindowX", 0)
	win_y=ReadPreferenceLong ("WindowY", 0)
	larg_fenetre=ReadPreferenceLong ("WindowX_larg", 800)
	haut_fenetre=ReadPreferenceLong ("WindowY_haut", 600)
	PreferenceGroup("Path")
	File_image$=ReadPreferenceString("chemin image", "c:\")
	ClosePreferences()
EndIf
EndProcedure

Procedure annule()
; By Dobro
If StartDrawing(CanvasOutput(#canvas))
	If GrabDrawingImage(#image_annule, 0, 0, 1024, 768)
	EndIf
StopDrawing()
EndIf
EndProcedure
Procedure color_brush(image,couleur)
	; By Dobro
	;colorise l'image du Brush
StopDrawing() ; on quitte le mode Canvas
StartDrawing(ImageOutput(image))
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	
	For iyy=0 To 128-1
		For ixx=0 To 128-1
			cc=Point(ixx,iyy)
			;debug str(red(cc))+" "+str(green(cc))+" "+str(blue(cc))+" "+str(Alpha(Cc) )²
			If Alpha(cc)<>0
				Plot (ixx,iyy,RGBA(Red(couleur),Green(couleur),Blue(couleur),Alpha(cc)))
			EndIf
			
		Next ixx
	Next iyy
StopDrawing()
StartDrawing(CanvasOutput(#canvas)) ; on retourne dans le mode Canvas
EndProcedure

Procedure MyWindowCallback(WindowID, Message, wParam, lParam)
	Result = #PB_ProcessPureBasicEvents
	Select Message
		Case #WM_LBUTTONUP
		Flag_bouton_on=0
		
		; Case #WT_PACKET
		; ;-tablette_boucle
		; WTPacket(lParam,wParam, @pkt.PACKET)
		; if MulDiv_(pkt\pkZ ,1024,10000)=0 and pkt\pkButtons=0; si le Stylet est trop loin, et qu'il ,ne touche pas la tablette ,on desactive la reconnaisance de la tablette
		; tablette=#False
		; else
		; ;xx_mouse=MulDiv_(pkt\pkX,1024,10000) ; recup les coordonées
		; ;yy_mouse=768-MulDiv_(pkt\pkY,768,10000);; recup les coordonées
		; ;;;;;taille_pinceau=pkt\pkNormalPressure / 30+5
		; tablette=#True
		; Endif
		; 
		
		
		
	EndSelect  
	ProcedureReturn Result
EndProcedure




; 



; 



; 



; 



; 



; 



; 



; 





; 



; 



; 



; 



; 



; 

;-DATASECTION
DataSection
  Vermicelles: 
  IncludeBinary "Icone_brush\Vermicelles.png"
  reel: 
  IncludeBinary "Icone_brush\reel.png"
  pop_art: 
  IncludeBinary "Icone_brush\pop_art.png"
  pointillism_floue: 
  IncludeBinary "Icone_brush\pointillism_floue.png"
  pointillism: 
  IncludeBinary "Icone_brush\pointillism.png"
  impress: 
  IncludeBinary "Icone_brush\impress.png"
  flocon: 
  IncludeBinary "Icone_brush\flocon.png"
  croix_creuse: 
  IncludeBinary "Icone_brush\croix_creuse.png"
  croix: 
  IncludeBinary "Icone_brush\croix.png"
  cederavic: 
  IncludeBinary "Icone_brush\cederavic.png"
  aquarelle: 
  IncludeBinary "Icone_brush\aquarelle.png"
  Brosse_floue: 
  IncludeBinary "Icone_brush\brosse_floue.png"
  Brush1:
  IncludeBinary "Icone_brush\brosse_1.png"
  Brush2:
  IncludeBinary "Icone_brush\brosse_2.png"
  Brush3:
  IncludeBinary "Icone_brush\brosse_3.png"
  Brush4:
  IncludeBinary "Icone_brush\brosse_4.png"
  Brush5:
  IncludeBinary "Icone_brush\brosse_5.png"
  Brush6:
  IncludeBinary "Icone_brush\brosse_6.png"
  Brush7:
  IncludeBinary "Icone_brush\brosse_7.png"
  Brush8:
  IncludeBinary "Icone_brush\brosse_8.png"
  Brush9:
  IncludeBinary "Icone_brush\brosse_9.png"
  Brush10:
  IncludeBinary "Icone_brush\brosse_10.png"
  Brush11:
  IncludeBinary "Icone_brush\brosse_11.png"
  Brush12:
  IncludeBinary "Icone_brush\brosse_12.png"
  Brush13:
  IncludeBinary "Icone_brush\brosse_13.png"
  Brush14:
  IncludeBinary "Icone_brush\brosse_14.png"
  Brush15:
  IncludeBinary "Icone_brush\brosse_15.png"
  Brush16:
  IncludeBinary "Icone_brush\brosse_16.png"
EndDataSection

; EPB

; 
; EPB 

; IDE Options = PureBasic 6.10 LTS (Windows - x64)
; CursorPosition = 3543
; FirstLine = 3520
; Folding = ------------
; EnableXP
; DPIAware
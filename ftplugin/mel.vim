" Mel syntax file
" Language   : Mel (mel)
" Maintainer : John E. Dietz
" Last change: June 1, 2000
"
"add the line below to your .vimrc:
":au BufNewFile,BufReadPost *.mel source  ~/vim/syntax/mel.vim

"and put this file in: ~/vim/syntax/mel.vim


syn clear

" Strings Handeling (stolen from csh stuff) -------------------------------
syntax match   pshNoEndlineDQ	contained "[^\"]\(\\\\\)*$"
syntax match   pshNoEndlineSQ	contained "[^\']\(\\\\\)*$"
syntax match   pshNoEndlineBQ	contained "[^\`]\(\\\\\)*$"

syntax region  pshDblQuote      start=+[^\\]"+hs=s+1 skip=+\\\\\|\\"+ end=+"+	contains=pshNoEndlineDQ,pshBckQuote
syntax region  pshSnglQuote	start=+[^\\]'+hs=s+1 skip=+\\\\\|\\'+ end=+'+	contains=pshNoEndlineSQ
syntax region  pshBckQuote      start=+[^\\]`+hs=s+1 skip=+\\\\\|\\`+ end=+`+	contains=pshNoEndlineBQ
syntax region  pshDblQuote      start=+^"+           skip=+\\\\\|\\"+ end=+"+	contains=pshNoEndlineDQ
syntax region  pshSnglQuote	start=+^'+           skip=+\\\\\|\\'+ end=+'+	contains=pshNoEndlineSQ
syntax region  pshBckQuote      start=+^`+           skip=+\\\\\|\\`+ end=+`+	contains=pshNoEndlineBQ
" Modifiable Variables without {}
syn match cshExtVar	"\$[a-zA-Z_][a-zA-Z0-9_]*"	
syn match cshSelector	"\$[a-zA-Z_][a-zA-Z0-9_]*\[[a-zA-Z_]\+\]"
syn match cshQtyWord	"\$\?[a-zA-Z_][a-zA-Z0-9_]*"	
syn match cshArgv	"\$[0-9]"		
syn match cshArgv	"\$\*"
		
syn match flagExtVar	"\-[a-zA-Z_][a-zA-Z0-9_]*"	
syn match flagSelector	"\-[a-zA-Z_][a-zA-Z0-9_]*\[[a-zA-Z_]\+\]"
syn match flagQtyWord	"\-\?[a-zA-Z_][a-zA-Z0-9_]*"	
syn match flagArgv	"\-[0-9]"		
syn match flagArgv	"\-\*"

" Modifiable Variables with {}
syn match cshExtVar	"\${[a-zA-Z_][a-zA-Z0-9_]*}"
syn match cshSelector	"\${[a-zA-Z_][a-zA-Z0-9_]*\[[a-zA-Z_]\+\]}"
syn match cshQtyWord	"\${\?[a-zA-Z_][a-zA-Z0-9_]*}"	
syn match cshArgv	"\${[0-9]}"

" Array []
syn match melArrayVarExtVar	    "\[\$[a-zA-Z_][a-zA-Z0-9_]*\]"
syn match melArrayVarSelector	"\[\$[a-zA-Z_][a-zA-Z0-9_]*\[[a-zA-Z_]\+\]\]"
syn match melArrayVarQtyWord	"\[\$\?[a-zA-Z_][a-zA-Z0-9_]*\]"	
syn match melArrayVarArgv	    "\[\$[0-9]\]"
syn match melArrayExtVar	"\[[a-zA-Z_][a-zA-Z0-9_]*\]"
syn match melArraySelector	"\[[a-zA-Z_][a-zA-Z0-9_]*\[[a-zA-Z_]\+\]\]"
syn match melArrayQtyWord	"\[\?[a-zA-Z_][a-zA-Z0-9_]*\]"	
syn match melArrayArgv	    "\[[0-9]\]"
" Highlight special characters (those which have a backslash) differently-
syntax match   pshSpecial       contained "\\[0-9][0-9][0-9]\|\\[abcfnrtv\\]"
syntax match   pshNumber        "-\=\<[0-9]\+\>"

" Mel Highlighting ---------------------------------------------------
syntax keyword melCommand break case continue default do else false float 
syntax keyword melCommand for global if in int matrix no off on proc return  
syntax keyword melCommand string switch true vector while yes setAttr boolean   
   

syntax keyword melFunction about abs addAttr addDynamic addPP affectedNet aimConstraint 
syntax keyword melFunction air alias aliasAttr alignCurve alignSurface ambientLight   

syntax keyword melFunction angle angleBetween animCurveEditor animDisplay animView  
syntax keyword melFunction applyTake arcCtx arcLenDimContext arcLengthDimension arclen 
syntax keyword melFunction arrayMapper assignCommand assignInputDevice attachCurve attachDeviceAttr
syntax keyword melFunction attachSurface attrColorSliderGrp attrCompatibility attrEnumOptionMenu 
syntax keyword melFunction attrEnumOptionMenuGrp attrFieldGrp attrFieldSliderGrp attrNavigationControlGrp 
syntax keyword melFunction attrPaintCtx attributeMenu attributeQuery autoKeyframe autoPlace  
syntax keyword melFunction bakeResults bakeSimulation batchRender bessel bevel bindPose bindSkin  
syntax keyword melFunction blend2 blendShape blendShapeEditor blendShapePanel blendTwoAttr blindDataType 
syntax keyword melFunction boneLattice boundary boxDollyCtx boxZoomCtx bufferCurve buildBookmarkMenu 
syntax keyword melFunction buildKeyframeMenu button buttonManip 
syntax keyword melFunction camera cameraView canCreateManip canvas catch ceil changeSubdivComponentDisplayLevel 
syntax keyword melFunction changeSubdivRegion channelBox character chdir checkBox checkBoxGrp choice 
syntax keyword melFunction circle circularFillet clamp clear clearCache closeCurve closeSurface  
syntax keyword melFunction cluster cmdShell collision color colorEditor colorIndex colorIndexSliderGrp 
syntax keyword melFunction colorSliderButtonGrp colorSliderGrp columnLayout commandEcho commandLine 
syntax keyword melFunction commandPort commonPaintCtx componentEditor condition cone confirmDialog connectAttr 
syntax keyword melFunction connectControl connectDynamic connectJoint connectionInfo constrain constrainValue
syntax keyword melFunction constructionHistory contextInfo control convertSolidTx convertUnit copyFlexor 
syntax keyword melFunction copyKey cos cpButton cpCollision cpConstraint cpPanel cpProperty cpSeam 
syntax keyword melFunction cpSolver cpTool createDisplayLayer createDrawCtx createEditor createNode 
syntax keyword melFunction createSubdivRegion cross ctxAbort ctxCompletion ctxEditMode ctxTraverse currentCtx 
syntax keyword melFunction currentTime currentTimeCtx currentUnit curve curveAddPtCtx curveCVCtx curveEPCtx 
syntax keyword melFunction curveEditorCtx curveIntersect curveMoveEPCtx curveOnSurface curveSketchCtx 
syntax keyword melFunction cutKey cycleCheck cylinder 


syntax keyword melFunction dagObjectHit directKeyCtx dopeSheetEditor dagPose directionalLight dot defaultNavigation dirmap doubleProfileBirailSurface defineDataServer disable drag defineEditor disconnectAttr draggerContext defineEditorTemplate disconnectJoint dropoffLocator defineVirtualDevice displacementToPoly duplicate deformer displayAffected duplicateCurve deg_to_rad displayColor dynCache delete displayCull dynControl deleteAttr displayLevelOfDetail dynExport deleteUI displayPref dynExpression detachCurve displayRGBColor dynGlobals detachDeviceAttr displaySmoothness dynPaintEditor detachSurface displayStats dynParticleCtx devicePanel displaySurface dynPrefAction dgInfo distanceDimContext dynRelEdPanel dgPerformance distanceDimension dynRelEditor dgdirty doBlur dynamicLoad dgeval dolly dimWhen dollyCtx e editDisplayLayerGlobals encodeString exclusiveLightCheckBox editDisplayLayerMembers env exists editor erf exp editorTemplate error expression effector eval expressionEditorListen emit evalDeferred extendCurve emitter evalEcho extendSurface enableDevice event extrude f fclose findKeyframe flushUndo feof finder fmod fflush fitBspline fopen fgetline flexor formLayout fgetword floatField fprint file floatFieldGrp frameLayout fileBrowserDialog floatScrollBar fread fileDialog floatSlider freeFormFillet filetest floatSliderButtonGrp frewind filletCurve floatSliderGrp fwrite filter floor filterExpand flow g gamma getPanel grabColor gauss getParticleAttr graphDollyCtx geometryConstraint getenv graphSelectContext getAttr getpid graphTrackCtx getClassification glRender gravity getDefaultBrush glRenderEditor grid getFileList globalStitch gridLayout getInputDeviceRange gmatch group getModifiers goal h handleRotateCtx hermite hsv_to_rgb hardenPointCurve hide hyperGraph hardware hilite hyperPanel hardwareRenderPanel hotBox hyperShade help hotkey hypot helpLine hotkeyCheck 
syntax keyword melFunction iconTextButton image intSlider iconTextCheckBox imageWindowEditor intSliderGrp iconTextRadioButton inheritTransform internalVar iconTextRadioCollection insertJoint intersect iconTextStaticLabel insertJointCtx iprEngine ikHandle insertKeyCtx isConnected ikHandleCtx insertKnotCurve isDirty ikHandleDisplayScale insertKnotSurface isTrue ikSolver instance itemFilter ikSplineHandleCtx instancer itemFilterAttr ikSplineManipCtx intField itemFilterRender ikSystem intFieldGrp itemFilterType ikSystemInfo intScrollBar j joint jointCtx jointLattice jointCluster jointDisplayScale k keyTangent keyframeRegionDollyCtx keyframeRegionSetKeyCtx keyframe keyframeRegionInsertKeyCtx keyframeRegionTrackCtx keyframeOutliner keyframeRegionMoveKeyCtx keyframeStats keyframeRegionCurrentTimeCtx keyframeRegionScaleKeyCtx keyframeRegionDirectKeyCtx keyframeRegionSelectKeyCtx 
syntax keyword melFunction lattice listAttr listSets layerButton listCameras listerEditor layeredShaderPort listConnections loadPlugin layout listDeviceAttachments loadPrefObjects lightList listHistory loft lightListEditor listInputDeviceAxes log lightListPanel listInputDeviceButtons lookThru lightlink listInputDevices ls linstep listNodeTypes lsThroughFilter listAnimatable listRelatives lsUI m mag marker mirrorJoint makeIdentity match modelCurrentTimeCtx makeLive max modelEditor makebot memory modelPanel manipMoveContext menu movIn manipMoveLimitsCtx menuBarLayout movOut manipOptions menuEditor move manipRotateContext menuItem moveKeyCtx manipRotateLimitsCtx messageLine moveVertexAlongDirection manipScaleContext min multiProfileBirailSurface manipScaleLimitsCtx minimizeApp 
syntax keyword melFunction nameCommand nodeOutliner nurbsCube nameField nodeType nurbsPlane namespace noise nurbsSquare namespaceInfo nonLinear nurbsToPoly newPanelItems normalConstraint nurbsToPolygonsPref newton nurbsBoolean nurbsToSubdiv o objExists openMayaPref orientConstraint objectCenter optionMenu outlinerEditor objectType optionMenuGrp outlinerPanel objectTypeUI optionVar overrideModifier offsetCurve orbit offsetCurveOnSurface orbitCtx 
syntax keyword melFunction palettePort polyBoolOp polyProjection paneLayout polyChipOff polyQuad panel polyClipboard polyQueryBlindData panelConfiguration polyCloseBorder polyReduce panelHistory polyCollapseEdge polySelectConstraint paramDimContext polyCollapseFacet polySelectConstraintMonitor paramDimension polyColorBlindData polySeparate paramLocator polyColorPerVertex polySetToFaceNormal parent polyCone polySewEdge particle polyCreateFacet polySmooth particleExists polyCube polySoftEdge particleInstancer polyCylinder polySphere particleRenderInfo polyCylindricalProjection polySphericalProjection partition polyDelEdge polySplit pasteKey polyDelFacet polySubdivideEdge pathAnimation polyDelVertex polySubdivideFacet pause polyEditUV polySuperCtx pclose polyEvaluate polyToSubdiv percent polyExtrudeFacet polyTorus performanceOptions polyFlipEdge polyTriangulate pickWalk polyForceUV polyUnite picture polyGeoSampler popen pixelMove polyInstallAction popupMenu planarSrf polyListComponentConversion pow plane polyMapCut print play polyMapDel projFileViewer playbackOptions polyMapSew projectCurve playblast
syntax keyword melFunction polyMergeEdge projectLight pluginInfo polyMergeFacet projectLightEditor pointConstraint polyMergeVertex projectTangent pointCurveConstraint polyMoveEdge projectionContext pointLight polyMoveFacet projectionManip pointOnCurve polyMoveFacetUV promptDialog pointOnSurface polyMoveUV propModCtx pointPosition polyMoveVertex propMove poleVectorConstraint polyNormal putenv polyAppend polyNormalPerVertex puttyCtx polyAverageNormal polyOptions pwd polyBevel polyPlanarProjection polyBlindData polyPlane q querySubdiv quit 
syntax keyword melFunction rad_to_deg reloadImage resetTool radial removeJoint resolutionNode radioButton rename reverseCurve radioButtonGrp renameUI reverseSurface radioCollection render revolve radioMenuItemCollection renderGlobalsNode rgb_to_hsv rampColorPort renderInfo rigidBody rand renderManip rigidSolver rangeControl renderPartition roll readTake renderQualityNode rollCtx rebuildCurve renderThumbnailUpdate rot rebuildSurface renderWindowEditor rotate recordAttr renderWindowSelectContext roundConstantRadius recordDevice reorder 
syntax keyword melFunction rowColumnLayout redo reorderDeformers rowLayout refineSubdivSelectionList requires runup refresh reroot s sampleImage setDrivenKeyframe smoothstep saveAllShelves setDynamic snapKey saveImage setEditCtx snapMode saveInitialState setEditPaintCtx snapshot saveMenu setEditor soft savePrefObjects setEscapeCtx sort savePrefs setFocus sound saveShelf setInfinity soundControl saveToolSettings setInputDeviceMapping workspace source scale
syntax keyword melFunction scale setKeyCtx spaceLocator scaleConstraint setKeyPath sphere scaleKey setKeyframe sphrand scaleKeyCtx setNodeTypeFlag spotLight sceneUIReplacement setParent spotLightPreviewPort sceneViewer setParticleAttr spreadSheetEditor scriptCtx setStartupMessage spring scriptJob setToolTo sqrt scriptNode setUITemplate squareSurface scriptTable sets srtContext scriptedPanel shadingConnection stackTrace scriptedPanelType shadingGeometryRelCtx stitchSurface scrollField shadingGroupDialogDaemon stitchSurfacePoints scrollLayout shadingLightRelCtx strcmp sculpt shadingNode stringArrayIntersector seed shelfButton stroke select shelfLayout subdToPoly selectContext shelfTabLayout subdivCrease selectKey shellField subdivDisplaySmoothness selectKeyCtx showHidden substitute selectMode showManipCtx substring selectPaintCtx showSelectionInTitle superCtx selectPref showShadingGroupAttrEditor surface selectPriority showWindow surfacePaintCtx selectType sign surfaceShaderList selectedLine 
syntax  keyword melFunction simplify swatchDisplayPort selectedNodes sin switchTable selectionConnection singleProfileBirailSurface symbolButton separator size symbolCheckBox setAttr skinCluster sysFile setAttrMapping skinPercent system setDefaultShadingGroup smoothCurve t tabLayout textureWindow toolPropertyWindow tan threePointArcCtx torus tangentConstraint timeControl toupper texManipContext timePort trace texMoveContext timer track texRotateContext timerX trackCtx texScaleContext toggle transformLimits texSelectContext toggleAxis translator texWinToolCtx toggleWindowVisibility trim text tokenize trunc textCurves tolerance tumble textField tolower tumbleCtx textFieldButtonGrp toolButton turbulence textFieldGrp toolCollection twoPointArcCtx textScrollList toolDropped texturePlacementContext toolHasOptions u uiTemplate ungroup untrim unassignInputDevice uniform upAxis undo unit userCtx undoInfo unloadPlugin userPaintCtx v valuePaintCtx viewFit viewSet view2dToolCtx viewHeadOn visor viewCamera viewLookAt vortex viewClipPlane viewPlace w waitCursor windowPref wrinkle warning wire wrinkleContext whatIs wireContext writeTake window workspace wtPaintCtx x xform 


" Comments ----------------------------------------------------------------
syntax region  pshComment       start="/\*" end = "\*/"
syntax region  pshComment       start="#"  end = "$"
syntax region  pshComment       start="//"  end = "$"
"syntax region  melBracket       start="{"  end = "[.][/n]" 
"syntax region  melBracket       start="}"  end = "[.][/n]" 
syntax match  melBracket  "{"      
syntax match  melBracket  "}"      
syntax match  melSemiColon  ";" 



if !exists("did_psh_syntax_inits")
  let did_psh_syntax_inits = 1

  hi link melCommand        Command
  hi link melFunction       Function  
  hi link pshBckQuote	        Statement
  hi link pshDblQuote	        String
  hi link pshNoEndlineBQ	Error
  hi link pshNoEndlineDQ	Error
  hi link pshNoEndlineSQ	Error
  hi link pshSnglQuote	        String
  hi link pshNoEndline	        Error
  hi link pshNumber	        Number
  hi link pshRedir	        Statement
  hi link pshRepeat	        Repeat
  hi link pshShellVariables	Special
  hi link pshSpecial	        Special
  hi link pshString	        String

  hi link melEquals         Statement
  hi link pshComment            Comment



  hi link cshArgv	cshVariables
  hi link cshExtVar	cshVariables
  hi link cshQtyWord	cshVariables
  hi link cshSelector	cshVariables
  hi link cshVariables	Type

  hi link flagArgv	flagVariables
  hi link flagExtVar	flagVariables
  hi link flagQtyWord	flagVariables
  hi link flagSelector	flagVariables
  hi link flagVariables	Flag
  hi link melBracket	Repeat


  hi link melArrayArgv	    melArray
  hi link melArrayExtVar	melArray
  hi link melArrayQtyWord	melArray
  hi link melArraySelector	melArray
  hi link melArrayVarArgv	    melArray
  hi link melArrayVarExtVar	melArray
  hi link melArrayVarQtyWord	melArray
  hi link melArrayVarSelector	melArray

  hi link melArray Array

  hi link melSemiColon SemiColon

endif



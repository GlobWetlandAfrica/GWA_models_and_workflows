.NAME:2:Water Quality Assessment
.GROUP:PG#4:Water Quality
.ALGORITHM:beam:fub.water
.PARAMETERS:{"computeCHL": true, "checkWhetherSuspectIsValid": true, "computeAtmCorr": true, "computeYS": true, "computeTSM": true, "expression": "not l1_flags.GLINT_RISK and not l1_flags.BRIGHT and not l1_flags.INVALID and not l1_flags.SUSPECT"}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:11pt; font-weight:600;">Step1: FUB/WeW Water Processor</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Input:</span><span style=" font-size:10pt; font-weight:600;"> </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">MERIS Level 1 FR or RR product including pixel classification in BEAM DIMAP format (output of step 2 preprocessing).</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Output:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Water quality indicators in GeoTiff format</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Description:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">This step performes water quality analysis based on FUB/WeW processor.</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:beam:meris.mph
.PARAMETERS:{"validPixelExpression": "not (l1_flags.LAND_OCEAN or l1_flags.INVALID)", "cyanoMaxValue": 1000, "exportMph": false, "chlThreshForFloatFlag": 350}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:11pt; font-weight:600;">Step2: MPH Processor</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Input:</span><span style=" font-size:10pt; font-weight:600;"> </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Rayleigh corrected MERIS Level 1 FR product including pixel classification in BEAM DIMAP format (output of step 4 preprocessing).</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Output:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Water quality indicators in GeoTiff format</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Description:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">This step performes water quality analysis based on MPH processor.</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:beam:coastcolour.l2w
.PARAMETERS:{"ccCloudScreeningSure": 1.8, "useExtremeCaseMode": true, "ccIgnoreSeaIceClimatology": false, "outputAOT550": false, "useSnTMap": true, "doSmile": true, "landExpression": "l1p_flags.CC_LAND", "outputL2WReflecAs": 0, "ccCloudBufferWidth": 2, "doEqualization": true, "ccGlintCloudThresholdAddition": 0.1, "cloudIceExpression": "(l1p_flags.CC_CLOUD && not l1p_flags.CC_CLOUD_AMBIGUOUS) || l1p_flags.CC_SNOW_ICE", "averageTemperature": 15, "invalidPixelExpression": "l2r_flags.INPUT_INVALID", "ccCloudScreeningAmbiguous": 1.4, "averageSalinity": 35, "outputReflec": false, "doCalibration": false, "owtType": 0, "outputKdSpectrum": true}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:11pt; font-weight:600;">Step3: CoastColour In-Water Processor</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Input:</span><span style=" font-size:10pt; font-weight:600;"> </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Atmospheric corrected MERIS Level 1 FR product including pixel classification in BEAM DIMAP format (output of step 3 preprocessing).</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Output:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Water quality indicators in GeoTiff format</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Description:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">This step performes water quality analysis based on CC In-Water processor.</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:beam:owtclassification
.PARAMETERS:{"inputReflectanceIs": 0, "writeInputReflectances": false, "reflectancesPrefix": "reflec", "owtType": 0}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:11pt; font-weight:600;">Step4: OWT Classification</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Input:</span><span style=" font-size:10pt; font-weight:600;"> </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Atmospheric corrected MERIS Level 1 FR product including pixel classification in BEAM DIMAP format (output of step 3 preprocessing).</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Output:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">OWT classification in GeoTiff format</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt; font-weight:600; text-decoration: underline;">Description:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">This step performes an OWT classification.</span></p></body></html>
!INSTRUCTIONS

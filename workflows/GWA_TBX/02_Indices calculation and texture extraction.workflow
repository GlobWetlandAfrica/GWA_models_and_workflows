.NAME:Indices calculation and texture extraction
.GROUP:PG#2:Wetland Habitat Mapping
.ALGORITHM:script:sentinel2indiceswhm
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><a name="OLE_LINK20"></a><span style=" font-family:'Arial'; font-size:9pt;">T</span><span style=" font-family:'Arial'; font-size:9pt;">his tool calculates 5 spectral indices which are useful for wetland habitat mapping using Sentinel-2 imagery.</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;"> </span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">The 5 indices that are calculated are:</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 1: NDVI using S2 bands 8 and 4</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 2: Red Edge NDI using S2 bands 8a and 5</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 3: Red Edge NDI using S2 bands 7 and 5</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 4: mNDWI using S2 bands 3 and 11</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 5: DVW (NDVI-NDWI) using S2 bands 8 and 4 as well as 3 and 8</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;"> </span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input Reflectance Stack: Input pre-processed image</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Folder to save the stack of Indices: Use the ... button to navigate to the folder where you want to save the indices.</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:script:landsat8indices
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><a name="OLE_LINK24"></a><span style=" font-family:'Arial'; font-size:9pt;">T</span><span style=" font-family:'Arial'; font-size:9pt;">his tool calculates 6 spectral indices which are useful for wetland habitat mapping using Landsat imagery (</span><a name="OLE_LINK10"></a><span style=" font-family:'Arial'; font-size:9pt;">s</span><span style=" font-family:'Arial'; font-size:9pt;">kip this step if you’re using Sentinel-2 data).</span><span style=" font-family:'Arial'; font-size:8pt;"> </span><span style=" font-family:'Arial'; font-size:9pt;"> </span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">The 6 indices that are calculated are:</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style="-qt-paragraph-type:empty; margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:8pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><a name="OLE_LINK3"></a><span style=" font-family:'Arial'; font-size:9pt;">B</span><span style=" font-family:'Arial'; font-size:9pt;">and 1: NDVI using S2 bands 4 and 3</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 2: mNDWI using S2 bands 2 and 5</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 3: DVW (NDVI-NDWI) using S2 bands 4 and 3 as well as 2 and 4</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 4: Tasseled cap brightness index</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 5: Tasseled cap greenness index</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Band 6: Tasseled cap wetness index</span><span style=" font-family:'Arial'; font-size:8pt;">  </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input Reflectance Stack: Input pre-processed image</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Folder to save the stack of Indices: Use the ... button to navigate to the folder where you want to save the indices.</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:r:whmndvistatistics
.PARAMETERS:{"Range ": true, "StandardDeviation ": false, "satellite ": 0, "Minimum ": true, "Maximum ": true, "Mean ": true}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><a name="OLE_LINK22"></a><span style=" font-family:'Arial'; font-size:9pt;">T</span><span style=" font-family:'Arial'; font-size:9pt;">his tool calculates multi-temporal NDVI features (mean, maximum, minimum, range and standard deviation) derived from time-series Sentinel-2 or Landsat imagery. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Directory containing multitemporal iamges: Select the folder that contains Sentinel-2/Landsat images over a number of dates.</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Note: the folder should contain only TIF files;  Sentinel-2 image should have 10 bands (with 10m and 20m resolutions); Landsat image should have 6 bands (Green, Blue, Red, NIR, SWIR1, SWIR2).</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:9pt;">satellite: select the satellite type (Sentinel-2 or Landsat) of the imagery</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:9pt;">Select the features (mean, maximum, minimum, range, standard deviation) to be calculated.</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Output_NDVI statistics: Define the output directory and image name. The output image name should be called [‘enter name’]_NDVIstats.tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:modeler:pca texture
.PARAMETERS:{"radius": 11}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><a name="OLE_LINK28"></a><span style=" font-family:'Arial'; font-size:9pt;">T</span><span style=" font-family:'Arial'; font-size:9pt;">his tool first implements a principal component analysis and uses the first component to calculate 5 Haralick texture features: Energy, Entropy, Inverse Difference Moment, Inertia and Haralick Correlation.</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:8pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings:</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input image: Select the pre-processed image</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Radius: The default is ‘11’ for Sentinel-2 data but change this to ‘4’ if Landsat data are used.</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Texture features: Define the output directory and image name. The output image name should be called [‘enter name’]_texture.tif</span></p></body></html>
!INSTRUCTIONS

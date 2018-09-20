.NAME:1: Indices calculation and texture extraction
.GROUP:PG#2:Wetland Habitat Mapping
.ALGORITHM:script:vegetationandwaterindiceswhm
.PARAMETERS:{"sat": 0}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><a name="OLE_LINK2"></a><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">T</span><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">his tool calculates spectral indices which are useful for wetland habitat mapping using Sentinel-2 (S2) or Landsat imagery.</span> </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">For Sentinel-2 imagery, 5 indices are calculated :</span> </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 1: NDVI using S2 bands 8 and 4 </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 2: Red Edge NDI using S2 bands 8a and 5 </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 3: Red Edge NDI using S2 bands 7 and 5 </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 4: mNDWI using S2 bands 3 and 11 </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 5: DVW (NDVI-NDWI) using S2 bands 8 and 4 as well as 3 and 8 </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;"> </span> </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">For Landsat imagery, 6 indices are calculated:</span> </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><a name="OLE_LINK3"></a><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">L</span><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">ayer 1: NDVI using Landsat bands 4 and 3 </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 2: mNDWI using Landsat bands 2 and 5 </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 3: DVW (NDVI-NDWI) using Landsat bands 4 and 3 as well as 2 and 4 </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 4: Tasseled Cap brightness index </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 5: Tasseled Cap greenness index </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 6: Tasseled Cap wetness index </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">  </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings:</span> </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Input Reflectance Stack: Input pre-processed image </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial,sans-serif'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Satellite: </span><span style=" font-family:'MS Shell Dlg 2,sans-serif'; font-size:9pt;">select the satellite type (Sentinel-2 or Landsat) of the imagery</span> </p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Folder to save the stack of Indices: Use the ... button to navigate to the folder where you want to save the indices.</span> </p></body></html>
!INSTRUCTIONS
.ALGORITHM:r:whmndvistatistics
.PARAMETERS:{"Range ": true, "StandardDeviation ": true, "satellite ": 0, "Minimum ": true, "Maximum ": true, "Mean ": true}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This tool calculates multi-temporal NDVI features (mean, maximum, minimum, range and standard deviation) derived from time-series Sentinel-2 or Landsat imagery. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Directory containing multi-temporal images: Select the folder that contains Sentinel-2/Landsat images over a number of dates.</span> </p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Note: the folder should contain only TIF files;  Sentinel-2 image should have 10 bands (2-8, 8a,11 and 12); Landsat image should have 6 bands (Green, Blue, Red, NIR, SWIR1, SWIR2). Note: Do not have Landsat and Sentinel-2 files in the same folder</span> </p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">satellite: select the satellite type (Sentinel-2 or Landsat) of the imagery</span> </p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Select the features (mean, maximum, minimum, range, standard deviation) to be calculated. If only two images are used, select mean and range.</span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Output_NDVI statistics: Define the output directory and image name. The output image name can be called [‘enter name’]_NDVIstats.tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:modeler:pca texture
.PARAMETERS:{"radius": 11}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This tool first implements a Principal Component Analysis and uses the first principal component to calculate 5 Haralick texture features: </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 1: Energy (texture uniformity)</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 2: Entropy (measure of randomness of intensity image) </span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 3:Inverse Difference Moment (measure of texture homogeneity)</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 4: Inertia (intensity contrast between a pixel and its neighborhood)</span>  </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Layer 5: Haralick Correlation</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"> <span style=" font-family:'Arial,sans-serif'; font-size:9pt;"> </span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings:</span><span style=" font-family:'Arial,sans-serif'; font-size:8pt;"> </span></p>
<p style="-qt-paragraph-type:empty; margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial,sans-serif'; font-size:8pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Input image: Select the pre-processed image</span><span style=" font-family:'Arial,sans-serif'; font-size:8pt;"> (same as for Step 1)</span> </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Radius: The default is ‘11’ for Sentinel-2 data but change this to ‘4’ if Landsat data are used.</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:8pt;"> </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Texture features: Define the output directory and image name. The output image name can be called [‘enter name’]_texture.tif</span></p></body></html>
!INSTRUCTIONS

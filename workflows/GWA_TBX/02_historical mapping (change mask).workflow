.NAME:4: Wetland habitat historical mapping (with change mask)
.GROUP:PG#2:Wetland Habitat Mapping
.ALGORITHM:otb:superimposesensor
.PARAMETERS:{"-interpolator": 0, "-mode": 0, "-ram": 512, "-interpolator.bco.radius": 2, "-lms": 4, "-elev.default": 0}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This application detects change between two given multi-spectral images based on Multivariate Alteration Detection (MAD), and Maximum Autocorrelation Factor (MAF) analyses.</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;"> </span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This step is optional. It performs the projection of an image into the geometry of another one (matching the spatial resolution and extent of two images). When both Landsat and Sentinel-2 images are used to do change detection using MAD/MAF, this tool will resample the 30m Landsat image to 10m as the resolution of the Sentinel-2 image and match the extent of the Sentinel-2 image, or vice versa. Skip this step if two images with the same resolution and extent are used for change detection.</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;"> </span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings:</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Reference input: select one image used for change detection that you would like to keep its resolution.</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">The image to reproject: select the other image used for change detection that needs reprojection to the reference image.</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Output image: Define the output directory and image name. The output image name can be called 01_Resampled</span><a name="OLE_LINK16"></a><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">_</span><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">[‘enter name’].tif </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Keep default settings for the other parameters.</span> </p></body></html>
!INSTRUCTIONS
.ALGORITHM:modeler:mad_maf
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This step implements the MAD/MAF transformation to detect change between two images, splits the MAD/MAF components into single files for easier inspection and reclassifies into change and no-change maps. The change map yields a normal distribution where pixels with no change are distributed around the mean and pixels of change are found at the tails of the distribution. </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;"> </span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Input Image 1: Select the image representing the initial state</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Input Image 2: Select the image representing the final state</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Note: For this technique to work, the input images must have the same spatial extent and resolution </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Change Map: Define the output directory and change map name. The output map can be called 02_MAD_[‘enter name’].tif </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Note: The individual MAD/MAFs maps generated from the split routine will be automatically numbered and should afterwards be inspected to identify the map with the most change information.</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:modeler:change mask
.PARAMETERS:{"formula": "(A>1)+(A<-1)"}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This step creates a binary change mask from the reclassified MAD/MAF component. The MAD/MAF component is a normal distribution where pixels with no change are distributed around the mean and pixels of change are found at the tails of the distribution. The mask is computed by image thresholding, where the absolute values of pixels greater than the specified threshold are assigned 1 (indicating change) while values below the threshold are assigned nan or no data value (indicating no change). A modal (majority) filter is applied to smooth out the spectral variability in the binary change mask (i.e. removes isolated pixels). </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;"> </span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Raster Layer A: Select “02_MAD_[‘enter name’]_n.tif” derived from Step 2 where n refers to the number of the component with most change information </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Formula: &quot;(A&gt;xx)+(A&lt;-xx)&quot;, where xx should be replaced by the threshold value. </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Note: Thresholds are specified in number of standard deviations, and the typical change threshold will be within the range from 1 to 2 standard deviations. Standard ‘1’ is used.</span>  </p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Output raster layer: Define the output directory and map name. The output map name can be called 03 _Mask_[‘enter name’].tif</span> </p></body></html>
!INSTRUCTIONS
.ALGORITHM:gdalogr:merge
.PARAMETERS:{"RTYPE": 1, "PCT": false, "SEPARATE": true}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This step combines all input imagery used for the historical classification into one single raster stack. If you are using only one raster dataset as input you can skip this step. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial,sans-serif'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Input Layers: Select each of the raster data set you will use for the classification. e.g. reflectance bands, spectral indices. Imagery from multiple dates can also be added, which may improve classification accuracy.  </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Note: Data have to be loaded in QGIS before they can be listed and selected in the window.</span> </p>
<p style="-qt-paragraph-type:empty; margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Output raster type: Generally you should try work with integer values, as these are lighter on memory and can improve general performance. If you've followed the pre-processing steps for generating surface reflectance and spectral indices the datasets should already be in 'Signed Integer' form (Int16). Choose &quot;Int16&quot; as the &quot;Output raster type&quot; to keep the data in this format. Otherwise choose &quot;Float32&quot;. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial,sans-serif'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Merged: Define the output directory and image name. The output image name can be called 04_Stack_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:r:randomforestclass
.PARAMETERS:{"Number_of_Cores_for_Processing ": 2, "Class_ID_Field": "", "Number_of_Trees ": 500}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This step performs Random Forest classification by relating the input imagery to associated training polygon or point vector data. </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings: </span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Data to be classified: This is the image stack created from the previous step - 04_Stack_[‘enter name’].tif </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Training Data: This is the vector training data used to classify the imagery. This should be a vector polygon or point shape file and the projection of this file must be identical to the ‘Data to be classified’. </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Class ID: This is the field name in the training data shapefile attributes that corresponds to the unique class ID. The default is ‘class_ID’ but change this if the class field name is different in your shapefile. </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Mask Raster: This is the change mask “03 _Mask_[‘enter name’].tif “ produced in Step 3. </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Number of Decision Trees: Integer - The number of decision trees used in the random forest. </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Number of Cores for Processing:  Number of cores used for processing the imagery. The default is 2, but if your computer has more cores available you can increase this for better performance. You can check the number of cores your computer has on Windows by going to Task Manager and under the Performance tab you can see how many cores are available. It’s a good idea to leave at least one core free for other processes. </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Output Raster: Define the output directory and map name. The output map name can be called 05_RFC_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:modeler:map combination
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This step replaces the no data value of the no-change areas in the classification map A at time </span><span style=" font-family:'Arial,sans-serif'; font-size:9pt; font-style:italic;">t1</span><span style=" font-family:'Arial,sans-serif'; font-size:9pt;"> generated from previous step with the existing classification B at time </span><span style=" font-family:'Arial,sans-serif'; font-size:9pt; font-style:italic;">t2.</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt; font-style:italic;"> </span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Classification A: This is the classification map in change areas “05_RFC_[‘enter name’].tif” produced in previous step. </span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Classification B: This is the classification map for no-change areas at time </span><span style=" font-family:'Arial,sans-serif'; font-size:9pt; font-style:italic;">t2</span><span style=" font-family:'Arial,sans-serif'; font-size:9pt;"> (derived from WORKFLOW 2)</span> </p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Combined map: Define the output directory and map name. The output map name can be called 06_Combi_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:gdalogr:sieve
.PARAMETERS:{"THRESHOLD": 11, "CONNECTIONS": 1}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">This step eliminates small patches of isolated pixels in the classified image, effectively defining the minimum mapping unit (MMU). The result is a much &quot;cleaner&quot; map. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial,sans-serif'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Settings: </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial,sans-serif'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Input Layer: This is the classified image from the previous step - 06_Combi_[‘enter name’].tif </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial,sans-serif'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Threshold: This defines the minimum allowable group of pixels in the final map. All patches of pixels equal to or below this number are filtered out. The default value is 11 pixels for classification derived from 30m Landsat data (MMU=1ha). Change to 10 pixels for classification derived from 10m Sentinel-2 data (MMU=0.1ha).</span> </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Pixel connection: This the pattern by which patches of pixels are defined as being connection. The default is 8 meaning all neighbouring pixels are seen as connected. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial,sans-serif'; font-size:9pt;">Sieved: Define the output directory and final map name. The output map name can be called 07_ MMU_[‘enter name’].tif</span> </p></body></html>
!INSTRUCTIONS

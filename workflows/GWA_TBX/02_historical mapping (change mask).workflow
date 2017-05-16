.NAME:Wetland habitat historical mapping (with change mask)
.GROUP:PG#2:Wetland Habitat Mapping
.ALGORITHM:modeler:mad_maf
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">The first step implements the MAD/MAF transformation to detect change between two given images, splits the MAD/MAF components into single files for easier inspection and reclassification into change and no-change. The change image yields a normal distribution where pixels with no change are distributed around the mean and pixels of change are found at the tails of the distribution. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input Image 1: Select the image representing the initial state </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input Image 2: Select the image representing the final state </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Note: For this technique to work, the input images must have the same spatial extent and resolution. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Change Map: Define the output directory and image name. The output image name should be called 01_MAD</span><a name="OLE_LINK16"></a><span style=" font-family:'Arial'; font-size:9pt;">_</span><span style=" font-family:'Arial'; font-size:9pt;">[‘enter name’].tif </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Note: The individual MAD/MAFs images generated from the split routine will be automatically numbered and should afterwards be inspected to identify the image with the most change information.</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:modeler:change mask
.PARAMETERS:{"formula": "if(A>XX||A<-XX,1,0)"}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">This step creates a binary change mask from the reclassified MAD/MAF component. The mask is computed by image thresholding, where the absolute values of pixels greater than the specified threshold are assigned 1 (indicating change) while values below the threshold are assigned 0 (indicating no change). A modal filter is applied to smooth out the spectral variability in the binary change mask (i.e. remove isolated pixels). The pixel value of no-change background in the output change mask is automatically converted to no data value (NA or nan).</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;"> </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Raster Layer A: Select “01_MAD_[‘enter name’]_n.tif” where n refers to the number of the component with most change information </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Formula: &quot;</span><a name="OLE_LINK17"></a><span style=" font-family:'Arial'; font-size:9pt;">i</span><span style=" font-family:'Arial'; font-size:9pt;">f(A&gt;XX || A&lt;-XX,1,0)&quot;  where XX should be replaced by the threshold value. </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Note: Thresholds are specified in number of standard deviations, and the typical change threshold will be within the range from 1 to 2 standard deviations. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Output raster layer: 02 _Mask_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:gdalogr:merge
.PARAMETERS:{"RTYPE": 5, "PCT": false, "SEPARATE": true}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">The first step combines all input imagery used for the classification into 1 single raster stack. If you are using only one raster dataset as input you can skip this step. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:0px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input Layers: Select each of the raster data set you will use for the classification. e.g. reflectance bands, spectral indices. Imagery from multiple dates can also be added, which may improve classification accuracy.  </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Layer stack: If you are stacking rasters that are already in a raster stack (i.e. stacking stacks), then select the &quot;Layer stack&quot; option. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Output raster type: Generally you should try work with integer values, as these are lighter on memory and can improve general performance. If you've followed the pre-processing steps for generating surface reflectance and spectral indices the datasets should already be in 'Signed Integer' form (Int16). Choose &quot;Int16&quot; as the &quot;Output raster type&quot; to keep the data in this format. Otherwise choose &quot;Float32&quot;. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Merged: Define the output directory and image name. The output image name should be called 03_Stack_[‘enter name’].tif </span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:r:randomforestclass
.PARAMETERS:{"Number_of_Cores_for_Processing ": 2, "Class_ID_Field": "", "Number_of_Trees ": 500}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">This step performs Random Forest classification by relating the input imagery to associated training polygon or point vector data. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Data to be classified: This is the image stack created from the previous step - 03_Stack_[‘enter name’].tif </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Training Data: This is the vector training data used to classify the imagery. This should be a vector polygon or point .shp file and the projection of this file must be identical to the ‘Data to be classified’. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Class ID: This is the field name in the training data shapefile attributes that corresponds to the unique class ID. The default is ‘class_ID’ but change this if the class field name is different in your shapefile. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Mask Raster: This is the change mask “02 _Mask_[‘enter name’].tif “ produced in Step 2. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Number of Trees: Integer - The number of trees used in the random forest. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Number of Cores for Processing:  Number of cores used for processing the imagery. The default is 2, but if your computer has more cores available you can increase this for better performance. You can check the number of cores your computer has on Windows by going to Task Manager and under the Performance tab you can see how many cores are available. It’s a good idea to leave at least one core free for other processes. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Output Raster: Define the output directory and image name. The output image name should be called 04_RFC_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:grass:r.mapcalculator
.PARAMETERS:{"formula": "if(isnull(A),B,A)", "GRASS_REGION_PARAMETER": null, "GRASS_REGION_CELLSIZE_PARAMETER": 0}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">This step replaces the no data value of the no-change areas in the map at time </span><span style=" font-family:'Arial'; font-size:9pt; font-style:italic;">t1</span><span style=" font-family:'Arial'; font-size:9pt;"> generated from previous step with the existing classification at time </span><span style=" font-family:'Arial'; font-size:9pt; font-style:italic;">t2.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt; font-style:italic;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Raster layer A: This is the classification map in change areas “04_RFC_[‘enter name’].tif” produced in previous step. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Raster layer B: This is the classification map for no-change areas at time </span><span style=" font-family:'Arial'; font-size:9pt; font-style:italic;">t2</span><span style=" font-family:'Arial'; font-size:9pt;">. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Formula: “if(isnull(A),B,A)” </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Calculated: Define the output directory and image name. The output image name should be called 05_Combi_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:gdalogr:sieve
.PARAMETERS:{"THRESHOLD": 11, "CONNECTIONS": 1}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">This step eliminates small patches of isolated pixels in the classified image, effectively defining the minimum mapping unit (MMU). The result is a much &quot;cleaner&quot; map. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input Layer: This is the classified image from the previous step - 02_RFC_[‘enter name’].tif </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Threshold: This defines the minimum allowable group of pixels in the final map. All patches of pixels equal to or below this number are filtered out. The default value is 10 pixels. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Pixel connection: This the pattern by which patches of pixels are defined as being connection. The default is 8 meaning all neighbouring pixels are seen as connected. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Sieved: Define the output directory and final image name. The output image name should be called 06_ MMU_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS

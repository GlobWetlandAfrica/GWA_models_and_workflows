.NAME:Wetland habitat status mapping (general)
.GROUP:PG#2:Wetland Habitat Mapping
.ALGORITHM:gdalogr:merge
.PARAMETERS:{"RTYPE": 1, "PCT": false, "SEPARATE": true}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">The first step combines all input imagery used for the classification into one single raster stack. If you are using only one raster dataset as input you can skip this step. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:0px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input Layers: Select each of the raster data set you will use for the classification. e.g. reflectance bands, spectral indices. Imagery from multiple dates can also be added.</span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Output raster type: Generally you should try work with integer values, as these are lighter on memory and can improve general performance. If you've followed the pre-processing steps for generating surface reflectance and spectral indices the datasets should already be in 'Signed Integer' form (Int16). Choose &quot;Int16&quot; as the &quot;Output raster type&quot; to keep the data in this format. Otherwise choose &quot;Float32&quot;.</span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Merged: </span><a name="OLE_LINK56"></a><span style=" font-family:'Arial'; font-size:9pt;">D</span><span style=" font-family:'Arial'; font-size:9pt;">efine the output directory and image name. The output image name should be called 01_Stack_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:r:randomforestclass
.PARAMETERS:{"Number_of_Cores_for_Processing ": 2, "Class_ID_Field": "", "Number_of_Trees ": 500}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">This step performs Random Forest classification by relating the input imagery to associated training point data. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Data to be classified: This is the image stack created from the previous step - 01_Stack_[‘enter name’].tif</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;"> </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Training Data: This is the vector training data used to classify the imagery. This should be a vector polygon or point .shp file and the projection of this file must be identical to the ‘Data to be classified’. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Class ID: This is the field name in the training data shapefile attributes that corresponds to the unique class ID. The default is ‘class_ID’ but change this if the class field name is different in your shapefile.</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;"> </span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Mask Raster: This could be provided if you only want to map a certain area of the image. The area of interest should have a value of 1, while masked-out areas should have a no data value (NA or nan). </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Number of Trees: Integer - The number of trees used in the random forest. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Number of Cores for Processing:  Number of cores used for processing the imagery. The default is 2, but if your computer has more cores available you can increase this for better performance. You can check the number of cores your computer has on Windows by going to Task Manager and under the Performance tab you can see how many cores are available. It’s a good idea to leave at least one core free for other processes. </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Output Raster: Define the output directory and image name. The output image name should be called 02_RFC_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:gdalogr:sieve
.PARAMETERS:{"THRESHOLD": 10, "CONNECTIONS": 1}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.8pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">This step eliminates small patches of isolated pixels in the classified image, effectively defining the minimum mapping unit (MMU). The result is a much &quot;cleaner&quot; map. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Settings: </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input Layer: This is the classified image from the previous step “02_RFC_[‘enter name’].tif “ </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Threshold: This defines the minimum allowable group of pixels in the final map. All patches of pixels equal to or below this number are filtered out. The default value is 10 pixels. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Pixel connection: This the pattern by which patches of pixels are defined as being connection. The default is 8 meaning all neighbouring pixels are seen as connected. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Sieved: Define the output directory and final image name. The output image name should be called 03_RFC_MMU_[‘enter name’].tif</span></p></body></html>
!INSTRUCTIONS

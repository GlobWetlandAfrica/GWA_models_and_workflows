.NAME:Generate Stratified Sample
.GROUP:Validation Tools
.ALGORITHM:r:rasterstratsamp
.PARAMETERS:{"Optional_Attribute_name_1": "", "Optional_Attribute_name_2": "", "Attribute_name": "class_id", "Samples_per_strata": 50}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Generate a Stratified Random Sample from raster data that can be used to validate land cover\use classifications. The output will the a points shapefile. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">The input raster should be a classified raster (e.g. land cover map). Each class in the map is represented by a unique value in the raster (e.g. a map with five classes has unique values from 1-5 in the raster). These values are used as strata in the stratified sampler. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Raster to be sampled: This is the classified map with unique values for each class. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Samples per strata: Define how many samples you want for each class. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Attribute name: This is the name of a field in the resulting shapefile attribute table that is used to record the true class label for each validation point. The true class label is determined from field visits or image interpretation. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Optional Attribute name 1 &amp; 2: If you would like any additional fields in the attribute table (e.g. comments for each sample) and them here. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Sample_Points: Define the output directory for the resulting stratified sample.</span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">NOTE: No Data values are not treated as strata, but zero (0) values are. If zero values are not land cover class, all zero values should be reclassed as No Data.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;"><br /></p></body></html>
!INSTRUCTIONS
.ALGORITHM:r:vectokml
.PARAMETERS:{"KML_Filename": "enter_file_name_here.kml"}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;">
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">When interpreting samples using imagery is can be very useful to have a copy of the data that can be used on Google Earth. This step creates a .kml file which can be opened in Google Earth.</span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Skip this step if you do not plan to use Google Earth for sample interpretation.</span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Sample Shapefile: This is the Stratified sample you created in the previous step.</span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Output Folder: Define the folder where you want to store the .kml file. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">KML Filename: Define the name for the .kml file. This should be the same name as the input file but with the .kml extension instead of .shp. </span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:r:pointtogrid
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">This step generates a sample unit outline for each validation sample. In other words, the spatial border for each sample. The border of each sample unit with match the pixel border outline of the raster to base the grid on. This raster should be the classified map. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Point Samples: Define the point shapefile for the validation sample </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Raster To Base Grid On: This is the raster layer with the spatial grid you want to base sample polygons on. For every sample point that overlaps with a pixel, a polygon outlining the pixel boundaries will be made. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Sample Outline: Define the output directory for the sample outlines. This should be the same as the input file but with “_unit” added to the end of the filename. </span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:r:vectokml
.PARAMETERS:{"KML_Filename": "enter_file_name_here.kml"}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">When interpreting samples using imagery is can be very useful to have a copy of the data that can be used on Google Earth. This step creates a .kml file for the sample outlines which can be opened in Google Earth. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Skip this step if you do not plan to use Google Earth for sample interpretation. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Sample Shapefile: This is the sample outline shapefile you created in the previous step. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">Output Folder: Define the folder where you want to store the .kml file. </span></p>
<p style=" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:10pt;">KML Filename: Define the name for the .kml file. This should be the same name as the input file but with the .kml extension instead of .shp. </span></p></body></html>
!INSTRUCTIONS

.NAME:1 - Generate Stratified Sample
.GROUP:Validation Tools
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Generat Stratified Sample
<br><br>


## Objective of the workflow
This workflow can be used to generate a Stratified Random Sample from raster data that can be used to validate land cover\use classifications. The output will the a points shapefile.


## Theoretical background
A variety of probability sampling designs are applicable to accuracy assessment with the most commonly used designs being simple random, stratified random, and systematic (Stehman, 2009). No single sampling design can serve as a universally appropriate design; however, stratified random sampling is a practical and cost-efficient design that satisfies the basic accuracy assessment objectives and most of the desirable design criteria. Stratified random sampling affords the option to increase the sample size in classes and/or regions that occupy a small proportion of area to reduce the standard errors of the class/region-specific accuracy estimates for these rare occurrences.

## References and futher reading
* Stehman, S. V. (2009). Sampling designs for accuracy assessment of land cover. International Journal of Remote Sensing, 30, 5243–5272.
!INSTRUCTIONS
.ALGORITHM:r:rasterstratsamp
.PARAMETERS:{"Optional_Attribute_name_1": "", "Optional_Attribute_name_2": "", "Attribute_name": "class_id", "Samples_per_strata": 50}
.MODE:Normal
.INSTRUCTIONS:# Generate sample

Generate a Stratified Random Sample from raster data that can be used to validate land cover\use classifications.

## Settings

**Raster to be sampled**: This is the classified map with unique values for each class.

The input raster should be a classified raster (e.g. land cover map). Each class in the map is represented by a unique value in the raster (e.g. a map with five classes has unique values from 1-5 in the raster). These values are used as strata in the stratified sampler.

**Samples per strata**: Define how many samples you want for each class.

**Attribute name**: This is the name of a field in the resulting shapefile attribute table that is used to record the true class label for each validation point. The true class label is determined from field visits or image interpretation.

**Optional Attribute name 1 & 2**: If you would like any additional fields in the attribute table (e.g. comments for each sample) and them here.

**Sample_Points**: Define the output directory for the resulting stratified sample.

## Notes
No Data values are not treated as strata, but zero (0) values are. If zero values are not land cover class, all zero values should be reclassed as No Data.
!INSTRUCTIONS
.ALGORITHM:r:vectokml
.PARAMETERS:{"ID_Field_from_Shapefile_Attributes": "number", "KML_Filename": "enter_file_name_here.kml"}
.MODE:Normal
.INSTRUCTIONS:# Convert to KML (point)

When interpreting samples using imagery is can be very useful to have a copy of the data that can be used on Google Earth. This step creates a .kml file which can be opened in Google Earth.

## Settings

**Sample Shapefile**: This is the Stratified sample you created in the previous step.

**Output Folder**: Define the folder where you want to store the .kml file.

**ID Field from Shapefile Attributes**: Leave as default

**KML Filename**: Define the name for the .kml file. This should be the same name as the input file but with the .kml extension instead of .shp.

## Notes
Skip this step if you do not plan to use Google Earth for sample interpretation.
!INSTRUCTIONS
.ALGORITHM:r:pointtogrid
.PARAMETERS:{"Make_3x3_Grid____Yes_or_No": "Yes"}
.MODE:Normal
.INSTRUCTIONS:# Generate sample unit outline

This step generates a sample unit outline (i.e. a polygon) for each validation sample point. In other words, the spatial border for each sample. The border of each sample unit with match the pixel border outline of the raster to base the grid on. This raster should be the classified map.

## Settings

**Point Samples**: Define the point shapefile for the validation sample

**Raster To Base Grid On**: This is the raster layer with the spatial grid you want to base sample polygons on. For every sample point that overlaps with a pixel, a polygon outlining the pixel boundaries will be made.

**Make 3x3 Grid**: Decide wether to extent the sample unit to a 3x3 pixel Grid (Yes). Choosing "No" means the sample outline will 1x1 pixel.

**Sample Outline**: Define the output directory for the sample outlines. This should be the same as the input file but with “_unit” added to the end of the filename.

!INSTRUCTIONS
.ALGORITHM:r:vectokml
.PARAMETERS:{"ID_Field_from_Shapefile_Attributes": "number", "KML_Filename": "enter_file_name_here.kml"}
.MODE:Normal
.INSTRUCTIONS:# Convert to KML (polygon)

When interpreting samples using imagery is can be very useful to have a copy of the data that can be used on Google Earth. This step creates a .kml file for the sample outlines which can be opened in Google Earth.

## Settings

**Sample Shapefile**: This is the sample outline shapefile you created in the previous step.

**Output Folder**: Define the folder where you want to store the .kml file.

**ID Field from Shapefile Attributes**: Leave as default

**KML Filename**: Define the name for the .kml file. This should be the same name as the input file but with the .kml extension instead of .shp.

## Notes
Skip this step if you do not plan to use Google Earth for sample interpretation.

!INSTRUCTIONS

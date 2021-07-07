.NAME:1 - Status mapping (wetland extent and type)
.GROUP:2. Wetland (Habitat) Mapping
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Wetland Habitat Mapping
<br><br>


## Objective of the workflow
Sustainable wetland management relies on not only the information on wetland extent but also the information on the distribution of various wetland types and how land is used inside and around the wetlands. Remote sensing for mapping the wetland covers and associated land covers/uses provides a useful tool to assess the overall status, ecological character and functional integrity of wetland ecosystems.

**This workflow performs a detailed classification of land cover and land use inside and around wetland sites using multi-specral optical satellite images (e.g., Sentinel-2 and Landsat)**.

## Theoretical background
Land surface reflectance shows intra-annual variation due to phenology, which complicates land cover/use
classification. On the other hand, wetlands are also highly dynamic and a single image cannot accurately quantify the status and changes of wetlands. Multi-temporal land cover/use classification accounts the phenology vegetation and land cover/use dynamics. Therefore, **best results are obtained when including time-series imagery in the analysis that capture the seasonal characteristics of different land covers/uses**.

In this workflow we use the **Random Forest classifier**. Random Forest is an ensemble learning algorithm for classification that operates by constructing many decision trees during model training and outputting the class that receives the most ‘votes’ from the entire group of decision trees, i.e. the mode occurrence. Random Forests was chosen as the classifier due to a number of appealing characteristics that lend to robust exploratory analysis; it is amongst the most accurate machine learning algorithms, it runs efficiently on large datasets, it can handle a large amount of input variables, it is robust against model over fitting, it requires less model tuning compared to other machine learning approaches (e.g.Support Vector Machine).

## Data preparation
Before running this workflow you should use the **Sentinel-2 Pre-processing workflow** (located in the *I/O* group) for each image in the Sentinel-2 time-series to be used in the classification, and the **1 - Indices calculation and texutre extraction workflow** (located in the *PG#2: Wetland Habitat Mapping* group) to generate vegetation and water indices and image textural features for the classification. You should also create a a vector polygon or point shapefile (.shp) with the **training data**. It should contain multiple training samples for each land cover/use (wetland) class to be classified and the projection of this file must be identical to that of the Sentinel-2 time-series images.

## References and futher reading
* Breiman, L. Machine Learning (2001) 45: 5. [https://doi.org/10.1023/A:1010933404324](https://doi.org/10.1023/A:1010933404324)
!INSTRUCTIONS
.ALGORITHM:gdal:merge
.PARAMETERS:{"RTYPE": 1, "NODATA": -9999, "PCT": false, "SEPARATE": true}
.MODE:Normal
.INSTRUCTIONS:# Combine input images

The first step combines all input imagery (either all Sentinel-2 or Landsat) which will be used for the classification into one single raster stack. If you are using only one raster dataset as input you can skip this step.

## Settings

**Input Layers**: Click ... button and select all the raster data sets you will use for the classification. In addition to the reflectance bands include spectral indices, texture features and multi-temporal NDVI features (if multi-temporal images are available) derived in WORKFLOW 1 are suggested to be included to improve mapping accuracy.

**Output raster type**: Generally you should try to work with integer values, as these are lighter on memory and can improve general performance. If you've followed the pre-processing steps (WORKFLOW 1) for generating surface reflectance and spectral indices the datasets should already be in 'Signed Integer' form (Int16). Choose "Int16" as the "Output raster type" to keep the data in this format. Otherwise choose "Float32".

**Merged**: Define the output directory and image name. The output image name can be called *01_Stack_[‘enter name’].tif*

## Notes
Data have to be loaded in QGIS before they can be listed and selected in the window.
!INSTRUCTIONS
.ALGORITHM:r:RandomForestClass
.PARAMETERS:{"Number_of_Trees": 500, "Class_ID_Field": "", "Number_of_Cores_for_Processing": 2}
.MODE:Normal
.INSTRUCTIONS:# Classify land cover and land use including wetland types

This step performs Random Forest classification by relating the input imagery to associated training point/polygon data.

A Shapefile (.shp) with vector polygon or point training data for each class is required to proceed in this workflow.

## Settings

**Data to be classified**: This is the image stack created from the previous step "01_Stack_[‘enter name’].tif"

**Training Data**: This is the vector training data used to classify the imagery. This should be a vector polygon or point shape (.shp) file and the projection of this file must be identical to the ‘Data to be classified’.

**Class ID Field**: This is the field name in the training data shapefile attributes that corresponds to the unique class ID. The default is ‘Class’ but change this if the class field name is different in your shapefile.

**Mask Raster [optional]**: This could be provided if you only want to map a certain area of the image. The area of interest should have a value of 1, while masked-out areas should have a no data value (NA or nan).

**Number of Cores for Processing**:  Number of cores used for processing the imagery. The default is 2, but if your computer has more cores available you can increase this for better performance. You can check the number of cores your computer has on Windows by going to Task Manager and under the Performance tab you can see how many cores (boxes in the CPU Usage History section) are available. It’s a good idea to leave at least one core free for other processes.

**Number of Trees**: Integer - The number of decision trees used in the random forest. 500 trees are used by default for wetland habitat mapping.

**Output Raster**: Define the output directory and map name. The output map name can be called *02_RFC_[‘enter name’].tif*
!INSTRUCTIONS
.ALGORITHM:gdal:sieve
.PARAMETERS:{"THRESHOLD": 10, "CONNECTIONS": 1}
.MODE:Normal
.INSTRUCTIONS:# Post-processing

This step eliminates small patches of isolated pixels in the classified image, effectively defining the minimum mapping unit (MMU). The result is a much "cleaner" map.

## Settings

**Input Layer**: This is the classified image from the previous step "02_RFC_[‘enter name’].tif"

**Threshold**: This defines the minimum allowable homogenous group of pixels in the final map. All patches of pixels equal to or below this number are filtered out. The default value is 10 pixels for classification derived from Sentinel-2 (with a resolution of 10 meter) data (MMU=0.1ha). Change to 11 pixels for classification derived from Landsat data (with a resolution of 30 meter) (MMU=1ha).

**Pixel connection**: This the pattern by which patches of pixels are defined as being connection. The default is 8 meaning all neighbouring pixels are seen as connected.

**Sieved**: Define the output directory and final map name. The output map name can be called *03_RFC_MMU_[‘enter name’].tif*
!INSTRUCTIONS

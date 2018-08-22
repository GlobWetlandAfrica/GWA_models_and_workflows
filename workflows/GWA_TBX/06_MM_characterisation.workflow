.NAME:2 - Mangrove Characterisation
.GROUP:PG#6: Mangrove Mapping
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Mangrove Mapping
<br><br>


## Objective of the workflow
Recent advancements in remote sensing technology and image processing methods have enabled a shift in focus from mapping broad land cover types to mapping specific attributes or characteristics of vegetation. This movement towards more detailed land cover mapping should greatly benefit a broad array of natural resource management plans and conservation initiatives. Many coastal wetland management strategies are now recognising the growing importance of accurate maps that characterise mangrove species and/or structure. For example, mapping mangrove species can feed into biodiversity monitoring systems and help prioritise conservation efforts. Similarly, mapping structural attributes related to mangrove height and density can contribute to better understanding of a number of important themes, e.g. ecosystems resilience against storm surges or climate change, or more reliable estimates of wetland habitat biomass.

**The focus of this workflow is on the use optical datasets provided by ESA’s Sentinel 2 satellites to characterize mangroves.**

## Theoretical background
Considerable change occurs in mangrove phenology throughout the year, especially as the dry season progresses. Seasonal changes in optical spectra may improve the identification of different species and/or structural types. A second aspect that may have an influence on mangrove characterisation is the difference between high and low tide. At high tide, the background signal of water is expected to have a greater influence on the overall spectral response compared to low tide conditions, especially so for lower elevation or less dense areas of mangrove. Therefore, **best results are obtained when including imagery in the analysis that captured both seasonal and tidal differences**.
<center><img src="images/mangroves_timeseries_evolution.png" alt="mangroves_timeseries_evolution"></center>
In this workflow we use the **Random Forest classifier**. Random Forest  is an ensemble learning algorithm for classification that operates by constructing many decision trees during model training and outputting the class that receives the most ‘votes’ from the entire group of decision trees, i.e. the mode occurrence. Random Forests was chosen as the classifier due to a number of appealing characteristics that lend to robust exploratory analysis; it is amongst the most accurate machine learning algorithms, it runs efficiently on large datasets, it can handle a large amount of input variables, it is robust against model over fitting, it requires less model tuning compared to other machine learning approaches (e.g.Support Vector Machine).

## Data preparation
Before running this workflow you should use the **__Sentinel-2 Pre-processing workflow__** (loacated in the *I/O* group) for each image in the Sentinel-2 time-series to be used in the classification.

## References and futher reading
* Breiman, L. Machine Learning (2001) 45: 5. https://doi.org/10.1023/A:1010933404324
* GlobWetland-Africa, Algorithm Theoretical Basis Document, chapter 4.7
!INSTRUCTIONS
.ALGORITHM:gdalogr:merge
.PARAMETERS:{"RTYPE": 1, "NODATA": -9999, "PCT": false, "SEPARATE": true}
.MODE:Normal
.INSTRUCTIONS:#Combine input images

The first step combines all input imagery used for the classification into 1 single raster stack. If you are using only one raster dataset as input you can skip this step.

##Settings

**Input Layers**: Select each of the raster data sets you will use for the classification. e.g. reflectance bands, spectral indices. Imagery from multiple dates can also be added, which may improve classification accuracy.

**Output raster type**: Generally you should try work with integer values, as these are lighter on memory and can improve general performance. If you've followed the pre-processing steps for generating surface reflectance and spectral indices the datasets should already be in 'Signed Integer' form (Int16). Choose "Int16" as the "Output raster type" to keep the data in this format. Otherwise choose "Float32".

**Merged**: Define the output directory and image name. The output image name should be called *01_Stack_[‘enter name’].tif*

##Notes
Nothing relevant.
!INSTRUCTIONS
.ALGORITHM:r:randomforestclass
.PARAMETERS:{"Number_of_Cores_for_Processing ": 2, "Class_ID_Field": "", "Number_of_Trees ": 150}
.MODE:Normal
.INSTRUCTIONS:# Classify mangrove types

This step performs Random Forest classification by relating the input imagery to associated training data. To focus the classification on mangroves only, the mangrove extent mask from the *Mangrove Inventory* workflow is used to mask out all area that are not mangroves.

A Shapefile (.shp) with vector polygon or point training data for each class is required to proceed in this workflow.

## Settings

**Data to be classified**: This is the image stack created from the previous step - 01_Stack_[‘enter name’].tif

**Training Data**: This is the vector training data used to classify the imagery. This should be a vector polygon or point .shp file and the projection of this file must be identical to the ‘Data to be classified’.

**Class ID**: this is the field name in the training data shapefile attributes that corresponds to the unique class ID. The default is ‘class_ID’ but change this if the class field name is different in your shapefile.

**Mask Raster**: This is the mangrove extent mask created from the Mangrove Inventory Step. Mangrove pixel should have a value of 1, while non-mangrove areas should have a no data value (NA or nan).

**Number of Trees**: The number of trees used in the random forest. Default is 150.

**Number of Cores for Processing**:  Number of cores used for processing the imagery. The default is 2, but if your computer has more cores available you can increase this for better performance. You can check the number of cores your computer has on Windows by going to Task Manager and under the Performance tab you can see how many cores are available. It’s a good idea to leave at least one core free for other processes.

**Output Raster**: Define the output directory and image name. The output image name should be called 02_RFC_[‘enter name’].tif
!INSTRUCTIONS
.ALGORITHM:gdalogr:sieve
.PARAMETERS:{"THRESHOLD": 4, "CONNECTIONS": 1}
.MODE:Normal
.INSTRUCTIONS:# Post-processing

This step eliminates small patches of isolated pixels in the classified image, effectively defining the minimum mapping unit (MMU). The result is a much "cleaner" map.

## Settings

**Input Layer**:  This is the classified image from the previous step - 02_RFC_[‘enter name’].tif

**Threshold**: This defines the minimum allowable group of pixels in the final map. All patches of pixels equal to or below this number are filtered out. The default value is 4 pixels.

**Pixel connection**: This the pattern by which patches of pixels are defined as being connection. The default is 8 meaning all neighbouring pixels are seen as connected.

**Sieved**:  Define the output directory and final image name. The output image name should be called 03_RFC_MMU_[‘enter name’].tif
!INSTRUCTIONS

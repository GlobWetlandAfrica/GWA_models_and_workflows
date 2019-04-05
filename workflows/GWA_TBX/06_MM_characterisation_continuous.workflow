.NAME:3 - Characterisation (continuous)
.GROUP:PG#6: Mangrove Mapping
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Mangrove Characterisation for continuous variables
<br><br>


## Objective of the workflow
Recent advancements in remote sensing technology and image processing methods have enabled a shift in focus from mapping broad land cover types to mapping specific attributes or characteristics of vegetation. This movement towards more detailed land cover mapping should greatly benefit a broad array of natural resource management plans and conservation initiatives. Many coastal wetland management strategies are now recognising the growing importance of accurate maps that characterise mangrove species and/or structure. For example, mapping mangrove species can feed into biodiversity monitoring systems and help prioritise conservation efforts. Similarly, mapping structural attributes related to mangrove height and density can contribute to better understanding of a number of important themes, e.g. ecosystems resilience against storm surges or climate change, or more reliable estimates of wetland habitat biomass.

**The focus of this workflow is on the use optical datasets provided by ESA’s Sentinel 2 or NASA's Landsat satellites to characterize mangroves using machine learning regression.**

## Theoretical background
This workflow uses Support Vector Regression to characterise mangroves on a continuous scale - for example per-pixel mangrove height (meters), carbon density (tons per hectare), canopy cover (percent) etc. are all variables that can be estimated on a continuous scale. This algorithm relates spectral characteristics in the satellite imagery to sample estimates of the continuous variable of interest. Building these relationships results in a model that can be used to predict the variable of interest (e.g. mangrove height) for all pixels in the satellite imagery.

## Data preparation
Before running this workflow you should use the **__Sentinel-2 Pre-processing workflow__** (located in the *I/O* group) for each image you want to include in the analysis. You should have a vector point shapefile (.shp) with the **training data**. It should contain training samples covering the full range of the continuous variable to be mapped. The projection of this training data file must be identical to that of the satellite imagery used.
!INSTRUCTIONS
.ALGORITHM:gdalogr:merge
.PARAMETERS:{"RTYPE": 5, "NODATA": -9999, "PCT": false, "SEPARATE": false}
.MODE:Normal
.INSTRUCTIONS:#Combine input images

The first step combines all input imagery used for the regression into 1 single raster stack. If you are using only one raster dataset as input, you can skip this step.

##Settings

**Input Layers**: Select each of the raster data sets you will use for the regression. e.g. reflectance bands, spectral indices. Imagery from multiple dates can also be added, which may improve accuracy.

**Output raster type**: Generally, you should try work with integer values, as these are lighter on memory and can improve general performance. If you've followed the pre-processing steps for generating surface reflectance and spectral indices, the datasets should already be in 'Signed Integer' form (Int16). Choose "Int16" as the "Output raster type" to keep the data in this format. Otherwise choose "Float32".

**Merged**: Define the output directory and image name. The output image name should be called *01_Stack_[‘enter name’].tif*
!INSTRUCTIONS
.ALGORITHM:r:supportvectorregression
.PARAMETERS:{"Cost_for_Radial_Kernel": 10, "Number_of_Cores_for_Processing": 2, "Gamma_for_Radial_Kernel": 0, "Variable_Name": ""}
.MODE:Normal
.INSTRUCTIONS:# Predict continuos variable

This step performs Support Vector Regression by relating the input imagery to associated training data. To focus the analysis on mangroves only, the mangrove extent mask from the *Mangrove Inventory* workflow is used to mask out all areas that are not mangroves.

A Shapefile (.shp) with vector point training data for the continuous variable is required to proceed in this workflow.

## Settings

**Regression Data**: This is the image stack created from the previous step - 01_Stack_[‘enter name’].tif

**Training Data**: This is the vector training data used to train the regression model. This should be a vector point .shp file and the projection of this file must be identical to the ‘Data to be classified’.

**Variable Name**: this is the field name in the training data shapefile attributes that corresponds to samples of continuous estimates.

**Mask Raster**: This is the mangrove extent mask created from the Mangrove Inventory Step. Mangrove pixel should have a value of 1, while non-mangrove areas should have a no data value (NA or nan).

**Number of Cores for Processing**:  Number of cores used for processing the imagery. The default is 2, but if your computer has more cores available you can increase this for better performance. You can check the number of cores your computer has on Windows by going to Task Manager and under the Performance tab you can see how many cores are available. It’s a good idea to leave at least one core free for other processes.

**Gamma for Radial Kernel**: Changing the gamma value may lead to improved results. When this is left at 0 is chooses the default gamma value which is 1/(data dimension). When testing this algorithim the default value worked well.

**Cost for Radial Kernel**: Changing the caost value may lead to imporved results. The default value is choosen as 10 - which worked well in testing.

**Output Raster**: Define the output directory and image name. The output image name should be called 02_SVR_[‘enter name’].tif
!INSTRUCTIONS

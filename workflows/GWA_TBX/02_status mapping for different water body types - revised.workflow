.NAME:3 - Status mapping (different water body types)
.GROUP:PG#2: Wetland Habitat Mapping
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Wetland Habitat Mapping
<br><br>


## Objective of the workflow
Although the combination of the spectral bands, water and vegetation indices can effectively extract water surface, the pixel-based classifier may fail to accurately discriminate between various types of water bodies with very similar spectral characteristics (i.e., river, lake and aquaculture ponds). The integration of object-based features into the classification helps to differentiate these classes.

**The focus of this workflow is on the use of segment-based features derived from satellite images and classified water area to identify various water body types.**

## Theoretical background
A set of **geometric and contextual features** of water segments are used, such as shape index, perimeter/square root of the area, and maximum distance/square root of the area of the water segment polygons as well as standard deviation and sum of pixels values of the NIR band within the polygons.
<center><img src="images/WHM_water_types.png" alt="Example of water types"></center>
As with the general status mapping workflow, we also use the **Random Forest classifier** in this workflow. Random Forest is an ensemble learning algorithm for classification that operates by constructing many decision trees during model training and outputting the class that receives the most ‘votes’ from the entire group of decision trees, i.e. the mode occurrence. Random Forests was chosen as the classifier due to a number of appealing characteristics that lend to robust exploratory analysis; it is amongst the most accurate machine learning algorithms, it runs efficiently on large datasets, it can handle a large amount of input variables, it is robust against model over fitting, it requires less model tuning compared to other machine learning approaches (e.g.Support Vector Machine).

## Data preparation
Before running this workflow you should use the **2 - Status mapping (general) workflow** (loacated in the *PG#2: Wetland Habitat Mapping* group) for the classification of general land cover/use types to extract water area. You should also create a a vector polygon or point shapefile (.shp) with the **training data**. It should contain multiple training samples for each class of water bodies to be classified and the projection of this file must be identical to that of the Sentinel-2 images or derived classification map.

## References and futher reading
* Breiman, L. Machine Learning (2001) 45: 5. [https://doi.org/10.1023/A:1010933404324](https://doi.org/10.1023/A:1010933404324)
!INSTRUCTIONS
.ALGORITHM:modeler:water mask
.PARAMETERS:{"classidofwater": 1}
.MODE:Normal
.INSTRUCTIONS:# Extract water area

The first step creates a binary water mask from a reclassified map derived from Wetland habitat status mapping (general) workflow. The area of water body will have a value of 1, while non-water areas will have a no data value (NA or nan).

## Settings

**Classification map**: Select the classification map derived from Wetland habitat status mapping (general) workflow.

**Class ID of water**: Specify the Class ID value of water in the classification map.

**Water mask**: Define the output directory and map name. The output map name can be called *01_WaterMask_[‘enter name’].tif*
!INSTRUCTIONS
.ALGORITHM:modeler:feature extraction
.PARAMETERS:{"nirbandnumber": 7, "spatialresolution": 10}
.MODE:Normal
.INSTRUCTIONS:# Calculate geometric features of water polygons

This step creates vector polygons for all connected regions of water pixels, and calculates spatial statistics for these water polygons, such as shape index, perimeter / square root of the area, and maximum distance / square root of the area. It also calculates standard deviation and sum of pixels values of the NIR band within the water segment polygons. All results are stored as attributes in a new vector layer. The polygonal vector data are then converted to raster data and combined to one single output layer for further analysis.

## Settings

**water mask**: Select the water mask map “01_Mask_[‘enter name’].tif” generated in the previous step.

**Surface reflectance**: This is the stacked bands of satellite image used for classification (use the same image as in workflow 1 step 1).

**NIR band number**: This is the serial number of NIR band. The default is ‘7’ for Sentinel-2 data or ‘4’ for Landsat data.

**Spatial resolution(m)**: The spatial resolution of output raster should be the same as the satellite image used for classification. The default is ‘10’ for Sentinel-2 and  ‘30’ if Landsat data are used.

**Output raster**: Define the output directory and map name. The output map name can be called *02_Feature_[‘enter name’].tif*
!INSTRUCTIONS
.ALGORITHM:r:randomforestclass
.PARAMETERS:{"Number_of_Trees": 500, "Class_ID_Field": "", "Number_of_Cores_for_Processing": 2}
.MODE:Normal
.INSTRUCTIONS:# Classify water body types

This step performs Random Forest classification by relating the input imagery to associated training point/polygon data.

A Shapefile (.shp) with vector polygon or point training data for each class is required to proceed in this workflow.

## Settings

**Data to be classified**: This is the layer stack created from the previous step "02_Feature_[‘enter name’].tif"

**Training Data**: This is the vector training data used to classify the area. This should be a vector polygon or point shape file (.shp) and the projection of this file must be identical to the ‘Data to be classified’.

**Class ID Field**: This is the field name in the training data shapefile attributes that corresponds to the unique class ID. The default is ‘Class’ but change this if the class field name is different in your shapefile.

**Mask Raster**: This is the water mask “01_Mask_[‘enter name’].tif” generated in Step 1. The water body pixels should have a value of 1, while non-water pixels should have a no data value (NA or nan).

**Number of Cores for Processing**:  Number of cores used for processing the imagery. The default is 2, but if your computer has more cores available you can increase this for better performance. You can check the number of cores your computer has on Windows by going to Task Manager and under the Performance tab you can see how many cores (boxes in the CPU Usage History section) are available. It’s a good idea to leave at least one core free for other processes.

**Number of Trees**: Integer - The number of trees used in the random forest. By default, 500 decision trees are used for classification.

**Output Raster**: Define the output directory and image name. The output image name can be called *03_RFC_[‘enter name’].tif*

## Note
The value of class ID for water body types should be different from other land cover/use classes in the previous classification (derived from WORKFLOW 2).
!INSTRUCTIONS
.ALGORITHM:modeler:map combination
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Combine maps

This step replaces the pixel value of water class in the original classification with the values of different water body types derived in the previous step.

## Settings

**Classfication A**: This is the classification map of different water body types “03_RFC_[‘enter name’].tif” produced in previous step (Step 3).

**Classification B**: This is the classification map for other land uses/covers generated from Wetland habitat status mapping (general) workflow.

**Combined map**: Define the output directory and map name. The output map name can be called *04_Combi_[‘enter name’].tif*
!INSTRUCTIONS

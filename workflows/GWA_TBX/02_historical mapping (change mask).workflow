.NAME:4 - Historical mapping (with change mask)
.GROUP:PG#2: Wetland Habitat Mapping
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Wetland Habitat Mapping
<br><br>


## Objective of the workflow
Change in land use and land cover is a key driver of environmental changes. Identifying where and to what extent the wetland has been changing provide a better understanding of the underlying environmental and social drivers of the change to assist planning and interventions.

For historical analysis, the challenge is to generate a set of successive land cover/use maps that are both accurate and consistent over time. The availability and sufficiency of historical ground truth data may further hinder the classification performance. To reduce the propagation of classification errors, **this workflow is designed to implement a change detection in multispectral, bi-temporal image data to identify potential change/no-change areas, perform land cover/use classification within the change area, and combine with the existing classification map for the no-change background**.

## Theoretical background
The methodology is based on the **Multivariate Alteration Detection (MAD)** transformation and **maximum autocorrelation factor (MAF)** postprocessing in multispectral, bitemporal image data and **Random Forest** classification of multispectral satellite imagery.

The MAD algorithm, which is based on the established canonical correlation analysis, performs change detection from a pair multi-band images and outputs a multi-band image of change maps, each one being uncorrelated with the remaining. The MAF post-processing of the MAD variates, as a spatial extension of the MAD, generates new variates that maximize auto-correlation between neighboring pixels instead of variance to retain the spatial structure in the resulting change images. The MAD/MAF variates contains information of land cover/use changes at various spatial scales, which can be attributed to various stressors. The MAD/MAF components are split into single files for easier inspection by users to identify the one with the most change information, which will be reclassified to a binary change/no-change mask by a user-defined threshold.
<center><img src="images/WHM_change_mask_routine.png" alt="IMAGE_DESCRIPTION"></center>
As with status mapping, we use the Random Forest classifier for image classification. Random Forest is an ensemble learning algorithm for classification that operates by constructing many decision trees during model training and outputting the class that receives the most ‘votes’ from the entire group of decision trees, i.e. the mode occurrence. Random Forests was chosen as the classifier due to a number of appealing characteristics that lend to robust exploratory analysis; it is amongst the most accurate machine learning algorithms, it runs efficiently on large datasets, it can handle a large amount of input variables, it is robust against model over fitting, it requires less model tuning compared to other machine learning approaches (e.g.Support Vector Machine).

## Data preparation
Before running this workflow you should use the **Landsat Pre-processing workflow** (located in the *I/O* group) for each image in the Landsat time-series to be used in the classification. You also need the **1 - Indicies calculation and texture extraction workflow** (located in the *PG#2: Wetland Habitat Mapping* group) to generate vegetation and water indices as well as image textural features for the classification. You should also create a a vector polygon or point shapefile (.shp) with the **training data**. It should contain multiple training samples for each land cover/use class to be classified and the projection of this file must be identical to that of the satellite images.

## References and futher reading
* Nielsen, A. A., Conradsen, K., & Simpson, J. J. Remote Sensing of Environment (1998) 64: 1. [https://doi.org/10.1016/S0034-4257(97)00162-4](https://doi.org/10.1016/S0034-4257(97)00162-4)
* Breiman, L. Machine Learning (2001) 45: 5. [https://doi.org/10.1023/A:1010933404324](https://doi.org/10.1023/A:1010933404324)
* Alaibakhsh, M., Emelyanova, I., Barron, O., Mohyeddin, A., & Khiadani, M. International Journal of Remote Sensing (2015) 36: 2599. [https://doi.org/10.1080/01431161.2015.1042595](https://doi.org/10.1080/01431161.2015.1042595)
!INSTRUCTIONS
.ALGORITHM:otb:Superimpose
.PARAMETERS:{"-interpolator": 0, "-mode": 0, "-ram": 512, "-interpolator.bco.radius": 2, "-lms": 4, "-elev.default": 0}
.MODE:Normal
.INSTRUCTIONS:# Project image (optional)

This step is optional. It performs the projection of an image into the geometry of another one (matching the spatial resolution and extent of two images). When both Landsat and Sentinel-2 images are used to do change detection using MAD/MAF, this tool will resample the 30m Landsat image to 10m as the resolution of the Sentinel-2 image and match the extent of the Sentinel-2 image, or vice versa. Skip this step if two images with the same resolution and extent are used for change detection.

## Settings

**Reference input**: Select one image used for change detection that you would like to keep its resolution.

**The image to reproject**: Select the other image used for change detection that needs reprojection to the reference image.

**Output image**: Define the output directory and image name. The output image name can be called *01_Resampled_[‘enter name’].tif*
!INSTRUCTIONS
.ALGORITHM:model:MAD/MAF
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Change detection between two images

This step implements the MAD/MAF transformation to detect change between two images, splits the MAD/MAF components into single files for easier inspection and reclassifies into change and no-change maps. The change map yields a normal distribution where pixels with no change are distributed around the mean and pixels of change are found at the tails of the distribution.

## Settings

**Input Image 1**: Select the image representing the initial state.

**Input Image 2**: Select the image representing the final state.

**Change Map**: Define the output directory and change map name. The output map can be called *02_MAD_[‘enter name’]* (file extension not needed)

## Notes
For this technique to work, the input images must have the same spatial extent and resolution.

The individual MAD/MAFs maps generated from the split routine will be automatically numbered and should afterwards be inspected to identify the map with the most change information.
!INSTRUCTIONS
.ALGORITHM:model:change mask
.PARAMETERS:{"formula": "(A>1)+(A<-1)"}
.MODE:Normal
.INSTRUCTIONS:# Create change mask

This step creates a binary change mask from the reclassified MAD/MAF component. The MAD/MAF component is a normal distribution where pixels with no change are distributed around the mean and pixels of change are found at the tails of the distribution. The mask is computed by image thresholding, where the absolute values of pixels greater than the specified threshold are assigned 1 (indicating change) while values below the threshold are assigned nan or no data value (indicating no change). A modal (majority) filter is applied to smooth out the spectral variability in the binary change mask (i.e. removes isolated pixels).

## Settings

**MAD/MAF component with most change information**: Select one change map with most change information derived from Step 2 “02_MAD_[‘enter name’]_n.tif” where n refers to the number.

**Formula**: "(A>xx)+(A<-xx)", where A represents the layer chosen above and xx should be replaced by the threshold value (default is 1).

**Change mask**: Define the output directory and map name. The output map name can be called *03 _Mask_[‘enter name’].tif*

## Notes
Thresholds are specified in number of standard deviations, and the typical change threshold will be within the range from 1 to 2 standard deviations. Standard ‘1’ is used.
!INSTRUCTIONS
.ALGORITHM:gdal:merge
.PARAMETERS:{"RTYPE": 1, "NODATA": -9999, "PCT": false, "SEPARATE": true}
.MODE:Normal
.INSTRUCTIONS:# Combine input images

The first step combines all input imagery (either all Sentinel-2 or Landsat) which will be used for the classification into one single raster stack. If you are using only one raster dataset as input you can skip this step.

## Settings

**Input Layers**: Click ... button and select all the raster data sets you will use for the classification. In addition to the reflectance bands include spectral indices, texture features and multi-temporal NDVI features (if multi-temporal images are available) derived in WORKFLOW 1 are suggested to be included to improve mapping accuracy.

**Output raster type**: Generally you should try to work with integer values, as these are lighter on memory and can improve general performance. If you've followed the pre-processing steps (WORKFLOW 1) for generating surface reflectance and spectral indices the datasets should already be in 'Signed Integer' form (Int16). Choose "Int16" as the "Output raster type" to keep the data in this format. Otherwise choose "Float32".

**Merged**: Define the output directory and image name. The output image name can be called *04_Stack_[‘enter name’].tif*

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

**Data to be classified**: This is the image stack created from the previous step "04_Stack_[‘enter name’].tif"

**Training Data**: This is the vector training data used to classify the imagery. This should be a vector polygon or point shape (.shp) file and the projection of this file must be identical to the ‘Data to be classified’.

**Class ID Field**: This is the field name in the training data shapefile attributes that corresponds to the unique class ID. The default is ‘Class’ but change this if the class field name is different in your shapefile.

**Mask Raster**: This is not optional, and should be the change mask "03 _Mask_[‘enter name’].tif" produced in Step 3.

**Number of Cores for Processing**:  Number of cores used for processing the imagery. The default is 2, but if your computer has more cores available you can increase this for better performance. You can check the number of cores your computer has on Windows by going to Task Manager and under the Performance tab you can see how many cores (boxes in the CPU Usage History section) are available. It’s a good idea to leave at least one core free for other processes.

**Number of Trees**: Integer - The number of decision trees used in the random forest. 500 trees are used by default for wetland habitat mapping.

**Output Raster**: Define the output directory and map name. The output map name can be called *05_RFC_[‘enter name’].tif*
!INSTRUCTIONS
.ALGORITHM:model:map combination
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Combine maps

This step replaces the no data value of the no-change areas in the classification map A at time *t1* generated from previous step with the existing classification B at time *t2*.

## Settings

**Classification A**: This is the classification map in change areas “05_RFC_[‘enter name’].tif” produced in previous step.

**Classification B**: This is the classification map for no-change areas at time *t2* (derived from WORKFLOW 2)

**Combined map**: Define the output directory and map name. The output map name can be called *06_Combi_[‘enter name’].tif*
!INSTRUCTIONS
.ALGORITHM:gdal:sieve
.PARAMETERS:{"THRESHOLD": 11, "CONNECTIONS": 1}
.MODE:Normal
.INSTRUCTIONS:# Post-processing

This step eliminates small patches of isolated pixels in the classified image, effectively defining the minimum mapping unit (MMU). The result is a much "cleaner" map.

## Settings

**Input Layer**: This is the classified image from the previous step "06_Combi_[‘enter name’].tif"

**Threshold**: This defines the minimum allowable homogenous group of pixels in the final map. All patches of pixels equal to or below this number are filtered out. The default value is 11 pixels for classification derived from 30m Landsat data (MMU=1ha). Change to 10 pixels for classification derived from 10m Sentinel-2 data (MMU=0.1ha).

**Pixel connection**: This the pattern by which patches of pixels are defined as being connection. The default is 8 meaning all neighbouring pixels are seen as connected.

**Sieved**: Define the output directory and final map name. The output map name can be called *07_MMU_[‘enter name’].tif*
!INSTRUCTIONS

.NAME:1 - Extent
.GROUP:PG#6: Mangrove Mapping
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Mangrove Mapping - Extent
<br><br>


## Objective of the workflow
The Mangrove extent workflow provides a basic classification of mangrove forests in large mangrove-prone areas, as a tool for the inventory, monitoring and assessment of mangroves.

## Theoretical background
The extraction of maps for mangrove extent is a result of combining information from radar imagery and optical data. The methodology is based on a supervised classification using the LibSVM method to classify stacks of combined radar and optical data.

Depending on the region of interest, the Sentinel-1 radar imagery is available at dense (12-day repeat cycle) or less dense time intervals. However, in general it is sufficient to use observations covering different stages of the intra-annual precipitation cycle. To reduce the noise inherent to radar data, averaging over several backscatter images within a particular season helps to improve the overall classification quality.

For the optical part of the classification procedure, Sentinel-2 imagery is used. Due to the fact that many mangrove-prone areas lie within the tropics, where the degree of cloudiness is often high, images of the dry season with no or low cloud cover are used. From images of the dry season the NDWI (Normalized difference water index) or moisture index is derived, using the NIR and SWIR bands of Sentinel-2.

The initial processing steps include the preprocessing of the radar images and the calculation of the moisture index from the optical data. These layers are then combined into a single raster stack.

The supervised LibSVM classification algorithm requires different inputs: the stacked layer with radar backscatter and moisture index, training data of different land cover (mangroves, water, non-mangrove areas with high radar reflectance, other land), and a Digital Elevation model to mask out elevated areas. The output is reclassified to obtain a binary map of the land surface (mangrove, other land, water) and small patches and isolated pixels are removed.

## Data preparation
Before running this workflow you should search for Sentinel-1 and Sentinel-2 images using the **Search & Download Sentinel data workflow** (located in the *I/O* group). You should also use the **Sentinel-1 Pre-processing workflow**  (located in the *I/O* group too) for each image in the Sentinel-1 time-series to be used in the classification. In pre-processing radar backscatter values are calibrated and converted to dB, to ease the interpretation.
Additionally you optionally need a Digital Elevation Model (DEM) covering the AOI.

## References and futher reading
!INSTRUCTIONS
.ALGORITHM:modeler:mm_s1_comb_img
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Calculate mean seasonal backscatter

For the analysis of the Mangrove extent Sentinel-1 radar data is used, which has to be pre-processed before starting with these steps. The pre-processing can be performed using the 'Sentinel-1 Pre-processing' tool.

Sentinel-1 images of different seasons should be included in the analysis, more precisely scenes from the **dry season** and the **wet season**.

If more Sentinel-1 images per season are available, the average backscatter for the season can be derived, which will enhance the quality of the classification, through a smoothing of the pixel values. In this step the mean backscatter value of each band of the radar images, ideally bands with VH and VV polarizations are calculated.

## Settings

**Input layer**: single scenes of one season (up to 3)

**Radar image - band 1**: output of the averaged first band (VH)

**Radar image - band 2**: output of the averaged first band (VV)

## Notes
ATTENTION: Repeat this step for radar images of different seasons!
!INSTRUCTIONS
.ALGORITHM:modeler:mm_s2_ndii
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Sentinel-2: Moisture index / NDII

The **moisture index** is calculated from two bands of the Sentinel-2 satellite, the NIR (near infrared, B8A) and the SWIR (short wavelength infrared, B11), and is a **NDII (Normalized Difference Infrared Index)**. The expression which is used in this calculation is: (B8A – B11) / (B8A + B11).

Before this step Sentinel-2 data has to be downloaded via the the tool **Search & Download Sentinel Data** and pre-processed with the tool **Sentinel-2 Pre-processing**. In the last pre-processing step, the index calculation, the NDII is stored as band 7.

It is better to use images from the dry season, due to less cloud cover, which reduces the number of necessary images.

## Settings

**Sentinel-2 indices**: Raster which contains all Sentinel-2 indices (NDII should be band 7)

**Sentinel-2 NDII**: Define the output directory and layer name of the extracted NDII layer. All NDII layer need to be stored in the same folder.

## Notes

Repeat this step for every Sentinel-2 scene! All extracted NDII layer need to be stored in the same folder.

If in the Sentinel-2 index layer (after pre-processing) the NDII is not band 7 it has to be extracted with the raster calculator.


!INSTRUCTIONS
.ALGORITHM:modeler:mm_s2_ndii_combination
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Sentinel-2: Moisture index / NDII - image combination

If the region of interest has a high cloud cover, more Sentinel-2 scenes are needed to get a **cloud-free NDII image**. After the NDII calculation of different scenes, the images can be combined to a new one, which is not or less affected by clouds.

## Settings

**AOI**: Shapefile of the Area of Interest in the same reference system

**Folder containing NDII images**: Folder in which all single NDII images are stored (no other data must be stored in this folder)

**Combined NDII image**: Define the output directory and layer name

## Notes
All NDII images have to be stored in one directory to compete this step.
!INSTRUCTIONS
.ALGORITHM:modeler:mm_layer_stack
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Create layer stack

All input imagery used for the classification (VH and VV radar backscatter of different seasons, NDII) are merged into a **single raster stack**.

## Settings

**Input layer 1**: radar backscatter VH of dry season

**Input layer 2**: radar backscatter VV of dry season

**Input layer 3**: radar backscatter VH of wet season

**Input layer 4**: radar backscatter VV of wet season

**Input layer 5**: NDII/moisture index

## Notes
ATTENTION: The input imagery needs to be in the same reference system.
!INSTRUCTIONS
.ALGORITHM:modeler:mm_dem_mask
.PARAMETERS:{"demthreshold": 40}
.MODE:Normal
.INSTRUCTIONS:# Create a DEM mask

From a **Digital Elevation Model (DEM)** a mask is derived which excludes all areas which are higher than a specified threshold above sea level. Higher areas are less prone to mangrove vegetation, because of their distance from the sea. The DEM is reclassified and fitted to the layer stack.

Before this step a DEM has to be get, e.g. the SRTM 1 arc-second data downloaded via Earth Explorer (http://earthexplorer.usgs.gov/). The classification works also without DEM mask.

## Settings

**DEM**: Choose the SRTM 1 arc-second tile

**Layer stack**: Layer stack which was generated in the previous step

**DEM threshold**: height above sea level to which mangroves can appear (default value is 40 m)

**DEM mask**: mask where every pixel below threshold has the value 1, and every pixel above the treshold the value 0
!INSTRUCTIONS
.ALGORITHM:modeler:mm_classification
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Supervised classification of layer stack

This step performs a **libSVM classification** relating the input imagery to associated **training polygon or point vector data**. To exclude non-mangrove prone areas, the DEM-mask is included in the processing. A shapefile (.shp) containing polygon or point training data with following classes is required (the class has to be stored in an attribute field named "class"):
1 - mangroves
2 - water
3 - other land
4 - high backscatter (urban areas, such as cities, villages)

## Settings

**DEM mask**: This is the DEM mask created in the previous step.

**Data to be classified**: This is the image stack created in step 4 ('Create layer stack').

**Training data**: This is the vector training data used to classify the imagery. This should be a vector polygon or point shapefile file (.shp) and the projection of this file must be identical to the 'Data to be classified'. The class value must be stored in an attribute field named "class".

**Output classification**: Define the output directory and classification name (or save as temporary file).
!INSTRUCTIONS
.ALGORITHM:modeler:mm_mmu_filter_clean
.PARAMETERS:{"mmupixels": 6}
.MODE:Normal
.INSTRUCTIONS:# Apply MMU filter

This step eliminates isolated pixels and small patches in the classified image, effectively defining the minimum mapping unit (MMU) and also reduces the number of land cover classes calculated in the classification.

## Settings

**Input**: classified image from the previous step.

**MMU**: The number of pixel a patch should contain to not be eliminated, e.g. with a spatial resolution of 10*10 meters the value '6' will issue a MMU of 0,06 ha.

**Output classification**: Define the output directory and classification name.
!INSTRUCTIONS

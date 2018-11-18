.NAME:Wetland Inventory
.GROUP:PG#1: Wetland Inventory
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Wetland Inventory 
<br><br>


## Objective of the workflow
The **Wetland inventory workflow** provides the functionality to derive a raster-based delineation of **wetland/non-wetland** in wetland-prone areas.

## Theoretical background
The creation of the wetland inventory is based on a multi-temporal classification approach using optical and radar data (if available in sufficient quantity). Water and wetness frequency parameters are separately derived for both datasets and fused in the end to give an accurate delineation of the wetlands. The optical approach is based on **Sentinel-2 MSI imagery** for which a selection of spectral indices is calculated. A combination of these indices and the Topographic Wetness Index yields the water and wetness probabilities. Subsequently, split-based Otsu thresholding is applied to derive water and wetness extents for each Sentinel-2 scene (or multi-temporal composites). Finally, all derived extents are aggregated to derive water and wetness frequencies, the Water-Wetness-Probability Index (WWPI) and a wetland classification map. The radar-based algorithm builds on geophysical parameters, surface soil moisture dynamics and water bodies, derived from historical **Envisat ASAR and Sentinel-1 backscatter time series** to identify permanent/temporary wet and flooded areas. In addition, it is possible to identify flooded vegetation according to the double-bounce scattering principle in densely vegetated wetlands. The non-flood prone areas are masked using the Height Above Nearest Drainage (HAND) index which is generated using the digital elevation model and flow direction within the drainage network. Processing of the radar data cannot be done within the toolbox, due to the heavy data load necessary to create the information layers. After the separate processing of the optical and radar imagery, the data is fused into a combined water and wetness product making use of the advantages of both sensor systems.

## Data preparation
Before running this workflow you should search for Sentinel-1 and Sentinel-2 images using the **Search & Download Sentinel data workflow** (located in the *I/O* group). Sentinel-2 imagery needs preprocessing and calculation of indices, which can be accomplished using the **Sentinel-2 Pre-processing workflow** (located in the *I/O* group). The **Sentinel-1 Pre-processing workflow** (located in the *I/O* group too) needs to be applied for each image of the Sentinel-1 time-series. Additionally you need a Digital Elevation Model (DEM) covering the AOI. 

!INSTRUCTIONS
.ALGORITHM:script:fmasklandsat
.PARAMETERS:{"cloudbufferdistance": 150, "greensnowthreshold": 0.1, "nirsnowthreshold": 0.11, "shadowbufferdistance": 300, "mincloudsize": 0, "cloudprobthreshold": 20, "landsatkeynr": 2}
.MODE:Normal
.INSTRUCTIONS:# Cloud masking

In this step cloud masks are generated for Landsat multi-spectral images.

## Settings

**Directory of the Landsat input imagery**:
Specify the path to the directory containing the individual Landsat images in separate folders.

**Landsat sensor**: Specify Landsat mission of the images in use (do not mix images from different missions, but rather process the data for individual missions separately).

**Output cloud mask**:
Specify the path to the output file. Store the cloud mask in the directory of the Landsat product. Choose an output file name that ends with "_fmask.tif".

## Notes

Other parameters can be used to fine-tune the cloud mask, but without expert knowledge it is recommended to keep the default values.
!INSTRUCTIONS
.ALGORITHM:script:maskforsentinel2forwetlandinventory
.PARAMETERS:{"cloudbufferdistance": 150, "verbose": true, "nirsnowthreshold": 0, "shadowbufferdistance": 300, "greensnowthreshold": 0, "mincloudsize": 0, "cloudprobthreshold": 20}
.MODE:Normal
.INSTRUCTIONS:# Cloud masking

In this step cloud masks are generated for Sentinel-2 multi-spectral images.

## Settings

**Directory of Sentinel-2 input imagery**: Specify the path to the folder which contains all Sentinel-2 images in the the SAFE file format. Cloud masks will be produced for every Sentinel-2 observation (located in subfolders) in this folder.

## Notes

The cloud mask will be written to the "IMG_DATA" folder of the respective Sentinel-2 image.

Advanced parameters can be used to fine-tune the cloud mask, but this is only recommended for expert users and we advice to keep the default values.
!INSTRUCTIONS
.ALGORITHM:script:waterandwetnessindices
.PARAMETERS:{"end_date": "", "AOI_type": 0, "extent_coordinates": null, "calculate_wetness_indices": 0, "tile_ID": "", "sensor": 0, "start_date": ""}
.MODE:Normal
.INSTRUCTIONS:# Calculation of water/wetness indices

This module calculates the spectral indices required for the dection of water/wetness in each observation (image).

## Settings

**Directory containing imagery**: Specify the path to the directory in which the imagery is stored.

**Sensor**: Choose whether Sentinel-2 or Landsat imagery is used as input.

**Type of AOI (Area Of Interest)**: Specify how the AOI is defined. The AOI specifies the area which is processed in the succeeding steps. Three options are available:

*1. Shapefile*: Specify the path to the shapefile in the field *Shapefile containing AOI*.
Shapefile containing AOI (optional): Specify the path to the shapefile which contains the AOI.

*2. User defined extent*: Manually draw the extent in the canvas using the field "User defined extent".
User defined extent (optional): Specify the path to the shapefile which contains the AOI.

*3. Joint extent of all scenes*: The AOI is defined by the area that is covered by all input images. This option only works if all scenes share a common extent.

**Output directory**: Specify the path to the directory in which the results should be saved. In this directory a new folder will be created called "Step4_indices" in which all spectral indices will be stored and a folder called "Step4_VRTfiles" in which one VRT file (GDAL virtual stack) for each scene will be stored.


**Advanced parameters (optional)**

**Tile ID / Path Row**: If this parameter is set, only scenes of this TileID (Sentinel-2 e.g. 31TJC) or Path/Row (Landsat, format: PPPRRR e.g. 200205) will be processed.

**Start and end date**: If a start and end date is given, only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.

**Spectral indices for ...**: Specify for which module the spectral indices should be calculated. The indices for the Inundation Regime are  included in the indices for the Wetland Inventory.
!INSTRUCTIONS
.ALGORITHM:modeler:wi_wcr_twi_v1
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Topographic Wetness Index

This module calculates the Topographic Wetness Index (TWI) and a TWI binary mask. This processing step is necessary for both the Wetland Inventory and the Inundation Regime.

## Settings

**Digital Elevation Model (DEM)**: Specify the path to the Digital Elevation Model (DEM), e.g. SRTM 1 Arc-Second Global DEM available at https://earthexplorer.usgs.gov. Make sure that the DEM has a projected coordinate reference systems and not a geographic one.

**AOI as shapefile (optional)**: Specify the path to the shapefile containing a polygon that respresents the Area Of Interest (AOI). The shapefile must contain only one polygon. Make sure that the AOI is at least as big as the one used to calculate the spectral indices. The shapefile needs to have the same coordinate reference system as the DEM.

**Output file (TWI)**: It is recommended to create an output folder for the results of this module called "Step5_TWI" in the same location where the output of the other modules are stored.
Specify the path to the output file for the TWI so that it will be stored in this new directory.
!INSTRUCTIONS
.ALGORITHM:r:waterandwetnessdetection
.PARAMETERS:{"Minimum_water_probability": 45, "End_Date": "", "Minimum_wetness_probability_sparse_vegetation": 55, "Plot_probability": false, "Minimum_wetness_probability_dense_vegetation": 65, "Plot_certainty_indicator": false, "Minimum_mapping_unit": 3, "Minimum_wetness_probability_bare_soil": 55, "Start_Date": ""}
.MODE:Normal
.INSTRUCTIONS:# Water and Wetness Detection

This module performs the water and wetness detection based on the spectral indices and the Topographic Wetness Index (TWI) alculated in the previous Steps.

## Settings

**Directory containing indices**: Specify the path to the spectral indices processed within Step 4.

**Directory containing the TWI**: Specify the path to the Topographic Wetness Index (TWI) and the TWI binary mask calculated in Step 5.

**Output directory**: Specify the path to the folder in which the water and wetness masks should be stored. In this directory a new folder will be created called "Step6_[...]" in which all water and wetness masks will be stored.


**Advanced parameters (optional)**

**Start and end date**: If a start and end date is given, then only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.

**Minimum water probability [0-100%]**: This threshold controls the sensitivity towards water detection. The lower this threshold, the more water will be detected. The value range of this parameter is 0 to 100. For regions containing many narrow rivers, this parameter should be lowered to around 40-50. For coastal areas between 45 and 55.

**Minimum wetness probability  [0-100%]**: This threshold controls the sensitivity of the wetness detection. The lower this threshold, the more wet areas will be detected. This parameter can be controled separately for different land cover types:
- bare soil (NDVI < 0.3)
- sparse vegetation (0.3 < NDVI < 0.5)
- dense vegetation (NDVI > 0.5)

**Minimum mapping unit [pixel]**: Water and wetness patches that are smaller than the minimum mapping unit (MMU) are removed from the water / wetness masks.

**Plot probability**: If this option is activated, the water and wetness probabiliy maps of each scene will be exported to the output directory. The water and wetness probability value indicates how likely it is for each pixel to represent water or wetness.

**Plot certainty indicator**: If this option is activated, a certainty indicator will be calculated for each image and the whole time series to quantify the reliability of the water and wetness masks. The higher the certainty indicator for a particular pixel, the higher the certainty that this pixel was correctly classified, e.g., open water usually has high certainty values, while shallow waters show low certainty values, since they are located at the transition zone between water and land, where a clear distinction is difficult.
!INSTRUCTIONS
.ALGORITHM:script:filtersarwaterandwetnessfrequencies
.PARAMETERS:{"water": true, "wetness": true}
.MODE:Normal
.INSTRUCTIONS:# Filter SAR water and wetness frequencies
(optional)

It is possible to include pre-processed SAR data into the classification, but these must be ordered and processed externally. **Therefore, this step is not mandatory and can be skipped if no SAR data is available.**

This module applies an additional filter to the pre-processed SAR water and wetness frequencies.

## Settings

**Directory containing SAR-based water and wetness frequencies**: Specify the path to the directory in which the SAR-based water and wetness frequencies are stored.

**Output directory**: Specify the path to the directory which shall contain the results. In this directory a new folder will be created called "Step7_SAR_filtered" in which all filtered SAR frequency files will be stored.

At least one of the following parameters must be activated:

**Filter water frequencies**: If this parameter is activated, SAR-based water frequencies will be filtered. (Needed for Wetland Inventory & Inundation Regime)

**Filter wetness frequencies**: If this parameter is activated, SAR-based wetness frequencies will be filtered. (Needed for Wetland Inventory only)
!INSTRUCTIONS
.ALGORITHM:script:opticalsarwaterandwetnessfusion
.PARAMETERS:{"wetness_fusion": true, "start_date": "", "end_date": ""}
.MODE:Normal
.INSTRUCTIONS:# Optical-SAR Water and Wetness Fusion
(optional)
  
Using this optional module (**only if SAR data is available**), the water or wetness frequency layer derived from SAR imagery can be fused with one or several optical water and wetness masks. For wetness, only the wetness masks for bare soil and sparse vegetation will be fused with the SAR data.

## Settings

**Directory containing optical-based water and wetness masks**: Specify the path to the directory containing the water masks derived from Sentinel-2 or Landsat scenes in Step 2.

**SAR-based water frequency**: Specify the path to file containing the SAR-based water frequency. (These are be processed within the GWA Toolbox)

**SAR-based wetness frequency**: Specify the path to file containing the SAR-based wetness frequency. (These are be processed within the GWA Toolbox)

**Output directory**: Specify the path to the folder in which the water masks should be saved. In this directory a new folder will be created called "Step8_[...]_sar" in which the fused water and wetness masks will be stored.

**Start and end date**: If a start and end date are given, then only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.
!INSTRUCTIONS
.ALGORITHM:script:classification
.PARAMETERS:{"low_wetland_prob_thresh": 25, "start_date": "", "end_date": "", "high_wetland_prob_thresh": 50}
.MODE:Normal
.INSTRUCTIONS:# Classification

This module calculates the water and wetness frequencies as well as the final wetland classification and the Water and Wetness Probability Index (WWPI).

## Settings

**Directory containing water and wetness masks**: Specify the path to the folder in which the water and wetness masks (Step 6 or 8) are stored.

**Output directory**: Specify the path to the directory in which the final classification results should be saved. In this directory a new folder will be created called "Step9_[...]_WIclassification" in which the classification results will be stored.

**Advanced parameters (optional)**

**Start and end date**: If a start and end date is given, then only scenes within this time period will be considered for the wetland classification. If left empty, all scenes will be considered. The dates must be given in the format YYYYMMDD.

**WWPI threshold between high and medium wetland probability**: With this parameter the wetland probability classification can be adjusted. This parameter specifies the separation between wetlands with medium and high probability.

**WWPI threshold between medium and low wetland probability**: With this parameter the wetland probability classification can be adjusted. This parameter specifies the separation between wetlands with low and medium probability.
!INSTRUCTIONS

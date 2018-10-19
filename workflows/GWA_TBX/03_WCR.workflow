.NAME:Inundation Regime
.GROUP:PG#3: Inundation Regime
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Inundation Regime
<br /><br />


## Objective of the workflow The inundation regime (IR) product will contain a detailed mapping of the annual variations of the surface water extent (minimum and maximum water extent) inside and around a wetland site.


## Theoretical background
The derivation of the inundation regime is based on a multi-temporal classification approach using optical and radar data (optional, if available in sufficient quantity). Water and wetness frequency parameters will be derived separately for both datasets and fused in the end to give a comprehensive representation of the inundation regime. 

The optical approach is based on Sentinal-2 MSI imagery for which a selection of spectral indices is calculated. A combination of those and the Topographic Wetness Index yield the water probabilities. Split-based Otsu thresholding is applied subsequently to derive water extents for each Sentinel-2 scene. Finally, all derived extents are aggregated to derive the water frequency and the minimum and maximum water extents.

The radar-based algorithm builds on geophysical parameters derived from historical Envisat ASAR and Sentinel-1 backscatter time series to identify flooded areas. In addition, it is possible to identify flooded vegetation according to the double-bounce scattering principle in densely vegetated wetlands. The non-flood prone areas are masked using the Height Above Nearest Drainage (HAND) index which is generated using the digital elevation model and flow direction within the drainage network. The processing of the radar data needs to be externally done, due to the large amount of data involved in the retrieval algorithm.

After the separate processing of the optical and radar imagery, the data is fused to derive a comprehensive representation of the inundation regime making use of the advantages of both sensor systems.

## Data preparation
Before running this workflow you should search for Sentinel-1 and Sentinel-2 images using the **Search & Download Sentinel data workflow** (located in the *I/O* group).

Sentinel-2 imagery needs preprocessing and calculation of indices, which can be accomplished using the **Sentinel-2 Pre-processing workflow** (located in the *I/O* group). 

Radar imagery of Sentinel-1 can be in raw format, as the pre-processing doese take place in this workflow.

Additionally you need a Digital Elevation Model (DEM) covering the AOI.

## References and futher reading
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
.PARAMETERS:{"cloudbufferdistance": 0, "verbose": true, "nirsnowthreshold": 0, "shadowbufferdistance": 0, "greensnowthreshold": 0, "mincloudsize": 0, "cloudprobthreshold": 0}
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
.INSTRUCTIONS:# Calculation of water indices

This module calculates the spectral indices necessary for the detection of water in each observation (image).

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
.ALGORITHM:r:opticalwaterdetection
.PARAMETERS:{"Minimum_water_probability": 45, "End_Date": "", "Plot_water_probability": false, "Minimum_mapping_unit ": 3, "Plot_certainty_indicator": false, "Start_Date": ""}
.MODE:Normal
.INSTRUCTIONS:# Optical Water Detection

This module performs the water detection based on the optical spectral indices and the Topographic Wetness Index (TWI) calculated in the previous Steps.

## Settings

**Directory containing indices**: Specify the path to the directory containing the spectral indices calculated within Step 4.

**Directory containing TWI**: Specify the path to the directory containing the TWI calculated in Step 5.

**Output directory**: Specify the path to the folder in which the water masks should be saved. In this directory a new folder will be created called "Step6_[...]" in which all water masks will be stored.

**Start and end date (optional)**: If a start and end date is given, then only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.

**Minimum water probability [0-100%]**: This threshold controls the sensitivity towards water detection. The lower this threshold, the more water will be detected. The value range of this parameter is 0 to 100. For areas of interest with many narrow rivers, this parameter should be lowered to around 40-50. For coastal areas between 45 and 55.

**Minimum mapping unit [pixel]**: Water and wetness patches that are smaller than the minimum mapping unit (MMU) are removed from the water / wetness masks.

**Plot probability**: If this option is activated, the water and wetness probabiliy maps of each scene will be exported to the output directory. The water and wetness probability value indicates how likely it is for each pixel to represent water or wetness.

**Plot certainty indicator**: If this option is activated, a certainty indicator will be calculated for each image and the whole time series to quantify the reliability of the water and wetness masks. The higher the certainty indicator for a pixel, the higher the certainty that this pixel was correctly classified, e.g., open water usually has high certainty values, while shallow waters show low certainty values, since they are located at the transition zone between water and land, where a clear distinction is difficult.

!INSTRUCTIONS
.ALGORITHM:script:sarwaterdetection
.PARAMETERS:{"startDate": "", "endDate": ""}
.MODE:Normal
.INSTRUCTIONS:# SAR Water Detection

This module performs the water detection based on a number of Sentinel-1 scenes.

## Settings

**Directory containing Sentinel-1 imagery**: Specify the path to the directory containing the Sentinel-1 GRDH imagery in zip format.

**Shapefile containing AOI (optional)**: Specify the path to the shapefile which contains the AOI. Use the same AOI as was used to calculated the spectral indices to make sure that SAR and optical water masks have the same extent.

**Start and end date (optional)**: If a start and end date is given, then only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.

**Output directory**: Specify the path to the folder in which the water masks should be saved. In this directory, a new folder will be created called "Step7_SAR_filtered" in which all filtered SAR frequency files will be stored.

!INSTRUCTIONS
.ALGORITHM:script:opticalsarwaterfusion
.PARAMETERS:{"start_date": "", "end_date": ""}
.MODE:Normal
.INSTRUCTIONS:# Optical-SAR Water Fusion

Using this module, a SAR-based water mask can be fused with one or several optical water masks.

If a water mask is available that is derived from SAR scenes of the dry season, this mask can be fused with all optical water masks to reduce ommission errors.

A water mask derived from SAR scenes in the rainy season should only be fused with an optical water mask from the same season. In this way, data coverage can be improved, since SAR imagery is not sensitive to clouds.

## Settings

**Directory containing optical-based water masks**: Specify the path to the directory containing the water masks derived from Sentinel-2 or Landsat scenes in Step 6.

**SAR-based water mask**: Specify the path to the water mask derived from SAR data created in Step 3.

**Output directory**: Specify the path to the folder in which the water masks should be saved. In this directory a new folder will be created called "Step8_[...]_sar" in which the fused water masks will be stored.


**Advanced parameters (optional)**

**Start and end date**: If a start and end date is given, then only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.

!INSTRUCTIONS
.ALGORITHM:script:classificationwcr
.PARAMETERS:{"min_extent_thresh": 80, "start_date": "", "end_date": "", "max_extent_thresh": 10}
.MODE:Normal
.INSTRUCTIONS:# Classification IR

This module calculates the water frequencies as well as the minimum and maximum water extent of the whole time series.

## Settings

**Directory containing water masks**: Specify the path to the folder in which the water masks (Step 8) are stored.

**Output directory**: Specify the path to the directory in which the final classification results should be saved. In this directory a new folder will be created called "Step9_[...]_IRclassification" in which the classification results will be stored.


**Advanced parameters**

**Start and end date**: If a start and end date is given, then only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.

**Water frequency threshold for maximum water extent**: With this parameter the maximum water extent can be adjusted. Pixels with a water probability higher than this threshold will be classified as temporarily flooded in the maximum water extent.

**Water frequency threshold for minimum water extent**: With this parameter the minimum water extent can be adjusted. Pixels with a water probability higher than this threshold will be classified as permanently flooded in the minimum water extent.

!INSTRUCTIONS

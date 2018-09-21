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
The creation of the wetland inventory is based on a multi-temporal classification approach using optical and radar data (if available in sufficient quantity). Water and wetness frequency parameters are separately derived for both datasets and fused in the end to give an accurate delineation of the wetlands.

The optical approach is based on **Sentinel-2 MSI imagery** for which a selection of spectral indices is calculated. A combination of these indices and the Topographic Wetness Index yields the water and wetness probabilities. Subsequently, split-based Otsu thresholding is applied to derive water and wetness extents for each Sentinel-2 scene (or multi-temporal composites). Finally, all derived extents are aggregated to derive water and wetness frequencies, the Water-Wetness-Probability Index (WWPI) and a wetland classification map.

The radar-based algorithm builds on geophysical parameters, surface soil moisture dynamics and water bodies, derived from historical **Envisat ASAR and Sentinel-1 backscatter time series** to identify permanent/temporary wet and flooded areas. In addition, it is possible to identify flooded vegetation according to the double-bounce scattering principle in densely vegetated wetlands. The non-flood prone areas are masked using the Height Above Nearest Drainage (HAND) index which is generated using the digital elevation model and flow direction within the drainage network. Processing of the radar data cannot be done within the toolbox, due to the heavy data load necessary to create the information layers.
After the separate processing of the optical and radar imagery, the data is fused into a combined water and wetness product making use of the advantages of both sensor systems.

## Data preparation
Before running this workflow you should search for Sentinel-1 and Sentinel-2 images using the **Search & Download Sentinel data workflow** (located in the *I/O* group).

Sentinel-2 imagery needs preprocessing and calculation of indices, which can be accomplished using the **Sentinel-2 Pre-processing workflow** (located in the *I/O* group). 

The **Sentinel-1 Pre-processing workflow** (located in the *I/O* group too) needs to be applied for each image of the Sentinel-1 time-series. 

Additionally you need a Digital Elevation Model (DEM) covering the AOI.

## References and futher reading
!INSTRUCTIONS
.ALGORITHM:modeler:wi_wcr_twi_v1
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Topographic Wetness Index

This module calculates the Topographic Wetness Index (TWI) and a TWI binary mask. This processing step is necessary for both the Wetland Inventory and the Water Cycle Regime.

## Settings

**Digital Elevation Model (DEM)**: Specify the path to the Digital Elevation Model (DEM) e.g. SRTM 1 Arc-Second Global DEM available at https://earthexplorer.usgs.gov. Make sure that the DEM has a projected coordinate reference systems and not a geographic one. 

**AOI as shapefile (optional)**: Specify the path to the shapefile containing a polygon that respresents the Area Of Interest (AOI). The shapefile must contain only one polygon. Make sure that the AOI is at least as big as the one used to calculate the spectral indices. The shapefile needs to have the same coordinate reference system as the DEM.

**Output file (TWI)**: It is recommended to create an output folder for the results of this module called "step4_TWI" in the same location where the output of the other modules are stored. 
Specify the path to the output file for the TWI so that it will be stored in this new directory. 
!INSTRUCTIONS
.ALGORITHM:r:waterandwetnessdetection
.PARAMETERS:{"Minimum_water_probability": 45, "End_Date": "", "Minimum_wetness_probability_sparse_vegetation": 55, "Plot_probability": false, "Minimum_wetness_probability_dense_vegetation": 65, "Plot_certainty_indicator": false, "Minimum_mapping_unit": 3, "Minimum_wetness_probability_bare_soil": 55, "Start_Date": ""}
.MODE:Normal
.INSTRUCTIONS:# Water and Wetness Detection

This module performs the water and wetness detection based on the spectral indices and Topographic Wetness Index (TWI).

## Settings

**Directory containing indices**: Specify the path to the spectral indices processed with the **Sentinel-2 Pre-processing workflow** (located in the *I/O* group).

**Directory containing the TWI**: Specify the path to the Topographic Wetness Index (TWI) and the TWI binary mask calculated in step 1. 

**Output directory**: Specify the path to the folder in which the water and wetness masks should be stored. In this directory a new folder will be created called "step2_[...]" in which all water and wetness masks will be stored. 


**Advanced parameters (optional)**

**Start and end date**: If a start and end date are given, then only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.

**Minimum water probability [0-100%]**: This threshold controls the sensitivity towards water detection. The lower this threshold, the more water will be detected. The value range of this parameter is 0 to 1000. For areas of interest with many narrow rivers, this parameter should be lowered to around 40-50. For coastal areas between 45 and 55. 

**Minimum wetness probability  [0-100%]**: This threshold controls the sensitivity for wetness detection. The lower this threshold, the more wet areas will be detected. This parameter can be controled separately for different land cover types:
- bare soil (NDVI < 0.3)
- sparse vegetation (0.3 < NDVI < 0.5)
- dense vegetation (NDVI > 0.5)

**Minimum mapping unit [pixel]**: Water and wetness patches that are smaller than the minimum mapping unit (MMU) are removed from the water / wetness masks. 

**Plot probability**: If this option is activated, the water and wetness probabiliy maps of each scene will be exported to the output directory. The water and wetness probability value indicates how likely it is for each pixel to represent water or wetness. 

**Plot certainty indicator**: If this option is activated, a certainty indicator will be calculated for each image and the whole time series to quantify the reliability of the water and wetness masks. The higher the certainty indicator for a pixel, the higher the certainty that this pixel was correctly classified e.g. open water usually has high certainty values, while shallow waters show low certainty values, since they are located at the transition zone between water and land, where a clear distinction is difficult.
!INSTRUCTIONS
.ALGORITHM:script:filtersarwaterandwetnessfrequencies
.PARAMETERS:{"water": true, "wetness": true}
.MODE:Normal
.INSTRUCTIONS:# Filter SAR water and wetness frequencies

It is possible to include preprocessed SAR data into the classification, but these must be ordered and processed externally. Therefore, this step is not mandatory. 

This module applies an additional filter to the preprocessed SAR water and wetness frequencies. 

## Settings

**Directory containing SAR based water and wetness frequencies**: Specify the path to the directory in which the SAR based water and wetness frequencies are stored.

**Output directory**: Specify the path to the directory in which the results should be saved. In this directory a new folder will be created called "step3_SAR_filtered" in which all filtered SAR frequency files will be stored. 

At least one of the following parameters must be activated:

**Filter water frequencies**: If this parameter is activated, SAR based water frequencies will be filtered. (Needed for Wetland Inventory & Water Cycle Regime)

**Filter wetness frequencies**: If this parameter is activated, SAR based wetness frequencies will be filtered. (Needed for Wetland Inventory only)
!INSTRUCTIONS
.ALGORITHM:script:opticalsarwaterandwetnessfusion
.PARAMETERS:{"start_date": "", "end_date": ""}
.MODE:Normal
.INSTRUCTIONS:# Optical-SAR Water and Wetness Fusion

Using this module water or wetness frequency layer derived from SAR imagery can be fused with one or several optical water and wetness masks. For wetness only the wetness masks for bare soil and sparse vegetation will be fused with the SAR data. 

## Settings

**Directory containing optical based water and wetness masks**: Specify the path to the directory containing the water masks derived from Sentinel-2 or Landsat scenes in step 2.

**SAR based water frequency**: Specify the path to file containing the SAR based water frequency. (These are be processed within the GWA Toolbox)

**SAR based wetness frequency**: Specify the path to file containing the SAR based wetness frequency. (These are be processed within the GWA Toolbox)

**Output directory**: Specify the path to the folder in which the water masks should be saved. In this directory a new folder will be created called "step4_[...]_sar" in which the fused water and wetness masks will be stored.

**Start and end date**: If a start and end date are given, then only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.
!INSTRUCTIONS
.ALGORITHM:script:classification
.PARAMETERS:{"low_wetland_prob_thresh": 25, "start_date": "", "end_date": "", "high_wetland_prob_thresh": 50}
.MODE:Normal
.INSTRUCTIONS:# Classification

This module calculates the water and wetness frequencies as well as the final wetland classification and the Water Wetness Presence Index (WWPI).

## Settings

**Directory containing water and wetness masks**: Specify the path to the folder in which the water and wetness masks (Step 4) are stored. 

**Output directory**: Specify the path to the directory in which the final classification results should be saved. In this directory a new folder will be created called "step5_[...]_WIclassification" in which the classification results will be stored. 

**Advanced parameters (optional)**

**Start and end date**: If a start and end date are given, then only scenes within this time period will be considered for the wetland classification. If left empty, all scenes will be considered. The dates must be given in the format YYYYMMDD.

**WWPI threshold between high and medium wetland probability**: With this parameter the wetland probability classification can be adjusted. This parameter specifies the separation between wetlands with medium and high probability.

**WWPI threshold between medium and low wetland probability**: With this parameter the wetland probability classification can be adjusted. This parameter specifies the separation between wetlands with low and medium probability.
!INSTRUCTIONS

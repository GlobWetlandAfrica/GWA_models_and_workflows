.NAME:Sentinel-2 Pre-processing
.GROUP:I/O
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Sentinel-2 pre-processing
<br><br>
<br>
<left><img src="images/S2.jpeg" alt="Sentinel-2" width=200></left>
<br><br>

## Objective of workflow
This workflow is used to extract usable imagery from the downloaded Sentinel 2 data. Steps include extracting relevant bands, resampling to a consistent pixel resolution, cloud masking, clipping the data to a specific study area, atmospheric correction, and spectral index calculation.

## Workflow dependencies
This workflow should be run prior to starting the Wetland Inventory and Mangroves Characterization workflows.

### Note
*If multiple images need to be processed users may take note of the individual processing steps and run them in batch mode separately and in sequence.*
!INSTRUCTIONS
.ALGORITHM:script:unzipsentinel2data
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Unzip data

The first step is to Unzip the Sentinel 2 data.

## Settings

**zipped file**: Use the ... button to navigate to the zipped Sentinel 2 file that was downloaded from SciHub.

**Directory to unzip data to**:  Use the ... button to navigate to the folder where you will save the unzipped data.

!INSTRUCTIONS
.ALGORITHM:script:exportsentinel2data
.PARAMETERS:{"out_res": 0, "allVISNIR": false, "B10": false, "bands_param": "", "B11": true, "B4": true, "B5": true, "B6": true, "B7": true, "B12": true, "B1": false, "B2": true, "B3": true, "B8A": true, "B8": true, "B9": false, "granules": ""}
.MODE:Normal
.INSTRUCTIONS:# Export data

This step exports a selection of Sentinel 2 data to a new file for further processing.

## Settings

**Sentinel-2 product folder (.SAFE)**: Use the ... button to navigate to the unzipped .SAFE folder created in the previous step.

**Choose the bands you want to export**. For wetland characterizations  Bands 2-8, 8a, 11, and 12 are the most useful. Choose these 10 bands.

**Output resolution**: Define the resolution of the output imagery. Choose 10 meter.

**Granule selection**: Choose the specific granule(s) that correspond to you study area.

**Directory to save the exported data in**: Use the ... button to navigate to the folder where you will save the output imagery.
!INSTRUCTIONS
.ALGORITHM:script:fmasksentinel2
.PARAMETERS:{"cloudbufferdistance": 150, "verbose": true, "nirsnowthreshold": 0.11, "shadowbufferdistance": 300, "greensnowthreshold": 0.1, "mincloudsize": 0, "cloudprobthreshold": 20}
.MODE:Normal
.INSTRUCTIONS:# Cloud masking

In this step a cloud masks is produced for a Sentinel-2 scene.

## Settings

**Directory of target Sentinel-2 image directory**:
Specify the path to the Sentinel-2 "SAFE" directory. The processed cloud mask will be located in the folder "IMG_DATA" in the directory of the target granule. Please note, if you use Sentinel-2 images that contains several subtiles, you have to navigate to the particular subtile directory


**Output cloud mask**: Specify the path to the output file. Store the cloud mask in the S2 export directory (cf. previous step). Choose an output file name that ends with "_fmask.tif".
Notes

## Notes
Other parameters can be used to fine-tune the cloud mask, but without expert knowledge it is recommended to keep the default values.
!INSTRUCTIONS
.ALGORITHM:gdalogr:cliprasterbyextent
.PARAMETERS:{"ZLEVEL": 6, "PROJWIN": "699960.0,809760.0,8190220.0,8300020.0", "RTYPE": 5, "BIGTIFF": 0, "EXTRA": "", "COMPRESS": 4, "NO_DATA": "", "TILED": false, "JPEGCOMPRESSION": 75, "TFW": false, "PREDICTOR": 1}
.MODE:Normal
.INSTRUCTIONS:# Subset image

This tool clips the imagery to a region of interst that covers your study area.

## Settings:

**Input layer**: Use the ... button to navigate to the exported data from the previous step. If you want to use the entire image you can skip this step.

**Clipping Extent**: The clipping extent can be defined using a vector layer which outlines your study area. This layer must have the same projection as the input imagery. Although you can also define the clipping extent using the QGIS layer canvas, this is not recommended as other data sets may need to be clipped to the exact same extent in later processes (e.g. the cloud mask). Using the vector layer will make this job easy.

**Clipped (extent)**: Use the ... button to navigate to the folder where you will save the output data, and give is a suitable image name: ["enter name"]_Clip.tif

## Notes
If you do not have a vector layer outlining your study region you can create one. In QGIS go to Layer > Create Layer > New Shapefile Layer. Make sure the "Selected CRS" is the same as your input imagery! You can then draw the outline of your study area by editing the shapefile.

Note: This tool can also be used in "Batch" mode. Change the bottom dropdown menu from "Normal" to "Batch" for use in batch mode.
!INSTRUCTIONS
.ALGORITHM:dhigras:atmosphericcorrection
.PARAMETERS:{"PWV": 0, "SATELLITE": 7, "ATMOSPHERIC_PROFILE": 0, "TILE_SIZE_PIXELS": 0, "OZONE": 0, "PANCHROMATIC": false, "AOT": 0, "METHOD": 0}
.MODE:Normal
.INSTRUCTIONS:# Atmospheric Correction

This step performs atmospheric correction to the imagery using Dark Object Subtraction (DOS).

## Settings:

**Satellite**: Select Sentinel-2A 10m.

**DN file**: Select the clipped image from the previous step - ["enter name"]_Clip.tif. If you did not clip the image using step 3, select the exported data from step 2.

**Metafile**: Choose the .xml file that is placed in the original .SAFE folder for the Sentinel 2 data

**Correction methods**: Choose DOS.

**Output file**: Use the ... button to navigate to the directory where you will save the atmospherically corrected data and give it a suitable name - ["enter name"]_DOS.tif

Leave all other parameters at the default values.
!INSTRUCTIONS
.ALGORITHM:script:sentinel2indices
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Index calculation #1

This step calculates 8 spectral indices which are useful for Mangrove Characterization

## Settings

**Input Reflectance Stack**: Input the atmospherically corrected data created in the previous step -  ["enter name"]_DOS.tif

**Folder to save the stack of Indices**: Use the ... button to navigate to the folder where you want to save the indices.

## Notes
The 8 indices that are calculated are: <br>
Band 1: NDVI using S2 bands 8 and 4 <br>
Band 2: NDVI using S2 bands 8a and 4 <br>
Band 3: Red Edge NDI using S2 bands 8a and 5 <br>
Band 4: Red Edge NDI using S2 bands 8a and 6 <br>
Band 5: Red Edge NDI using S2 bands 6 and 5 <br>
Band 6: Red Edge NDI using S2 bands 7 and 5 <br>
Band 7: NDII using S2 bands 8a and 11 <br>
Band 8: NDWI using S2 bands 8a and 12 <br>
!INSTRUCTIONS
.ALGORITHM:script:waterandwetnessindices
.PARAMETERS:{"end_date": "", "AOI_type": 0, "extent_coordinates": null, "calculate_wetness_indices": 0, "tile_ID": "", "sensor": 0, "start_date": ""}
.MODE:Normal
.INSTRUCTIONS:# Index calculation #2

This module calculates the spectral indices necessary for water detection of each scene i.e. in support of Wetland Inventory and Inundation regime.

## Settings

**Directory containing imagery**: Specify the path to the directory in which the imagery is stored. To avoid problems, the scenes shoud be stored in separate zip compressed folders.

**Sensor**: Choose Landsat imagery as input.

**Type of AOI (Area Of Interest)**:
Specify how the AOI should is defined. There are three options:

1.Shapefile
Specify the path to the shapefile in the field "Shapefile containing AOI".

--> Shapefile containing AOI (optional)
Specify the path to the shapefile which contains an AOI within which the classification should be performed.

2.User defined extent
Manually draw the extent in the canvas using the field "User defined extent".

--> User defined extent (optional)
Specify the path to the shapefile which contains an AOI within which the classification should be performed.

3.Joint extent of all scenes
The AOI is defined by the are that is covered by all input scenes. This option only works if all scenes share a common extent.

**Output directory**: Specify the path to the directory in which the results should be saved. In this directory a new folder will be created called "step4_indices" in which all spectral indices will be stored and a folder called "step4_VRTfiles" in which one vrt file for each scene will be stored.

## Advanced parameters (optional)

**Tile ID / Path Row**: If this parameter is set, only scenes of this Path/Row (Landsat, format: PPPRRR e.g. 200205) will be processed.

**Start and end date**: If a start and end date are given, only scenes within this time period will be processed. If left empty, all scenes will be processed. The dates must be given in the format YYYYMMDD.

**Spectral indices for ...**: Specify for which module the spectral indices should be calculated. The indices for the Inundation Regime are  included in the indices for the Wetland Inventory.
!INSTRUCTIONS
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# H1 Header
## H2
### H3

Emphasis, aka italics, with *asterisks* or _underscores_.

Strong emphasis, aka bold, with **asterisks** or __underscores__.

Combined emphasis with **asterisks and _underscores_**.

Alternatively, for H1 and H2, an underline-ish style:

Alt-H1
======

Alt-H2
------

1. First ordered list item
2. Another item
    * Unordered sub-list.
1. Actual numbers don't matter, just that it's a number
    1. Ordered sub-list
4. And another item.


## More markdown

For more markdown features visit [link](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).
!INSTRUCTIONS

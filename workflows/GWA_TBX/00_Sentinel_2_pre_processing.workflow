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
.ALGORITHM:script:fmasksentinel2
.PARAMETERS:{"cloudbufferdistance": 150, "verbose": true, "nirsnowthreshold": 0.11, "shadowbufferdistance": 300, "greensnowthreshold": 0.1, "mincloudsize": 0, "cloudprobthreshold": 20}
.MODE:Normal
.INSTRUCTIONS:# Cloud masking

In this step a cloud masks is produced for a Sentinel-2 scene.

## Settings

**Directory of target Sentinel-2 image directory**:
Specify the path to the Sentinel-2 "SAFE" directory. The processed cloud mask will be located in the folder "IMG_DATA" in the directory of the target granule. Please note, if you are using Sentinel-2 images that contain several subtiles, you have to navigate to the particular subtile directory


**Output cloud mask**: Specify the path to the output file. Store the cloud mask in the S2 export directory (cf. previous step). Choose an output file name that ends with "_fmask.tif".
Notes

## Notes
Other parameters can be used to fine-tune the cloud mask, but without expert knowledge it is recommended to keep the default values.
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
.ALGORITHM:script:sentinel2atmosphericcorrection
.PARAMETERS:{"method": 0}
.MODE:Normal
.INSTRUCTIONS:# Atmospheric Correction

This step performs atmospheric correction to the imagery using Dark Object Subtraction (DOS).

## Settings:

**Input File**: A band-stacked raster containing Sentinel-2 bands.

**Sentinel-2 metadata file**: Choose the .xml file that is placed in the original .SAFE folder for the Sentinel 2 data.

**Output type**: Choose DOS.

**Output file**: Use the ... button to navigate to the directory where you will save the atmospherically corrected data and give it a suitable name - ["enter name"]_DOS.tif

!INSTRUCTIONS
.ALGORITHM:script:burncloudmask
.PARAMETERS:{"maskWater": false, "maskLand": false, "maskShadow": true, "maskSnow": true, "maskCloud": true, "maskNull": true}
.MODE:Normal
.INSTRUCTIONS:# Apply cloud mask (optional)

In this step you can apply (burn) the cloud mask produced by FMask to the Sentinel-2 stack.

## Settings

**An image file to burn the cloud mask into**:
Specify the path to the Sentinel-2 band-stacked file.

**Cloud mask from FMask**: Specify the path to the corresponding FMask output file.

**Masked output image**:
Use the ... button to navigate to the folder where you will save the output data, and give is a suitable image name: ["enter name"]_Masked.tif

## Notes

In Advanced parameters you can specify which types of FMask classes you would like to be masked. By default the following classes will be masked: null, cloud, shadow, snow.
!INSTRUCTIONS

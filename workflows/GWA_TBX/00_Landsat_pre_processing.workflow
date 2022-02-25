.NAME:Landsat Pre-processing
.GROUP:1. Pre-processing
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Landsat pre-processing
<br><br>
<br>
<left><img src="images/Landsat.jpeg" alt="Landsat" width=200></left>
<br><br>

## Objective of workflow
This workflow is used to prepare Landsat data for analysis. Steps include unzipping, cloud masking, stacking, clipping the data to a specific study area and spectral index calculation.

## Requirements
The workflow works on Landsat Collection-2 Level-2 surface reflectance data which can be ordered here:

[https://earthexplorer.usgs.gov/](https://earthexplorer.usgs.gov/)

## Workflow dependencies
This workflow should be run prior to intergating Landsat imagery into any of the processing workflows.

### Note
*If multiple images need to be processed users may take note of the individual processing steps and run them in batch mode separately and in sequence.*




!INSTRUCTIONS
.ALGORITHM:script:untarimagery
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Untar imagery

The first step is to untar (unpack) the Landsat data. Relevant Landsat bands are loaded into QGIS after they have been unpacked.

## Settings

**tar.gz file**: Use the ... button to navigate to the downloaded Landsat data, and select the tar.gz you want to unpack.

**Folder to unpack the data to**: Use the ... button to navigate to the folder where you want to unpack the Landsat data.


!INSTRUCTIONS
.ALGORITHM:gdal:buildvirtualraster
.PARAMETERS:{"RESOLUTION": 0, "SEPARATE": false, "PROJ_DIFFERENCE": false, "ADD_ALPHA": false, "RESAMPLING": 0, "SRC_NODATA": "", "EXTRA": ""}
.MODE:Normal
.INSTRUCTIONS:# Stack input bands

In this step we build a virtual raster to combine all input bands into a single image stack - One file containing all relevant bands.

Navigate to the folder that you unpacked the Landsat bands to and load the specific bands into QGIS.

## Settings

**Input layers**: Select the input bands.

For Landsat 8 load bands 2,3,4,5,6, and 7.

For Landsat 4, 5, and 7 load bands 1,2,3,4,5, and 7.

**Resolution**: Select average

Make sure **Layer stack** is selected

**Virtual**: Specify name and location of out file (*.vrt)

## Notes
The order of the bands is very important. You must arrange the bands in the correct order from top to bottom in the QGIS Layers Panel. Alternatively, you can reorder the bands in the *Multiple selection* dialog by dragging and dropping.

For example using Landsat 8:

LC81950212017071LGN00_B2
LC81950212017071LGN00_B3
LC81950212017071LGN00_B4
LC81950212017071LGN00_B5
LC81950212017071LGN00_B6
LC81950212017071LGN00_B7


!INSTRUCTIONS
.ALGORITHM:gdal:cliprasterbyextent
.PARAMETERS:{"PROJWIN": "556485.000000000,791715.000000000,6079785.000000000,6318315.000000000 [EPSG:32637]", "NODATA": null, "OPTIONS": "", "DATA_TYPE": 0, "EXTRA": ""}
.MODE:Normal
.INSTRUCTIONS:# Subset image

This tool clips the imagery to a region of interst that covers your study area.

## Settings

**Input layer**: Select the Landsat stack you wish to clip.

**Clipping Extent**: The clipping extent can be defined using a vector layer which outlines your study area. This layer must have the same projection as the input imagery. Although you can also define the clipping extent using the QGIS layer canvas, this is not recommended as other data sets may need to be clipped to the exact same extent in later processes. Using the vector layer will make this job easier.

**Clipped (extent)**: Use the ... button to navigate to the folder where you will save the output data, and give is a suitable image name: ["enter name"]_Clip.tif

## Notes
If you do not have a vector layer outlining your study region you can create one. In QGIS go to Layer > Create Layer > New Shapefile Layer. Make sure the "Selected CRS" is the same as your input imagery! You can then draw the outline of your study area by editing the shapefile.


!INSTRUCTIONS
.ALGORITHM:script:reclassifylandsatqa
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Reclassify Landsat QA_PIXEL band (optional)

In this step you can reclassify the Landsat Quality Assesment bit mask, which contains a cloud mask, into Fmask cloud mask classes. This step is only required if you would like to burn cloud mask into the image in the next step.

## Settings

**Landsat QA_PIXEL file**:
Specify the path to the Landsat QA_PIXEL tif file.

**Reclassified output image**:
Use the ... button to navigate to the folder where you will save the output data, and give is a suitable image name: ["enter name"]_cloudMask.tif

!INSTRUCTIONS
.ALGORITHM:script:burncloudmask
.PARAMETERS:{"maskNull": true, "maskCloud": true, "maskShadow": true, "maskSnow": true, "maskWater": false, "maskLand": false}
.MODE:Normal
.INSTRUCTIONS:# Apply cloud mask (optional)

In this step you can apply (burn) the cloud mask produced by FMask to the Landsat stack. If you have not made a cloud mask, skip this step.

## Settings

**An image file to burn the cloud mask into**:
Specify the path to the Landsat band-stacked file.

**Cloud mask from FMask**: Specify the path to the corresponding FMask output file.

**Masked output image**:
Use the ... button to navigate to the folder where you will save the output data, and give is a suitable image name: ["enter name"]_Masked.tif

## Notes

In Advanced parameters you can specify which types of FMask classes you would like to be masked. By default the following classes will be masked: null, cloud, shadow, snow.


!INSTRUCTIONS
.ALGORITHM:script:landsatindices
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Calculate Landsat Indices

This tool calculates 4 spectral indices which are useful for mapping using Landsat imagery.

The 4 indices that are calculated are:
Band 1: NDVI
Band 2: NDMI
Band 3: NBR
Band 4: NBR2

**Input Reflectance Stack**: Input pre-processed image

**Folder to save the stack of Indices**: Use the ... button to navigate to the **folder** where you want to save the indices.


!INSTRUCTIONS

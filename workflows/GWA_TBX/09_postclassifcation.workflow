.NAME:Wetland change (post-classification comparison)
.GROUP:5. Wetland Indicators
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Wetland changes (post-classification comparison)
<br><br>

## Objective of the workflow
This workflow can be used to compile a detailed tabulation of changes between two land cover classifications.

The workflow has two steps. The first step returns the change statistics for a full image, while the second step should be used if the change statistics should be constrained to a defined region.

## Theoretical background
The analysis focuses primarily on the initial state classification changes; that is, for each initial state class, the analysis identifies the classes into which those pixels changed in the final state image.

The outcome is a change matrix where unchanged areas occupy the diagonal of the matrix while changed areas are represented in the off-diagonal elements of the matrix.

<center><img src="images/ChangeMatrix.jpg" alt="Change Matrix - Example"></center>

## Note
The input images need to have the same reference system and exact same pixel size and x,y dimensions. 

!INSTRUCTIONS
.ALGORITHM:script:postclassificationcomparison
.PARAMETERS:{"extent": "", "w": true}
.MODE:Normal
.INSTRUCTIONS:# Change statistics for full image

This step returns the detailed tabulation of changes between two land cover classifications.

## Settings

**Select Classification of "initial state"**

**Select Classification of "final state"**

Make sure **Wide report** is checked 

**Name for output file containing the change matrix**: Specify the name and location of the output change detection matrix (*.txt)

## Notes
Note that in the report the initial state is listed as MAP2 and the final state as MAP1.
!INSTRUCTIONS
.ALGORITHM:model:Subbasin land cover change
.PARAMETERS:{"NUMBER_RASTERRESOLUTION": 0}
.MODE:Normal
.INSTRUCTIONS:# Change statistics for user defined region

This step returns the detailed tabulation of changes between two land cover classifications within a region specified by the input zone layer.

## Settings

**Select Classification of "initial state"**

**Select Classification of "final state"**

**Zone layer**: Select the input zone layer (*.shp). If the zone layer includes several regions (e.g. sub-catchments) make sure to select the zone of interest from the QGIS canvas.

**raster res**: Specify the raster resolution. This value should be the same as the input classification file.

**Output land cover change matrix**: Specify the name and location of the output change detection matrix (*.txt)

## Notes
Note that in the report the initial state is listed as MAP2 and the final state as MAP1.
!INSTRUCTIONS

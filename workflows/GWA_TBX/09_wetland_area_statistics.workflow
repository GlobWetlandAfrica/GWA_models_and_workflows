.NAME:Wetland area statistics
.GROUP:Wetland Indicators
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Wetland area statistics
<br><br>

## Objective of the workflow
This workflow calculates the area present in each of the categories of a user-selected land cover map. The result will be a list summarizing the areal coverage of each class and the sum of the total mapped area (covered either by entire raster or predefined extent).

The workflow have two steps. The first step returns the area statistics for a full image, while the second step should be used if the wetland area statistics should be constrained to a defined region.

<center><img src="images/AreaStat.jpg" alt="Area Statistics - Example"></center>
!INSTRUCTIONS
.ALGORITHM:grass7:r.report
.PARAMETERS:{"-e": true, "-f": true, "-n": true, "-h": true, "GRASS_REGION_PARAMETER": null, "-N": true, "units": 1, "null": "*", "nsteps": 255}
.MODE:Normal
.INSTRUCTIONS:# Area statistics for full image

This step calculates the area present in each of the categories of a user-selected land cover map.

The statistics is provided for the full image or a regtangular subset (optional).  To constrain the statistics to a irregular sub-region (e.g. a watershed or district boundary) proceed to step 2.

## Settings

**Raster layer(s) to report on**: Select the input classification

**Units**: Specify the desired output units i.e.:
mi: miles
me: meters
k: kilometers
a: acres
h: hectares
c: cell counts
p: percent cover

**Character representing no data cell value**: Leave as deafult

**Number of fp subranges to collect stats from**: Leave as default

**GRASS region extent**: Can be used to constrain the statistics to a specific rectangular subset using a defined layer extent or by drawing on QGIS canvas.

**Report**: Specify the name and location of the output statistics file (*.html)

**Report (raw output)**: Specify the name and location of the output statistics file (*.txt)

!INSTRUCTIONS
.ALGORITHM:model:Subbasin land cover
.PARAMETERS:{"NUMBER_RASTERRES": 0}
.MODE:Normal
.INSTRUCTIONS:# Report area statistics within user defined region

This step calculates the area (in km2) present in each of the categories of a user-selected land cover map and within a region specified by the input zone layer.

## Settings

**Input classification**:Sselect the input land cover classification to report on

**Zone layer**: Select the input Zone layer (*.shp). If the zone layer includes several regions (e.g. sub-catcements) make sure to select the zone of interest from the QGIS canvas.

**raster res**: Specify the raster resolution. This value should be the same as the input classification file.

**Output report file**: Specify name and output location for the output report file (*.html)

## Notes
Make sure that the raster layer (input classification) and vector layer (Zone layer) do have the same reference system to avoid unexpected behavior or results.
!INSTRUCTIONS

.NAME:Wetland time-series analysis
.GROUP:5. Wetland Indicators
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Wetland time-series analysis
<br><br>

## Objective of the workflow
This workflow can be used for time-series analysis in order to extract meaningful statistics and better understanding of seasonal and intra-annual information within an image time-series.  

## Theoretical background
This workflow can be used to analyse time-series data i.e. perform calculations that returns an image where each pixel value is a function of the values assigned to the corresponding pixels in the input image time-series (e.g. min, max, mean, median, quartile, percentile).

<center><img src="images/TimeSeries.jpg" alt="Time-series - Example"></center>

As an optional output the generated image can be smoothed to reduce 'speckle' noise and enhance the overall spatial trends in the output image.
!INSTRUCTIONS
.ALGORITHM:grass7:r.series
.PARAMETERS:{"GRASS_REGION_PARAMETER": null, "range": "-10000000000,10000000000", "-n": false, "GRASS_REGION_CELLSIZE_PARAMETER": 0, "method": 0}
.MODE:Normal
.INSTRUCTIONS:# Time-series statistics

This step makes each pixel value a function of the values as-signed to the corresponding pixels in the input image time-series.

## Settings

**Input raster layer(s)**: Select the input images

Make sure **Propogate NULLs** is deselected

**Aggregation operation**: Select the desired output statistics (e.g. max, mean, median, P90)

**GRASS GIS 7 region extent**: Specify region extent (optional)

**GRAS GIS 7 region cellsize**: Leave as default

**Aggregated**: Specify name and location of output composite image under "Output raster layer"

## Advanced paraemeters

**Ignore values outside this range**: Specify range for values which can be ignored
!INSTRUCTIONS
.ALGORITHM:grass7:r.neighbors
.PARAMETERS:{"GRASS_REGION_CELLSIZE_PARAMETER": 0, "-c": false, "-a": false, "GRASS_REGION_PARAMETER": null, "method": 0, "size": 3}
.MODE:Normal
.INSTRUCTIONS:# Low-pass filtering (optional)

This step can be used to smooth out variability and enhance the overall spatial trends in the composite maps by using a low-pass smoothing filter:

## Settings

**Input raster layer**: Select the input image i.e. the output results of the previous step

**Neighborhood operation**:Select the smoothing option ( e.g. average or median)

**Neighborhood size**: Choze size of the smoothing window (default is 3x3 pixels)

**Neighbors**:  Specify name and location of output  image.

!INSTRUCTIONS

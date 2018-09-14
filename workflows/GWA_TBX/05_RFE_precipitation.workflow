.NAME:Historic and Real-time precipitation
.GROUP:PG#5:River Basin Hydrology
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Historic and Real-time precipitation
<br><br>


## Objective of the workflow
Precipitation are important for basin hydrology (e.g. by impacting runoff and streamflow) as well as for the formation, development, and maintenance of wetland ecosystems.

This workflow provideprovide the necessary tools for downloading daily historic and real-time precipitation for the entire African continent. In addition the workflow also provide for the option to calculate accumulated precipitation, e.g. decadal, monthly or annual rainfall.

## Theoretical background
The precipitation data is based on the Rainfall Estimate (RFE) blended gauge-satellite rainfall product produced by NOAA's Climate Prediction Center. The RFE product is provided as daily as well as decadal data and consists of two sub-products: RFE 1.0 covering January 1999 – November 1999 and RFE 2.0 covering December 1999 – December 2011.

<center><img src="images/RFE_Rainfall.png" alt="RFE - example"></center>

The module connects to the internet and downloads the latest available precipitation data from http://earlywarning.usgs.gov/fews/africa/web/imgbrowsc2.php?extent=afp6. Daily precipitation is stored as geotiff files in the folder specified by the user.

After running this module, the precipitation folder will contain data for the requested period, unless the dataset in the online archive ends earlier. Typically, FEWS-RFE is available with a real-time delay of a few days.

## References and futher reading
* Xie, P. and P. A. Arkin, 1997. A 17-year monthly analysis based on gauge observations, satellite estimates, and numerical model outputs. Bulletin of the American Meteorological Society 78(11): 2539-58
!INSTRUCTIONS
.ALGORITHM:wg9hm:12getfewsrfedataosfwf
.PARAMETERS:{"START_DATE": "20160101", "EXTENT": "0,1,0,1", "END_DATE": "20160630"}
.MODE:Normal
.INSTRUCTIONS:# Download precipitation data

Download daily, pan-African FEWS-RFE precipitation data

## Settings

**Select precipitation folder**: Specify a local directory where the data will be downloaded to (e.g. C:\Data\RFE).

**Start date and End date**: Rainfall data will be downloaded for period between the start and end dates. For dates before the current year, the whole year of data will be downloaded.

**Subset to extent (Advanced parameters)**:
If this field is set, the images will be automatically subsetted to the given extent after downloading. By default the extent cover the entire African continent.
!INSTRUCTIONS
.ALGORITHM:script:grassrseriesforwholedirectory
.PARAMETERS:{"cellSize": 0, "range": "-10000000000,10000000000", "extent": "", "propagateNulls": true, "filenameFormat": "", "operation": 10, "outputFileFormat": "", "groupBy": 0}
.MODE:Normal
.INSTRUCTIONS:# Calculate accumulated rainfall

This step can be used to calculate accumulated rainfall e.g. by month or year.

## Settings

**An image file located in the data directory**:
Select the first rainfall image located in the directory to which the images were downloaded to (e.g. in C:\Data\RFE).

**Input images filename**:
Type the filename of the image selected in the above field with the date string replaced with Y, M and D (e.g. 20140601 = YYYYMMDD). Remember to include file extension (e.g. .tif) as well.

**Output directory**:
Specify the directory where the aggregated evapotranspiration images are to be saved (e.g. C:\Data\RFE\SumMonthly).

**Output image filename**:
Define the output image filename, with the date string replaced by "YMD" (e.g. RFE_sumMonthly_YMD.tif).

**Aggregate operation**:
With the pre-set options the algorithm will group all the images that come from the same year and month and calculate the sum of values for each pixel.

**Propagate NULLs**: when checked pixels with missing values will be ignored.

**Regional extent and Region cellsize**:  Those parameters are optional and allow to subset the region of interest based on a spatial extent selected on the map or based on the extent of another layer. Region cellsize is used for spatial resampling of the pixel size. If settings are left as is, the whole image will be processed at native resolution.

Other settings:
Leave the default values.

## Notes
With the above settings, accumulated monthly rainfall will be calculated. If you want to calculate accumulated yearly rainfall, the "Aggregation condition" needs to be changed to "Year".
!INSTRUCTIONS

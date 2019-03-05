.NAME:2 - Budyko model execution
.GROUP:PG#5: River Basin Hydrology
.ALGORITHM:script:downloadfewsrfedata
.PARAMETERS:{"subset_extent": "0,1,0,1", "start_date": "20130101", "end_date": "20130101"}
.MODE:Normal
.INSTRUCTIONS:#Download FEWS-RFE data

In this step, FEWS-RFE precipitation observations are downloaded.

##Settings

**Select precipitation folder**: Select the directory, where you would like to save the data.

**Start date**: First date of observation. FEWS-RFE records start in 2001.

**Start date**: Last date of observation. FEWS-RFE usually only has a few days of delay before data is available. Be aware, that data is downloaded in bulks of one year.

## Advaced parameters
**Subset to download**: Default downloads global dataset (African continent).

!INSTRUCTIONS
.ALGORITHM:script:downloadecmwfdata
.PARAMETERS:{"subset_extent": "-20,55,-40,40", "token": "", "start_date": "20130101", "end_date": "20130601", "email": ""}
.MODE:Normal
.INSTRUCTIONS:#Download ECMWF Era-Interim data

In this step, ECMWF Era-Interim temperature observations are downloaded.

##Settings

**Select maximum temperature folder**: Select the directory, where you would like to save the maximum temperature data files.

**Select minimum temperature folder**: Select the directory, where you would like to save the minimum temperature data files.

**Start date**: First date of observation. ECMWF records start in 1979. Be aware that precipitation is not available until 2001 if using FEWS-RFE and that downloading can be very slow for large datasets.

**Start date**: Last date of observation. Due to download times, it is recommended to download the dataset in 6 months intervals.

**Email registered with ECMWF**: Before download, you must be a registered user with ECMWF. The login uses your email as username.

**ECMWF token**: Beware this is not your user password. The token can be obtained by following the
<a href="https://confluence.ecmwf.int//display/WEBAPI/Access+ECMWF+Public+Datasets" title="ECMWF data access guide" rel="nofollow">ECMWF data access guide</a>.

## Advaced parameters
**Subset to download**: Default downloads all of the African continent.
!INSTRUCTIONS
.ALGORITHM:script:preparebudykomodelclimatefiles
.PARAMETERS:{"subcatchmap_res": 0.01}
.MODE:Normal
.INSTRUCTIONS:#Prepare Budyko model climate files

In this step, the climate files are processed using zonal statistics to produce time series at point locations. For each subbasin, a time series of weighted mean precipitation and minimum and maximum temperature are produced and associated to the centroid coordinates.

##Settings

**Model description file**: Select model description file produced in previous step.

**Precipitation folder**: Select the directory, where precipitation data is saved.

**Maximum temperature folder**: Select the directory, where maximum temperature data is saved.

**Minimum temperature folder**: Select the directory, where minimum temperature data is saved.

**Resolution of subcatchment map in degrees**: Resolution of subcatchment map used to calculate zonal statistics. If there are very small subbasins, this value may need to be decreased.
!INSTRUCTIONS
.ALGORITHM:script:budykohydrologicalmodel
.PARAMETERS:{"STARTDATE": "", "REACH_NUMBER": 0, "AREA_TO_M": 1, "TIME_RESOLUTION_ID": 0, "N_CLASSES": 20, "FIGURE_TITLE": "", "MODEL_TYPE_ID": 0}
.MODE:Normal
.INSTRUCTIONS:#Budyko Hydrological Model

In this step, the hydrological model is run.

##Settings

**Geometry setup**: This .csv file must be created by the user and should contain the following columns:

<ol>
<li><i>Subbasins</i>: each catchment subbasin must have a line with this column containing the subbasin ID</li>
<li><i>Subbasins</i>: the number of subreaches to divided the subbasin river reach in. Ideally the length of each subreach should not exceed 20 km to ensure stability of the routing module.</li>
<li><i>Length</i>:total length of the reach within each subbasin</li>
<li><i>Width</i>: average width of the reach in each subbasin</li>
<li><i>Slope</i>: average slope of the reach in each subbasin</li>
<li><i>Depth</i>: average depth of the reach in each subbasin - this can be estimated using average width and the method from Andreadis et al. (2013) (</li>
</ol>


**Model setup**: Select the model file created in previous steps.

**Observed-discharge file**: This text file should contain the following columns, separated by semi-columns. The plugin can read GRDC .day and .mon files aswell as different types of observation files:
<ol>
<li><i>Origin</i> Data origin, e.g. GRDC</li>
<li><i>Station</i>: Station name - must match file name without extension</li>
<li><i>ReachNo</i>: Subbasin ID of outlet at discharge station location</li>
<li><i>time_resolution</i>:daily or monthly</li>
</ol>

**Model parameter-file**: If the model has been calibrated, a parameter file can be provided - either using the Spotpy output directly or in a standard .json file.

**Reach number considered**: Select subbasin id of reach outlet to be visualized.

**Stardate**: Select startdate for part of simulation to be visualized.

**Output type**: Select output type: hydrograph (obs: if the time of observation and time of simulation do not match, the time series are overlayed with different x-axis), FDC (flow duration curve) or climatology (daily average discharge).

**Time resolution**: Select daily or monthly time resolution in accordance to observation time resolution.

**Output directory for plots**: Select directory in which to save the plots.


## Advanced parameters:
**Number of volume classes for FDC**: Select number of evaluation points for FDC. This may impact the objective function.

**Title for plot**: Select plot title.



##References
* Andreadis, K. M., Schumann, G. J.-P., Pavelsky, T. (2013): A simple global river bankfull width and depth database, *Water Resour. Res.*, 49, 7164-7168, doi:10.1002/wrcr.2044.
!INSTRUCTIONS

.NAME:Budyko model set-up
.GROUP:PG#5: River Basin Hydrology
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Budyko model set-up
<br><br>


## Objective of the workflow
This regional product will allow to assess the water conditions at a river basin level, through the direct observation of important components of the water cycle budget within a river catchment such as surface water extent and soil moisture, and through the modelling of the water balance and the underlying hydrological mechanisms. These regional products produced at catchment level will allow to assess the impact of human activity (such as water pumping for irrigated crop lands or urban settlements) or the adverse effects of climate changes on wetland areas, in particular in water-limited environments such as in the African drylands.

This workflow allows users to setup a hydrological model for a catchment of interest. The key outputs are simulated river discharge time series at various locations in the basins. The product can be used to establish baseline conditions for poorly gauged and ungauged basins as well as to quantify impacts on hydrological regimes due to climate change, hydraulic infrastructure projects, irrigation diversions etc. The hydrological models are set up using a lumped conceptual rainfall-runoff model developed by Zhang et al. (2008), coupled with a linear cascade of reservoirs, simulating tributary processes (optional), a deep groundwater aquifer (optional), and a Muskingum routing scheme. 

**The focus of this workflow is on setting up a Budyko rainfall-runoff model for a catchment of interest.**

## Theoretical background
Changes in catchment hydrology may impact downstream wetland services. Pertubations include climate change and human activity, including hydraulic constructions such as dams. A hydrological model allows users to simulate important components of the land water balance, and assess these impacts at key points in the catchment. The model used is the lumped conceptual model developed by Zhang et al. (2008) based on Budyko's concept of limits. Details can be found in Zhang et al. (2008) and Kittel et al. (2018). The following graph illustrates the model workflow:
<center><img src="images/budyko_model.png" alt="mangroves_timeseries_evolution", height ="450", with="450"></center>
*Image from Kittel et al. (2018)*

## References and further reading
* Kittel, C. M. M., Nielsen, K., Tøttrup, C., Bauer-Gottwein, P. (2018): Informing a hydrological model of the Ogooué with multi-mission remote sensing data, Hydrol. Earth Syst. Sci., 22, 1453-1472 [10.5194/hess-22-1453-2018]
* Zhang, L., Potter, N., Hickel, K., Zhang, Y., and Shao, Q. (2008): Water balance modeling over variable time scales based on the Budyko framework – Model development and testing, J. Hydrol., 360, 117–131 [https://doi.org/10.1016/j.jhydrol.2008.07.021]
!INSTRUCTIONS
.ALGORITHM:script:mergereprojectandsubset
.PARAMETERS:{"resolution": 0, "extent": ""}
.MODE:Normal
.INSTRUCTIONS:#Merge, reproject and subset SRTM tiles

The first step combines all input imagery used to create the digital elevation model (DEM) of the catchment into 1 single raster file. If you are using only one raster dataset as input you can skip this step.

##Settings

**Input Layers**: Select each of the SRTM tiles you will use for the DEM. Make sure the tiles completely cover you region of interest to avoid border artefacts.

**Metric coordinate system**: Select the appropriate UTM region.

**Spatial resolution**: Select spatial resolution. Leave at 0 for for no change.

**Output image**: Define the output directory and name for your catchment DEM. 


!INSTRUCTIONS
.ALGORITHM:modeler:05_outlet_contributing_areas
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:#Calculate outlet contributing areas.

In this step, the DEM is processed to delineate the flow direction and contributing areas of each individual cell of the raster.

##Settings

**Input DEM**: Select DEM from previous step.

**DEM with pits filled**: Define the output directory and name for the pit-filled DEM. 

**Flow direction**: Define the output directory and name for the flow direction file. This raster will contain the direction of flow from each pixel in the pit-filled DEM.

**Outlet contributing areas**: Define the output directory and name for the contributing areas file. This file contains the number of pixels flowing into each individual pixel of the pit-filled DEM. 

After this step, create a shapefile containing outlets of interest. The outlets must be snapped to the flow paths, i.e. aligned on top of the flow paths.
!INSTRUCTIONS
.ALGORITHM:modeler:05_extract_watersheds
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:#Extract watersheds and stream reach

In this step, the pit-filled DEM, flow direction and outlet points file are processed to extract the watersheds and stream reach.

##Settings

**Pit-filled elevation**: Select pit-filled DEM created in previous step. 

**Flow direction**: Select flow direction file created in previous step. 

**Outlet points**: Select shapefile with outlet points of interest. Make sure the points are aligned on top of the flow paths, or they will be ignored by the algorithm. 

**Stream reach vector**:  Define the output directory and name for the stream reach vector file. This line shapefile contains the river network including upstream and downstream links for each individual river reach. 
 
**Watershed vector**:  Define the output directory and name for the watershed vector file. This area shapefile contains all the catchment subbasins. 

!INSTRUCTIONS
.ALGORITHM:modeler:05_process_catchment_layers
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:#Process catchment layers

In this step, the DEM, catchment layer and stream layer are processed to produce files necessary for use in the Budyko model.

##Settings

**Digital Elevation Model**: Select DEM from previous steps.

**Catchment layer**: Select watershed vector file from previous step.

**Stream layer**: Select stream reach vector file from previous step.

**Catchment centroids**:  Define the output directory and name for the catchment centroids. The centroids will add as virtual climate stations to force the model.
 
**Catchment layer with mean DEM and area**: Define the output directory and name for the updated catchment layer with mean elevation from the DEM and area.
!INSTRUCTIONS
.ALGORITHM:script:generatebudykomodelfiles
.PARAMETERS:{"MODEL_AREACOLUMN": "area", "MODEL_LATCOLUMN": "ycoord", "MODEL_ELEVCOLUMN": "elev_mean", "MODEL_STARTDATE": "20000101", "MODEL_SUBCOLUMN": "ID", "MODEL_LONCOLUMN": "xcoord", "MODEL_PCPFAC": 1, "MODEL_NAME": ""}
.MODE:Normal
.INSTRUCTIONS:#Generate Budyko model files

In this step, files necessary to run the Budyko model are generated. The files contain information on file location and model parameters, and must only be moved with great care.

##Settings

**Storage location for model description file**: Select directory for model description file. Be careful if moving this file, to check the paths saved in the file.

**Name of the model**: Select model name.

**Starting date of the model**: Select starting date - if earlier than first climate observations, the time series will be filled with the daily average. It is advised to add at least one year of warm-up for the model to stabilize. The date must be given in year followed by day of year, e.g. 2001001 is equivalent to 1/1/2001..

**Model sub-basin polygon file**:  Select the updated catchment layer with mean elevation from the DEM and area from the previous step.
 
**Storage location for model cliamte station file**: Select directory for model climate station file. Be careful if moving this file, to check the paths saved in the file. This file will contain all information about the precipitation and temperature stations needed by the model.

**Model sub-basin centroid file**:  Select the catchment centroid layer from the previous step.

##Advanced settings
**Check advanced settings to ensure your catchment shapefile attribute table column names match the default names provided** 


!INSTRUCTIONS
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
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:Placeholder for model calibration
!INSTRUCTIONS

.NAME:Lake water products for recent years (OLCI)
.GROUP:PG#4: Water Quality
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Water Quality in Lakes - processing for recent years based on OLCI
<br><br>

## Objective of the workflow
With this workflow you are able to process 10days or monthly averages of water quality parameters in (larger) lakes starting in November 2016. Several parameters are processed: chlorophyll concentration, total suspended matter and turbidity.Further, an indicator for floating vegetation is provided.
Depending on the number of input products, the results will be several averaged water quality products covering the time span of your input products. The resulting products can be used for investigating spatial and temporal dynamics of the mentioned parameters.
<br>

**This workflow uses OLCI Full Resolution or Reduced Resolution products which have a spatial resolution of 300m/1200m respectively**

<center><img src="images/LakeTurkana_TSM_2017.png" alt="monthly averages of the chlorophyll concentration in Lake Volta derived from OLCI 300m resolution"></center>

## Theoretical background
The retrieval of the water quality parameters are based on different algorithms, which are performing (1) a pre-processing step for pixel identification (non-water pixels are removed from processing) (2) atmospheric correction in order to retrieve the spectral signal from the water, (3) retrieval of water quality parameters providing chlorophyll, suspended matter and turbidity, (4) temporal aggregation over the specified time span. The workflow will guide you through all single steps. Some parameters can be changed, but is works well with all pre-defined parameters that are given within the workflow.

Algorithms used for the single steps:<br>
(1) idepix (Pixel identification tool in SNAP) <br>
(2) BRR for eutrophic waters, C2RCC for turbidity retrieval<br>
(3) MPH for eutrophic chlorophyll retrieval, C2RCC for chlorophyll concentration, suspended matter an turbidity retrieval<br>
(4) Level-3 Binner (SNAP tool)<br>


## Data preparation
The input products are OLCI Level 1b products. They can be used either in standard .SEN3 (Sentinel) format or in BEAM DIMAP format. They can be subsets of the region of interest (e.g. the lake you are interested in) or they can be original products from which the workflow will subset the region of interest. For the second option, a polygon-shapefile is needed to define the area for the subsetting.


## References and further reading
* Brockmann, C., Doerffer, R., Peters, M., Stelzer, K., Embacher, S., Ruescas, A. (2016):  Evolution of the C2RCC Neural Network for Sentinel 2 and 3 for the retrieval of ocean colour products in normal and extreme optically complex waters.- Proceedings ESA Living Planet Symposium Prague (09.-13. May 2016).
* Doerffer, R. and Schiller, H. (2008). MERIS Regional Coastal and Lake Case 2 Water Project Atmospheric Correction ATBD (MERIS Lakes ATBD) (p. 42). Geesthacht, Germany: GKSS.
* Matthews, M. W. (2011). A current review of empirical procedures of remote sensing in inland and near-coastal transitional waters. International Journal of Remote Sensing, 32(21), 6855–6899. Available at: http://doi.org/10.1080/01431161.2010.512947.
* Matthews, M. W. and Odermatt, D. (2015). Improved algorithm for routine monitoring of cyanobacteria and eutrophication in inland and near-coastal waters. Remote Sensing of Environment, 156, 374–382. Available at: http://doi.org/10.1016/j.rse.2014.10.010.



!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameters00olcisubsetting
.PARAMETERS:{"dontsubset": false}
.MODE:Normal
.INSTRUCTIONS:# Step 1: Subset input data to AOI

A shapefile or any other vector delineating your area of interest (AOI).

## Settings

**Input vector**: Browse to a shapefile that surrounds your area of interest (AOI) for subsetting all input images to this AOI.

**Checkbox**: In case your input data is already subsetted to a specific lake or area and you don't want to peform the subsetting, check the "Don't subset products" checkbox. In this case you don't need to select or provide any shapefile, just click on Run.

## Notes
The smaller the region of interest in your shapefile, the faster is the processing of the products.

!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameters01olciidepix
.PARAMETERS:{"CloudBufferWidth": 2, "CloudBuffer": true}
.MODE:Normal
.INSTRUCTIONS:# Step 2: Pixel identification

This step defines the parameters for the cloud detection. It is possible to add a buffer around clouds to improve the cloud detection at cloud borders.

## Settings

**Process cloud buffer**: If selected, a cloud buffer will be added to identified clouds. This reduces wrong pixels at cloud borders in the final products. It is adviced to keep this activated.

**Insert size of cloud buffer in pixel**: specifies the size of the buffer in pixels. The default is a buffer of 2 pixels added to detected cloud.


## Notes
It is recommended to keep the default options. The size of the cloud buffer can be enlarged, if too many artefacts remain in the final products.
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameters02c2rcc
.PARAMETERS:{"AverageSalinity": 1, "AverageTemperature": 15, "validExpression": "not quality_flags.invalid and (not pixel_classif_flags.IDEPIX_LAND or quality_flags.fresh_inland_water) and not (pixel_classif_flags.IDEPIX_CLOUD or pixel_classif_flags.IDEPIX_CLOUD_BUFFER)"}
.MODE:Normal
.INSTRUCTIONS:# Step 3: Total suspended matter retrieval

This step performs one of the algorithms for water quality retrieval. It includes the atmospheric correction as well as the in-water retrieval for total suspended matter concentrations. The parameters enable to specify the salinity and temperature of the lake water and to provide a valid pixel expression for calculating only those water pixels that are not cloud covered.

## Settings

**Average Salinity**: Enter here the salinity of your water. Keep the default value (1.0) for freshwater lakes.

**Average Temperature**: Specifies the temperature of your lake. If the temperature is not known, keep the default value.

**Valid pixel expression**: This expression refers to different flags that are generated in step 1: Pixel identification. Only expert users should change this expression.

## Notes
For salt lakes, the salinity should be adapted. Otherwise it is recommended to keep all default options. <br>
The algorithm that is performed is the C2RCC algorithm.
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameters03olcimphchl
.PARAMETERS:{"MPHvalidPixelExpression": "not quality_flags.invalid and (not pixel_classif_flags.IDEPIX_LAND or quality_flags.fresh_inland_water) and not (pixel_classif_flags.IDEPIX_CLOUD or pixel_classif_flags.IDEPIX_CLOUD_BUFFER)", "MPHchlThreshForFloatFlag": 350, "MPHcyanoMaxValue": 1000}
.MODE:Normal
.INSTRUCTIONS:# Step 4: Chlorophyll retrieval for eutrophic lakes

A second algorithm for water retrieval provides the chlorophyll concentration for eutrophic waters. It comprises an atmospheric correction (rayleigh correction) as well as the water retrieval for chlorophyll concentration.

## Settings

**Valid pixel expression**: This expression refers to different flags that are generated in step 1: Pixel identification. Only expert users should change this expression.

**Cyano maximum value**: Threshold to cap maximum chlorophyll concentration estimated for cyanobacteria-dominant waters.

**CHL threshold for float flag**: This threshold specifies the chlorophyll concentration beyond which the flag for floating vegetation is set.

## Notes
It is recommended to keep all default options. <br>
The algorithm that is performed is the MPH algorithm. It is  valid for Chlorophyll concentration >10-20 mg/m³.

!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameters04olcicrsselect
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Step 5: Set Projection Parameters

This step specifies the projection for the output products.

## Settings

**Define output CRS**: Select the output projection from the drop down list (e.g. WGS_84 EPSG:4326)

## Notes


!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityworkflowsnapgraphprocessor
.PARAMETERS:{"ext": "SEN3"}
.MODE:Normal
.INSTRUCTIONS:# Step 6: Execution of the processing

This step performs the actual processing of the (Level 2) products by using the parameters that have been defined wihin the previous steps.The input products and the output folder need to be selected before starting the processing.

## Settings

**Input Folder**: Select the folder in which the OLCI Level 1 products  are stored. All products within the specified folder will be processed. <br>
*Please note that the specification of the  input folder is mandatory and NOT optional as specified in the formular.*

**Define filename extension of input products**: Use *SEN3* if the input products are stored in the original Sentinel-3 format and *dim* if the input products are stored in BEAM DIMAP format.

**Output Folder**: Select a folder to save all output files. The output comprises water quality indicators in BEAM-DIMAP format (so called Level 2 products). Those products are an intermediate step and will become the input products for the next step (temporal aggregation). <br>
*Please note that the specification of the  output folder is mandatory and NOT optional as specified in the formular.*

## Notes
* All products that are stored in the input folder will be processed. Therefore, the input folder should contain only those products that shall be processed. Otherwise the processing will take longer than needed.
* A very large number of products needs a certain time for processing (depending on the size of the AOI).
* The Input products can be in SEN3 format or in BEAM DIMAP format.
* The input  products can be either OLCI FR (full resolution) or OLCI RR (reduced resolution) products.
* The intermediate products that are generated in this step can be opened and analysed with SNAP or BEAM software packages.
* If something goes wrong, all settings from the previous steps can still be edited after this processing step.
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityworkflowsnapl3binning
.PARAMETERS:{"binning_type": 0, "end_date_string": "2017/01/31", "start_date_string": "2016/12/01", "res": 0.5, "interval": 10, "datepref": "R____", "outpref": "S3A_OL_", "sensor": 0}
.MODE:Normal
.INSTRUCTIONS:# Step 7: Temporal and spatial aggregation (L3-binning)

This step generates temporally aggregated products. The time range and the averaging period can be specified. The output pixel size can also be defined. The number of output products depend on the time span, the time range and averaging period. The output products are in GIS compatible format (geoTIFF) and can be opened in QGIS or any other GIS software.


## Settings

**Input folder**: Select the folder in which the Level 2 products are stored (output step 6) <br>
*Please note that the specification of the  input folder is mandatory and NOT optional as specified in the formular.*

**Select sensor**: Select the sensor of the used L2 products (output step 6). You can select between MERIS and OLCI products. For this workflow you will select OLCI as we want to create Level 3 from OLCI Level 2 data.

**Select start date for binning period**: Specify the start date of the period you want to average.

**Select end date for binning period**: Specify the end date of the period you want to average. Start date and end date define the time span (e.g. one year). How many averaged products will be generated within this period depends on the binning period (e.g. 1 month resulting in 12 output products).

**Define character pattern beore date in filename**: the date of the products is derived from the product names. Therefore, it is necessary to specify the character pattern before the date pattern.

**Select binning type**: The binning type defines the period and way for the averaging: <br>
*Period*: a period in *Number of days* will be averaged. The number of dates is specifie in the field below. <br>
*monthly*: monthly averages will be generated. Complete months will be binned. (1-31; 1-28; 1-31; 1-30;...) <br>
*date to date monthly*: the start date defines the day of the monthly period. It will end at the same day of the set end month. The format has to be YYYY/MM/DD

**Set binning period (in days)**: Specifies the number of days for the binning type *period*. 10 will generate 10days averages, starting with *start date*. This number is only required when using binning type *period*.

**Set spatial resolution**: the pixel size is specified in km/px. It is recommended to choose a pixel size larger than the input pixel size to avoid the Moirée effect (>0.3 for OLCI FR input products and >1.2km for OLCI RR input products).

**Prefix for output filenames**: Define a prefix for the output filenames. The rest of the filename is automatically generated, based on the binned period.

**Output folder**: Select a folder to save all output files. The output comprises temporally averaged water quality indicators in GeoTiff format (layer stack). <br>
*Please note that the specification of the  output folder is mandatory and NOT optional as specified in the formular.*


## Notes
* If something goes wrong, all settings from the previous steps can still be edited after this processing step.
* The output products are in GIS compatible format and can be opened in QGIS or any other GIS software.
* The output products can also be opened in SNAP or BEAM software packages. Here, more metadata is available than in GIS software packages
* The output products contain for each temporal aggregation step the different parameters as single bands.
* The output products can be stacked to thematic image stacks with the workflow "Time series preparation for OLCI temporal averages".

!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityworkflowolcitempdatacleanup
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Step 8: Clean temporal data

This step removes all temporary processing files from your computer created during the previous 8 steps.
<br>
After this step all settings made in steps 1-7 are erased. If you afterwards want to run step 8 again, steps 1-7 have to be repeated.

## Settings
no settings are needed for this step.



## Notes
!INSTRUCTIONS

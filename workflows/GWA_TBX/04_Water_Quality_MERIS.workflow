.NAME:Lake water products for past years 2002-2012 (MERIS)
.GROUP:PG#4:Water Quality
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Water Quality in Lakes - historic processing (2002-2012) based on MERIS
<br><br>

## Objective of the workflow
With this workflow you are able to process 10day- or monthly averages of water quality parameters in (larger) lakes. Several parameters are processed: chlorophyll concentration, total suspended matter and turbidity. Further, an indicator for floating vegetation is provided. Depending on the number of input products, the results will be several averaged water quality products covering the time span of your input products. The resulting products can be used for investigating spatial and temporal dynamics of the mentioned parameters.
<br>

**This workflow uses MERIS Full Resolution products which have a spatial resolution of 300m**

<center><img src="images/LakeTurkana_TSM_2010.png" alt="monthly averages of the chlorophyll concentration in Lake Volta derived from MERIS 300m resolution"></center>

## Theoretical background
The retrieval of the water quality parameters are based on different algorithms, which are performing (1) pre-processing steps for radiometric corrections and for pixel identification (non-water pixels are removed from processing) (2) atmospheric correction in order to retrieve the spectral signal from the water, (3) retrieval of water quality parameters providing chlorophyll, suspended matter and turbidity, (4) temporal aggregation over the specified time span. The workflow will guide you through all single steps. Some parameters can be changed, but is works well with all pre-defined parameters that are given within the workflow.

Algorithms used for the single steps:<br>
(1) Idepix (Pixel identification tool in SNAP) <br>
(2) FUB for oligotrophic lakes, BRR for eutrophic waters, C2RCC for turbidity retrieval<br>
(3) FUB for oligotrophic lakes, MPH for eutrophic chlorophyll retrieval, C2RCC for chlorophyll concentration, suspended matter an turbidity retrieval<br>
(4) Level-3 Binner (SNAP tool)<br>


## Data preparation
The input products are MERIS Level 1b products. They can be either in standards .N1 (ENVISAT) format or in BEAM DIMAP format (BEAM 5.0). They can be subsets of the region of interest (e.g. the lake you are interested in) or they can be original products from which the workflow will subset the region of interest. For the second option, a polygon-shapefile is needed to define the area for the subsetting.


## References and further reading
* Brockmann, C., Doerffer, R., Peters, M., Stelzer, K., Embacher, S., Ruescas, A. (2016):  Evolution of the C2RCC Neural Network for Sentinel 2 and 3 for the retrieval of ocean colour products in normal and extreme optically complex waters.- Proceedings ESA Living Planet Symposium Prague (09.-13. May 2016).
* Doerffer, R. and Schiller, H. (2008). MERIS Regional Coastal and Lake Case 2 Water Project Atmospheric Correction ATBD (MERIS Lakes ATBD) (p. 42). Geesthacht, Germany: GKSS.
* Matthews, M. W. (2011). A current review of empirical procedures of remote sensing in inland and near-coastal transitional waters. International Journal of Remote Sensing, 32(21), 6855–6899. Available at: http://doi.org/10.1080/01431161.2010.512947.
* Matthews, M. W. and Odermatt, D. (2015). Improved algorithm for routine monitoring of cyanobacteria and eutrophication in inland and near-coastal waters. Remote Sensing of Environment, 156, 374–382. Available at: http://doi.org/10.1016/j.rse.2014.10.010.
* Schroeder, T., Behnert, I., Schaale, M., Fischer, J., Doerffer, R. (2007). Atmospheric correction algorithm for MERIS above case‐2 waters. International Journal of Remote Sensing, 28(7), 1469–1486. Available at: http://doi.org/10.1080/01431160600962574.
* Schroeder, T., M. Schaale, Fischer, J. (2007): Retrieval of atmospheric and oceanic properties from MERIS measurements: A new Case-2 water processor for BEAM. IJRS Vol 28 Iss 24.
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameterssubsetting
.PARAMETERS:{"dontsubset": false}
.MODE:Normal
.INSTRUCTIONS:# Step 1: Subset input data to AOI

This step enables you to provide an area of interest (AOI). the region of interest should be stored in a shapefile, containing a box or polygon delineating your lake / AOI.

## Settings

**Input vector**: Browse to a shapefile that surrounds your area of interest (AOI) for subsetting all input images to this AOI.

**Checkbox**: In case your input data is already subsetted to a specific lake or area and you don't want to use a the subsetting, check the "Don't subset products" checkbox. In this case you don't need to select or provide any shapefile, just click Run. The full input products will be processed.

## Notes
* The smaller the region of interest or the input products are, the faster is the processing of the products.
* Only ENVISAT .N1 formats or BEAM5 beam-dimap format can be used as input products (step 8).
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameterscoastcolourl1p
.PARAMETERS:{"CloudBufferWidth": 2, "CloudScreeningAmbiguous": 1.4, "Calibration": false, "Equalization": true, "GlintCloudThresholdAddition": 0.1, "CloudScreeningSure": 1.8, "Smile": true, "IgnoreSeaIceClim": false, "Icol": false}
.MODE:Normal
.INSTRUCTIONS:# Step 2: Radiometric correction and pixel identification

This step defines the parameters for some pre-processing steps such as radiometric correction or cloud detection. It is recommended to keep the default values.

## Settings

**Icol**: Icol is a tool for correcting the adjacency effect. It can improve the results, but it also takes much more time for processing. If Icol shall be applied, the subset (Step 1) needs to be large enough because the surrounding of the lake is needed for assessing the adjacency effect. It is adviced not to select Icol.

**Calibration**: Calibration only needs to be chosen if MERIS 2nd reprocessing data is used. MERIS 3rd reprocessed data must not be processed with this option.

**Smile**: Smile correction should be always selected. It corrects the MERIS images for smile effect and reduces the transition of the camera borders.

**Equalization**: Equalisation should be selected. It improves the striping of MERIS images.

**Ignore sea ice climatology**: This option should not be selected.

**Insert size of cloud buffer in pixel**: specifies the size of the buffer in pixels. The default is a buffer of 2 pixels added to detected cloud.

**Cloud screening ambiguous thresholds**: this threshold manipulates the decision if pixel is clear or cloud; the pixel is flagged as ambiguous cloud. The default value (1.4) should be kept.

**Cloud screening sure thresholds**: this threshold manipulates the decision if a cloud is a sure, opaque cloud or if it is flagged as ambiguous cloud. The default value(1.8) should be kept.

**Glint cloud screening addition**: This threshold changes the cloud detection over sun glint. The default value (0.1) should be kept.

## Notes
* It is recommended to keep the default options.
* The size of the cloud buffer can be enlarged, if too many artefacts remain in the final products.
* If the final products show severe adjacency effect along the shoreline of the lake, try to run Icol and compare the results.
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameterscoastcolourl2r
.PARAMETERS:{"L2RReflectAs": 0, "LandExpression": "l1p_flags.CC_LAND", "L2RToa": false, "ExtremeCaseMode": false, "AverageTemperature": 15, "SnowIceExpression": "l1p_flags.CC_CLOUD or l1p_flags.CC_SNOW_ICE", "AverageSalinity": 1}
.MODE:Normal
.INSTRUCTIONS:# Step 3: Total suspended matter retrieval

This step defines the parameters for one of the algorithms for water qualtity retrieval. It includes the atmospheric correction as well as the in-water retrieval for chlorophyll-, total suspended matter concentrations and
turbidity. The parameters enable to specify the salinity and temperature of the lake water and to provide an expression for excluding land and cloud pixels from the processing.


## Settings

**Average Salinity**: Enter here the salinity of your water. Keep the default value (1.0) for freshwater lakes.

**Average Temperature**: Specifies the temperature of you lake. If the temperature is not known, keep the default value.

**Use extreme case mode**: This option should be selected if the processed lake has high chlorophyll concentration (>80mg/m³) and/or high suspended matter concentration (>80g/m³).

**Land expression**:  expression identifying land pixels. Those pixels will not be processed with the water quality algorithms. Keep the default setting.

**Snow ice expression**: expression identifying cloud and ice pixels. Those pixels will not be processed with the water quality algorithm.

**Calculate L2R TOA**: selecting this option, the processed products will include water leaving reflectances (only Level 2 products). This option should only be selected by expert users knowing how to work with Level 2 products.

**Reflection as...**:  This option enables to store the water leaving reflectances as radiance reflectances or irradiance reflectances. This option is only relevant for expert users. Keep the default.

## Notes
* For salt lakes, the salinity should be adapted. Otherwise it is recommended to keep all default options.
* The algorithm that is performed is the CoastColour algorithm.
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparametersfubwater
.PARAMETERS:{"FubExpression": "(radiance_13- radiance_8)/(radiance_8+ radiance_13) &lt; 0.05 and radiance_13 &lt; 50 and not l1p_flags.CC_CLOUD_SHADOW and not l1p_flags.CC_CLOUD and not l1p_flags.CC_CLOUD_BUFFER and not l1p_flags.CC_LAND and not l1_flags.INVALID", "CheckWhetherSuspectIsValid": true}
.MODE:Normal
.INSTRUCTIONS:# Step 4: Chlorophyll retrieval for oligotrophic water types (FUB/WeW Water Processor)

This step specifies the parameters for the algorithms retrieving chlorophyll concentration for oligotrophic waters. It includes the atmospheric correction as well as the in-water retrieval for chlorophyll concentration.

## Settings

**Check wether suspect is valid**: keep this option selected.

**Expression**: provide an expression to identify the valid pixels. Only valid pixles will be processed. it is recommended to keep the default expression. Only expert users should change the expression.

##Notes
The FUB/WeW Water processor provides the chlorophyll concentration for oligotrohpic waters. it is valid for a chlorophyll concentration < 50mg/m³.
References: Schroeder et al. 2007
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparametersmerismph
.PARAMETERS:{"MPHvalidPixelExpression": "not (l1p_flags.CC_LAND or l1_flags.INVALID or l1p_flags.CC_CLOUD or l1p_flags.CC_CLOUD_BUFFER or l1p_flags.CC_CLOUD_SHADOW)", "MPHchlThreshForFloatFlag": 350, "MPHcyanoMaxValue": 1000}
.MODE:Normal
.INSTRUCTIONS:# Step 5: Chlorophyll retrieval for Eutrophic Lakes

A second algorithm for water retrieval provides the chlorophyll concentration for eutrophic waters. It comprises an atmospheric correction (rayleigh correction) as well as the water retrieval for chlorophyll concentration.

## Settings

**Valid pixel expression**: specifies the valid water pixels that shall be processed. This expression refers to different flags that are generated in step 1: Pixel identification. Only expert users should change this expression.

**Cyano maximum value**: Threshold to cap the maximum chlorophyll concentration estimated for cyanobacteria-dominant waters.

**CHL threshold for float flag**: This threshold specifies the chlorophyll concentration beyond which the flag for floating vegetation is set.

## Notes
* It is recommended to keep all default options.
* The algorithm that is performed is the MPH algorithm (Matthews et al. 2011, 1015).
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameterscoastcolourl2w
.PARAMETERS:{"invalidPixelExpression": "l2r_flags.INPUT_INVALID", "owtType": 0}
.MODE:Normal
.INSTRUCTIONS:# Step 6: Optical Water Type Classification

This step defines the parameters for an optical water type classification.

## Settings

**Invalid pixel expression**: keep this entry default

**Select OWT type**: a list of different water type classifiers is available. Keep the default option for inland water types.


## Notes
* It is recommended to keep the default settings.
* The information about the optical water class is only available in the Level-2 products (intermediate products after step 8).
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityparameterscrsselect
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Step 7: Set Projection Parameters

This step specifies the projection for the output products.

## Settings

**Define output CRS**: Select the output projection from the drop-down list (e.g. WGS_84 EPSG:4326)

## Notes
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityworkflowgraphprocessorv5
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Step 8: Execution of the processing

This step finalises the collection of parameters and performs the actual processing of the products by using the parameters that have been defined within the previous steps. The input products and the folder for the output products need to be selected before starting the processing.

## Settings

**Select files to be processed**: Navigate to the folder in which the MERIS Level 1 products are stored. Select the products you want to process from this folder and press ok. <br>
*Please note that the specification of the  input products is mandatory and NOT optional as specified in the formular.*


**Output Folder**: Select a folder to save the output products. The output comprises water quality indicators in so called Level 2 products in BEAM-DIMAP format. Those products are an intermediate step and will become the input products for the next step (temporal aggregation). <br>
*Please note that the specification of the  output folder is mandatory and NOT optional as specified in the formular.*

## Notes
* The input products must be stored in ENVISAT .N1 format or in BEAM DIMAP format that is generated with BEAM 5.0.
* The processing time depends on the number of input products and the size of the area of interest.
* The input  products can be either MERIS FR (full resolution, 300m) or MERIS RR (reduced resolution, 1km) products.
* The intermediate products that are generated in this step can be opended and analysed with SNAP or BEAM software packages.
* If something goes wrong, all settings from the previous steps can still be edited after this processing step. Use the <back> buttom for stepping back.
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityworkflowsnapl3binning
.PARAMETERS:{"binning_type": 1, "end_date_string": "2008/12/31", "start_date_string": "2008/01/01", "res": 0.5, "interval": 10, "datepref": "BCM", "outpref": "MER_FRS_", "sensor": 1}
.MODE:Normal
.INSTRUCTIONS:# Step 9: Temporal and spatial aggregation (L3-binning)

This step generates temporally aggregated products. The time range and the averaging period can be specified. The output pixel size can also be defined. The number of output products depend on the time span, the time range and averaging period. The output products are in GIS compatible format (geoTIFF) and can be opened in QGIS or any other GIS software.

## Settings

**Input folder**: Select the folder in which the Level 2 data are stored (output step 8) <br>
*Please note that the specification of the  input folder is mandatory and NOT optional as specified in the formular.*

**Select sensor**: Select the sensor of the used L2 products (output step 8). You can select between MERIS and OLCI products. For this workflow you will select MERIS as we want to create the temporal aggregation from the MERIS Level 2 data.

**Select start date for binning period**: Specify the start date of the period you want to average.

**Select end date for binning period**: Specify the end date of the period you want to average. Start date and end date define the time span (e.g. one year). How many averaged products will be generated within this period depends on the binning period (e.g. 1 month resulting in 12 output products).

**Define character pattern before date in filename**: the date of the products is derived from the product names. Therefore it is necessary to specify the character pattern before the date pattern.

**Select binning type**: The binning type defines the period and way for the averaging: <br>
*Period*: a period in *Number of days* will be averaged. The number of dates is specified in the field below.<br>
*monthly*: monthly averages will be generated. Complete months will be binned. (1-31; 1-28; 1-31; 1-30;...) <br>
*date to date monthly*: the start date defines the day of the monthly period. It will end at the same day of the set end month. The format has to be YYYY/MM/DD

**Set binning period (in days)**: Specifies the number of days for the binning type *period*. 10 will generate 10days averages, starting with *start date*. This number is only required when using binning type *period*.

**Set spatial resolution**: the pixel size is specified in km/px. It is recommended to choose a pixel size larger than the input pixel size to avoid the Moirée effect (>0.3 for OLCI FR input products and >1.2km for OLCI RR input products).

**Prefix for output filenames**: Define a prefix for the output filenames. The rest of the filename is automatically generated, based on the binned period.

**Output folder**: Select a folder to save all output files. The output comprises temporally averaged water quality indicators in GeoTiff format (layer stack). <br>
*Please note that the specification of the  output folder is mandatory and NOT optional as specified in the formular.*


## Notes
* If something goes wrong, all settings from the previous steps can still be edited after this processing step.
*  The output products are in GIS compatible format and can be opened in QGIS or any other GIS software.
* The output products can also be opened in SNAP or BEAM software packages. Here, more metadata is available than in GIS software packages
* The output products contain for each temporal aggregation step the different parameters as single bands.
* The output products can be stacked to thematic image stacks with the workflow "Time series preparation for MERIS temporal averages".
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualityworkflowtempdatacleanup
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Step 9: Clean temporal data

This step removes all temporary processing files from your computer created during the previous 8 steps.
<br>
After this step all settings made in steps 1-7 are erased. If you afterwards want to run step 8 again, steps 1-7 have to be repeated.

## Settings
no settings are needed for this step.



## Notes
!INSTRUCTIONS

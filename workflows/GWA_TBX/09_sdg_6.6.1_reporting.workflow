.NAME:SDG 6.6.1 reporting
.GROUP:Wetland Indicators
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# SDG 6.6.1 reporting
<br><br>


## Objective of the workflow
This workflow facilitates reporting of spatial extent data of vegetated wetlands and open water bodies, as required for sub-indicator 1 of SDG Indicator 6.6.1. It takes two or more raster maps (one for the reference period and one or more for the reporting periods) containing wetlands and water bodies classification together with a vector map holding administrative regions and produces reports, statistics tables and statistics file to be used for online visualization. The calculated statistics are total area of each classification class for each given period and relative change of area of each class from the reference period to the reporting period.

## Theoretical background
Statistics calculation follows the "Step-by-step methodology for monitoring ecosystems (6.6.1)" document prepared by UN Water (see references). In particular the following equation is used
<center><img src="images/sdg_6.6.1_percent_change_equation.png" alt="Equation for calculation of percent change"></center>
where &beta; is the average spatial extent for a given class the reference period and &gamma; is the average spatial extent for the reporting period. This means that negative value represents a gain in spatial extent and positive value represents a loss in spatial extent.

## Data preparation
The workflow requires two or more classified wetlands and water bodies raster maps. At least one of those maps should be loaded into the QGIS canvas and should be displayed with a *Singleband pseudocolor* render type with each class having a different color and label. If required, you can change the render type of the raster by right clicking on it in the QGIS *Layer Panel* and selection *Properties*. In the dialog which will appear, select *Singleband pseudocolor* render type under the *Style* tab and assign values for each class.
<center><img src="images/sdg_6.6.1_setting_render_type.png" alt="Setting render type in QGIS"></center>

In addition, a polygon vector holding administrative regions is required. The vector attribute table should have columns with regions' id and name fields (preferably called *aoi_id* and *aoi_name*, but if named differently they can be renamed in the workflow).

## References and further reading
* [Step-by-step methodology for monitoring ecosystems (6.6.1) by UN Water](http://www.unwater.org/publications/step-step-methodology-monitoring-ecosystems-6-6-1/)


!INSTRUCTIONS
.ALGORITHM:qgis:refactorfields
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Rename vector fields.

The administrative regions vector needs to have attribute table fields called *aoi_name* and *aoi_id*. This step can be used to rename the fields if required.

## Settings

**Input layer**: Vector layer containing polygons with administrative regions.

**Fields mapping**: In this table you can rename the field which holds the regions' name to *aoi_name* and the field which holds the regions' id number to *aoi_id*.

**Refactored**: Output filename for the refactored vector layer.

## Notes
If the vector layer already contains the required fields then this step can be skipped.
!INSTRUCTIONS
.ALGORITHM:script:reprojectrasterandvectorlayers
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Reproject raster and vector layers

Because area statistics will be calculated in the subsequent steps, it is important that both the classified raster layer and the administrative vector layer are in the same metric projection (e.g. in an UTM projection).

## Settings

**Raster layer**: Raster map with wetlands and water bodies classes.

**Vector layer**: Vector map with polygons containing administrative regions.

**Metric coordinate system (UTM)**: Select the UTM projection suitable for your area of interest (e.g. in Uganda it would be zone 36). Have a look at the [UTM grid](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system#/media/File:Utm-zones.jpg) if you are not sure which projection to choose.

**Reprojected raster layer**: Output filename for the reprojected raster layer.

**Reprojected vector layer**: Output filename for the reprojected vector layer.

## Notes
If the layers are already in the same metric projection then this step can be skipped.

!INSTRUCTIONS
.ALGORITHM:model:land_cover_area_statstics
.PARAMETERS:{}
.MODE:Batch
.INSTRUCTIONS:# Calculate land cover area statistics

In this step, the area (in km<sup>2</sup>) of each wetland or water class in each administrative region is calculated and saved to a text file. This step processes the classification map from the reference as well as from all the reporting periods.

## Settings

**Classification map**: A raster map in metric projection with the wetlands and water bodies classes. In the first row select the map for the reference period, and in subsequent rows the maps for reporting periods.

**Region polygons**: A vector map with polygons of the administrative regions. It should be in the same metric projection as the *classification map* name and should have *aoi_name* and *aoi_id* fields.

**Output statistics file**: The filename of the text file which will hold the statistics for a given period. If the period covers only one year, then this year should be in the filename (e.g. statistics_2018.txt). If the period covers multiple years, then the start and end years should be in the filename separated by a hyphen (e.g. statistics_2005-2010.txt). The filenames for all the periods should be exactly the same, except for the actual period years.

## Notes
If all the classification maps are not in a metric projection, then the previous step should be repeated.
!INSTRUCTIONS
.ALGORITHM:script:sdg661processrreportstatistics
.PARAMETERS:{"skip_lc": "Non Wetland", "filename": "report_yyyy-yyyy.txt"}
.MODE:Normal
.INSTRUCTIONS:# Collate statistics for different periods.

This step collates the statistics for the reference and reporting periods, calculated in the previous step, into a JSON file to be used for online visualization and CSV files (one per region) to be used for further analysis and plotting.

## Settings

**Classification statistics file for reference period**: A statistics text file for the reference period, produced in the previous step.

**Statistics filename**: The filename of the reference period statistics file but with the actual date replaced by *yyyy* (in case of single year period) or *yyyy-yyyy* (in case of multi-year period).

**Classification map**: The classification raster map for the reference period. The map must be rendered as *Singleband pseudocolor* and its legend must include all the classification classes.

**Land cover class to use only in tables**: This is a website specific parameter. It should hold the name of the class which should not be included in the pie-chart shown on the website.

**Output JSON file**: The filename of the JSON file which will hold all the statistics for all the periods and regions. If the file is to be uploaded to the website then the name should be the same as the name of the vector file holding the regions.

**Output CSV file**: The filename of the CSV file which will hold the statistic tables for one region. If the tables are to be uploaded to the website then the name should be the same as the name of the vector file holding the regions. A separate file will be created for each region by appending the region id to the specified filename.

!INSTRUCTIONS
.ALGORITHM:script:sdg661producereportforagivenperiod
.PARAMETERS:{"period": "2018"}
.MODE:Normal
.INSTRUCTIONS:# Produce PDF reports for each region

For each region in the vector file a PDF report will be created, following a specified template.

## Settings

**JSON file with the statistics**: The JSON file created in the previous step, holding the statistics for all the regions and periods.

**Classification map for the period to report on**: The classification map which will be used in the PDF reports.

**Region polygons**: A vector map with polygons of the administrative regions. An individual report will be created for each polygon in the vector.

**Period to report on**: This period should already have been processed and saved the JSON file. Change statistics between this period and reference period will be included in the report.

**Report template file**: A QGIS composer template which holds the layout of the report. See *Notes* below for more details.

**Output report PDF file**: The filename of the PDF file which will hold the report for one region. If the reports are to be uploaded to the website then the name should be the same as the name of the vector file holding the regions. A separate file will be created for each region by appending the region id to the specified filename.

## Notes
The report template should contain the following elements:

* A map with an id *atlas_map*
* A label with an id *title_label* which can contian *%REGION_NAMES%* tag which will be replaced by the actual region name.
* A label with an id *description_label* which can contain *%REGION_NAMES%*, *%REF_PERIOD%* and *%TARGET_PERIOD%* tags which will be replaced by the actual values.
* An HTML frame with an id *stats_table* which will hold the table with the statistics.
* A legend item with an id *atlas_legend*.

The JSON file, CSV files and PDF files can be uploaded to the web server for online visualization and download if required.

!INSTRUCTIONS

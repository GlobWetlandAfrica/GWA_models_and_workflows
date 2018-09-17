.NAME:Time series preparation for OLCI temporal averages
.GROUP:PG#4:Water Quality
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Water Quality in Lakes - thematic layer stacking for MERIS lake water products
<br><br>

## Objective of the workflow
This workflow sorts the former processed temporal averages of lake water quality products into two raster stacks. One for chlorophyll concentration and one for suspended matter concentrations. This enables the usage of time series player and the format might be better suited for some users.
<br>

**The input to this workflow are the OLCI temporally averaged L3 products (e.g. 10days, monthly averages)**


## Theoretical background
The output format is  a layerstack. The usage of layerstacks in QGIS is described in the User Manual / Training Kit.


## Data preparation
The input products are OLCI Level 3 products that have been processed with the workflow: "Lake water products for recent years (OLCI)".
!INSTRUCTIONS
.ALGORITHM:script:pg04waterqualitypostprocessingfortimeseriesolci
.PARAMETERS:{"outpref": "S3A_OL"}
.MODE:Normal
.INSTRUCTIONS:# Prepare Water Quality Level 3 data for time series analysis

The input- and output folders are specified for the generation of the raster stacking for retrieving thematic raster stacks. Those raster stack contain one band per time period.

## Settings

**Input files to be processed**: multiple level 3 water quality products. (Example: If you have processed one year of data as monthly level 3 products, you know select your 12 level 3 files.)
 <br>
*Please note that the specification of the  input folder is mandatory and NOT optional as specified in the formular.*

**Output prefix**: for the created time series products. For OLCI FR products this can be OLCI_FR. If you want to indicate a certain year or period, you could also include for example OLC_FR_2008_monthly


**Output Folder**: Select a folder for you output(s). <br>
*Please note that the specification of the  output folder is mandatory and NOT optional as specified in the formular.*

## Notes
* The Output are two raster stacks with as many bands as your level 3 products (e.g. 12, one for each month of a year). One stack now holds all eutrophic_chl products, while the other stack holds all tsm_nechad_865 products.
* The two stacks can afterwards be used with the Spectral/Temporal Profile Tool in QGIS.

!INSTRUCTIONS

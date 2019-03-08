.NAME:Search & Download Sentinel data
.GROUP:I/O
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Search & Download Sentinel data
<br><br>

Data from the European Copernicus Sentinels Missions are made available systematically and free of charge to all data users including the general public, scientific and commercial users.
<br><br>
<br>
<left><img src="images/sentinel_infographic.jpg" alt="Sentinels" width=800></left>
<br><br>

## Objective of workflow
This workflow is used to search and download Sentinel data using ESA’s SciHub API. Imagery from Sentinels 1, 2 and 3 can be downloaded with this tool.

### Note
*To to use this workflow you need a user account from*: [https://scihub.copernicus.eu/dhus](https://scihub.copernicus.eu/dhus)
!INSTRUCTIONS
.ALGORITHM:script:downloadsentinel
.PARAMETERS:{"END": "NOW", "PRODUCTTYPE": 0, "INSTRUMENT": 0, "URL": "https://scihub.copernicus.eu/apihub/", "FOOTPRINTS": false, "NAME": "", "START": "NOW-1DAY", "LIMIT": 0, "USER": "", "EXTENT": null, "SENTINEL": 0, "QUERY": "", "PASSWORD": "", "DOWNLOAD": false, "CLOUD": 0, "UUID": ""}
.MODE:Normal
.INSTRUCTIONS:# Search and download Sentinel data

In this step you will search and download Sentinel data for any give region of interest.

**Sentinel satellite constellation**:
Select wether you want to search for S1, S2, S3 or all data from the Sentinel family.

**Start/end date**:
Define the start and end time of the period of interest. You can use relative times like NOW-30DAYS or YYYYMMDD-formatted dates.

**Area of interest extent**:
Provide the extent of the you region of interest.

**Maximum cloud cover in percent**: restrict your search by specifying a maximum cloud cover threshold (Sentinel-2 and Sentinel-3 only).

**Maximum number of products**: Use this option to restrict the number of returned products.

**Create geojson file**:
Load footprints and metadata of query. Useful for viewing your query results without downloading the data yet.

**Set the path where the files will be saved**: Specify name and location of the folder to where the search results shouldl be stored


## Notes
Note: You need a user account from https://scihub.copernicus.eu/dhus
!INSTRUCTIONS

.NAME:Wetland fragmentation
.GROUP:Wetland Indicators
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Wetland Fragmentation
<br><br>


## Objective of the workflow

The steps in this workflow can be used to perform Spatial Pattern Analysis at both landscape and patch-level.
Such analysis is important for assessing and monitoring the ecological integrity and functioning of wetlands.

## Theoretical background

In many applications, the primary interest is in the pattern (i.e., composition and configuration) of the entire landscape mosaic. A good example is in the study of wildlife communities where it has been noted that that wildlife diversity is greater in more diverse and spatially heterogenous landscapes. Thus, the quantification of landscape diversity and heterogeneity has assumed a preeminent role in landscape ecology.

Patch-level statistics are defined for individual patches, and characterize the spatial character and context of patches. For example, many vertebrates require suitable habitat patches larger than some minimum size so it would be useful to know the size of each patch in the landscape. Similarly, some species are adversely affected by edges and are more closely associated with patch interiors so it would be useful to know about patch edges. The probability of occupancy and persistence of an organism in a patch may be related to patch insularity so it would be useful to know about the connectivity of patches. The utility of the patch characteristic information will ultimately depend on the objectives of the investigation.


## References and futher reading
* FRAGSTATS: [http://www.umass.edu/landeco/research/fragstats/fragstats.html](http://www.umass.edu/landeco/research/fragstats/fragstats.html)
!INSTRUCTIONS
.ALGORITHM:lecos:landscapewidestatistics
.PARAMETERS:{"METRIC": 0}
.MODE:Normal
.INSTRUCTIONS:# Landscape wide statistics

This step can be used to quantify landscape patterns throug the calculation of various Landscape-level metrics such as mean patch size and Shannon Diversity Index.

## Settings

**Landscape Grid**: Select your input wetland classification map

**What to calculate**: Select the Landscape metric to be calculated

**Output file**: Specify the name and location of the outputfile (*.csv)

!INSTRUCTIONS
.ALGORITHM:lecos:patchstatistics
.PARAMETERS:{"LC_CLASS": 1, "METRIC": 0}
.MODE:Normal
.INSTRUCTIONS:# Patch statistics

This step can be used to calculate patch-level statistics such metrics such as number and size of patches, patch and edge density as well as patch cohesion index (i.e. connectivity).

## Settings

**Landscape Grid**: Select your input wetland classification map

**Choose Landscape Class**: Specify the raster value of the wetland class to analyse

**What to calculate**: Select the patch metric to be calculated

**Output file**: Specify the name and location of the outputfile (*.csv)
!INSTRUCTIONS

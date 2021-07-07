.NAME:2 - Accuracy Assessment
.GROUP:4. Validation Tools
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Accuracy Assessment
<br><br>


## Objective of the workflow
This tool is used to estimate the accuracy and area statistics, including 95% confidence intervals, for a thematic classification map.


## Theoretical background
The concept of accuracy is central to all geographic data, and validation is now seen as an essential component of all major remote sensing projects. The accuracy assessment approach uses a standard error matrix, reporting User’s and Producer’s accuracy for each class and Overall map accuracy. Confidence intervals (95%) for all accuracy statistics are equally estimated using post-stratification equations outlined by Ollofson et al. (2013). The latter has the added advantage of deriving complimentary unbiased area estimates with confidence intervals for each class. In this way, the uncertainty revealed in the error matrix is used to adjust the mapped area and provide statistically sound area measures of land cover for both Simple Random and Stratified Random sampling designs.


## References and further reading
* P. Olofsson, G.M. Foody, S.V. Stehman, C.E. Woodcock: Making better use of accuracy data in land change studies: Estimating accuracy and area and quantifying uncertainty using stratified estimation. Remote Sensing of Environment, 129 (2013), pp. 122-131
!INSTRUCTIONS
.ALGORITHM:r:weighted_accuracy
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Accuracy assessment

This tool is used to estimate the accuracy and area statistics, including 95% confidence intervals, for classified maps. The input validation sample is weighed by the class area proportions, meaning the resulting statistics are unbiased and statistically sound for both Simple Random and Stratified Random sampling designs.

## Settings

**Classified Map**: enter the classified map here.
NOTE: Values in this raster that are not classified values should be explicitly assigned a "No Data" value.

**Validation Sample**: Choose a point vector file with labelled reference information for each class.

**Validation Label Field**: Choose the attribute from the point vector file that contains the reference labels for each class.

**Unweighted Error Matrix**: Specify the name and location for the reporting file of the standard unweighted error matrix (*.csv).

**Area Weighted Error matrix**: Specify the name and location for the reporting file of the accuracy statistics by weighting the error matrix using area proportions (*.csv).

**Unbiased Area Estimates**: Specify the name and location for the reporting file of the unbiased area estimates for each class (*.csv). NOTE: The mapped area statistics are also included for comparison.
!INSTRUCTIONS

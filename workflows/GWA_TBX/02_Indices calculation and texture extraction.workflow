.NAME:1 - Indices calculation and texture extraction
.GROUP:PG#2: Wetland Habitat Mapping
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Wetland Habitat Mapping
<br><br>


## Objective of the workflow
Spectral vegetation and water indices,  statistical characteristics of temporal-related features, and image texture have long been recognized as valuable in improving land cover/use classification.
**This workflow is used to calculate several vegeation and water indices, multi-temporal NDVI features and image texture that are most useful for wetland habitat mapping from pre-processed Sentinel-2 or Landsat images.**

## Theoretical background
The **Normalized Difference Vegetation Index (NDVI)** is the most well-know and frequently used vegetation indices. The combination of its normalized difference formulation and use of the highest absorption and reflectance regions of chlorophyll make it robust over a wide range of conditions. It is calculated as:
<center><img src="images/WHM_NDVI_equation.png" alt="Equation for NDVI"></center>

The **modified Normalized Difference Water Index (MNDWI)** was designed to maximize the reflectance of the water body in the green band and minimize the reflectance of water body in the SWIR band, efficiently suppressing the signal noise from land cover features of built-up areas. It is calculated as:
<center><img src="images/WHM_MNDWI_equation.png" alt="Equation for MNDWI"></center>

The **difference between NDVI and NDWI (DVW = NDVI - NDWI)** is also included for the classification of wetland covers. The negative DVW values indicate dry bare soil or vegetation, while the positive values represent water or wet surfaces. It is calculated as:
<center><img src="images/WHM_DVW_equation.png" alt="Equation for DVW"></center>

For Sentinel-2 imagery, two versions of the **Red Edge (RE) Normalized Difference Index (NDI)** that could potentially aid the separation of wetland vegetation classes are included and calculated as:
<center><img src="images/WHM_RENDI_equation.png" alt="Equation for Red Edge NDI"></center>

For Landsat imagery, **tasseled cap transformation** is a guided and scaled principal components analysis, which transforms the 6 Landsat bands into 3 bands of known characteristics, **soil brightness, vegetation greenness, and soil/vegetation wetness**. The wetness component contrasts the sum of the visible and near infrared bands with the longer infrared bands to determine the amount of moisture being held by the vegetation or soil. The longer infrared bands are the most sensitive to soil and plant moisture, therefore, the contrast of visible and near infrared bands with the longer infrared bands highlights moisture levels within a scene.

When **multi-temporal images** acquired in different seasons are available, **temporal statistics (i.e., mean, maximum, minimum, range and standard deviation)** derived from time-series vegetation/water index layers are used in the classification as well, as  difference in phenology and seasonality can be useful for the classification.

The **gray level co-occurrence matrix (GLCM)** is adopted to extract second order statistical texture features of the images. Five texture measures were selected based on a preliminary analysis, namely **energy, entropy, difference moment, inertia and Haralick’s correlation**.The calculations of texture statistics are based on a **moving window** around each pixel. In order to decrease the correlation among bands, **principle component analysis** is implemented, and only the first component (preserving around 70% of the total variance of all bands) is used to calculate textual features.

## Data preparation
Before running this workflow you should use the **Sentinel-2 Pre-processing workflow** or **Landsat Pre-processing workflow** (loacated in the *I/O* group) for each image in the Sentinel-2 or Landsat time-series to be used in the classification.

## References and futher reading
* Tucker, C. J. Remote Sensing of Environment (1979) 8: 127. [https://doi.org/10.1016/0034-4257(79)90013-0](https://doi.org/10.1016/0034-4257(79)90013-0)
* Xu, H. International Journal of Remote Sensing (2006) 27: 3025. [https://doi.org/10.1080/01431160600589179](https://doi.org/10.1080/01431160600589179)
* Crist, E. P., & Cicone, R. C. Photogrammetric Engineering and Remote Sensing (1984) 50: 343.
* Haralick, R. M., Shanmugam, K., & Dinstein, I. IEEE Transactions on Systems, Man, and Cybernetics (1973) SMC-3: 610. [https://doi.org/10.1109/TSMC.1973.4309314](https://doi.org/10.1109/TSMC.1973.4309314)

!INSTRUCTIONS
.ALGORITHM:script:vegetationandwaterindices
.PARAMETERS:{"sensor": 0}
.MODE:Normal
.INSTRUCTIONS:# Calculate vegetation and water indices

This tool calculates spectral indices which are useful for wetland habitat mapping using Sentinel-2 (S2) or Landsat imagery.

For Sentinel-2 imagery, 5 indices are calculated :

* Layer 1: NDVI using S2 bands 8 and 4
* Layer 2: Red Edge NDI (NDI8a5) using S2 bands 8a and 5
* Layer 3: Red Edge NDI (NDI705) using S2 bands 7 and 5
* Layer 4: mNDWI using S2 bands 3 and 11
* Layer 5: DVW (NDVI-NDWI) using S2 bands 8 and 4 as well as 3 and 8

For Landsat imagery, 6 indices are calculated:

* Layer 1: NDVI using Landsat bands 4 and 3
* Layer 2: mNDWI using Landsat bands 2 and 5
* Layer 3: DVW (NDVI-NDWI) using Landsat bands 4 and 3 as well as 2 and 4
* Layer 4: Tasseled Cap Brightness index
* Layer 5: Tasseled Cap Greenness index
* Layer 6: Tasseled Cap Wetness index

## Settings

**Direory containing imagery**: Select the folder that contains pre-processed Sentinel-2/Landsat images over a number of dates in different seasons.

**Sensor**: Select the satellite sensor type (Sentinel-2 or Landsat) of the imagery

**Output directory**: Use the ... button to navigate to the folder where you want to save the output.
Subfolder named by index will be automatically created for each index.
!INSTRUCTIONS
.ALGORITHM:script:temporalstatisticsrseries
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:# Calculate temporal statistics

This tool calculates aggregate features (mean, maximum, minimum, range and standard deviation) based on time-series vegetation/water indices. If you use a single-date image, please skip this step.

## Settings

**Directory containing vegetation/water index layers**: Select the folder that contains the indices generated from previous step.

**Output temporal statistics**: Define the output directory and raster stack name. The output image name can be called *[‘enter index  name’]_stats.tif*

## Notes
Do not have indices derived from Landsat and Sentinel-2 images in the same folder. If there are only two-date index layers, only mean and range will be calculated.
!INSTRUCTIONS
.ALGORITHM:modeler:pca texture
.PARAMETERS:{"radius": 11}
.MODE:Normal
.INSTRUCTIONS:# Extract image texture

This tool first implements a Principal Component Analysis and uses the first principal component to calculate 5 Haralick texture features:

* Layer 1: Energy (texture uniformity)
* Layer 2: Entropy (measure of randomness of intensity image)
* Layer 3:Inverse Difference Moment (measure of texture homogeneity)
* Layer 4: Inertia (intensity contrast between a pixel and its neighborhood)
* Layer 5: Haralick Correlation

##Settings:

**Input image**: Select the pre-processed image (same as for Step 1)

**Radius**: The radius of the moving window varies for images with different spatial resolutions. The default is ‘11’ for satellite image with 10m resoluation (Sentinel-2 data) but change this to ‘4’ if image with 30m resoluation (Landsat data) are used.

**Texture features**: Define the output directory and image name. The output image name can be called *[‘enter name’]_texture.tif*
!INSTRUCTIONS

.NAME:Sentinel-1 Pre-processing
.GROUP:I/O
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>
# Sentinel-1 pre-processing
<br><br>
<br>
<left><img src="images/S1.jpeg" alt="Sentinel-1" width=200></left>
<br><br>

## Objective of workflow
This workflow is used to pre-process Sentinel-1 data in order to prepare them for analysis. Steps include clipping the data to a specific study area, radiometric calibration, filtering and geometric correction.

## Workflow dependencies
This workflow should be run prior to intergating Sentinel-1 imagery into any of the processing workflows.

### Note
*If multiple images need to be processed users may take note of the individual processing steps and run them in batch mode separately and in sequence.*
!INSTRUCTIONS
.ALGORITHM:snap:subset
.PARAMETERS:{"sourceBands": "", "copyMetadata": true, "subSamplingY": 1, "geoRegion": null, "subSamplingX": 1}
.MODE:Normal
.INSTRUCTIONS:# Subset image

This first preprocessing step is to subset the image into the Area of Interest to speed up the processing.

## Settings

**Input image (the product which will be subsetted)**:
Select the Zip file containing the Sentinel-1 image to process.
E.g. "S1A_IW_GRDH_1SSV_20141130T233100_20141130T233136_003518_00422D_9C62.zip"

**Spatial extent**:
Here you can select options;
- Use the extent of the map or a layer (e.g. AOI file)
- Select the extent on the canvas (draw a box on the map).
Make sure the coordinates are in lat/lon WGS 84 (EPSG:4326 similar to the input file)

Leave pixel sub-sampling steps equal to 1

**Bands**: Choose the "Amplitude_XX" band for processing.

**Copy metadata**: YES

**Output Image**:
As this is an intermediate result it is okay to save as temporary file (will be named out.tif and automatically deleted when you close QGIS).

But if you want to review the intermediate results save the file as GeoTiff.
Naming tips: prefix "subset_"
Outputname example: "subset_S1A_IW_GRDH_1SSV_20141130T233100.tif"

**Open output file after running algorithm**: YES
!INSTRUCTIONS
.ALGORITHM:snap:applyorbitfile
.PARAMETERS:{"polyDegree": 3, "orbitType": 0, "continueOnFail": false}
.MODE:Normal
.INSTRUCTIONS:# Apply Orbit File

The next step for Sentinel-1 processing consist of retrieving precise orbit information on the exact position of the Sentinel-1 satellite during the acquisition of the image.

## Settings

**Input image**: Select the Sentinel-1 image to process (output from previous step)

**Orbit type**: Select Sentinel Precise (Auto Download). If there is no internet connection, then this step is skipped.

**Output Image**: As this is an intermediate result it is okay to save as temporary file (will be named out.tif and automatically deleted when you close QGIS).

But if you want to review the intermediate results save the file as GeoTiff.
Naming tips: prefix "orb_"
Outputname example: "orb_subset_S1A_IW_GRDH_1SSV_20141130T233100.tif"
!INSTRUCTIONS
.ALGORITHM:snap:calibration
.PARAMETERS:{"outputImageInComplex": false, "createBetaBand": false, "selectedPolarisations": "", "sourceBands": "", "outputBetaBand": false, "outputSigmaBand": true, "auxFile": 1, "outputGammaBand": false, "createGammaBand": false, "outputImageScaleInDb": true}
.MODE:Normal
.INSTRUCTIONS:# Calibration

Sentinel-1 Level 1 data have to be calibrated to obtain Sigma nought values (measure of backscatter in dB).

## Settings

**Input image**: This list of source bands:
Select an Sentinel-1 image as "Input image" (output from previous step) and choose the "Amplitude_XX" band for processing.

**Output Image**: As this is an intermediate result it is okay to save as temporary file (will be named out.tif and automatically deleted when you close QGIS).

But if you want to review the intermediate results save the file as GeoTiff.
Naming tips: prefix "cal_"
Outputname example: "cal_orb_subset_S1A_IW_GRDH_1SSV_20141130T233100.tif"

**Other settings**:
Leave the default values.

**Create Beta band(Advanced)** and **Create Gamma band(Advanced)**:
If you want to produce the Beta or Gamma band information, please enter the output file path here.
!INSTRUCTIONS
.ALGORITHM:snap:lineartofromdb
.PARAMETERS:{"sourceBands": ""}
.MODE:Normal
.INSTRUCTIONS:# Linear to/from dB

This step is to scale the backscatter into the dB domain (generally in the range from -25.5 to 0 dB).

## Settings

**Input image**: Select an Sentinel-1 image (output from previous step).

**The list of source bands**: Choose the "Sigma0_XX" band for processing.

**Output Image**: As this is an intermediate result it is okay to save as temporary file (will be named out.tif and automatically deleted when you close QGIS).

But if you want to review the intermediate results save the file as GeoTiff.
Naming tips: prefix "dB_"
Outputname example: "dB_cal_orb_subset_S1A_IW_GRDH_1SSV_20141130T233100.tif"
!INSTRUCTIONS
.ALGORITHM:snap:terraincorrection
.PARAMETERS:{"applyRadiometricNormalization": false, "saveSigmaNought": false, "sourceBands": "", "saveLocalIncidenceAngle": false, "saveGammaNought": false, "outputComplex": false, "saveIncidenceAngleFromEllipsoid": false, "saveProjectedLocalIncidenceAngle": false, "externalDEMNoDataValue": -32768, "auxFile": 1, "saveDEM": false, "pixelSpacingInDegree": 8.9e-05, "incidenceAngleForSigma0": 1, "demResamplingMethod": 1, "saveLatLon": false, "saveSelectedSourceBand": true, "nodataValueAtSea": false, "demName": 2, "pixelSpacingInMeter": 10, "incidenceAngleForGamma0": 1, "externalDEMApplyEGM": false, "saveBetaNought": false, "imgResamplingMethod": 1}
.MODE:Normal
.INSTRUCTIONS:# Terrain correction

The final step of the basic preprocessing is to perfrom Terrain Correction i.e. transform the image to ground geometry, called orthorectification.

## Settings

**Input image**: The input image has to be a calibrated Sentinel 1 image (output from previous step). In The list of source bands select Sigma0_dB.

**The digital elevation model**: For DEM you can either choose one of the options (like SRTM) in which case the DEM will be downloaded. If you want to use another DEM you have to specify it as an external DEM (cf. advanced parameters).

**The pixel spacing in degrees**: For Sentinel-1: Pixel spacing in degrees: 8.983152841195215E-5 for high resolution and 3.594159451762205E-4 for medium resolution

**The pixle spacing in meters:**: Pixel spacing in meters: 10 for high resolution and 40 for medium resolution.

**Output Image**:
This is the final step, thus give the output a meaningful name.
Naming tips: prefix "TC_"
Outputname example: "TC_dB_cal_orb_subset_S1A_IW_GRDH_1SSV_20141130T233100.tif" or the more simple "S1_20141130.tif"

**Other settings**:
Leave the default values.

## Advanced parameters:

Set **Save selected Source Band** to Yes.

If you want to mask out open water then tickmark **no data value at sea**.

If you want to **save the projected local incidence angle** for normalizing the backscatter later, please activate the "Save projected incidence angle" in the advanced parameters.
!INSTRUCTIONS

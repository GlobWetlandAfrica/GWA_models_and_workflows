.NAME:Wetland area statistics
.GROUP:Wetland Indicators
.ALGORITHM:grass:r.report
.PARAMETERS:{"-e": true, "-f": true, "-n": true, "-h": true, "GRASS_REGION_PARAMETER": null, "units": 1, "null_value": "*", "nsteps": 255}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.5pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:11pt; font-weight:600;">Report area statistics for wetland map</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:11pt; font-weight:600;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">This tool calculates the area present in each of the categories of a user-selected land cover map. The result will be a list summarizing the areal coverage of each class and the sum of the total mapped area (covered either by entire raster or predefined extent).</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt; font-weight:600;">Note: skip this step and use next step if you wish to constrain the wetland area statistics to a defined region.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:8pt;"><br /></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt; text-decoration: underline;">SETTINGS:</span><span style=" font-family:'Arial'; font-size:8pt; text-decoration: underline;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Select the input classification under &quot;Raster layer(s) to report on.</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Specify the desired output units:<br />mi: miles<br />me: meters<br />k: kilometers<br />a: acres<br />h: hectares<br />c: cell counts<br />p: percent cover</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Optional: Spatial subsetting of the image can be done by using Region extent.</span><span style=" font-family:'Arial'; font-size:8pt;"> </span><span style=" font-family:'Arial'; font-size:9pt;">Specify name and output location for the output report file (*.html and *.txt).</span></p></body></html>
!INSTRUCTIONS
.ALGORITHM:modeler:subbasin_lc
.PARAMETERS:{"NUMBER_RASTERRES": 0}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.5pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:11pt; font-weight:600;">Report area statistics for wetland map within user defined region</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:11pt; font-weight:600;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">This tool calculates the land cover areas (km2) found within a region specified by the input zone layer.</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:8pt;"><br /></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt; text-decoration: underline;">SETTINGS:</span><span style=" font-family:'Arial'; font-size:8pt; text-decoration: underline;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Under input classification select the input land cover classification to report on.</span><span style=" font-family:'Arial'; font-size:8pt;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Select the input Zone layer. If the zone layer includes several regions (e.g. sub-catcements) make sure to select the zone of interest from the QGIS canvas.</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Specify the raster resolution. This value should be the same as the input classification file.</span><span style=" font-family:'Arial'; font-size:8pt;"> </span><span style=" font-family:'Arial'; font-size:9pt;">Specify name and output location for the output report file (*.html).</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt; font-weight:600;">Important note</span><span style=" font-family:'Arial'; font-size:9pt;">: Make sure that the raster layer (input classification) and vector layer (Zone layer) do have the same reference system to avoid unexpected behavior or results.</span></p></body></html>
!INSTRUCTIONS

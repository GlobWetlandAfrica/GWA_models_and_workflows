.NAME:Wetland fragmentation
.GROUP:Wetland Indicators
.ALGORITHM:modeler:wi_fragmentation
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'MS Shell Dlg 2'; font-size:7.5pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:11pt; font-weight:600;">Report Wetland Fragmentation</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:11pt; font-weight:600;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">This tool calculates fragmentation classes based on density and connectivity information. The main input for the fragmentation analysis is the binary classification of the Wetland Inventory product based on the probabilistic wetland classification.</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:8pt;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">More detailed information can be found at:</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:8pt;">SAGA Tool Documentation<br/>http://www.saga-gis.org/saga_tool_doc/2.2.4/grid_analysis_15.html</span></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:8pt;">Riitters et al., 2000<br/>https://www.ecologyandsociety.org/vol4/iss2/art3/</span></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Arial'; font-size:9pt;"><br /></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt; text-decoration: underline;">SETTINGS:</span><span style=" font-family:'Arial'; font-size:8pt; text-decoration: underline;"> </span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Input raster: Please select the WWPI classification product as a basis for the fragmentation analysis.</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Output products:</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Connectivity: Specify name and location of output raster containing information on connectivity of wetland areas.</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Density: Specify name and location of output raster containing the WWPI (wetland probability) in percent from 0 to 1.</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Fragmentation classification: Specify name and location of output raster containing fragmentation classes.</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">Fragmentation Summary: Specify name and location of output summary file (CSV) of fragmentation classification.</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt; text-decoration: underline;">Additional Information:</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:'Arial'; font-size:9pt;">The resulting fragmentation classification contains the following classes:</span></p>
<p style=" margin-top:12px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:9pt;">(1) Core area<br />(2) Interior<br />(3) Undetermined<br />(4) Perforated<br />(5) Edge<br />(6) Transitional<br />(7) Patch<br />(8) None</span></p>
!INSTRUCTIONS

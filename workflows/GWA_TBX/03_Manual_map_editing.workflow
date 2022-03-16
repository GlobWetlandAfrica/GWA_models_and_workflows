.NAME:Manual Map Editing
.GROUP:3. Post-processing
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:<img src="images/GlobWetland_Africa.png" alt="GWA_logo" width=250 align="right">
<br>

# Manual Map Editing

## Objective of workflow
This post-processing workflow provides the necessary fucntionality for users to perform manual map editing of a thematic raster layer.

### Workflow dependencies
This workflow can be used for reclassification and updating of thematic outputs such as existing EO based wetland (pre-)Inventories or an output from the Wetland Habitat workflow. The workflow is bulit upon the ThRasE is a Thematic Raster Editor plugin of Qgis and includes a navigation tool and a pixel recoder so users can zoom and modify classifications in problematic regions.

<img src="images/editing_min.gif" alt="ThRasE config" width=500 align="left">
<br>











!INSTRUCTIONS
.ALGORITHM:script:runthrase
.PARAMETERS:{"run_thrase": true}
.MODE:Normal
.INSTRUCTIONS:# Instructions

## Thematic raster to edit
Thematic raster file to edit must be a categorical thematic layer with byte or integer as data type with a specific pixel-value/color associated.

## View config and active layers
The configuration of the view grid is done only when the plugin is opened in the new tab, in it, you can set the columns and rows.

Each view has the option of three layers, you can use one, two or three active layers to view and overlap in the respective order. You can set the opacity of each layer if you need it.

## Editing
Each view has an editing tool, there are three options to edit; pixels, lines or polygons. Each tool has a maximum of 20 actions to do undo or redo. You can use any view for edit, but always the image to edit is the thematic selected even if it is not showing in the view.

## Navigation
The navigation is an optional tool, with the purpose to guarantee the revision of the thematic raster, going tile by tile throughout the thematic file, areas of interest, polygons, points or centroid of polygons.

## Save configuration and restore it
With this Save button you can save all settings and configuration of ThRasE dialog, views, pixel table with colors and values, navigation, current tile, size dialog, current extent, among others.

##### **Optional** - If you are using network layers in the view (such as Google, Bing, Esri satellite) use save/load a Qgis project, important: load first the Qgis project before load the .yml saved with ThRasE.

### Credits
####*ThRasE was developing, designed and implemented by the Group of Forest and Carbon Monitoring System (SMByC), operated by the Institute of Hydrology, Meteorology and Environmental Studies (IDEAM) - Colombia.*

####*Author and developer: Xavier Corredor Ll. Theoretical support, tester and product verification: SMByC-PDI group*









!INSTRUCTIONS

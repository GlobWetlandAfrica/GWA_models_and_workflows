.NAME:Budyko model set-up
.GROUP:Budyko
.ALGORITHM:script:mergereprojectandsubset
.PARAMETERS:{"resolution": 0, "extent": ""}
.MODE:Normal
.INSTRUCTIONS:Merge SRTM tiles, reproject them into metric projection and subset to catchment extent.
!INSTRUCTIONS
.ALGORITHM:modeler:05_outlet_contributing_areas
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:Extract outlet contributing areas. After this step, outlet shapefile has to be created and aligned on top of the flow paths.
!INSTRUCTIONS
.ALGORITHM:modeler:05_extract_watersheds
.PARAMETERS:{"minimumcontributionthresholdforwatershedseparation": 10000}
.MODE:Normal
.INSTRUCTIONS:Extract watersheds and stream reach from the DEM.
!INSTRUCTIONS
.ALGORITHM:modeler:05_process_catchment_layers
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:Prepare watershed and stream layers for use in Budyko model.
!INSTRUCTIONS
.ALGORITHM:script:generatebudykomodelfiles
.PARAMETERS:{"MODEL_AREACOLUMN": "area", "MODEL_LATCOLUMN": "ycoord", "MODEL_ELEVCOLUMN": "elev_mean", "MODEL_STARTDATE": "20000101", "MODEL_SUBCOLUMN": "ID", "MODEL_LONCOLUMN": "xcoord", "MODEL_PCPFAC": 1, "MODEL_NAME": ""}
.MODE:Normal
.INSTRUCTIONS:Prepare model files
!INSTRUCTIONS
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:Placeholder for downloading climate data
!INSTRUCTIONS
.ALGORITHM:script:preparebudykomodelclimatefiles
.PARAMETERS:{"subcatchmap_res": 0.01}
.MODE:Normal
.INSTRUCTIONS:Prepare climate files
!INSTRUCTIONS
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:Placeholder for model calibration
!INSTRUCTIONS

.NAME:Budyko model execution
.GROUP:PG#5: River Basin Hydrology
.ALGORITHM:workflowtools:workflowinstructions
.PARAMETERS:{}
.MODE:Normal
.INSTRUCTIONS:Placeholder for downloading climate data
!INSTRUCTIONS
.ALGORITHM:script:preparebudykomodelclimatefiles
.PARAMETERS:{"subcatchmap_res": 0.01}
.MODE:Normal
.INSTRUCTIONS:Update climate files
!INSTRUCTIONS
.ALGORITHM:script:budykohydrologicalmodel
.PARAMETERS:{"STARTDATE": "", "REACH_NUMBER": 0, "TIME_RESOLUTION_ID": 0, "N_CLASSES": 20, "FIGURE_TITLE": "", "MODEL_TYPE_ID": 0}
.MODE:Normal
.INSTRUCTIONS:Run the model
!INSTRUCTIONS

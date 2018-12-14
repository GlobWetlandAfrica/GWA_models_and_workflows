.NAME:Budyko model execution
.GROUP:PG#5: River Basin Hydrology
.ALGORITHM:script:downloadfewsrfedata
.PARAMETERS:{"subset_extent": "0,1,0,1", "start_date": "20130101", "end_date": "20130101"}
.MODE:Normal
.INSTRUCTIONS:Download rainfall data
!INSTRUCTIONS
.ALGORITHM:script:downloadecmwfdata
.PARAMETERS:{"subset_extent": "-20,55,-40,40", "token": "", "start_date": "20130101", "end_date": "20130601", "email": ""}
.MODE:Normal
.INSTRUCTIONS:Download temperature data
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

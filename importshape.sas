**********************************************************************
** This file outlines steps required to import an Esri shapefile    **
** containing custom polygon definitions into a SAS dataset.        **
** All values specified in <angle brackets> need to be modified     **
** based on the path and files being used.                          **
**********************************************************************

**********************************************************************
** DEFINE LOCATION OF SHAPEFILE(S)                                  **
** --------------------------------                                 **
** Create libname reference to the location of the desired files    **
**                                                                  **
**********************************************************************
;
libname ics 'C:\Users\suksel\OneDrive - SAS\Working On\Current Projects\NHS\Data\SASData';


**********************************************************************
** STEP ONE: IMPORT SHAPEFILE INTO SAS DATASET                      **
** -------------------------------------------                      **
** Proc mapimport requires an ID variable to be specified.  This ID **
** variable must be a unique value for each record in the shapefile **
** attribute table.  If this is a publicly-available shapefile, it  **
** may require using a GIS software application such as ArcGIS or   **
** QGIS to view the contents of the shapefile in order to determine **
** the unique identifier name.                                      **
**********************************************************************
;
proc mapimport out=ics.ics
	datafile='C:\Users\suksel\OneDrive - SAS\Working On\Current Projects\NHS\Data\Source\STP\STP_APR_2021_EN_BFC_V2.shp';

	/* unique identifier in shapefile */
	id OBJECTID;
run;


**********************************************************************
** STEP TWO: ADD SEQUENCE COLUMN                                    **
** ------------------------------                                   **
** A sequence number is required by VA to display custom            **
** polygons.                                                        **
**********************************************************************
;
data ics.ics;
	set ics.ics;
	SEQUENCE = _n_;
run;


**********************************************************************
** STEP THREE: REDUCE DATA TO GET DENSITY COLUMN                    **
** ----------------------------------------                         **
** Generally, shapefiles contain far more data than what is needed  **
** by VA to display the polygon regions. To optimize VA performance,**
** the data can be reduced using PROC GREDUCE.  This step will      **
** process the dataset containing the imported shapefile and add a  **
** Density column.  The level of detail desired can then be         **
** specified as shown in the next step. The ID value used in here   **
** must be the same ID value used in step One.                      **
** This step is optional.                                           **
**********************************************************************
;
proc greduce data=ics.ics out=ics.ics;
	id OBJECTID;
run;


**********************************************************************
** STEP FOUR: LIMIT DATA BASED ON DENSITY                           **
** ---------------------------------------                          **
** Limiting the Density value to <=4 generally provides a good      **
** balance of detail and performance. The value can be adjusted as  **
** needed.                                                          **
** This step is optional.                                           **
**********************************************************************
;

data ics.ics;
  set ics.ics;
  where(density<=4);
run;

data ics.ics_3;
  set ics.ics;
  where(density<=3);
run;

data ics.ics_2;
  set ics.ics;
  where(density<=2);
run;

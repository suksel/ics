# ICS and ICB Data

Shape file was downloaded from here - https://geoportal.statistics.gov.uk/datasets/ons::sustainability-and-transformation-partnerships-april-2021-en-bfc/explore?location=52.273217%2C-2.060989%2C6.94

Then the SAS importshape.sas code was used to import the shape file and create co-ordinates in the resulting SAS dataset ics2 (you would obviously have to modify to point to the folder with the shape file and the location of your output SAS dataset)

The Enterprise Guide project then exported the SAS dataset as a CSV which is zipped (7z) up

The CSV file (in the .7z file) is at Density=2 so ics2

An example using the basic mapping facilities in SAS

![alt text](https://github.com/suksel/ics/blob/main/gmap.jpg?raw=true)

A more advanced example using Visual Analytics - this would allow self-service reporting surfacing measures (Funding, Population) on the map

![alt text](https://github.com/suksel/ics/blob/main/VAReport.jpg?raw=true)

### GNU GPL v3
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)    


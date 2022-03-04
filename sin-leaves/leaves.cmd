@echo off

echo #####################################################
echo ### Query leaves difference between SAP and TRICO ###
echo #####################################################

echo.
echo Please prepare data in the following files:
echo  - data/leaves-sap.csv
echo  - data/leaves-trico.csv
echo.
echo NOTE: Please keep only 1 line of header and remove the extra titlings if any.
echo.
pause

echo.
echo Processing reports . . .

..\sqlite\sqlite3 ..\sqlite\wei.db < sql\leaves-data.sql
..\sqlite\sqlite3 -header -csv ..\sqlite\wei.db < sql\leaves-query.sql > leaves-result.csv

echo.
echo Done.
echo.
echo Please review the report in leaves-result.csv.
echo.
pause

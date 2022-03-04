@echo off

echo ###########################################
echo ### Query leaves difference - AUSTRALIA ###
echo ###########################################

echo.
echo Please prepare data in the following files:
echo  - data/al-leave-request.csv
echo  - data/al-ts-entry.csv
echo.
echo NOTE: Please keep only 1 line of header and remove the extra titlings if any.
echo NOTE: Please save date fields in format "yyyy-MM-dd".
echo.
pause

echo.
echo Processing reports . . .

..\sqlite\sqlite3 ..\sqlite\wei.db < sql\au-leaves-data.sql
..\sqlite\sqlite3 -header -csv ..\sqlite\wei.db < sql\au-leaves-query.sql > au-leaves-result.csv

echo.
echo Done.
echo.
echo Please review the report in au-leaves-result.csv.
echo.
pause

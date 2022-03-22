@echo off

echo ###########################################
echo ### Query leaves difference - SINGAPORE ###
echo ###########################################

echo.
echo Please prepare data in the following files:
echo  - data/sin-leave-request.csv
echo  - data/sin-ts-entry.csv
echo.
echo NOTE: Please keep only 1 line of header and remove the extra titlings if any.
echo NOTE: Please save date fields in format "yyyy-MM-dd".
echo.
pause

echo.
echo Processing reports . . .

..\sqlite\sqlite3 ..\sqlite\wei.db < sql\sin-leaves-data.sql
..\sqlite\sqlite3 -header -csv ..\sqlite\wei.db < sql\sin-leaves-query.sql > sin-leaves-result.csv

echo.
echo Done.
echo.
echo Please review the report in sin-leaves-result.csv.
echo.
pause

@echo off

echo ##################################################
echo ### Query employees difference from last month ###
echo ##################################################

echo.
echo Please prepare data in the following files:
echo  - data/employees-last-month.csv
echo  - data/employees-this-month.csv
echo.
echo NOTE: Please keep only 1 line of header and remove the extra titlings if any.
echo.
pause

echo.
echo Processing reports . . .

..\sqlite\sqlite3 ..\sqlite\wei.db < sql\employees-data.sql
..\sqlite\sqlite3 -header -csv ..\sqlite\wei.db < sql\employees-query.sql > employees-result.csv

echo.
echo Done.
echo.
echo Please review the report in employees-result.csv.
echo.
pause

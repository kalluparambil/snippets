@echo off

setlocal
for /f "skip=8 tokens=2,3,4,5,6,7,8 delims=: " %%D in ('robocopy /l * \ \ /ns /nc /ndl /nfl /np /njh /XF * /XD *') do (
 set "dow=%%D"
 set "month=%%E"
 set "day=%%F"
 set "HH=%%G"
 set "MM=%%H"
 set "SS=%%I"
 set "year=%%J"
)

echo Start Date: %year%-%month%-%day% %HH%:%MM%:%SS%

endlocal
::
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::Create the Log folder to hold the Log files locally
if not exist "Logs" mkdir Logs
::
::Delete the Log files if they older than 30 days
forfiles /m ".\Logs\ImportLog*.txt" /d -30 /c "cmd /c Del @file " 
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::Get today's date in YYYYMM format
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a)
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Wrapper procedure to Connect to Databases and import the data.
call RunDBImports.bat >> ".\Logs\ImportLog-DBImports-%mydate%.txt "
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Wrapper procedure to Import Data from Files.
call RunFileETLs.bat >> ".\Logs\ImportLog-FileETLs-%mydate%.txt "
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Wrapper procedure to Run Procedures after Import.
call RunDBProcesses.bat >> ".\Logs\ImportLog-DBProcesses-%mydate%.txt "
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::

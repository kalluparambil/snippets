@echo off
:: Wrapper procedure to run each batch file sequencially
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
echo ------------------------------------------------
echo 			 Starting etl-fieldglass-daily
echo ------------------------------------------------
call 21.import-file-data.bat
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::

@echo off
:: Wrapper procedure to run each batch file sequencially
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
echo ------------------------------------------------
echo 			 Starting etl-fieldglass-daily
echo ------------------------------------------------
call etl-fieldglass-daily.bat
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::

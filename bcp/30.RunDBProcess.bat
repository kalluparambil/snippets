@echo off
:: Wrapper procedure to run each batch file sequencially.
:: Call any Processes that have to be run after the file loads.
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
echo ------------------------------------------------
echo 			 Starting exec-post-load-tasks
echo ------------------------------------------------
call exec-post-load-tasks.bat
::

@echo off
:: Copy the last 5 days of Daily Source files received.
:: Load those files into Destination Landing Table.
:: ETL from Landing Table into Destination ODS Table.
:: 
::https://ss64.com/nt/robocopy.html
:: 
:: ---------BEGIN COMMANDS---------
::echo %~dp0
::
::Create the folder to hold the files locally
if not exist "srcdaily" mkdir srcdaily
::
:: --Delete existing files in destination
if exist .\srcdaily\Source_File*.txt del .\srcdaily\Source_File*.txt
:: 
::Create the Log folder to hold the Log files locally
if not exist "Logs" mkdir Logs
::
:: --Copy the last few files from source
ROBOCOPY ^
  "\\SharedServer\Landing_Files\Incoming_FTP_Files\Source1\ " ^
	.\srcdaily ^
	Source_File*.txt ^
	/MAXAGE:5 ^
	/R:3 /W:3 /LOG:".\Logs\RoboLog-srcdaily.txt" 
  ::/NFL /NDL
:: 
:: --------- Push to Database ---------
:: --Loop through the files in Order so that the oldest file is processed first
for /f "tokens=*" %%f in ('dir /b .\srcdaily\Source_File*.txt ^| sort') do (
	sqlcmd /S [Destination_Server] -E -Q "delete from [db].dbo.landing_src_daily"
	bcp [db].dbo.landing_src_daily in .\srcdaily\%%f -S [Destination_Server] -T -F 2 -c
	sqlcmd /S [Destination_Server] -E -Q "exec [Destination_Server].[dbo].[LOAD_ODS_Source1_Daily]"
)
:: ---------END COMMANDS---------

@echo off
::Execute the Post Processes.
::
:: ---------BEGIN COMMANDS---------
::
::Execute the Post Processes
sqlcmd /S [ServerName] -E -Q "exec  [db].dbo.DO_Stored_Procedure"
::
:: ---------END COMMANDS---------
::

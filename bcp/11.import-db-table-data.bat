@echo off
::Execute a Query in Source Database, export the data into a text file and then import that file into the Destinaton Landing table.
::From Landing Table move the Data into the ODS Destination Table that holds the data.
::
:: ---------BEGIN COMMANDS---------
::
::Create the DBFlatFiles folder to hold the Flat files from Database locally
if not exist "DBFlatFiles" mkdir DBFlatFiles
::
::export data into text file
bcp "select * from [db].[schema].[SourceTable]" queryout ".\DBFlatFiles\data-SourceTable.txt" -S [Source-ServerName] -T -c
::
::clear the Landing Table
sqlcmd /S [Destination-ServerName] -E -Q "delete [db].[schema].[DestinationLandingTable]"
::
::import data from text file into Landing Table
bcp [db].[schema].[DestinationLandingTable] in ".\DBFlatFiles\data-SourceTable.txt" -S [Destination-ServerName] -T -c
::
::move the data into the destination Table from Landing Table
sqlcmd /S [Destination-ServerName] -E -Q "exec  [db].[schema].[LOAD_ODS_Destination_Table]"
::
:: ---------END COMMANDS---------
::

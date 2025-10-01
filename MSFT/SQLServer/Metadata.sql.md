# Query the Sql Server Meta Data Tables

### Get the Server and Database information of the connected SQL Server
```sql
SELECT 
 @@SERVERNAME               AS SERVER_NM
,DB_NAME()                  AS DATABASE_NM
,SCHEMA_NAME()              AS USER_SCHEMA_NM
,@@VERSION                  AS VERSION_NM
;
```

### Find a list of tables in a Schema and Database
```sql
select top 100 *
from information_schema.tables
where 1=1
--and table_catalog = 'DATABASE_NAME'
and table_schema = 'DBO'
and upper(table_name) like '%SK_TEMP%'
;
```

### Search by Column Name and find the Table and Column
```sql
--Find the User's Table which holds this column
SELECT top 100
 t.schema_id
,SCHEMA_NAME(t.schema_id) as Schema_Name
,t.NAME AS Table_Name
,c.NAME AS Column_Name
FROM sys.columns c
INNER JOIN sys.objects t ON t.object_id = c.object_id
WHERE 1=1
and t.type = 'U' --user table type
and c.NAME like '%ColumnName%'
ORDER BY 1,2
;
```
### Search by Column Name and find the Table and Column
```sql
--Alternate way to find the columns
select * 
from information_schema.columns
where 1=1
and column_name like 'search_string%'
;
;
```
### Search by Column Name and find the View and Column
```sql
--Find View Details and Columns Details
--using column name
select top 100
 v.name
,c.name
from sys.columns as c
inner join sys.views as v on v.object_id = c.object_id
where 1=1
--and v.name = '%ViewName%'
and c.name like '%ColumnName%'
;
```
### Search dependencies to find tables inside stored procedures.
```sql
select *
from (
	select top 10
	coalesce(Referenced_server_name+'.','')+ --possible server name if cross-server
		coalesce(referenced_database_name+'.','')+ --possible database name if cross-database
		coalesce(referenced_schema_name+'.','')+ --likely schema name
		coalesce(referenced_entity_name,'') + --very likely entity name
		coalesce('.'+col_name(referenced_ID,referenced_minor_id),'') as source_name
	,coalesce(object_schema_name(Referencing_ID)+'.','')+ --likely schema name
		object_name(Referencing_ID)+ --definite entity name
		coalesce('.'+col_name(referencing_ID,referencing_minor_id),'') as source_used_in
	from sys.sql_expression_dependencies
) as t
where 1=1
and source_name like '%tbl_name%' --Find the source that is being referenced in procedures etc.
;
```

### Search by Text and find the Procedure and portions of the text
```sql
--Replace the Database Name
USE <DATABASE_NAME>
GO

--Search and Find the Procedure Name and portion of Text
SELECT 
  OBJECT_NAME(S.id) as Proc_Name
, S.text as Proc_Text
FROM SYS.SYSCOMMENTS AS S 
WHERE S.[text] LIKE '%text_to_search%' 
AND OBJECTPROPERTY(S.id, 'IsProcedure') = 1 
order by 1
;
```

### Search by Text and find the full definition of Procedure
```sql
SELECT 
  OBJECT_NAME(S.object_id) as Proc_Name
, S.DEFINITION AS Proc_Text
FROM SYS.SQL_MODULES AS S
WHERE OBJECTPROPERTY(S.object_id, 'IsProcedure') = 1
AND definition LIKE '%text_to_search%' 
;
```
```sql
SELECT  
    OBJECT_NAME(S.object_id) AS Proc_Name,
    S.definition AS Proc_Text
FROM sys.sql_modules AS S
WHERE OBJECTPROPERTY(S.object_id, 'IsProcedure') = 1
  AND PATINDEX('%insert%table1%', LOWER(S.definition)) > 0;
```
```sql
SELECT
    SCHEMA_NAME(p.schema_id) AS schema_name,
    p.name AS procedure_name,
    m.definition AS procedure_definition
FROM sys.procedures p
JOIN sys.sql_modules m ON p.object_id = m.object_id
WHERE 1=1
and m.definition LIKE '%INSERT%INTO%TABLE1%'
;
```
### Find a list of stored procedures
```sql
-- List the Stored Procedures
SELECT top 100 *
FROM dbo.sysobjects
WHERE 1=1
and (type = 'P')
and name like '%SP_sk_temp%'
;

SELECT * 
FROM INFORMATION_SCHEMA.ROUTINES
WHERE 1=1
and ROUTINE_TYPE = 'PROCEDURE'
and SPECIFIC_NAME like '%SP_sk_temp%'
;

```

# Query the Sql Server Meta Data Tables

### Get the Server and Database information of the connected SQL Server
```sql
SELECT 
 @@SERVERNAME               AS SERVER_NM
,DB_NAME()                  AS DATABASE_NM
,@@VERSION                  AS VERSION_NM
;
```

### Search by Column Name and find the Table and Column
```sql
--Find the User's Table which holds this column
SELECT top 100
 t.NAME AS Table_Name
,c.NAME AS Column_Name
FROM sys.columns c
INNER JOIN sys.objects t ON t.object_id = c.object_id
WHERE 1=1
and t.type = 'U' --user table type
and c.NAME like '%ColumnName%'
ORDER BY 1,2
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

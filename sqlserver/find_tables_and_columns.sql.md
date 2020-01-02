# Query the Sql Server Meta Data Tables

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

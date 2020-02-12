# Random Numbers

### Top n % random rows
SQL for tables with less number of rows, say < 100k
```sql
--Slower query that could be used for smaller tables
select top 1 percent 
*
from <tablename> 
order by newid()
;
```

SQL for tables with lot of rows, say >= 100k
```sql
--Faster query if there are a lot of rows
select * 
from <tablename> 
tablesample(1 percent)
;
```

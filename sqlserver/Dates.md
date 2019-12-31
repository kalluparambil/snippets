# Tips on Dates in SQL Server

### Displaying Date Field properly in Excel
Sometimes Excel does not like the microseconds. In that case, convert to a different format
```sql
--For displaying the Date in Excel
-- 120 == yyyy-mm-dd hh:mi:ss
CONVERT(varchar, PS_CREATE_DATE, 120)                  	AS PEOPLESOFT_CREATE
```

### Best Practice to search dates in SQL Server
#### Filter by Records of Last Month
[Stackoverflow Reference.](https://stackoverflow.com/questions/1424999/get-the-records-of-last-month-in-sql-server)
```sql
/* USAGE: 
 * AND Column_DT >= @startOfLastMonth AND < @startOfCurrentMonth
 */
DECLARE 
@startOfCurrentMonth DATETIME,
@startOfLastMonth DATETIME
;
SET @startOfCurrentMonth = DATEADD(month, DATEDIFF(month, 0, CURRENT_TIMESTAMP), 0);
SET @startOfLastMonth = DATEADD(month, -1, @startOfCurrentMonth);

PRINT @startOfCurrentMonth;
PRINT @startOfLastMonth;
```

### Find the Latest Date and the Previous to Latest Date and display them side by side
[Reference](https://dba.stackexchange.com/questions/161689/compare-last-data-and-second-last-data-sql-server-based-on-id)
Alternatively try LAG instead of LEAD function.
```sql
--Get the Latest and Previous-to-Latest values side by side
select 
 t._RowNumber
,t.Latest_Date
,t.Prev_Latest_Date
(
select
 RANK() 
        OVER( PARTITION BY table_name.partition_column ORDER BY table_name.date_column DESC )       AS _Rank
,table_name.date_column                                                                             AS Latest_Date
,LEAD(table_name.date_column,1) 
        OVER ( PARTITION BY table_name.partition_column ORDER BY table_name.date_column DESC )      AS Prev_Latest_Date
) as t
where 1=1
and t._RowNumber = 1 --Limit to just the top record
;
```

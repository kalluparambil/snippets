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

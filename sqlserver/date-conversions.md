--For displaying the Date in Excel
CONVERT(varchar, PS_CREATE_DATE, 120)                  	AS PEOPLESOFT_CREATE

/* USAGE: Records of Last Month
 * AND Column_DT >= @startOfLastMonth AND < @startOfCurrentMonth
 * Ref: https://stackoverflow.com/questions/1424999/get-the-records-of-last-month-in-sql-server
 */
DECLARE 
@startOfCurrentMonth DATETIME,
@startOfLastMonth DATETIME
;
SET @startOfCurrentMonth = DATEADD(month, DATEDIFF(month, 0, CURRENT_TIMESTAMP), 0);
SET @startOfLastMonth = DATEADD(month, -1, @startOfCurrentMonth);

PRINT @startOfCurrentMonth;
PRINT @startOfLastMonth;


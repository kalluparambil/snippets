--Find the User's Table which holds this column
SELECT 
 t.NAME AS Table_Name
,c.NAME AS Column_Name
FROM sys.columns c
INNER JOIN sys.objects t ON t.object_id = c.object_id
WHERE t.type = 'U' --user table type
and c.NAME like '%MODEL_NAME%'
ORDER BY 1,2
;

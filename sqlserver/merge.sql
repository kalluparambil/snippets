--Use below merge statement.
--The CTE can contain the Keys and Columns from multiple tables
WITH SOURCE_CTE AS
(
SELECT 
	 <KEY1>
	,<COL_TO_UPDATE1>
FROM <SRC_TABLE1>
WHERE 1=1
)
	MERGE <SCHEMA1>.<DEST_TABLE> AS DEST
	USING SOURCE_CTE AS SRC
	ON (DEST.<KEY1> = SRC.<KEY1>
	WHEN MATCHED
    THEN UPDATE
    SET
       DEST.<COL_TO_UPDATE1> = SRC.<COL_TO_UPDATE1>
;

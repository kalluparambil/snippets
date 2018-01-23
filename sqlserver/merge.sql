--Use below merge statement.
--The Merge is made using a Transaction
BEGIN TRANSACTION [Tran1]

BEGIN TRY

  --Check data before update
	SELECT 
		 <KEY1>
		,<COL_TO_UPDATE1>
	FROM <SRC_TABLE1>
	WHERE 1=1
  ;

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

  SELECT @@ROWCOUNT AS ROWS_AFFECTED;

  --Check data after update
	SELECT 
		 <KEY1>
		,<COL_TO_UPDATE1>
	FROM <SRC_TABLE1>
	WHERE 1=1
  ;

  --Comment Commit first, if test successful, run again with Rollback commented and Commit uncommented.
  ROLLBACK TRANSACTION [Tran1]
  --COMMIT TRANSACTION [Tran1]


END TRY

BEGIN CATCH
  ROLLBACK TRANSACTION [Tran1]
END CATCH  

GO

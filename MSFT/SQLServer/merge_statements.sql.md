[Reference](https://www.mssqltips.com/sqlservertip/1704/using-merge-in-sql-server-to-insert-update-and-delete-at-the-same-time/)

```sql
--***************************************
My examples:
	WITH DISTINCT_SRC AS
	(SELECT DISTINCT
	     [col1]
				...
	    ,[col10]
	FROM <TABLE>
  WHERE 1=1
  --Any constraits
	)
	MERGE <Dest_Table> AS DEST
	USING DISTINCT_SRC AS SRC
	--Merged to be made based on these keys
	ON (DEST.<Key1> = SRC.<Key1> AND DEST.<Key2> = SRC.<Key2>)
	WHEN NOT MATCHED BY TARGET
    THEN
    INSERT
	  (
	     [col1]
				...
	    ,[col10]
	  )
    VALUES
    (
	     [col1]
				...
	    ,[col10]
    )
WHEN MATCHED
    THEN UPDATE
    SET
       DEST.<Col1>           = SRC.<Col1>
				...
       DEST.<Col1>           = SRC.<Col1>
	OUTPUT $action
	    , INSERTED.<KEY1> AS INS_<KEY1>
	 INTO #TMP_<Table1>
	;
--***************************************
--Another way
--***************************************
	MERGE <Dest_Table> AS dest
	USING 
	(
		SELECT --DISTINCT
	     [col1]
				...
	    ,[col10]
		from <Src_Table>
		where 1=1
  )
	AS src
	--Merged to be made based on these keys
	ON (
	        dest.key1 = src.key1
		  and dest.key2 = src.key2
	   )
	WHEN NOT MATCHED BY TARGET
	 THEN
	 INSERT
	(
	     [col1]
				...
	    ,[col10]
	  )
    VALUES
    (
	     [col1]
				...
	    ,[col10]
	)
	VALUES
	(
	)
	WHEN MATCHED
	    THEN UPDATE
	    SET
       DEST.<Col1>           = SRC.<Col1>
				...
       DEST.<Col1>           = SRC.<Col1>
	OUTPUT $action
	  , INSERTED.Key AS ins_Key
	INTO #TMP_<Table1>
	;
--***************************************
```

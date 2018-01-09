--Update using Merge from one Table into another Table.
--Note that this Table already has the Keys as well as the Values to update.
--Exceptions may occur if more than one row has to be updated per key.
--Exceptions have to be handled separately.
MERGE INTO <DEST_TBL> DEST
USING
(
    --This query can be a join of the SRC and DEST1 Table.
    --It is important to get the Keys as well as the Columns for the Update.
    SELECT
      SRC_TBL.KEY1
    , SRC_TBL.KEY2
    , SRC_TBL.COLUMN_TO_UPDATE1
    , SRC_TBL.COLUMN_TO_UPDATE2
    FROM <SRC_TBL>
    WHERE 1=1
    --Filter if needed
) SRC ON (SRC.KEY1 = DEST.KEY1 AND SRC.KEY2 = DEST.KEY2)
WHEN MATCHED THEN UPDATE SET
  DEST.COLUMN_TO_UPDATE1         = SRC.COLUMN_TO_UPDATE1
, DEST.COLUMN_TO_UPDATE2         = SRC.COLUMN_TO_UPDATE2
-- ...
WHERE 1=1
--Filter if needed
;

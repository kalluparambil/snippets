# Code to Test Speed
[Reference](https://stackoverflow.com/questions/26652/is-there-a-way-to-make-a-tsql-variable-constant)
```sql
USE <DB>
GO

--Drop existing objects in schema. Be careful which schema or object to pick.
IF OBJECT_ID('fnFalse') IS NOT NULL DROP FUNCTION fnFalse
GO

IF OBJECT_ID('fnTrue') IS NOT NULL DROP FUNCTION fnTrue
GO

CREATE FUNCTION fnTrue() RETURNS INT WITH SCHEMABINDING 
AS 
BEGIN 
    RETURN 1
END
GO

CREATE FUNCTION fnFalse() RETURNS INT WITH SCHEMABINDING
AS
BEGIN
    RETURN ~ fnTrue()
END
GO

--Test 1 when calling the functions
DECLARE @TimeStart DATETIME = GETDATE()
DECLARE @Count INT = 100000
DECLARE @Value BIT

WHILE @Count > 0 
BEGIN
    SET @Count -= 1;

    SELECT @Value = fnTrue();
    IF @Value = 1
        SELECT @Value = fnFalse();

END

DECLARE @TimeEnd DATETIME = GETDATE()

PRINT CAST(DATEDIFF(ms, @TimeStart, @TimeEnd) AS VARCHAR) + ' elapsed, using function'
GO

--Test 2 when using Variables as Constants
DECLARE @TimeStart DATETIME = GETDATE()
DECLARE @Count INT = 100000
DECLARE @FALSE AS BIT = 0
DECLARE @TRUE AS BIT = ~ @FALSE
DECLARE @Value BIT

WHILE @Count > 0 
BEGIN
    SET @Count -= 1;

    SELECT @Value = @TRUE
    IF @Value = 1
        SELECT @Value = @FALSE
END

DECLARE @TimeEnd DATETIME = GETDATE()
PRINT CAST(DATEDIFF(ms, @TimeStart, @TimeEnd) AS VARCHAR) + ' elapsed, using local variable'
GO

--Test 3 when using hard-coded values instead of Constants
DECLARE @TimeStart DATETIME = GETDATE()
DECLARE @Count INT = 100000
DECLARE @Value BIT

WHILE @Count > 0 
BEGIN
    SET @Count -= 1;

    SELECT @Value = 1
    IF @Value = 1
        SELECT @Value = 0
END

DECLARE @TimeEnd DATETIME = GETDATE()
PRINT CAST(DATEDIFF(ms, @TimeStart, @TimeEnd) AS VARCHAR) + ' elapsed, using hard coded values'
GO
```

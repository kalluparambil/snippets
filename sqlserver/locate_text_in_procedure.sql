/* Use the below queries to find out whether a text is used in any procedure
 */

--Replace the Database Name
USE <DATABASE_NAME>
GO

--Search and Find the Procedure Name and portion of Text
SELECT 
  OBJECT_NAME(S.id) as Proc_Name
, S.text as Proc_Text
FROM SYS.SYSCOMMENTS AS S 
WHERE S.[text] LIKE '%text_to_search%' 
AND OBJECTPROPERTY(S.id, 'IsProcedure') = 1 
;

--Get the whole definition of the Procedure
SELECT 
  OBJECT_NAME(S.object_id) as Proc_Name
, S.DEFINITION AS Proc_Text
FROM SYS.SQL_MODULES AS S
WHERE OBJECTPROPERTY(S.object_id, 'IsProcedure') = 1
AND definition LIKE '%text_to_search%' 
;

```sql
-- How to add space to name only if name is not null
-- The code relies on the + operator failing when used with null
with cte as (
select
 'Johnny'	as First_Name
,'Noname'	as Middle_Name
,'Applesee'	as Last_Name
,'Jr'	as Suffix
union
select
 'Santa'	as First_Name
, null	as Middle_Name
,'Clause'	as Last_Name
,''	as Suffix
)
select *
,RTRIM(LTRIM(
	CONCAT( -- When null the first parameter is null else a space is added after the name
		 COALESCE(First_Name + ' ', '')
		,COALESCE(Middle_Name + ' ', '')
		,COALESCE(Last_Name + ' ', '')
		,COALESCE(Suffix, '')
	))) as Applicant_FullName
from cte
;
```

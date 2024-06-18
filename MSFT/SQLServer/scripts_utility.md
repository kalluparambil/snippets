# Collection of scripts that server some utility

### Scripts to drop tables in a schema
```sql
select -- top 100 *
 table_name
,'drop table if exists ' 
+ table_schema 
+ '.' 
+ table_name 
+ ' ;' 
as stmt
from information_schema.tables
where 1=1
--and table_catalog = 'DATABASE_NAME'
and table_schema = 'DBO'
and upper(table_name) like '%SK_TEMP%'
;
```

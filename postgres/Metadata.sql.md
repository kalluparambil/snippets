# Postgres related Metadata Queries

### Find Tables by name (option 1)
```sql
--Find names of tables with a Pattern
select
 schemaname
,tableowner
,tablename 
from pg_catalog.pg_tables 
where 1=1
and schemaname = 'public'
and tableowner like '%%'
and tablename like '%d%'
order by 1,2,3
--limit 100
;
```

### Find Tables by name (option 2)
```sql
--Find names of tables with a Pattern
select table_name
from information_schema.tables
where 1=1
and table_type = 'BASE TABLE' --exclude views
--and table_schema not in ('information_schema', 'pg_catalog')
and table_schema = 'public'
and table_name like '%sk_temp%'
;
```
### Find Tables by Column name and also filter by Table name if necessary
```sql
-- Find Columns and Tables based on a Pattern
select 
 t.table_schema
,t.table_name
,c.column_name
from information_schema.tables t
inner join information_schema.columns c on (1=1
    and c.table_name = t.table_name 
    and c.table_schema = t.table_schema)
where 1=1
and t.table_type = 'BASE TABLE' --exclude views
--Filter Schemas
and t.table_schema not in ('information_schema', 'pg_catalog')
and t.table_schema = 'sk' -- Schema filter
--and table_schema = 'public'
--
and t.table_name like '%case%' --Table filter
and c.column_name like '%rep%' --Column filter
order by 
 t.table_schema
,t.table_name
,c.column_name
;

```

### Find View Names based on Pattern
```sql
select isc.*
from information_schema.columns isc
join pg_class pgc on (
        pgc.relname = isc.table_name
    and pgc.relnamespace = table_schema::regnamespace
    )
where 1=1 
and pgc.relkind = 'v'
and isc.table_schema not in ('information_schema', 'pg_catalog')
and isc.table_schema in ('sb')
and isc.table_name like '%inv%' --Table filter
and isc.column_name like '%date%' --Column filter
limit 100
;
```

### Find Function Name based on a Pattern
```sql
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_type='FUNCTION' 
AND specific_schema='public' 
AND routine_name LIKE '%rem%'
;
```

### Find Function and Source based on Source Code Pattern
```sql
-- Find Function and Source based on Source Code Pattern
select 
 proname
,proargnames
,prosrc
from pg_proc
where 1=1 
and prosrc ilike '%data%'
;
```

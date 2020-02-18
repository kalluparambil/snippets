# Postgres related Queries

### Find Tables by name
```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema='public'
AND table_type='BASE TABLE'
AND table_name like '%report%'
order by 1
```
### Find Tables by Column name
```sql
select t.table_schema,
       t.table_name
from information_schema.tables t
inner join information_schema.columns c on c.table_name = t.table_name 
                                and c.table_schema = t.table_schema
where c.column_name like '%region%'
      and t.table_schema not in ('information_schema', 'pg_catalog')
      and t.table_type = 'BASE TABLE'
order by t.table_schema;
```

### Find Functions by Name
```sql
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_type='FUNCTION' 
AND specific_schema='public' 
AND routine_name LIKE '%removal%'
;
```

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

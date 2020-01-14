```sql
--Use the below Common Table Expression to obtain the list of people working under a Manager
--h => hierarchy
--a => anchor
--r => recurse/or
with h as
  (
  --First get the Manager on the level that we need
  select a.emp_id, a.mgr_id, 0 as treelevel
  from <emp_table> as a
  where a.emp_id = '<MANAGER_ID>'
  union all
  select r.emp_id, r.mgr_id, h.treelevel + 1 as treelevel
  from <emp_table> as r
  inner join h on (h.emp_id = r.mgr_id)
  where 1=1
  ) 
select * from h
;
```

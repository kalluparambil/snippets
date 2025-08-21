# Run AdHoc scripts in PG

### Run AdHoc scripts in PG
```sql

-- Find the performance of queries
do $$

declare

	vi_counts int  :=  0;
	t timestamptz := clock_timestamp();

	-- Useful local variables
	vls_sql 	varchar(4000);


begin

	-- Write statements here.

	-- get diagnostics vi_counts = row_count; --Use this in the future
    raise notice 'Counts: %', cast( vi_counts as varchar(11));
    raise notice 'Completion time: %', cast( (clock_timestamp() - t) as varchar(11));

end; $$;

-- Test and check the result set
-- select * from sk_temp_01;

```

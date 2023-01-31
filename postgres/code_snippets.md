# Postgres SQL Code Snippets

###Use PG Anonymous block to execute statements
```sql
do $$
declare

	--variables
	vld_last_date_prev_month date;
	vld_mid_date_prev_month date;

begin
	
	select (date_trunc('month',now()))::date - 1 as last_date_prev_month
	into vld_last_date_prev_month;

	vld_mid_date_prev_month := vld_last_date_prev_month - 13; --Two weeks back.
  
   -- print
   raise notice 'vld_last_date_prev_month: %', vld_last_date_prev_month;
   raise notice 'vld_mid_date_prev_month: %', vld_mid_date_prev_month;

end; $$;
```

### Insert Test Data and use Anonymous block to process the data
```
--Insert Test Data and use Anonymous block to process the data

/* 
--Alternative is to just import data from Excel using DBeaver

select * from sb.temp_test tt;

insert into sb.temp_test (id) values (1);
insert into sb.temp_test (id) values (2);
insert into sb.temp_test (id) values (3);
insert into sb.temp_test (id) values (4);
insert into sb.temp_test (id) values (5);

select * from sb.temp_test tt;
*/

do $$
begin
    --Check if table exists
    if exists(select 1 from information_schema.tables 
    			where table_schema = 'sb' --current_schema() 
    			and table_name = 'temp_test') 
    THEN --below write the action to take
    	delete from sb.temp_test where id in (4,5);
  end if;
end; $$ language plpgsql;

--Test
--select * from sb.temp_test tt;
```

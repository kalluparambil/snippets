# Postgres SQL Code Snippets

### Get a few random rows from a table
```
--Get a few random rows from a table
select *
from <replace_with_table_name>
where 1=1
order by random()
limit 100;
```

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

--Alternative is to just import data from Excel using DBeaver

drop table if exists sb.sk_temp_100;
create table sb.sk_temp_100(id serial primary key , col_value int8 null);

/*
select * from sb.sk_temp_100 tt;

insert into sb.sk_temp_100 (col_value) values (1);
insert into sb.sk_temp_100 (col_value) values (2);
insert into sb.sk_temp_100 (col_value) values (3);
insert into sb.sk_temp_100 (col_value) values (4);
insert into sb.sk_temp_100 (col_value) values (5);
*/

select * from sb.sk_temp_100 tt;

do $$
begin
    --Check if table exists
    if exists(select 1 from information_schema.tables 
                where table_schema = 'sb' --current_schema() 
                and table_name = 'sk_temp_100') 
    THEN --below write the action to take
        delete from sb.sk_temp_100 where id in (2,4);
  end if;
end; $$ language plpgsql;

--Test
select * from sb.sk_temp_100 tt;

```

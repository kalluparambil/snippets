```sql
set role sb;

drop view if exists sb.vw_joblogs;

create or replace view sb.vw_joblogs
as 
select 
     log_id
    ,process_user
    ,batch_num
    ,started_at
    ,ended_at
    ,cast( (ended_at - started_at) as varchar(11)) as time_for_task
    ,process_id
    ,process_name
    ,process_location
    ,process_status
    ,custom_message
    ,error_code
    ,error_message
from sb.jobprocess_log 
order by 1 desc
;
```

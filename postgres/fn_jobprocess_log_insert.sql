```sql
-- ##########################################
-- Set the role so that other devs have edit access to the table.
-- ##########################################

set role sb;

drop function if exists sb.fn_jobprocess_log_insert
(   bigint,
    timestamp,
    timestamp,
    bigint,
    varchar,
    text,
    varchar,
    varchar,
    text,
    text
)
;

commit;

create or replace function sb.fn_jobprocess_log_insert
(   --defaults are provided in parameters so that we can skip columns when calling
     p_batch_num            bigint default null
    ,p_started_at           timestamp default clock_timestamp() 
    ,p_ended_at             timestamp default clock_timestamp()
    ,p_process_id           bigint default 0                -- A process id should be provided on call
    ,p_process_name         varchar(500) default 'Unknown'  -- A process name should be provided on call
    ,p_process_location     text default null
    ,p_process_status       varchar(255) default null
    ,p_custom_message       varchar(500) default null
    ,p_error_code           text default null
    ,p_error_message        text default null
)
returns void
language plpgsql
as $function$
declare
begin
    insert into sb.jobprocess_log
        (
         batch_num
        ,started_at
        ,ended_at
        ,process_id
        ,process_name
        ,process_location
        ,process_status
        ,custom_message
        ,error_code
        ,error_message
        )
    values(
         coalesce(p_batch_num,-1)               -- Everything defaults to -1 if no batch number is provided
        ,coalesce(p_started_at,clock_timestamp())
        ,coalesce(p_ended_at,clock_timestamp())
        ,coalesce(p_process_id,0)               -- A process id should be provided on call
        ,coalesce(p_process_name,'Unknown')     -- A process name should be provided on call
        ,p_process_location
        ,p_process_status
        ,p_custom_message
        ,p_error_code
        ,p_error_message
        );

exception
        --Just trapping the exception and letting everything proceed
        when others then
            raise notice 'Error while inserting in fn_jobprocess_log_insert';

end;
$function$
;

commit
;
```

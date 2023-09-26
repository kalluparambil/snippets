```sql
set role sb;

drop view if exists sb.vw_joblogs;
-- ############################
drop table if exists sb.jobprocess_log;

create table sb.jobprocess_log (
    log_id                      serial,
    process_user                varchar(255) not null default current_user,
    batch_num                   bigint not null,
    started_at                  timestamp not null default clock_timestamp(),
    ended_at                    timestamp not null default clock_timestamp(),
    process_id                  bigint not null,
    process_name                varchar(500) not null,
    process_location            text null,
    process_status              varchar(500) null,
    custom_message              varchar(500) null,
    error_code                  text null,
    error_message               text null
);

-- Do nothing on deletes and updates to maintain the integrity of the logs.
-- Only Select and Inserts need to be allowed.

drop rule if exists jobprocess_log_do_not_delete on sb.jobprocess_log;
drop rule if exists jobprocess_log_do_not_update on sb.jobprocess_log;

create rule jobprocess_log_do_not_delete as on delete to sb.jobprocess_log do instead nothing;
create rule jobprocess_log_do_not_update as on update to sb.jobprocess_log do instead nothing;

commit;

create sequence if not exists sb.jobprocess_seq
    as bigint
    increment by 1
    minvalue 1 
    no maxvalue
    start with 1 
    cycle
    owned by sb.jobprocess_log.batch_num
;

commit;
```

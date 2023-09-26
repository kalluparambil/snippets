```sql
-- ##########################################
-- Set the role so that other devs have edit access to the table.
-- ##########################################

set role sk;

-- ############################
drop table if exists sb.jobprocess_header;

create table sb.jobprocess_header (
    process_id                  bigint not null,
    process_name                varchar(500) null,
    created_on                  timestamp not null default clock_timestamp(),
    created_user                varchar(255) not null default current_user,
    modified_on                 timestamp null,
    modified_user               varchar(255) null
    )
;

set role sk;

delete from sb.jobprocess_header where process_id >= 1;
insert into sb.jobprocess_header (process_id,process_name) values (1,'fn_load_tbl_template');
```

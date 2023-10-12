/*

set role sk;

-- Use these scripts to test. Remember to drop the Table and Function after testing.
drop table if exists sb.tbl_template;

create table sb.tbl_template (
    product_name varchar(255),
    price decimal(10,2),
    quantity integer
);

INSERT INTO sb.tbl_template (product_name, price, quantity)
VALUES ('Apple', 100, 10),
       ('Banana', 200, 20),
       ('Orange', 300, 30),
       ('Mango', 400, 40),
       ('Mango1', 430, 40),
       ('Mango2', 470, 40),
       ('Grapes', 500, 50),
       ('Strawberry', 600, 60),
       --('Blueberry', 700, 70),
       ('Raspberry', 800, 80),
       ('Blackberry', 900, 90),
       ('Watermelon', 1000, 100)
;

select * from sb.tbl_template;

*/



-- ##########################################
-- Set the role so that other devs have edit access to the table.
-- ##########################################
--set role sk; 
--drop function if exists mdm.fn_load_tbl_template(int)

set role sb;

create or replace function sb.fn_load_tbl_template
    (p_days_to_refresh int default 90) --Defaulted to past 90 days
    returns character varying
    language plpgsql
as $function$
-- =============================================
-- Created by : Sanjay K.
-- Create date: YYYY-MM-DD
-- Updated by : Sanjay K.
-- Update date: YYYY-MM-DD
-- Description: 
-- Notes      : 
-- =============================================

declare
    -- Start of Exception Handling variables
    ex_fn_started_at             timestamp     := clock_timestamp();
    ex_fn_process_status_update  varchar(500)  := 'Success: Function Completed';
    ex_fn_batch_num              bigint        := nextval('sb.jobprocess_seq'); -- set once for each run
    --
    ex_started_at             timestamp     := clock_timestamp();
    ex_ended_at               timestamp     := null;
    ex_process_id             bigint        := -1; -- This should match the jobprocess_info value
    ex_process_name           varchar(500)  := 'sb.fn_load_tbl_template';
    ex_process_location       text          := 'sb.tbl_template';
    ex_process_status_fail    varchar(500)  := 'Failure: Error';
    ex_process_status_select  varchar(500)  := 'Success: Select';
    ex_process_status_insert  varchar(500)  := 'Success: Insert';
    ex_process_status_delete  varchar(500)  := 'Success: Delete';
    ex_process_status_update  varchar(500)  := 'Success: Update';
    ex_custom_message         varchar(500)  := null;
    ex_error_code             text          := null;
    ex_error_message          text          := null;
    ex_rows_selected          bigint        := 0;
    ex_rows_inserted          bigint        := 0;
    ex_rows_deleted           bigint        := 0;
    ex_rows_udpated           bigint        := 0;
    -- End of Exception Handling variables

    -- Generic local variables
    t timestamptz := clock_timestamp();
    
    -- Useful local variables
    v_days_to_refresh_start_date date;
    v_days_to_refresh_start_date_utc date;
begin
    
    -- ##########################################
    -- Deal with parameters here
    -- ##########################################
    if p_days_to_refresh < 0 --refresh all data when negative
    then
        v_days_to_refresh_start_date = '1970-01-01';
        v_days_to_refresh_start_date_utc = '1970-01-01'::timestamp at time zone 'EST5EDT' at time zone 'UTC';
    else
        v_days_to_refresh_start_date = current_date - make_interval(days => p_days_to_refresh);
        --store the UTC to compare later
        v_days_to_refresh_start_date_utc = 
                v_days_to_refresh_start_date::timestamp at time zone 'EST5EDT' at time zone 'UTC';
    end if;

  
    -- ##########################################
    -- Step 1. Load the Base Data
    -- ##########################################

    drop table if exists sk_tmp;

    ex_rows_selected = 0;
    ex_started_at = clock_timestamp();

    create temporary table sk_tmp
    as 
	-- <<<<<<<<<<<<<<<BEGIN>>>>>>>>>>>>>>>
    -- <<<Replace below SQL with your SELECT statement.>>>
	select * from tbl_template where 1=2;
	
	-- <<<Remove below insert statement too.>>>
	INSERT INTO sk_tmp (product_name, price, quantity)
	VALUES ('Apple', 100, 15),
		   ('Banana', 250, 20),
		   ('Orange', 300, 30),
		   ('Mango', 400, 40),
		   ('Grapes', 505, 50),
		   ('Jackfruit', 600, 60),
		   ('Tapioca', 700, 70),
           ('Cashewfruit', 812, 80),
           ('Fruit1', 850, 80),
           ('Fruit2', 900, 80),
           ('Fruit3', 980, 80),
           ('Fruit4', 1920, 80),
           ('Fruit5', 2960, 80)
		;
		
	-- <<<<<<<<<<<<<<<END>>>>>>>>>>>>>>>

    select count(*) into ex_rows_selected from sk_tmp;
	
	--Comment below test line.
	perform pg_sleep(1);

    -- ############# BEGIN LOG SELECT SUCCESS #############################

    perform sb.fn_jobprocess_log_insert
    (
         p_batch_num                    => ex_fn_batch_num
        ,p_started_at                   => ex_started_at
        ,p_ended_at                     => clock_timestamp()::timestamp
        ,p_process_id                   => ex_process_id
        ,p_process_name                 => ex_process_name
        ,p_error_code                   => null
        ,p_error_message                => null
        ,p_process_location             => ex_process_location
        ,p_process_status               => ex_process_status_select
        ,p_custom_message               => concat(cast(ex_rows_selected as varchar(20)), ', rows selected')
    )
    ;

    -- ############# END LOG SELECT SUCCESS #############################

    -- ############# BEGIN INDEX CREATION #############################
    --Indexes to speed up DMLs. Tested and it has big impact.
    create index idx_tmp_sk_tmp
    on sk_tmp
    using btree
    (
     product_name
    );
    
    analyze sk_tmp;
    -- ############# END INDEX CREATION #############################


    -- ##########################################
    -- Step 2. Merge Final Data into Destination
    -- Update go first. If Inserts go first then all those new rows will get updated too.
    -- Delete any records in destination which has some keys that are null. This avoids re-inserting those rows.
    -- After Deletes then do the inserts.
    -- ##########################################



    -- ############# BEGIN UPDATE STATEMENTS #############################
    ex_rows_udpated = 0;
    ex_started_at = clock_timestamp();
    with upd as(
	-- <<<<<<<<<<<<<<<BEGIN>>>>>>>>>>>>>>>
        update sb.tbl_template as dest
        set 
         price                        = src.price
        ,quantity                     = src.quantity
        --,download_date                     = clock_timestamp()
        from sk_tmp as src
        where 1=1
        and src.product_name = dest.product_name 
        returning 1
    ) select count(*) into ex_rows_udpated from upd
    ;
	-- <<<<<<<<<<<<<<<END>>>>>>>>>>>>>>>

	--Comment below test line.
	perform pg_sleep(1);

    -- ############# END UPDATE STATEMENTS #############################

    -- ############# BEGIN LOG UPDATE SUCCESS #############################
    perform sb.fn_jobprocess_log_insert
    (
         p_batch_num                    => ex_fn_batch_num
        ,p_started_at                   => ex_started_at
        ,p_ended_at                     => clock_timestamp()::timestamp
        ,p_process_id                   => ex_process_id
        ,p_process_name                 => ex_process_name
        ,p_error_code                   => null
        ,p_error_message                => null
        ,p_process_location             => ex_process_location
        ,p_process_status               => ex_process_status_update
        ,p_custom_message               => concat(cast(ex_rows_udpated as varchar(20)), ', rows updated')
    )
    ;
    -- ############# END LOG UPDATE SUCCESS #############################

	--Only use delete if the primary keys for insert could be null
    -- ############# BEGIN DELETE STATEMENTS #############################
    ex_rows_deleted = 0;
    ex_started_at = clock_timestamp();

	-- <<<<<<<<<<<<<<<BEGIN>>>>>>>>>>>>>>>
    with del as(
        delete from sb.tbl_template as dest
        where 1=1
        and not exists (select 1 from sk_tmp as src
            where src.product_name = dest.product_name)
        returning 1
    ) select count(*) into ex_rows_deleted from del
    ;
	-- <<<<<<<<<<<<<<<END>>>>>>>>>>>>>>>

	--Comment below test line.
	perform pg_sleep(1);

    -- ############# END DELETE STATEMENTS #############################

    -- ############# BEGIN LOG DELETE SUCCESS #############################
    perform sb.fn_jobprocess_log_insert
    (
         p_batch_num                    => ex_fn_batch_num
        ,p_started_at                   => ex_started_at
        ,p_ended_at                     => clock_timestamp()::timestamp
        ,p_process_id                   => ex_process_id
        ,p_process_name                 => ex_process_name
        ,p_error_code                   => null
        ,p_error_message                => null
        ,p_process_location             => ex_process_location
        ,p_process_status               => ex_process_status_delete
        ,p_custom_message               => concat(cast(ex_rows_deleted as varchar(20)), ', rows deleted')
    )
    ;
    -- ############# END LOG DELETE SUCCESS #############################


    -- ############# BEGIN INSERT STATEMENTS #############################
    ex_rows_inserted = 0;
    ex_started_at = clock_timestamp();
	
	-- <<<<<<<<<<<<<<<BEGIN>>>>>>>>>>>>>>>
    with ins as(
        insert into sb.tbl_template
        (
         product_name
        ,price
		,quantity
        )
        select
         product_name
        ,price
        ,quantity
        from sk_tmp as src
        where 1=1
        and not exists (select 1 from sb.tbl_template as dest 
                        where dest.product_name = src.product_name)
        returning 1
    ) select count(*) into ex_rows_inserted from ins
    ;
	-- <<<<<<<<<<<<<<<END>>>>>>>>>>>>>>>

	perform pg_sleep(1);
	
    -- ############# END INSERT STATEMENTS #############################

    -- ############# BEGIN LOG INSERT SUCCESS #############################
    perform sb.fn_jobprocess_log_insert
    (
         p_batch_num                    => ex_fn_batch_num
        ,p_started_at                   => ex_started_at
        ,p_ended_at                     => clock_timestamp()::timestamp
        ,p_process_id                   => ex_process_id
        ,p_process_name                 => ex_process_name
        ,p_error_code                   => null
        ,p_error_message                => null
        ,p_process_location             => ex_process_location
        ,p_process_status               => ex_process_status_insert
        ,p_custom_message               => concat(cast(ex_rows_inserted as varchar(20)), ', rows inserted')
    )
    ;
    -- ############# END LOG INSERT SUCCESS #############################


	-- ############# BEGIN CLEAN UP #############################
    drop table if exists sk_tmp;
    -- ############# END CLEAN UP #############################

    -- ############# BEGIN TEST ERROR HANDLING #############################
    -- perform 1 / 0;
    -- ############# END TEST ERROR HANDLING #############################

    -- ############# BEGIN LOG FUNCTION SUCCESS #############################
    perform sb.fn_jobprocess_log_insert
    (
         p_batch_num                    => ex_fn_batch_num
        ,p_started_at                   => ex_fn_started_at
        ,p_ended_at                     => clock_timestamp()::timestamp
        ,p_process_id                   => ex_process_id
        ,p_process_name                 => ex_process_name
        ,p_error_code                   => null
        ,p_error_message                => null
        ,p_process_location             => ex_process_location
        ,p_process_status               => ex_fn_process_status_update
        ,p_custom_message               => concat(ex_process_name, ', function completed successfully')
    )
    ;
    -- ############# END LOG FUNCTION SUCCESS #############################

    return concat('Completion time: ' || cast( (clock_timestamp() - t) as varchar(11)));

exception
    when others then
        get stacked diagnostics
            ex_error_code := RETURNED_SQLSTATE,
            ex_error_message := MESSAGE_TEXT,
            ex_process_location := PG_EXCEPTION_CONTEXT;
        
        perform sb.fn_jobprocess_log_insert
        (
             p_batch_num                    => ex_fn_batch_num
            ,p_started_at                   => ex_fn_started_at
            ,p_ended_at                     => clock_timestamp()::timestamp
            ,p_process_id                   => ex_process_id
            ,p_process_name                 => ex_process_name
            ,p_error_code                   => ex_error_code
            ,p_error_message                => ex_error_message
            ,p_process_location             => ex_process_location
            ,p_process_status               => ex_process_status_fail
            ,p_custom_message               => null
        )
        ;
    
        return 'Error: Check table, jobprocess_log for details.';

end;
$function$

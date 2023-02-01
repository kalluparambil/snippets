# Looping without using Cursors

### SQL Server
```

-- *******************************************************************
-- Looping using sql table and without using cursors in SQL Server
-- *******************************************************************
declare @rowid int;
declare @rows int;

declare @col1 int;
declare @tbl1 table (
      rowid int identity(1,1)
     ,col1 int
    );

drop table if exists #destination_table;

--Create destination table to hold records
create table #destination_table (
     rowid int
    ,col1 int
    );

insert into @tbl1 (col1) 
select distinct col1
from #source_table
where 1=1
;

select @rows = count(*) from @tbl1;

while (@rows > 0)
Begin
    select top 1 
        @rowid = rowid
       ,@col1  = col1
    from @tbl1
    ;

    insert into #destination_table
    (
     rowid
    ,col1
    )
    values
    (
     @rowid
    ,@col1
    )
    ;

    delete from @tbl1 where rowid = @rowid;
    select @rows = count(*) from @tbl1;
End

--Post processing below
select * from #destination_table;

```

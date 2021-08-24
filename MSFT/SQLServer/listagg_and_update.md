# How to aggregate a column with multiple row data and then update another table with that aggregated data
```sql
update dest 
set
	dest.<dest_column> = src.<concatenated_column>
from <dest_table_name> as dest
inner join 
(
    select 
     t1.<source_to_dest_join_key>
    ,stuff((select distinct 
            t2.<column_to_concatenate> + '; '
            from <source_table_name> t2
            where t1.<source_to_dest_join_key> = t2.<source_to_dest_join_key>
            for xml path(''), type
            ).value('.', 'nvarchar(max)') 
        ,1,0,'') as <concatenated_column>
    from <dest_table_name> t1
    where 1=1
) as src on 1=1
and src.<source_to_dest_join_key> = dest.<source_to_dest_join_key>
where 1=1
;
```

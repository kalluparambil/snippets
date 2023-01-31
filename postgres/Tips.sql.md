# Postgres SQL Tips

###Sample Table with Primary Key and Identity Column
```sql
CREATE TABLE <schema>.<table_name> (
	id int8 NOT NULL GENERATED ALWAYS AS IDENTITY,
	CONSTRAINT <table_name>_pkey PRIMARY KEY (id)
);
```
### Using concat to get full name
Sometimes the value in middlename would be blank or null.
```sql
rtrim(concat(lastname,', ',firstname,' ',coalesce(nullif(middlename,''), ' '))) as fullname
```

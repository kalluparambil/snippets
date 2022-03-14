Sample Table with Primary Key and Identity Column
CREATE TABLE <schema>.<table_name> (
	id int8 NOT NULL GENERATED ALWAYS AS IDENTITY,
	CONSTRAINT <table_name>_pkey PRIMARY KEY (id)
);

--Create Database
create database MyDatabase;

--Create Table
create table Customer
(
 FirstName varchar(100)
,LastName varchar(100)
,Age int
)
;

--Insert Statement
insert into Customer
(
 FirstName
,LastName
,Age
)
values
(
 'B'
,'McDonald'
,60
)
;

--Select  Statement
select  FirstName, LastName, Age
from Customers
where LastName = 'Obama'
;

--Update Statement
update Customers
set
 FirstName = 'Barry'
,Age = 61
where LastName = 'McDonald'
;

--Delete Statement
delete Customers
where LastName = 'King'
;

--Change Table (new column, update column)
alter table Customers
add City varchar(50)
;

drop table Customers;

create table Customers
(
 Id int Primary Key identity (1,1)
,FirstName varchar(100)
,LastName varchar(100)
,Age int
,City varchar(100)
)
;

create index Customers_idx
on Customers(LastName, FirstName);

--Create Foreign Key
alter table Orders
add foreign key (Customer_Id) references Customers(Id)
;

--Inner joins
select c.FirstName, c.LastName
,o.ItemName, o.ItemPrice
from Customers c
inner join Orders o on (o.OrderId = c.OrderId)
where c.LastName = 'McDonald'
;

--Group By
select 
 o.ItemName
 ,count(*)
from Orders o
where 1=1
group by 
 o.ItemName
having count(*) > 1
;


--Using Rank Function	
SELECT
	product_id,
	product_name,
	list_price,
	RANK () OVER (ORDER BY list_price DESC) price_rank
FROM production.products
;

--Using Rank Function with a Partition (Level of Detail)
SELECT * FROM 
	(
	SELECT
		product_id,
		product_name,
		brand_id,
		list_price,
		RANK () OVER (PARTITION BY brand_id ORDER BY list_price DESC) price_rank
	FROM production.products
	) t
WHERE price_rank <= 3
;

use AdventureWorksLT
go

create view [SalesLT].[CurrentProduct]
as
select [ProductID], [ProductNumber],[ListPrice] 
from [SalesLT].[Product]
where [SellEndDate] is null;

select LEFT([ProductNumber],2), COUNT(*)
from [SalesLT].[CurrentProduct]
where ListPrice >10
group by LEFT([ProductNumber],2);
go

create view  OrderedProduct as 
select top 100 percent [ProductNumber], [ListPrice]
from [SalesLT].[Product]
order by [ListPrice] desc;
go

select *
from [SalesLT].[CurrentProduct];

update [SalesLT].[CurrentProduct]
set ListPrice = 100
where ProductID = 680;
go

create view BandWProduct as
select [ProductID], [Name], [StandardCost]*1.15 as [StandardCost], [Color]
from [SalesLT].[Product]
where Color in ('Black', 'White');

select *
from BandWProduct;

update BandWProduct
set Color = 'Red'
where ProductID = 708;

select *
from BandWProduct;
go

alter view BandWProduct as
select [ProductID], [Name], [StandardCost]*1.15 as [StandardCost], [Color]
from [SalesLT].[Product]
where Color in ('Black', 'White')
with check option;
go

drop view BandWProduct;

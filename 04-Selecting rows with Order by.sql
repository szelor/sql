use AdventureWorksLT
go

select top 1 [Name], [ListPrice]
from [SalesLT].[Product]
order by [ListPrice] desc, [ProductID];

select top 1 with ties [Name], [ListPrice]
from [SalesLT].[Product]
order by [ListPrice] desc;

select [Name], [ListPrice]
from [SalesLT].[Product]
order by [ListPrice] desc, [ProductID]
	offset 2 row
	fetch next 5 row only;

/*
Odczytaj numer najd³u¿ej realizowanego zamówienia
*/
select [PurchaseOrderNumber]
from [SalesLT].[SalesOrderHeader]
order by Datediff(dd,[OrderDate],isnull([ShipDate], GETDATE())) desc
	offset 0 row
	fetch next 1 row only;

select [Name]
from [SalesLT].[Product]
order by newid()
	offset 10 rows
	fetch next 1 row only;

declare @page smallint = 10
	, @current tinyint = 2;

select [Name], [ListPrice], [Color]
from [SalesLT].[Product]
where [Color] = 'Black'
order by [ListPrice] 
	offset (@page * (@current-1)) rows
	fetch next @page rows only;

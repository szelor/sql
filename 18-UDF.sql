use AdventureWorksLT
go

select [SalesOrderID], [Status]
	, [dbo].[ufnGetSalesOrderStatusText]([Status])
from [SalesLT].[SalesOrderHeader];

select *
from [dbo].[ufnGetAllCategories]();

select *
from [dbo].[ufnGetCustomerInformation](100);

select oh.PurchaseOrderNumber
from [SalesLT].[SalesOrderHeader] as oh
join [dbo].[ufnGetCustomerInformation] ([SalesLT].[SalesOrderHeader].CustomerID) as f
	on oh.CustomerID = f.CustomerID;

select oh.PurchaseOrderNumber, f.*
from [SalesLT].[SalesOrderHeader] as oh
cross apply [dbo].[ufnGetCustomerInformation] (oh.CustomerID) as f;

select c.FirstName, f.*
from [SalesLT].[Customer] as c
cross apply [dbo].[udfLastOrders] (c.[CustomerID], 2) as f;

select c.FirstName, f.*
from [SalesLT].[Customer] as c
outer apply [dbo].[udfLastOrders] (c.[CustomerID], 2) as f;
go
/*
Napisz funkcjê która zwraca liczbê sprzedanych
sztuk danego produktu 
i ca³kowita wartoœæ jego sprzeda¿y
*/

create function dbo.ProductOrders (@ProductID int)
RETURNS TABLE
AS RETURN(
select sum([OrderQty]) as [OrderQty], sum([UnitPrice]) as [UnitPrice] 
from [SalesLT].[SalesOrderDetail]
where [ProductID] = @ProductID);
go

select *
from dbo.ProductOrders (907);
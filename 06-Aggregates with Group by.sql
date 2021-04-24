use AdventureWorksLT
go

select color
from [SalesLT].[Product];

select C.Name
from [SalesLT].[ProductCategory] as C
join [SalesLT].[Product] as P
	on C.ProductCategoryID = P.ProductCategoryID;

select COUNT(*)
from [SalesLT].[Product]
where Color = 'White';

select COUNT(distinct color)
from [SalesLT].[Product];

select MIN([ListPrice]), MAX([ListPrice])
	,AVG([ListPrice])
from [SalesLT].[Product];

select C.Name, COUNT(*) as [Number of products]
from [SalesLT].[ProductCategory] as C
join [SalesLT].[Product] as P
	on C.ProductCategoryID = P.ProductCategoryID
where P.Color = 'Black'
group by C.Name;

select max([ListPrice]) - MIN([ListPrice])
from [SalesLT].[Product];

select C.Name, P.Color, COUNT(*) as [Number of products]
from [SalesLT].[ProductCategory] as C
join [SalesLT].[Product] as P
	on C.ProductCategoryID = P.ProductCategoryID
--where P.Color = 'Black'
group by C.Name, P.Color
order by C.Name;

/*
Odczytaj z tabeli [SalesLT].[SalesOrderHeader] 
wartoœci zamówieñ o najwy¿szych op³atach za wysy³kê 
zrealizowanych w ka¿dym dniu, dla poszczególnych klientów
*/

select [ShipDate], [CustomerID], max([Freight])
from [SalesLT].[SalesOrderHeader]
group by [ShipDate], [CustomerID]
order by [CustomerID];

select [CountryRegion], null as [StateProvince], null as City, count(*)
from [SalesLT].[Address]
group by [CountryRegion]
union all
select null, [StateProvince], null, count(*)
from [SalesLT].[Address]
group by [StateProvince]
union all
select null, null,[City], count(*)
from [SalesLT].[Address]
group by [City];

select [CountryRegion], [StateProvince], City, count(*)
from [SalesLT].[Address]
group by grouping sets (
	([CountryRegion], [StateProvince], City),
	([CountryRegion], [StateProvince]),
	([CountryRegion]),
	()
	);

select Color, AVG(listprice) as [Avg price]
	, COUNT(*) as cnt
from [SalesLT].[Product]
where [SellEndDate] is null
group by Color
having COUNT(*) >10
order by [Avg price] desc;

/*
Odczytaj nazwy produktów, które zosta³y sprzedane wiêcej ni¿ trzy razy. 
Dodaj do wyniku liczbê czêsto sprzedawanych produktów.
*/

select p.Name, GROUPING_ID(p.Name) ,count(*) as cnt
from [SalesLT].[Product] as P
join [SalesLT].[SalesOrderDetail] as od
	on P.ProductID = od.ProductID
group by grouping sets ((p.Name), ())
having count(*) > 3;
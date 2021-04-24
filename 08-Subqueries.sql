use AdventureWorksLT
go

select CustomerID
from [SalesLT].[SalesOrderHeader]
where [SalesOrderNumber]= 'SO71780';

select [FirstName], [CompanyName]
from [SalesLT].[Customer]
where [CustomerID] = 30113;

select [FirstName], [CompanyName]
from [SalesLT].[Customer]
where [CustomerID] = 
	(select CustomerID
	from [SalesLT].[SalesOrderHeader]
	where [SalesOrderNumber]= 'SO71780'
	);

select [Name], [ListPrice]
from [SalesLT].[Product];

select AVG([ListPrice])
from [SalesLT].[Product];

select [Name], [ListPrice] - 742.529
from [SalesLT].[Product];

select [Name], [ListPrice]
	- (select AVG([ListPrice])
		from [SalesLT].[Product])
from [SalesLT].[Product];
/*
Odczytaj za pomoc¹ podzapytania 
numery zamówieñ z³o¿onych przez klienta 
o nazwisku Eminhizer.
*/

select [SalesOrderNumber]
from [SalesLT].[SalesOrderHeader] as OH
join [SalesLT].[Customer] as C
	on C.CustomerID = OH.CustomerID
where C.LastName = 'Eminhizer';

select CustomerID
from [SalesLT].[Customer]
where LastName = 'Eminhizer'

select [SalesOrderNumber]
from [SalesLT].[SalesOrderHeader]
where CustomerID in 
	(select CustomerID
	from [SalesLT].[Customer]
	where LastName = 'Eminhizer');

/*
Odczytaj numery (kolumna SalesOrderID), 
daty zap³aty (kolumna DueDate) 
i numery klientów (kolumna CustomerID) 
dla zamówieñ z³o¿onych ostatniego dnia 
ka¿dego miesi¹ca.
*/

select SalesOrderID, DueDate, CustomerID
from [SalesLT].[SalesOrderHeader]
where DueDate in
(select max([DueDate])
from [SalesLT].[SalesOrderHeader]
group by year([DueDate]), month([DueDate]));

select 
	concat_ws(' ' ,[CountryRegion], [StateProvince], [City]) as [Address]
	, COUNT(CA.[CustomerID]) as Cnt
from [SalesLT].[Address] as A
join [SalesLT].[CustomerAddress] as CA
	on A.AddressID = CA.AddressID
group by concat_ws(' ' ,[CountryRegion], [StateProvince], [City]);

select subquery.Address, COUNT(subquery.CustomerID)
from (
	select 
		concat_ws(' ' ,[CountryRegion], [StateProvince], [City]) as [Address]
			,CA.CustomerID
	from [SalesLT].[Address] as A
	join [SalesLT].[CustomerAddress] as CA
		on A.AddressID = CA.AddressID) as subquery
group by subquery.Address;

select s.Name, s.ListPrice 
from 
(select [Name], [ListPrice]
	,ROW_NUMBER() over (order by [ListPrice] desc) as rn
from [SalesLT].[Product]) as s
where s.rn between 10 and 15;
go

with s as
(select [Name], [ListPrice]
	,ROW_NUMBER() over (order by [ListPrice] desc) as rn
	from [SalesLT].[Product]
)
select [Name], [ListPrice]
from s
where s.rn between 10 and 15;

with Categories as
(select [ParentProductCategoryID], [ProductCategoryID]
	,0 as lvl, [Name]
from [SalesLT].[ProductCategory]
where [ParentProductCategoryID] is null
union all
select e.ParentProductCategoryID, e.ProductCategoryID
	, c.lvl+1, e.Name
from [SalesLT].[ProductCategory] as e
join Categories as c
on e.ParentProductCategoryID = c.ProductCategoryID)
select *
from Categories;
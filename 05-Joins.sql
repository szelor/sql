use AdventureWorksLT
go

select C.Name, P.Name
	--,C.ProductCategoryID, P.ProductCategoryID
from [SalesLT].[ProductCategory] as C
join [SalesLT].[Product] as P on C.ProductCategoryID = P.ProductCategoryID;

/*
Odczytaj alfabetycznie uporz¹dkowan¹ listê 
nazw produktów sprzedanych kiedykolwiek 
klientom o imieniu Jeffrey.
*/

select P.Name
from [SalesLT].[Customer] as C
join [SalesLT].[SalesOrderHeader] as OH 
	on C.CustomerID = OH.CustomerID
join [SalesLT].[SalesOrderDetail] as OD
	on OH.SalesOrderID = OD.SalesOrderID
join [SalesLT].[Product] as P
	on OD.ProductID = P.ProductID
where C.FirstName = 'Jeffrey'
order by P.Name;


select distinct C.Name as Category
from [SalesLT].[ProductCategory] as C
join [SalesLT].[Product] as P
	on C.ProductCategoryID = P.ProductCategoryID;

select distinct [Color]
from [SalesLT].[Product]
order by [Color];

select C.Name as Cat, P.Name as Prod
from [SalesLT].[Product] as P full outer join [SalesLT].[ProductCategory] as C
	on C.ProductCategoryID = P.ProductCategoryID;


/*
Odczytaj imiona i nazwiska klientów, którzy 
w 2021 roku nie z³o¿yli ani jednego zamówienia
*/

select C.FirstName, C.LastName
	--, *
from [SalesLT].[Customer] as C
left join [SalesLT].[SalesOrderHeader] as OH
	on C.CustomerID = OH.CustomerID
where (OH.OrderDate between '20210101' and '20211231'
	or OH.OrderDate is null)
	and OH.SalesOrderID is null;

/*
ZnajdŸ zamówienia które zosta³y wys³ane do USA 
i w ich ramach sprzedano czerwone produkty
*/

select OH.PurchaseOrderNumber
from [SalesLT].[Address] as A
join [SalesLT].[SalesOrderHeader] as OH
	on A.AddressID = OH.ShipToAddressID
join [SalesLT].[SalesOrderDetail] as OD
	on OH.SalesOrderID = OD.SalesOrderID
join [SalesLT].[Product] as P
	on OD.ProductID = P.ProductID
where A.CountryRegion = 'United States'
	and P.Color = 'Red';

select P.Name, OD.UnitPrice, OH.TotalDue
from [SalesLT].[Product] as P
left join [SalesLT].[SalesOrderDetail] as OD
	on P.ProductID = OD.ProductID
join [SalesLT].[SalesOrderHeader] as OH
	on OH.SalesOrderID = OD.SalesOrderID;

select P.Name, OD.UnitPrice, OH.TotalDue
from [SalesLT].[Product] as P
left join (
	[SalesLT].[SalesOrderDetail] as OD
	join [SalesLT].[SalesOrderHeader] as OH
		on OH.SalesOrderID = OD.SalesOrderID
	) on P.ProductID = OD.ProductID;

select Category.Name, Subcategory.Name
	,Category.ProductCategoryID, Subcategory.ParentProductCategoryID
from [SalesLT].[ProductCategory] as Category
join [SalesLT].[ProductCategory] as Subcategory
	on Category.ProductCategoryID = Subcategory.ParentProductCategoryID;

select [CountryRegion]
from [SalesLT].[Address]
union 
select [CompanyName]
from [SalesLT].[Customer];

select [CountryRegion]
from [SalesLT].[Address]
union all
select [CompanyName]
from [SalesLT].[Customer];

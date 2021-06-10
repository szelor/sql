use AdventureWorksLT
go

insert into [SalesLT].[ProductCategory] 
([Name])
values ('Cat10' ) , ('Cat8');

select *
from [SalesLT].[ProductCategory];

select [ProductID], [Name], [ProductNumber], [Color], [StandardCost], [ListPrice], [Size], [Weight], [ProductCategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ThumbNailPhoto], [ThumbnailPhotoFileName], [rowguid], [ModifiedDate]
into EmptyProduct
from [SalesLT].[Product]
where 1=0;

select *
from dbo.EmptyProduct;

set IDENTITY_INSERT dbo.EmptyProduct on

insert into dbo.EmptyProduct
([ProductID], [Name], [ProductNumber], [Color], [StandardCost], [ListPrice], [Size], [Weight], [ProductCategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ThumbNailPhoto], [ThumbnailPhotoFileName], [rowguid], [ModifiedDate])
select *
from [SalesLT].[Product]
where [Color] in ('Black', 'White');

set IDENTITY_INSERT dbo.EmptyProduct off

/*
Utwórz tabelê Ladies zawieraj¹c¹ identyfikatory, imiona 
i nazwiska wszystkich klientek firmy AdventureWorks. 
Przyjmij, ¿e tylko imiona pañ koñcz¹ siê na literê a.
*/

select [CustomerID], [FirstName], [LastName]
into [SalesLT].Ladies
from [SalesLT].[Customer]
where [FirstName] like '%a';

delete from [SalesLT].Ladies;

delete from dbo.EmptyProduct
where ProductID = 680;

delete from [SalesLT].[ProductCategory];

select *
from [dbo].EmptyProduct;

update [dbo].EmptyProduct
set Color = 'Red' , ListPrice = ListPrice*0.9
where Color = 'White';

update [dbo].EmptyProduct
set [ListPrice] = [StandardCost], [StandardCost] = [ListPrice];

update P
set [ListPrice] = OD.UnitPrice
from [dbo].[EmptyProduct] as P
join [SalesLT].[SalesOrderDetail] as OD
	on P.ProductID = OD.ProductID
where OD.UnitPriceDiscount >0.01;

select *
from [dbo].[Products];

delete from [dbo].[Products]
where brutto > 200;

select *
from [SalesLT].[Product];
go

merge into [dbo].[Products] as T
using [SalesLT].[Product] as S
on T.Name = S.Name
when not matched by target then
	insert (Name, Brutto)
	values (S.Name, S.ListPrice)
when matched then
	update set T.Brutto = S.ListPrice*1.23
when not matched by source then
	delete
output $action, deleted.*, inserted.*;




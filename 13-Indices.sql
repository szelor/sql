use AdventureWorksLT
go

select *
from sys.indexes;

select [FirstName], [LastName]
from [SalesLT].[Customer]
where [CompanyName] = 'A Bike Store';

create index IX_Customer_CompanyName
on [SalesLT].[Customer] ([CompanyName]);

drop index IX_Customer_CompanyName on [SalesLT].[Customer];

create nonclustered index IX_Customer_CompanyName
on [SalesLT].[Customer] ([CompanyName]) include ([FirstName], [LastName]);

create unique index IX_Product_Name
on [SalesLT].[Product] (Name);

alter index all
on [SalesLT].[Product] 
reorganize;




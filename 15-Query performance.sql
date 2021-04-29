use Indices
go

create table dbo.SellingPrice
(
    SellingPriceID int identity(1,1) 
      constraint PK_SellingPrice primary key,
    SubTotal decimal(18,2) NOT NULL,
    TaxAmount decimal(18,2) NOT NULL,
    OrderQty int NOT NULL,
	Filler char(300) default 'a'
);
go

create nonclustered index IX_SellingPrice_SubTotal_TaxAmount
on dbo.SellingPrice (SubTotal, TaxAmount);

insert into dbo.SellingPrice (SubTotal,TaxAmount,OrderQty)
select SubTotal, TaxAmount, OrderQty
from dbo.SellingPriceTemplate;

select *
from dbo.SellingPrice
where SubTotal > 3300;

select 1.*9700/66000;

select SellingPriceID, SubTotal, TaxAmount
from dbo.SellingPrice
where SubTotal > 3300;

select SellingPriceID, SubTotal, TaxAmount
from dbo.SellingPrice
where SubTotal * 100 > 330000;

select *
from dbo.SellingPrice
where SubTotal > 3300;

select SellingPriceID, SubTotal, TaxAmount
from dbo.SellingPrice
where (SubTotal + TaxAmount ) * OrderQty >33000;

create table dbo.SellingPriceWithComputeColumn
(
    SellingPriceID int identity(1,1) 
      constraint PK_SellingPriceV3 primary key,
    SubTotal decimal(18,2) NOT NULL,
    TaxAmount decimal(18,2) NOT NULL,
    OrderQty int NOT NULL,
    LineTotal as ((SubTotal + TaxAmount) * OrderQty),
	Filler char(300) default 'a'
);
go

create index SellingPriceV3ExtendedAmount
on dbo.SellingPriceWithComputeColumn(LineTotal)
go

insert into dbo.SellingPriceWithComputeColumn (SubTotal,TaxAmount,OrderQty)
select SubTotal, TaxAmount, OrderQty
from dbo.SellingPriceTemplate;

select SellingPriceID, SubTotal, TaxAmount
from dbo.SellingPriceWithComputeColumn
where LineTotal > 33000;

select SellingPriceID, SubTotal, TaxAmount
from dbo.SellingPriceWithComputeColumn
where (SubTotal + TaxAmount ) * OrderQty > 33000;


CREATE INDEX CustomersLastName
ON [dbo].[Customers]([LastName]);
GO

SELECT [CustomerID]
FROM [dbo].[Customers]
WHERE [LastName] = 'Szeliga' 
	OR [LastName] = 'SZELIGA'
AND [MiddleName] IS NOT NULL;

SELECT [CustomerID]
FROM [dbo].[Customers]
WHERE UPPER([LastName]) = 'SZELIGA'
AND [MiddleName] IS NOT NULL;
GO

ALTER TABLE [dbo].[Customers]
ADD LastNameUpper AS UPPER(LastName);
GO

CREATE INDEX CustomersLastNameUpper
ON dbo.[Customers](LastNameUpper)
WHERE [MiddleName] IS NOT NULL;
GO

SELECT [CustomerID]
FROM [dbo].[Customers]
WHERE UPPER([LastName]) = 'SZELIGA'
AND [MiddleName] IS NOT NULL;
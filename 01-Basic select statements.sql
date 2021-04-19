use AdventureWorksLT
go
/*
Odczytaj z tabeli [SalesLT].[Product] nazwy towar�w 
(kolumna [Name]) oraz powi�kszone o 23% ich ceny katalogowe 
(oblicz je na podstawie danych z kolumny [ListPrice]).
*/

select [Name], round([ListPrice] *1.23,2) as [Brutto]
from [SalesLT].[Product];

select '1'+'1'+1;

select [Name]
	, [ListPrice] - [StandardCost] as Margin
from [SalesLT].[Product];

select 
	--FirstName + ISNULL(MiddleName, ' ') + LastName as [Full Name]
	CONCAT_WS(' ', FirstName, MiddleName, LastName) as [Full Name]
from [SalesLT].[Customer];

/*
Oblicz, ile dni up�yn�o pomi�dzy z�o�eniem a wys�aniem 
zrealizowanych zam�wie� 
(r�nice mi�dzy warto�ciami kolumn [ShipDate] i [OrderDate] 
tabeli [SalesLT].[SalesOrderHeader]).
*/

select [PurchaseOrderNumber] 
	, DATEDIFF(d,[OrderDate],coalesce([ShipDate],getdate())) as [Delay]
	--,[OrderDate], [ShipDate]
from [SalesLT].[SalesOrderHeader];

select 'Product: ' + [Name], [ListPrice], [Color],
	case
		when [ListPrice] <=50 then 'Cheap'
		when [ListPrice] <=100 then 'Moderate'
		else 'Expensive'
	end as Price
from [SalesLT].[Product];
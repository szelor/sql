use [AdventureWorksLT]
go

select [Name], [ListPrice]
from [SalesLT].[Product]
where [ProductNumber] = 'FR-T67Y-50';

select [Name], [ListPrice]
	,[Color] , [ProductID]
from [SalesLT].[Product]
where [ProductID] between 900 and 910;

select [Name], [ListPrice]
	,[Color] 
from [SalesLT].[Product]
where [Color] in ('Black', 'White', 'Red');

select [Name], [ListPrice]
	,[Color] 
from [SalesLT].[Product]
where [Name] like '%[^0-9]';

select [Name], [ListPrice], [Color]
from [SalesLT].[Product]
where not [Color] = 'red';

/*
Wyœwietl tytu³y, imiona i nazwiska klientów 
którzy pracuj¹ w firmie której nazwa zawiera s³owo Bike, 
nie znamy ich drugiego imienia, 
ich login koñczy siê na cyfrê z zakresu 2-7 
i którzy zostali dodani lub zmodyfikowani po 2005 roku. 
Wynik ma mieæ postaæ jednej kolumny 
<tytu³: Imiê spacja Nazwisko>.
*/

select CONCAT_WS(' ', 'Tytu³:', [FirstName], [LastName]) 
	as 'Customer'
		--,[MiddleName]
from [SalesLT].[Customer]
where [CompanyName] like '%Bike%'
and [SalesPerson] like '%[0-7]'
and [ModifiedDate] > '20051231'
and [MiddleName] is not null;

select [Name], Color
from [SalesLT].[Product]
where [Color] = 'Black';
--89
select [Name], Color
from [SalesLT].[Product]
where [Color] <> 'Black';
--157
select 1
where null < null;

select [Name], Color
from [SalesLT].[Product]
where [Color] is not null;
--50

select [Name]
	--, [ProductID] , cast(RAND()*1000 as int)
from [SalesLT].[Product]
where [ProductID] = cast(RAND()*1000 as int);
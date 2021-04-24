use AdventureWorksLT
go

select [Color],[ListPrice]
	, avg([ListPrice]) over() as [avg price]
	, min([ListPrice]) over() as [min price]
	, max([ListPrice]) over() as [max price]
	, max([ListPrice]) over() - min([ListPrice]) over() as [range]
	, count(*) over()  as cnt
	, avg([ListPrice]) over(partition by [Color]) as [avg per color]
from [SalesLT].[Product];

/*
Policz sum� zam�wie� na poziomie dni, miesi�cy i lat 
dat zap�aty za poszczeg�lne zam�wienia
(warto�ci kolumny DueDate). 
Dodaj te� do zapytania sum� warto�ci wszystkich zam�wie�.
*/

select YEAR([DueDate]) as [year], MONTH([DueDate]) as [month]
	, DAY([DueDate]) as [day]
	, SUM([TotalDue]) over(partition by YEAR([DueDate])) as [yearly total]
	, SUM([TotalDue]) over(partition by month([DueDate])) as [monthy total]
	, SUM([TotalDue]) over(partition by day([DueDate])) as [daily total]
	, SUM([TotalDue]) over() as [overall total]
from [SalesLT].[SalesOrderHeader];

select [Name], sign([ListPrice] - AVG([ListPrice]) over())
from [SalesLT].[Product];

select [CustomerID], [PurchaseOrderNumber], [TotalDue]
	,CAST(100. * [TotalDue] / SUM([TotalDue]) over (partition by [CustomerID]) as numeric(5,2))
from [SalesLT].[SalesOrderHeader];

select [FirstName]
	,ROW_NUMBER() over(order by [FirstName]) as [row number]
	,RANK() over(order by [FirstName]) as [rank]
	,DENSE_RANK() over(order by [FirstName]) as [dense rank]
	,NTILE(5) over(order by [FirstName]) as [ntile]
from [SalesLT].[Customer]
where FirstName in ('Andrew', 'Juanita', 'Christopher');

/*
Policz, jak cz�sto sprzedane zosta�y poszczeg�lne produkty,
a nast�pnie ponumeruj wiersze wyniku tego zapytania na dwa sposoby: 
w jednej kolumnie umie�� numery od jednego 
(najcz�ciej sprzedawany produkt) do ostatniego 
na podstawie pozycji wiersza z danym produktem, 
w drugiej wstaw numery na podstawie liczby sprzeda�y danego towaru
(towary sprzedane tyle samo razy powinny mie� taki sam numer)
*/
select [Name], COUNT(*) as cnt
	,ROW_NUMBER() over(order by COUNT(*) desc)
	,DENSE_RANK() over(order by COUNT(*) desc)
from [SalesLT].[SalesOrderDetail] as OD
join [SalesLT].[Product] as P
	on P.ProductID = OD.ProductID
group by [Name];

select [PurchaseOrderNumber], [ShipDate], [TotalDue]
	,SUM([TotalDue]) over (partition by [ShipDate] order by [ShipDate]
		rows between 1 preceding
		and current row) as [running total]
	,SUM([TotalDue]) over (partition by [ShipDate] order by [ShipDate]
		rows between 1 preceding
		and 1 following) as [moving total]
	, LAG([TotalDue],2) over(partition by [ShipDate] order by [ShipDate])
from [SalesLT].[SalesOrderHeader]
order by [ShipDate];

/*
Policz r�nic� warto�ci zam�wie� sk�adanych w kolejnych dniach
*/
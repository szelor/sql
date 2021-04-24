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
Policz sumê zamówieñ na poziomie dni, miesiêcy i lat 
dat zap³aty za poszczególne zamówienia
(wartoœci kolumny DueDate). 
Dodaj te¿ do zapytania sumê wartoœci wszystkich zamówieñ.
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
Policz, jak czêsto sprzedane zosta³y poszczególne produkty,
a nastêpnie ponumeruj wiersze wyniku tego zapytania na dwa sposoby: 
w jednej kolumnie umieœæ numery od jednego 
(najczêœciej sprzedawany produkt) do ostatniego 
na podstawie pozycji wiersza z danym produktem, 
w drugiej wstaw numery na podstawie liczby sprzeda¿y danego towaru
(towary sprzedane tyle samo razy powinny mieæ taki sam numer)
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
Policz ró¿nicê wartoœci zamówieñ sk³adanych w kolejnych dniach
*/
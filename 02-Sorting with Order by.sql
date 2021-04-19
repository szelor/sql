select [Name], [Color], [ListPrice] 
from [SalesLT].[Product]
order by [Color], [ProductID];

select *
from [dbo].[imiona]
order by imie collate Polish_Bin;

/*
Odczytaj z tabeli [SalesLT].[Product] kolumny [ProductNumber] 
oraz [Size] 
i posortuj wynik rosn¹co wed³ug wartoœci kolumny [Size], 
ale w taki sposób, ¿eby wartoœci NULL znalaz³y siê na koñcu, 
a nie na pocz¹tku wyniku.
*/

select ProductNumber, Size
from [SalesLT].[Product]
order by case 
	when Size IS NULL then 1
	else 0
	end,
	size;
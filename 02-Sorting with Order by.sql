select [Name], [Color], [ListPrice] 
from [SalesLT].[Product]
order by [Color], [ProductID];

select *
from [dbo].[imiona]
order by imie collate Polish_Bin;

/*
Odczytaj z tabeli [SalesLT].[Product] kolumny [ProductNumber] 
oraz [Size] 
i posortuj wynik rosn�co wed�ug warto�ci kolumny [Size], 
ale w taki spos�b, �eby warto�ci NULL znalaz�y si� na ko�cu, 
a nie na pocz�tku wyniku.
*/

select ProductNumber, Size
from [SalesLT].[Product]
order by case 
	when Size IS NULL then 1
	else 0
	end,
	size;
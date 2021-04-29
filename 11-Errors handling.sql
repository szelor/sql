use AdventureWorksLT
go

/*
Dodaj 100 do wartoœci zamówienia o numerze 71774
i odejmij tê sam¹ kwotê od wartoœci zamówienia 71776
*/

select [SalesOrderID], [SubTotal]
from [SalesLT].[SalesOrderHeader]
where [SalesOrderID] in (71774, 71776);

begin tran
update [SalesLT].[SalesOrderHeader]
set [SubTotal] += 10
where [SalesOrderID] = 71774;

update [SalesLT].[SalesOrderHeader]
set [SubTotal] -= 10
where [SalesOrderID] = 71776;
commit tran

select 1/0
print 'Batch execution continues'

begin try
	begin tran
	update [SalesLT].[SalesOrderHeader]
	set [SubTotal] -= 10
	where [SalesOrderID] = 71774;

	update [SalesLT].[SalesOrderHeader]
	set [SubTotal] -= 100
	where [SalesOrderID] = 71776;
	commit tran
end try
begin catch
	print 'Catch block';
	throw
	rollback tran
end catch
print 'After Try/Catch';

set xact_abort on;

throw 50000, 'My error message',1
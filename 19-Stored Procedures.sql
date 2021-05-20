use AdventureWorksLT
go

create proc usp_test
as
select * from t1;

exec usp_test;

drop proc usp_test;

begin try
	select 1/0
end try
begin catch
	exec [dbo].[uspPrintError];
end catch

truncate table [dbo].[ErrorLog];
go

begin try
	select 1/0
end try
begin catch
	exec [dbo].[uspLogError];
end catch

select *
from [dbo].[ErrorLog];
go
/*
Napisz procedurê ustawiaj¹c¹ datê wycofania ze sprzeda¿y 
danego produktu.
Jesli ta data nie zostanie podana, ustaw datê 
wycofania ze sprzeda¿y na bie¿¹c¹ datê.
*/
alter proc usp_UpdateProduct
@ProductID int, @SellEndDate datetime = NULL
as
begin
	if @SellEndDate is null 
	set @SellEndDate = GETDATE();
update [SalesLT].[Product]
set [SellEndDate] = @SellEndDate
where [ProductID] = @ProductID;
end

exec usp_UpdateProduct 
	@ProductID = 907, @SellEndDate = '20210223';

select *
from [SalesLT].[Product]
where [ProductID] = 907;

exec usp_UpdateProduct 
	@ProductID = 907 with recompile;

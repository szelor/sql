use Indices
go

exec sp_helpindex '[dbo].[SalesOrderDetail]'

set statistics io on
go

select [ProductID], SUM ([UnitPrice]) as TotalPrice
from [dbo].[SalesOrderDetail] 
group by [ProductID]
order by [ProductID]
option (maxdop 1);

create index Covering
on [dbo].[SalesOrderDetail] ([UnitPrice], [ProductID]);

--POC
create index POC
on [dbo].[SalesOrderDetail] ([ProductID], [UnitPrice])
go

create view [SumUnitPrice] 
with schemabinding
as 
select [ProductID], SUM ([UnitPrice]) as TotalPrice, COUNT_BIG(*) as nr
from [dbo].[SalesOrderDetail] 
group by [ProductID];
go

create unique clustered index IdexedView
on [SumUnitPrice] ([ProductID]);

select *
from [SumUnitPrice];

select [ProductID], Avg ([UnitPrice]) as AvgPrice
from [dbo].[SalesOrderDetail] 
group by [ProductID]
order by [ProductID]
option (maxdop 1);

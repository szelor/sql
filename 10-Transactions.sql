use AdventureWorksLT
go

begin tran
select @@trancount;
update [SalesLT].[Product]
set [ListPrice] = 555
where [ProductID] <800;
select @@trancount;
--commit tran
select *
from [SalesLT].[Product];
commit tran
select @@trancount;
rollback tran

use master
go
alter database [AdventureWorksLT]
set read_committed_snapshot on
with rollback immediate;


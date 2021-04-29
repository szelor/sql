use Indices
go


exec sp_help [dbo.SalesOrderDetail];

select *
from sys.dm_db_index_physical_stats
	(DB_ID('Indices'),
	OBJECT_ID('dbo.SalesOrderDetail'),
	1,
	NULL,
	'Detailed');

select *
into cheap
from dbo.SalesOrderDetail;

exec sp_help [dbo.cheap];

set statistics io on
go

select ProductId
from dbo.SalesOrderDetail
where ProductId = 709;

select *
from dbo.SalesOrderDetail
where ProductId = 709;

select *
from dbo.SalesOrderDetail with (index (1))
where ProductId = 709;

select *
from dbo.SalesOrderDetail
where ProductId in (707,709);

select *
from dbo.SalesOrderDetail with (index (3))
where ProductId in (707,709);

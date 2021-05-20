use AdventureWorksLT
go

select USER_NAME();

use master
go

create login [Marcin]
with password = 'SuperT@jneH@slo00!',
check_policy = ON;

exec xp_readerrorlog
--Login failed for user 'Marcin'. Reason: An attempt to login using SQL authentication failed. Server is configured for Integrated authentication only. [CLIENT: <local machine>]  
use AdventureWorksLT
go

create user Marcin
for login [Marcin];

create role [IT];
go

alter role [IT]
add member [Marcin];

grant select, insert
on [SalesLT].[Product]
to [IT];
go

create view Customer
as 
select [FirstName], [LastName]
from [SalesLT].[Customer]
where [CompanyName] like 'A%';
go

grant select
on Customer
to [IT];

deny select
on Customer
to  [IT];
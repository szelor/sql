use AdventureWorksLT;
go

create schema Movies;
go

create table Movies.Movie 
(MovieId int identity constraint PK_Movie Primary Key,
Title nvarchar (100) not null constraint UQ_Movie_Title Unique,
Premiere smalldatetime null constraint DF_Movie_Premiere Default (getdate()),
Rating tinyint not null constraint CK_Movie_Rating Check (Rating between 0 and 5),
Genre char (50) null
);

insert into Movies.Movie (Title, Rating)
values ('Shrek', 5);

select *
from Movies.Movie;

alter table Movies.Movie
drop column Genre;

create table Movies.Genre
(GenreId int identity primary key,
Name char(50) not null unique
);

alter table Movies.Movie
add GenreId int null constraint FK_Genre_Movie references Movies.Genre(GenreId);


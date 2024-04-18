--Objektkunde

--Abfrageergebnisse
/*
a) adhoc Abfrage
b) Sicht 
c) f()
d) Proz

----------------------------> schnell
c     d					a|b
a						d

c       a|b    d


*/

select * from customers --customerid nchar(5)

exec gp_SucheKunden 'ALFKI' --  1 Zeile
exec gp_SucheKunden 'A'		--  4 Zeile
exec gp_SucheKunden '%'		--  1 Zeile


create or alter proc gp_SucheKunden @kdid varchar(5) = '%'
as
select * from customers where customerid like @kdid +'%'


--Variablen werden auf die Hälfte geschätzt
--Prozeduren nie benutzerfreundlich schreiben... 

--Sicht
--weil: Bequem, Rechte
-- 


create table slf (id int identity, stadt int, land int)


insert into slf
select 10, 100
UNION ALL
select 20,200
UNION ALL
select 30,300

select * from slf


create or alter view vslf
as
select * from slf


select * from vslf

alter table slf add fluss int
update slf set fluss = id*1000


select * from vslf


alter table slf drop column land

select * from vslf


-------------------------------
drop table slf
create table slf (id int identity, stadt int, land int)


insert into slf
select 10, 100
UNION ALL
select 20,200
UNION ALL
select 30,300

select * from slf


create or alter view vslf with schemabinding
as
select id, stadt,land from dbo.slf


select * from vslf

alter table slf add fluss int
update slf set fluss = id*1000


select * from vslf


alter table slf drop column land

select * from vslf


--Verwende nie ein Sicht 

create view vdemo1 as
SELECT Customers.CompanyName, Customers.CustomerID, 
   Customers.ContactName, Customers.City, Customers.Country, 
   [Order Details].ProductID, [Order Details].UnitPrice, 
   [Order Details].Quantity, Orders.OrderID, Orders.OrderDate, 
   Orders.ShippedDate
FROM [Order Details] INNER JOIN
   Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
   Customers ON Orders.CustomerID = Customers.CustomerID


select * from vdemo1


select country, count(distinct country) from vdemo1 group by country

select country, count(*) from customers group by country









create or alter proc gpdemo3 
as
select getdate();
GO



exec gpdemo3









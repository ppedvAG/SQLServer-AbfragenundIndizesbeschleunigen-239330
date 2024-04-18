--Ausf�hrugspl�ne sollten wiederverwedenbar sein
-- SQL Server versucht zu Autoparametrisieren
--allerdings gelingt dies nur selten
--Bereits ein Join kann dies verhindern
--Dieses Problem kennt eine Prozedur gruds�tzlich nicht...


--Situationen, in denen man nicht glaubt, dass
--neue Pl�ne erstellt werden
--verschiedene Schreibstile der Autoren k�nnen verschiedene
--Pl�ne erzeugen

--Gro� und Kleinschreibung-- Zeilenumbruch etc..

----------------------------------------------------
--Versuch
--alles von Zeile 20 bis Zeile 38 ausf�hren
--letzte Ergebnistabelle kontrollieren
----------------------------------------------------

dbcc freeproccache;
GO

select * from orders where customerID='HANAR'
go

select * from Orders where CustomerID='HANAR'
go
select * from Orders 
	where   CustomerID='HANAR'
go



select usecounts, cacheobjtype,[TEXT] from
	sys.dm_exec_cached_plans P
		CROSS APPLY sys.dm_exec_sql_text(plan_handle)
	where cacheobjtype ='Compiled PLan'
		AND [TEXT] not like '%dm_exec_cached_plans%'

---- ENDE


--3 Pl�ne...
----------------------------------------------------------
--hier ein anderer Versuche 
--lles von Zeile 47 bis 54 ausf�hren
-----------------------------------------------------------

dbcc freeproccache;
GO


select * from	 orders where orderid = 10

select	* from orders where orderid = 300

select * from orders where orderid = 30000

select * from orders where orderid = 300000


select usecounts, cacheobjtype,[TEXT] from
	sys.dm_exec_cached_plans P
		CROSS APPLY sys.dm_exec_sql_text(plan_handle)
	where cacheobjtype ='Compiled PLan'
		AND [TEXT] not like '%dm_exec_cached_plans%'


---ENDE

--Problem der Funktionen
--universell einsetzbar, aber ..

select f(spalte), f(wert) from f(wert)  where f(Sp) < f(wert)

--Simple Funktione , die die Rechnungsgsumme errechnet
--Es muss kein Join mit order details mehr geschrieben werden
--Aerdings ist das nur Makeup.. im Hintergrund muss dies der SQL Server dennoch leisten
--Pl�ne?


create function fRngSumme (@Bestid int) returns money
as
	begin
			return(select sum(unitprice*quantity) from [Order Details] where orderid = @Bestid)
	end
GO

--Test der Funktion
select dbo.fRngSumme(10248)
GO


ALTER DATABASE [Northwind] SET COMPATIBILITY_LEVEL = 130
GO

--Pl�ne ansehen. Ist die DB im KOmpabilit�tslevel 2016 oder fr�her
-- --> Kosten f�r F() etrem gering, was nicht sein kann
		--order details hat fast 3 mal soviele Zeilen wie orders
---> im tats. Plan taucht sie nicht auf
-->  in den Messungen statistics io ebenfalls nicht

--Sieht nur cool aus...
set statistics io , time on 
GO 

select  dbo.fRngSumme(orderid),* from orders
where dbo.fRngSumme(orderid) < 500
GO
set statistics io , time off
GO

--nun mit ..

ALTER DATABASE [Northwind] SET COMPATIBILITY_LEVEL = 160
GO

set statistics io , time on 
GO 

select  dbo.fRngSumme(orderid),* from orders
where dbo.fRngSumme(orderid) < 500
GO
set statistics io , time off
GO
--hier konnte der SQL Server die Funktion afl�sen.. Plan ist optimal


--Nun F() als Spalte integriert
alter table orders add RSumme as dbo.fRngSumme(orderid)
go

set statistics io , time on
Go
select  * from orders
set statistics io , time off
GO
--Hier versagt SQL Server trotz Modus 160..

--Fazit: Versuche Funktionen zu vermeiden, da die OPtimierung des SQL Server Grenzen hat



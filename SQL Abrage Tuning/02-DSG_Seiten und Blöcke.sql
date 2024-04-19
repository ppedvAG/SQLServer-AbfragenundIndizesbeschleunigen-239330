--Seiten und Blöcke

--Seiten und Blöcke

/*
1  Seiten = 8192bytes
max 8072 bytes Datenvolumen
1 DS mit fixen Längen max 8060byts und muss in Seite passen
max 700 DS pro Seite


-------------------
VERWALTUNG
--------------------
DS1
DS2
DS3
LEER
---------------------



8 zusammenhängende Seiten = Block

Seite = Page 
Block = Extent

SQL kann mur mit einem Thread eine Seite lesen. 
Zwei Zugriffe ergeben einen Latch oder auch Spinocks
Latch = supended, Spinlocks sind aktiv



*/

use northwind;
GO


create table t1 (id int identity, spx char(4100));
GO


insert into t1 
select 'XY'
GO 20000
--Zeit Messen


dbcc showcontig('Tabelle')


--besser weil detailierter
select * from sys.dm_db_index_physical_stats(db_id(), object_id(''), NULL, NULL, 'detailed')
GO



--Warum hat die Tabelle t1 160MB , bei ca 80MB Daten
--Warum liest man aus der Tabelle KU 57000, wenn der dbcc nur 41000 Seiten angibt





use northwind;


set statistics io, time on

select * from kundeumsatz where freight = 0.02  --56878

--dbcc?

dbcc showcontig('kundeumsatz')


select forwarded_record_count
from sys.dm_db_index_physical_stats(db_id(), object_id('kundeumsatz'), null, null, 'detailed')

--Problem beseitigen

--Clustered IX
USE [Northwind]

GO

CREATE CLUSTERED INDEX [CLIX] ON [dbo].[KundeUmsatz]
(	[id] ASC  )
GO


--den könnte man danach auch wieder löschen, dann aber ist ein fwrc wieder mögich
--> statt 56000 Seiten eam Ende 41000

--- Tipp: Brent Ozar --> sp_blitzIndex






--Normalisierung vs Redundanz
--Jeder Join kostet, Redundanz schafft Geschwindigkeit
-- Allerding muss diese gepflegt werden--> Trigger gelten als langsam
----> mit Rechten Zugriff auf Tabelle absichern, daf�r mit Prozedur arbeiten, die Redundanz pflegt




--Seiten: 8192 bytes davon sind 8060 bytes Nutzlast
--pro Seiten max 700 Slots
--i.d.R muss ein DS in eine Seite passen
--i.d.R?? varchar(max), nvarchar(max), varbinary(max) 
--varchar(8000)

--Messen der Seitendichte
dbcc showcontig () --gesamte DB
dbcc showcontig ('tabelle')

--Messungen
set statistics io , time on --Anzahl der Seiten, 
	--Dauer in ms von CPU und Gesamtzeit

--Ausf�hrungsplan: Routenplan f�r mein Statement
--manchmal l�gt der auch...

--8 Seiten am St�ck = Block (Extent)


create table t1 (id int identity,spx char(4100))


insert into t1
select 'XY'
GO 20000 --12 Sekunden



create table t2 (id int identity,spx char(4100))


insert into t2
select 'XY'
GO 20000 --9 Sekunden

--Seiten werden 1:1 in RAM geladen

set statistics io, time on --off
--IO = Seiten
--time = Dauer in ms und CPU Zeit

select * from t1 where id = 10

dbcc showcontig('t1')
-- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%  !!!


--DB Design:


--Normalform
-- 1NF  in einer Zelle ein! Wert

--DAtentyp


'otto'

--varchar(50):  'otto'      4
--nvarchar(50)   4*2 = 8
--char(50)       50
--nchar(50)     2*50   100

--Sparse Columns


--Spalten kosten

create table kunden
	(
	id int primary key identity,
	Fax1 int, 
	Fax2 int sparse null ,-- Sparse ..ein NULL kostet nichts--> 30000 Spalten
	Fax3 int null


	)

--_Wann lohnt sich das? i.d.R ab 60 % Werte






--warum 160MB?



use northwind;

--alle DS der Tab orders aus dem Jahr 1997 (orderdate)

--korrekt aber langsam
select * from orders where orderdate like '%1997%'

--zuf�llig richtig und w�re schnell, h�tte falsch sein k�nnen
select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59.997'
--richtig aber langsam
select * from orders where year(orderdate) = 1997





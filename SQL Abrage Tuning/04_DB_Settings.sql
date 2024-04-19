--evtl n�tzliche DB Settings


--Accelerated DB Recovery

/*

n�tzlich , wenn langdauernde TX oftmal ein Rollback erfahren
TX dauern zwar wg Versionierung l�nger, aber der Rollback ist deutlich schneller

--> Demos ADR_


*/


--DB Dateien
--am besten verschiedene Laufwerke einsetzen
--Start - ud Wachstumsgr��en anpassen --> Ziel : IO vermeiden und nicht f�rdern!
-- wie gro� in 3 Jahren als Ansatz


--Momentaufnahmenisolation


/*
TX erzeugen Kopien des Originaldatens�tzes als Version in der tempdb
Lesen hindert Schreiben nicht mehr und Schreiben das Lesen nicht

Die kann als Grundverhalten eingestellt werden

Locks werden gr��tenteils vermieden

--> Massive Last in Tempdb??

*/

USE [master]
GO
ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO
ALTER DATABASE [Northwind] SET ALLOW_SNAPSHOT_ISOLATION ON
GO


/* TRANSAKTIONEN

bei TX darauf achten dass diese immer kurz und rasch ausgef�hrt werden k�nnen:

-keine Userinteraktion w�hrend der TX
-statt komplexen TX lieber in einzelne TX aufteilen

*/


--Alternative f�r Momentaufnahmen
--�ndern des TX Levels
set transaction isolation level read uncommitted

--nun ist zwar das Lesen erlaubt, aber man bekommt den ge�nderten aber nicht committed DS


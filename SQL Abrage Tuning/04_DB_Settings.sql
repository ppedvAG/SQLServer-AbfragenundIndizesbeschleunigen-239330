--evtl nützliche DB Settings


--Accelerated DB Recovery

/*

nützlich , wenn langdauernde TX oftmal ein Rollback erfahren
TX dauern zwar wg Versionierung länger, aber der Rollback ist deutlich schneller

--> Demos ADR_


*/


--DB Dateien
--am besten verschiedene Laufwerke einsetzen
--Start - ud Wachstumsgrößen anpassen --> Ziel : IO vermeiden und nicht fördern!
-- wie groß in 3 Jahren als Ansatz


--Momentaufnahmenisolation


/*
TX erzeugen Kopien des Originaldatensätzes als Version in der tempdb
Lesen hindert Schreiben nicht mehr und Schreiben das Lesen nicht

Die kann als Grundverhalten eingestellt werden

Locks werden größtenteils vermieden

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

bei TX darauf achten dass diese immer kurz und rasch ausgeführt werden können:

-keine Userinteraktion während der TX
-statt komplexen TX lieber in einzelne TX aufteilen

*/


--Alternative für Momentaufnahmen
--Ändern des TX Levels
set transaction isolation level read uncommitted

--nun ist zwar das Lesen erlaubt, aber man bekommt den geänderten aber nicht committed DS


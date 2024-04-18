--Running: Startet danmit
--Supsended: falls Werte geholt werden müssen... Supsended vom Buffer Pool
--Runnable: sind die Werte da, dann Runnable..muss nun aber auf CPU warten

drop database if exists tuning;
GO
Create Database tuning;
GO

use tuning
GO

drop table if exists dummytable;
GO

create table dummytable (id int,sp1  varchar(8000))

declare @i as int = 0
While @i < 200
begin
    begin transaction
    insert into dummytable values (1, replicate('x', 8000))

    commit transaction
    set @i=@i+1
end

declare @spid as int = (select @@spid)

CREATE EVENT SESSION [WaitsInSession] ON SERVER 
ADD EVENT sqlos.wait_info(
    ACTION(sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[session_id]=(72)))
ADD TARGET package0.event_file(SET filename=N'C:\_SQLBACKUP\WaitsInSession.xel'),
ADD TARGET package0.ring_buffer(SET max_events_limit=(500),max_memory=(10240))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO




Alter event session WaitInSession
ON Server
	  State=Start
    GO


---insert

declare @i as int = 0

--begin transaction
While @i < 200
begin
	begin transaction
    
    insert into dummytable values (1, replicate('x', 8000))

    commit transaction
    set @i=@i+1
end
--Commit



create table t1 (id int identity, spx char(4100))


insert into t1
select 'XY'
GO 100

drop event session collwaitstats
ON Server

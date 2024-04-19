-- How big is the plan cache SQL 2012
select name, sum(pages_kb) /1024.0 MBUsed
from sys.dm_os_memory_clerks
where name = 'SQL PLans'
group by name;
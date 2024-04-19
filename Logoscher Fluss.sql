select o.ShipCountry as LAND, shipcity , sum(freight) as SummeFracht
from orders o
where shipcountry = 'USA'
group by Shipcountry, shipcity having shipcountry = 'USA'
order by LAND

--> FROM  --> JOIN --> WHERE --> GROUP BY --> SELECT --> order BY -->TOP -->  Ausgabe


--Logischer FLuss



--Hier erzeugen wir immer wieder neue Pl�ne bei Adhoc Abfragen


select customerid,
	companyname
from customers where customerid = 'ALFKI'


select  customerid
	   ,companyname
from customers where customerid = 'ALFKI'

select * from customers	
		where Customerid = 'AFLKI'

select * from Customers	
		where Customerid = 'AFLKI'


select * from orders where orderid = 10 --tinyint

select * from orders where orderid = 20000 --smallint

select * from orders where orderid = 50000 --int





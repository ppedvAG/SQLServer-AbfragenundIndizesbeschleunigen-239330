--Automatischer Batchmode


ALTER DATABASE NORTHWIND set compatibility_level =110


SELECT ProductID, SUM(UnitPrice) SumUnitPrice, AVG(UnitPrice) AvgUnitPrice,
SUM(Quantity) SumOrderQty, AVG(Quantity) AvgOrderQty
FROM [dbo].[ku]
GROUP BY ProductID
ORDER BY ProductID
GO


ALTER DATABASE NORTHWIND set compatibility_level =150

use ist722_soomondi_stage;
GO

/* Drop table dbo.stgNorthwindOrders */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.stgNorthwindOrders') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.stgNorthwindOrders 
;


/* Drop table dbo.stgNorthwindShippers */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.stgNorthwindShippers') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.stgNorthwindShippers 
;



/* Drop table dbo.stgOrderFulfillment */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'stgNorthwindOrderFulfillment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.stgNorthwindOrderFulfillment
;



--stage orders--
SELECT OrderID,
	   CustomerID,
	   OrderDate,  
	   RequiredDate,
	   ShippedDate,
	   ShipVia
INTO dbo.stgNorthwindOrders
FROM Northwind.dbo.Orders;
GO

--Delete from dbo.stgNorthwindOrders;
--select * from dbo.stgNorthwindOrders

/*
---stage shippers--
SELECT ShipperID,
       CompanyName
INTO dbo.stgNorthwindShippers
FROM Northwind.dbo.Shippers
GO


---stage order fulfillment---
SELECT o.OrderID,
	   s.ShipperID, 
	   o.OrderDate,  
	   o.RequiredDate,
	   o.ShippedDate
INTO dbo.stgNorthwindOrderFulfillment
FROM Northwind.dbo.Orders o
	JOIN Northwind.dbo.Shippers s
		ON s.ShipperID = o.ShipVia
GO
*/


---stage Shippers       
SELECT [ShipperID],
       [CompanyName],
	   [Phone]
INTO  [dbo].[stgNorthwindShippers]
FROM [Northwind].[dbo].[Shippers]


--stage OrderFulfillment


SELECT DISTINCT [ProductID],
d.[OrderID],
[CustomerID],
[OrderDate],
[ShippedDate],
[Quantity],
[ShipVia] as ShipperID
INTO [dbo].[stgNorthwindOrderFulfillment]
FROM [Northwind].[dbo].[Order Details] d
join [Northwind].[dbo].[Orders] o
on o.[OrderID] = d.[OrderID] 


--SELECT * FROM dbo.stgNorthwindOrderFulfillment where ProductID = 1
--delete from dbo.stgNorthwindOrderFulfillment
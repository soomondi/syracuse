use ist722_soomondi_dw;

/*
In order to create a Fulfillment schema, we need three dimension tables, and 1 Fact table:
1) DimCustomers
2) DimOrders
3) FactOrderFulfillment
So that we can answer a question: is there a difference btwn when an order is placed and when it is shipped? Is this acceptable.
=====Create DimCustomer Table ===
THIS DIMENSION ALREADY EXISTS, WILL RE-USE.
SELECT * FROM Northwind.DimCustomer;
*/


/* Drop table northwind.FactOrderFulfillment */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.FactOrderFulfillment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.FactOrderFulfillment 
;

/* Drop table northwind.DimOrders */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimOrders') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimOrders 
;


/* Drop table northwind.DimShipper */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimShipper') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimShipper 
;
GO




/* Create table northwind.DimOrders */
CREATE TABLE northwind.DimOrders (
   [DimOrderID] int IDENTITY  NOT NULL,
   [OrderKey] int NOT NULL						--Business key from the source order table (OrderID)
,  [CustomerName]  nvarchar(40)   NOT NULL
,  [OrderDate]  datetime   NOT NULL
,  [RequireDate]  datetime   NOT NULL
,  [ShippedDate]  datetime   NOT NULL
,  [Shipvia] int NOT NULL
, CONSTRAINT pk_DimOrders PRIMARY KEY ( [DimOrderID] )
);
GO





/* Create table northwind.DimShipper */
CREATE TABLE northwind.DimShipper (
   [ShipperKey]  int IDENTITY  NOT NULL
,  [ShipperID]  nvarchar(5)   NOT NULL
,  [CompanyName]  nvarchar(40)   NOT NULL
,  [Phone]  nvarchar(30)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_northwind.DimShipper] PRIMARY KEY CLUSTERED 
( [ShipperKey] )
) ON [PRIMARY]
;
SET IDENTITY_INSERT northwind.DimShipper ON
;
INSERT INTO northwind.DimShipper (ShipperKey, ShipperID, CompanyName,Phone, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown', 'None', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT northwind.DimShipper OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[northwind].[Shipper]'))
DROP VIEW [northwind].[Shipper]
GO
CREATE VIEW [northwind].[Shipper] AS 
SELECT [ShipperKey] AS [ShipperKey]
, [ShipperID] AS [ShipperID]
, [CompanyName] AS [CompanyName]
 , [Phone] as [Phone]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM northwind.DimShipper
GO



/* Create table northwind.DimShippers 
CREATE TABLE northwind.DimShippers (
   [DimShipperID] int IDENTITY  NOT NULL
,  [ShipperKey] int NOT NULL						--Business key from the source shippers table [ShipperID]
,  [ShipperName]  nvarchar(40)   NOT NULL
, CONSTRAINT pk_DimShipper PRIMARY KEY ( [DimShipperID] )
);
GO
*/


/* Create table northwind.FactOrderFulfillment 
CREATE TABLE northwind.FactOrderFulfillment (
   OrderKey int not null, ----from DimOrders.OrderKey
   OrderDateKey int not null,
   ShippedDateKey int not null,
   ShipperKey int not null, ---from DimShippers.ShipperKey
   DaysElapsed int not null,
CONSTRAINT pkFactOrderFulfillment PRIMARY KEY (ShipperKey, OrderKey),
CONSTRAINT fkFactOrderFulfillmentShipperKey FOREIGN KEY (ShipperKey)
	REFERENCES northwind.DimShippers([DimShipperID]),
CONSTRAINT fkFactOrderFulfillmentOrderKey FOREIGN KEY (OrderKey)
	REFERENCES northwind.DimOrders([DimOrderID])
);
GO

--select * from northwind.dbo.Customers
--select * from northwind.dbo.Orders
*/

/* Create table northwind.FactOrderFulfillment */
CREATE TABLE northwind.FactOrderFulfillment (
   [ProductKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [ShipperKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [ShippedDateKey]  int   NOT NULL
,  [OrderID]  int   NOT NULL
,  [Quantity]  smallint   NOT NULL
,  [DaysElapsed] int NOT NULL
, CONSTRAINT [PK_northwind.FactOrderFulfillment] PRIMARY KEY NONCLUSTERED 
( [ProductKey], [OrderID] )
) ON [PRIMARY]
;

 -- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[northwind].[OrderFulfillment]'))
DROP VIEW [northwind].[OrderFulfillment]
GO
CREATE VIEW [northwind].[OrderFulfillment] AS 
SELECT [ProductKey] AS [ProductKey]
, [CustomerKey] AS [CustomerKey]
, [ShipperKey] AS [ShipperKey]
, [OrderDateKey] AS [OrderDateKey]
, [ShippedDateKey] AS [ShippedDateKey]
, [OrderID] AS [OrderID]
, [Quantity] AS [Quantity]
FROM northwind.FactOrderFulfillment
GO

ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES northwind.DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES northwind.DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_ShipperKey FOREIGN KEY
   (
   ShipperKey
   ) REFERENCES northwind.DimShipper
   ( ShipperKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES northwind.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactOrderFulfillment ADD CONSTRAINT
   FK_northwind_FactOrderFulfillment_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES northwind.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
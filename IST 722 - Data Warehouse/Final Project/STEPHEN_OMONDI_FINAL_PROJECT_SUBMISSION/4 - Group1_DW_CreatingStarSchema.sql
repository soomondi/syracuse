DROP TABLE m2_FactSales;
DROP TABLE m2_DimCustomer;
DROP TABLE m2_DimProduct;
DROP TABLE m2_DimDate;

/****** Object:  Database ist722_hhkhan_ob1_dw    Script Date: 3/21/2020 11:57:42 PM ******/	
/*	
Kimball Group, The Microsoft Data Warehouse Toolkit	
Generate a database from the datamodel worksheet, version: 4	
	
You can use this Excel workbook as a data modeling tool during the logical design phase of your project.	
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.	
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.	
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your	
data modeling tool by generating a database using this script, then reverse-engineering that database into	
your tool.	
	
Uncomment the next lines if you want to drop and create the database	
*/	
/*	
DROP DATABASE ist722_hhkhan_ob1_dw	
GO	
CREATE DATABASE ist722_hhkhan_ob1_dw	
GO	
ALTER DATABASE ist722_hhkhan_ob1_dw	
SET RECOVERY SIMPLE	
GO	
*/	
USE ist722_hhkhan_ob1_dw	
;	
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')	
    EXEC sys.sp_dropextendedproperty @name = 'Description'	
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'	
;	
	
	
	
	
	
/* Drop table dbo.m2_DimDate */	
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.m2_DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)	
DROP TABLE dbo.m2_DimDate 	
;	
	
/* Create table dbo.m2_DimDate */	
CREATE TABLE dbo.m2_DimDate (	
   [DateKey]  int   NOT NULL	
,  [Date]  date   NULL	
,  [FullDateUSA]  nchar(11)   NOT NULL	
,  [DayOfWeek]  tinyint   NOT NULL	
,  [DayName]  nchar(10)   NOT NULL	
,  [DayOfMonth]  tinyint   NOT NULL	
,  [DayOfYear]  smallint   NOT NULL	
,  [WeekOfYear]  tinyint   NOT NULL	
,  [MonthName]  nchar(10)   NOT NULL	
,  [MonthOfYear]  tinyint   NOT NULL	
,  [Quarter]  tinyint   NOT NULL	
,  [QuarterName]  nchar(10)   NOT NULL	
,  [Year]  smallint   NOT NULL	
,  [IsWeekday]  bit  DEFAULT 0 NOT NULL	
, CONSTRAINT [PK_dbo.m2_DimDate] PRIMARY KEY CLUSTERED 	
( [DateKey] )	
) ON [PRIMARY]	
;	
	
--Table extended properties...	
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimDate	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimDate	
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimDate	
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Date dimension contains one row for every day, may also be rows for "hasn''t happened yet."', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimDate	
;	
	
INSERT INTO dbo.m2_DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)	
VALUES (-1, '', 'Unk date', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, 0)	
;	
	
--Column extended properties	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FullDateUSA', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WeekOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'QuarterName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsWeekday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full date as a SQL date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'String expression of the full date, eg MM/DD/YYYY', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day of week; Sunday = 1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Day name of week, eg Monday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the month', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the year', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Week of year, 1..53', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month name, eg January', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month of year, 1..12', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar quarter, 1..4', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quarter name eg. First', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar year, eg 2010', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is today a weekday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20041123', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'38314', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'23-Nov-2004', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..7', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Sunday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..31', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..365', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..52 or 53', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, …, 12', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3, 4', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2004', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 0', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 	
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'In the form: yyyymmdd', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 	
;	
	
	
	
	
	
/* Drop table dbo.m2_DimProduct */	
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.m2_DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)	
DROP TABLE dbo.m2_DimProduct 	
;	
	
/* Create table dbo.m2_DimProduct */	
CREATE TABLE dbo.m2_DimProduct (	
   [ProductKey]  int IDENTITY  NOT NULL	
,  [ProductID]  int  DEFAULT -1 NOT NULL	
,  [ProductName]  nvarchar(50)  DEFAULT 'unknown' NOT NULL	
,  [ProductDepartment]  nvarchar(50)  DEFAULT 'unknown' NOT NULL	
,  [ProductActive]  nchar(1)  DEFAULT '?' NOT NULL	
,  [SourceCode]  nchar(2)  DEFAULT 'XX' NOT NULL	
, CONSTRAINT [PK_dbo.m2_DimProduct] PRIMARY KEY CLUSTERED 	
( [ProductKey] )	
) ON [PRIMARY]	
;	
	
--Table extended properties...	
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimProduct	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Blank', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimProduct	
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimProduct	
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimProduct	
;	
	
SET IDENTITY_INSERT dbo.m2_DimProduct ON	
;	
INSERT INTO dbo.m2_DimProduct (ProductKey, ProductID, ProductName, ProductDepartment, ProductActive, SourceCode)	
VALUES (-1, -1, 'Unknown', 'Unknown', 'Y', 'XX')	
;	
SET IDENTITY_INSERT dbo.m2_DimProduct OFF	
;	
	
--Column extended properties	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Plan ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Plan Name', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Product Department', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Plan is current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductActive'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Pulled from key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of Product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Category for product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'is product active', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductActive'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ff for fudgeflix, and fm for fudgemart', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductActive'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'FM, FF', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductActive'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductActive'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductActive'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_plans, fm_products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_plans, fm_products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products, ff_plans', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductActive'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_name', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_department', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_is_active, plan_current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimProduct', @level2type=N'COLUMN', @level2name=N'ProductActive'; 	
;	
	
	
	
	
	
/* Drop table dbo.m2_DimCustomer */	
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.m2_DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)	
DROP TABLE dbo.m2_DimCustomer 	
;	
	
/* Create table dbo.m2_DimCustomer */	
CREATE TABLE dbo.m2_DimCustomer (	
   [CustomerKey]  int IDENTITY  NOT NULL	
,  [CustomerID]  int   NOT NULL	
,  [CustomerName]  nvarchar(50)   NOT NULL	
,  [CustomerEmail]  varchar(100)   NULL	
,  [CustomerAddress]  nvarchar(1000)   NOT NULL	
,  [CustomerZip]  varchar(20)  DEFAULT '12/31/9999' NOT NULL	
,  [SourceCode]  nchar(2)  DEFAULT 'XX' NOT NULL	
, CONSTRAINT [PK_dbo.m2_DimCustomer] PRIMARY KEY CLUSTERED 	
( [CustomerKey] )	
) ON [PRIMARY]	
;	
	
--Table extended properties...	
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimCustomer	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Blank', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimCustomer	
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimCustomer	
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_DimCustomer	
;	
	
SET IDENTITY_INSERT dbo.m2_DimCustomer ON	
;	
INSERT INTO dbo.m2_DimCustomer (CustomerKey, CustomerID, CustomerName, CustomerEmail, CustomerAddress, CustomerZip, SourceCode)	
VALUES (-1, -1, 'UnknownName', 'UnknownEmail', 'UnknownAddress', '99999', 'XX')	
;	
SET IDENTITY_INSERT dbo.m2_DimCustomer OFF	
;	
	
--Column extended properties	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customer Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Account ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customer Name', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customer Email', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customer Address', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Account Zip', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Pulled from key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'CustomerName, ', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Email', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Address', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Zip Code', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ff for fudgeflix, and fm for fudgemart', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Matt Arsenault', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'marsenau@syr.edu', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2420', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'FM, FF', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers, ff_accounts', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers, ff_accounts', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers, ff_accounts', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers, ff_accounts', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers, ff_accounts', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_lastname + customer_firstname', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_email', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer address', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerAddress'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_zip', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 	
;	
	
	
	
	
	
/* Drop table dbo.m2_FactSales */	
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.m2_FactSales') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)	
DROP TABLE dbo.m2_FactSales 	
;	
	
/* Create table dbo.m2_FactSales */	
CREATE TABLE dbo.m2_FactSales (	
   [ProductKey]  int  DEFAULT -1 NOT NULL	
,  [OrderDateKey]  int  DEFAULT -1 NOT NULL	
,  [CustomerKey]  int  DEFAULT -1 NOT NULL	
,  [OrderID]  int  DEFAULT -1 NOT NULL	
,  [SalesAmount]  money  DEFAULT -1 NOT NULL	
,  [SalesQuantity]  int   NOT NULL	
,  [ExtendedPriceAmount]  money   NOT NULL	
,  [ProductPrice]  money  DEFAULT 9999.99 NOT NULL	
,  [SourceCode]  nchar(2)  DEFAULT 'XX' NOT NULL	
, CONSTRAINT [PK_dbo.m2_FactSales] PRIMARY KEY NONCLUSTERED 	
( [ProductKey], [OrderID] )	
) ON [PRIMARY]	
;	
	
--Table extended properties...	
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_FactSales	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Blank Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_FactSales	
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_FactSales	
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=m2_FactSales	
;	
	
--Column extended properties	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Product Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customer Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderID'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Sales Amount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesAmount'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Sales Quantity', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesQuantity'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Extended Price Amount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ExtendedPriceAmount'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Plan Price', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 	
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Pulled from key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Dim1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key for orders', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key for Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'the order identify', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderID'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Amount Sold', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesAmount'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quanitty sold', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesQuantity'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Sales Quantity * Unit Price of a product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ExtendedPriceAmount'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Price of product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 	
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ff for fudgeflix, and fm for fudgemart', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'FM, FF', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 	
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderID'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amounts', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesAmount'; 	
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Amounts', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesQuantity'; 	
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from Sales.CurrencyRate.FromCurrencyCode', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from Sales.CurrencyRate.CurrencyRateDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductKey'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderID'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesAmount'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesQuantity'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ExtendedPriceAmount'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 	
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SourceCode'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderID'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesAmount'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesQuantity'; 	
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_orders', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_order_details', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderID'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesAmount'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_order_details', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesQuantity'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ExtendedPriceAmount'; 	
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_plans, fm_products', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'order_date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'order_id', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'OrderID'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_retail_price', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesAmount'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'order_quantity', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'SalesQuantity'; 	
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_retail_price', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'm2_FactSales', @level2type=N'COLUMN', @level2name=N'ProductPrice'; 	
;	
ALTER TABLE dbo.m2_FactSales ADD CONSTRAINT	
   FK_dbo_m2_FactSales_ProductKey FOREIGN KEY	
   (	
   ProductKey	
   ) REFERENCES m2_DimProduct	
   ( ProductKey )	
     ON UPDATE  NO ACTION	
     ON DELETE  NO ACTION	
;	
 	
ALTER TABLE dbo.m2_FactSales ADD CONSTRAINT	
   FK_dbo_m2_FactSales_OrderDateKey FOREIGN KEY	
   (	
   OrderDateKey	
   ) REFERENCES m2_DimDate	
   ( DateKey )	
     ON UPDATE  NO ACTION	
     ON DELETE  NO ACTION	
;	
 	
ALTER TABLE dbo.m2_FactSales ADD CONSTRAINT	
   FK_dbo_m2_FactSales_CustomerKey FOREIGN KEY	
   (	
   CustomerKey	
   ) REFERENCES m2_DimCustomer	
   ( CustomerKey )	
     ON UPDATE  NO ACTION	
     ON DELETE  NO ACTION	
;	
 	
	
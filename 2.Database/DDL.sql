use CarSales
go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[car_manufacturer]') AND type in (N'U'))
DROP TABLE [dbo].car_manufacturer
GO

-- car manufacturer
CREATE TABLE CarSales.dbo.car_manufacturer (
	manufacturerID Numeric(28,0) NOT NULL,
	manufacturer varchar(250) NOT NULL,
	CONSTRAINT car_manufacturer_pk PRIMARY KEY (manufacturerID)
)

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[car_model]') AND type in (N'U'))
DROP TABLE [dbo].car_model
GO
-- car model
CREATE TABLE CarSales.dbo.car_model (
	manufacturerID Numeric(28,0) NOT NULL,
	modelID Numeric(28,0) NOT NULL,
	model_name varchar(250) NOT NULL,
	weight numeric(18,2) NOT NULL,
	price numeric(28,2) NOT NULL,
	CONSTRAINT car_model_pk PRIMARY KEY (manufacturerID, modelID)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[customer]') AND type in (N'U'))
DROP TABLE [dbo].customer
GO
-- customer
CREATE TABLE CarSales.dbo.customer (
	customerID Numeric(28,0) NOT NULL,
	customer_name varchar(500) NOT NULL,
	phone varchar(50) NOT NULL,
	CONSTRAINT customer_pk PRIMARY KEY (customerID)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[salesperson]') AND type in (N'U'))
DROP TABLE [dbo].salesperson
GO
-- salesperson
CREATE TABLE CarSales.dbo.salesperson (
	salespersonID Numeric(28,0) NOT NULL,
	salesperson_name varchar(250) NOT NULL,
	salesperson_phone varchar(50) NOT NULL,
	CONSTRAINT salesperson_pk PRIMARY KEY (salespersonID)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[car]') AND type in (N'U'))
DROP TABLE [dbo].car
GO
-- Car 
CREATE TABLE CarSales.dbo.car (
	serial_number varchar(50) NOT NULL,
	manufacturerID Numeric(28,0) NOT NULL,
	modelID Numeric(28,0) NOT NULL,
	CONSTRAINT car_pk PRIMARY KEY (serial_number),
	CONSTRAINT car_fk_1 FOREIGN KEY (manufacturerID,modelID) REFERENCES CarSales.dbo.car_model(manufacturerID,modelID) ON UPDATE CASCADE
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sale_transaction]') AND type in (N'U'))
DROP TABLE [dbo].sale_transaction
GO
-- sale_transaction
CREATE TABLE CarSales.dbo.sale_transaction (
	salesID Numeric(28,0) NOT NULL,
	customerID Numeric(28,0) NOT NULL,
	manufacturerID Numeric(28,0) NOT NULL,
	modelID Numeric(28,0) NOT NULL,
	salespersonID Numeric(28,0) NOT NULL,
	car_serial_number varchar(50) NOT NULL,
	sales_price numeric(28,2) NOT NULL,
	SaleDateTime DateTime NOT NULL,
	CONSTRAINT sale_transaction_pk PRIMARY KEY (salesID),
    CONSTRAINT sale_transaction_un UNIQUE (car_serial_number),
	CONSTRAINT sale_transaction_fk FOREIGN KEY (car_serial_number) REFERENCES CarSales.dbo.car(serial_number) ON UPDATE CASCADE,
	CONSTRAINT sale_transaction_fk_1 FOREIGN KEY (customerID) REFERENCES CarSales.dbo.customer(customerID) ON UPDATE CASCADE,
	CONSTRAINT sale_transaction_fk_2 FOREIGN KEY (salespersonID) REFERENCES CarSales.dbo.salesperson(salespersonID) ON UPDATE CASCADE
);
----ALTER TABLE CarSales.dbo.sale_transaction ALTER COLUMN "timestamp" SET DEFAULT now();

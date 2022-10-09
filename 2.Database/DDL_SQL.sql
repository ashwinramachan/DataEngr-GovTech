CREATE TABLE car_model (
	manufacturer varchar(128) NOT NULL,
	model_name varchar(128) NOT NULL,
	weight numeric(7,2) NOT NULL,
	price numeric(12,2) NOT NULL,
	CONSTRAINT car_model_pk PRIMARY KEY (manufacturer, model_name)
);

CREATE TABLE  car (
	serial_number varchar(32) NOT NULL,
	manufacturer varchar(128) NOT NULL,
	model_name varchar(128) NOT NULL,
	CONSTRAINT car_pk PRIMARY KEY (serial_number),
	CONSTRAINT car_fk_1 FOREIGN KEY (manufacturer,model_name) REFERENCES  car_model(manufacturer,model_name) ON UPDATE CASCADE
);

 CREATE TABLE customer (
	customer_id int not null,
	customer_name varchar(500) NOT NULL,
	phone varchar(64) NOT NULL,
	CONSTRAINT customer_pk PRIMARY KEY (customer_id)
);

CREATE TABLE salesperson (
	id varchar(16) NOT NULL,
	salesperson_name varchar(1024) NOT NULL,
	CONSTRAINT salesperson_pk PRIMARY KEY (id)
);

CREATE TABLE sale_transaction (
	id int NOT NULL,
	customer_id int not null,
	salesperson_id varchar(16) NOT NULL,
	car_serial_number varchar(32) NOT NULL,
	"timestamp" timestamp NOT NULL,
	CONSTRAINT sale_transaction_pk PRIMARY KEY (id),
  CONSTRAINT sale_transaction_un UNIQUE (car_serial_number),
	CONSTRAINT sale_transaction_fk_car FOREIGN KEY (car_serial_number) REFERENCES car(serial_number) ON UPDATE CASCADE,
	CONSTRAINT sale_transaction_fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE,
	CONSTRAINT sale_transaction_fk_salesperson FOREIGN KEY (salesperson_id) REFERENCES  salesperson(id) ON UPDATE CASCADE
);

 
-- 2
-- use the proposed set of dimension tables and their respective columns and the table factsales.
drop table if exists dimdate;
create table dimdate (
    dateid serial primary key,
    date date,
    day int,
    month int,
    year int,
    quarter int,
    weekofyear int
);

drop table if exists dimcustomer;
create table dimcustomer (
    customerid serial primary key,
    companyname varchar(255),
    contactname varchar(255),
    contacttitle varchar(255),
    address varchar(255),
    city varchar(255),
    region varchar(255),
    postalcode varchar(10),
    country varchar(255),
    phone varchar(20)
);

drop table if exists dimproduct;
create table dimproduct (
    productid serial primary key,
    productname varchar(255),
    supplierid int,
    categoryid int,
    quantityperunit varchar(255),
    unitprice decimal(10, 2),
    unitsinstock int
);

drop table if exists dimemployee;
create table dimemployee (
    employeeid serial primary key,
    lastname varchar(255),
    firstname varchar(255),
    title varchar(255),
    birthdate date,
    hiredate date,
    address varchar(255),
    city varchar(255),
    region varchar(255),
    postalcode varchar(10),
    country varchar(255),
    homephone varchar(20),
    extension varchar(10)
);

drop table if exists dimcategory;
create table dimcategory (
    categoryid serial primary key,
    categoryname varchar(255),
    description text
);

drop table if exists dimshipper;
create table dimshipper (
    shipperid serial primary key,
    companyname varchar(255),
    phone varchar(20)
);

drop table if exists dimsupplier;
create table dimsupplier (
    supplierid serial primary key,
    companyname varchar(255),
    contactname varchar(255),
    contacttitle varchar(255),
    address varchar(255),
    city varchar(255),
    region varchar(255),
    postalcode varchar(10),
    country varchar(255),
    phone varchar(20)
);

drop table if exists factsales;
create table factsales (
    salesid serial primary key,
    dateid int,
    customerid int,
    productid int,
    employeeid int,
    categoryid int,
    shipperid int,
    supplierid int,
    quantitysold int,
    unitprice decimal(10, 2),
    discount decimal(10, 2),
    totalamount decimal(10, 2),
    taxamount decimal(10, 2),
    foreign key (dateid) references dimdate(dateid),
    foreign key (customerid) references dimcustomer(customerid),
    foreign key (productid) references dimproduct(productid),
    foreign key (employeeid) references dimemployee(employeeid),
    foreign key (categoryid) references dimcategory(categoryid),
    foreign key (shipperid) references dimshipper(shipperid),
    foreign key (supplierid) references dimsupplier(supplierid)
);

INSERT INTO staging_orders 
SELECT * FROM SalesOrder;

INSERT INTO staging_order_details 
SELECT * FROM OrderDetail;

INSERT INTO staging_products 
SELECT * FROM Product;

INSERT INTO staging_customers 
SELECT * FROM Customer;

INSERT INTO staging_employees 
SELECT * FROM Employee;

INSERT INTO staging_categories 
SELECT * FROM Category;

INSERT INTO staging_shippers 
SELECT * FROM Shipper;

INSERT INTO staging_suppliers 
SELECT * FROM Supplier;
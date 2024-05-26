-- 1
-- create the following staging tables:
drop table if exists staging_order_details cascade;
create table staging_order_details (
    orderid     int not null,
    productid   int not null,
    unitprice   decimal(10, 2) not null,
    qty         smallint not null,
    discount    decimal(10, 2) not null
);

drop table if exists staging_customers cascade;
create table staging_customers (
    custid       serial primary key not null,
    companyname  varchar(40) not null,
    contactname  varchar(30) null,
    contacttitle varchar(30) null,
    address      varchar(60) null,
    city         varchar(15) null,
    region       varchar(15) null,
    postalcode   varchar(10) null,
    country      varchar(15) null,
    phone        varchar(24) null,
    fax          varchar(24) null
);

drop table if exists staging_employees cascade;
create table staging_employees (
     empid      serial  primary key not null, 
     lastname        varchar (20) not null, 
     firstname       varchar (10) not null, 
     title           varchar (30) null, 
     titleofcourtesy varchar (25) null, 
     birthdate       timestamp null, 
     hiredate        timestamp null, 
     address         varchar (60) null, 
     city            varchar (15) null, 
     region          varchar (15) null, 
     postalcode      varchar (10) null, 
     country         varchar (15) null, 
     phone       varchar (24) null, 
     extension       varchar (4) null, 
     photo           bytea null, 
     notes           text null, 
     mgrid       int null, 
     photopath       varchar (255) null
);

drop table if exists staging_products cascade;
create table staging_products (
    productid       serial primary key not null,
    productname     varchar(40) not null,
    supplierid      int null,
    categoryid      int null,
    quantityperunit varchar(20) null,
    unitprice       decimal(10, 2) null,
    unitsinstock    smallint null,
    unitsonorder    smallint null,
    reorderlevel    smallint null,
    discontinued    char(1) not null
);

drop table if exists staging_categories;
create table staging_categories (
    categoryid   serial primary key not null,
    categoryname varchar(15) not null,
    description  text null,
    picture      bytea null
);

drop table if exists staging_shippers;
create table staging_shippers (
    shipperid   serial primary key not null,
    companyname varchar(40) not null,
    phone       varchar(44) null
);

drop table if exists staging_suppliers;
create table staging_suppliers (
    supplierid   serial primary key not null,
    companyname  varchar(40) not null,
    contactname  varchar(30) null,
    contacttitle varchar(30) null,
    address      varchar(60) null,
    city         varchar(15) null,
    region       varchar(15) null,
    postalcode   varchar(10) null,
    country      varchar(15) null,
    phone        varchar(24) null,
    fax          varchar(24) null,
    homepage     text null
);

drop table if exists staging_orders;
create table staging_orders (
    orderid        serial primary key not null,
    custid         varchar(15) null,
    empid          int null,
    orderdate      timestamp null,
    requireddate   timestamp null,
    shippeddate    timestamp null,
    shipperid      int null,
    freight        decimal(10, 2) null,
    shipname       varchar(40) null,
    shipaddress    varchar(60) null,
    shipcity       varchar(15) null,
    shipregion     varchar(15) null,
    shippostalcode varchar(10) null,
    shipcountry    varchar(15) null
);


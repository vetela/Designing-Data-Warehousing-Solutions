-- 3 && 4
-- transform the data from the staging tables and load it into the respective dimension tables
insert into dimproduct (productid, productname, supplierid, categoryid, quantityperunit, unitprice, unitsinstock)
select productid, productname, supplierid, categoryid, quantityperunit, unitprice, unitsinstock
from staging_products;

insert into dimcustomer (customerid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone) 
select custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone 
from staging_customers;

insert into dimcategory (categoryid, categoryname, description)
select categoryid, categoryname, description
from staging_categories;

insert into dimemployee (employeeid, lastname, firstname, title, birthdate, hiredate, address, city, region, postalcode, country, homephone, extension)
select empid, lastname, firstname, title, birthdate, hiredate, address, city, region, postalcode, country, phone, extension
from staging_employees;

insert into dimshipper (shipperid, companyname, phone)
select shipperid, companyname, phone
from staging_shippers;

insert into dimsupplier (supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone)
select supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone
from staging_suppliers;

insert into dimdate (date, day, month, year, quarter, weekofyear)
select
    distinct date(orderdate) as date,
    extract(day from date(orderdate)) as day,
    extract(month from date(orderdate)) as month,
    extract(year from date(orderdate)) as year,
    extract(quarter from date(orderdate)) as quarter,
    extract(week from date(orderdate)) as weekofyear
from
    staging_orders;
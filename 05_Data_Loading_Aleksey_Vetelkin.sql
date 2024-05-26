-- 5
-- load data into the fact table
insert into factsales (dateid, customerid, productid, employeeid, categoryid, shipperid, supplierid, quantitysold, unitprice, discount, totalamount, taxamount) 
select
    d.dateid,   
    c.custid,  
    p.productid,  
    e.empid,  
    cat.categoryid,  
    s.shipperid,  
    sup.supplierid, 
    od.qty, 
    od.unitprice, 
    od.discount,    
    (od.qty * od.unitprice - od.discount) as totalamount,
    (od.qty * od.unitprice - od.discount) * 0.1 as taxamount     
from staging_order_details od 
join staging_orders o on od.orderid = o.orderid 
join staging_customers c on o.custid = c.custid::varchar 
join staging_products p on od.productid = p.productid  
left join staging_employees e on o.empid = e.empid  
left join staging_categories cat on p.categoryid = cat.categoryid 
left join staging_shippers s on o.shipperid = s.shipperid  
left join staging_suppliers sup on p.supplierid = sup.supplierid
left join dimdate d on o.orderdate = d.date;

select * from factsales
-- 6
-- after loading data into the fact and dimension tables, you should validate the data to ensure it is accurate and complete. 
-- this process typically involves

-- (1)
-- Display average sales
select 'dimdate' as table_name, count(*) as record_count from dimdate
union all
select 'dimcustomer', count(*) from dimcustomer
union all
select 'dimproduct', count(*) from dimproduct
union all
select 'dimemployee', count(*) from dimemployee
union all
select 'dimcategory', count(*) from dimcategory
union all
select 'dimshipper', count(*) from dimshipper
union all
select 'dimsupplier', count(*) from dimsupplier
union all
select 'factsales', count(*) from factsales
union all
select 'staging_customers', count(*) from staging_customers
union all
select 'staging_products', count(*) from staging_products
union all
select 'staging_categories', count(*) from staging_categories
union all
select 'staging_employees', count(*) from staging_employees
union all
select 'staging_shippers', count(*) from staging_shippers
union all
select 'staging_suppliers', count(*) from staging_suppliers
union all
select 'staging_order_details', count(*) from staging_order_details
union all
select 'staging_orders_unique_orderdates', count(distinct orderdate) from staging_orders;

select count(*) as broken_record_count 
from factsales 
where dateid not in (select dateid from dimdate)
   or customerid not in (select customerid from dimcustomer)
   or productid not in (select productid from dimproduct)
   or employeeid not in (select employeeid from dimemployee)
   or categoryid not in (select categoryid from dimcategory)
   or shipperid not in (select shipperid from dimshipper)
   or supplierid not in (select supplierid from dimsupplier);
   
-- (2) 
-- display the top (worst) five products by number of transactions, total sales, and tax (add category section). 
-- this involves querying the factsales table   
select
    p.productname,
    c.categoryname,
    count(*) as numberoftransactions,
    sum(fs.quantitysold * fs.unitprice) as totalsales,
    sum(fs.taxamount) as totaltax
from factsales fs
join dimproduct p on fs.productid = p.productid
join dimcategory c on p.categoryid = c.categoryid
group by
    p.productname,
    c.categoryname
order by
    numberoftransactions desc,
    totalsales desc,
    totaltax desc
limit 5;

-- (3) 
-- display the top (worst) five customers by number of transactions and purchase amount (add gender section, region, country, product categories, age group).
-- this involves querying the factsales table.
select
    c.customerid,
    c.contactname,
    c.region,
    c.country,
    count(fs.salesid) as numberoftransactions,
    sum(fs.totalamount) as purchaseamount,
    string_agg(distinct cat.categoryname, ', ') as productcategories
from factsales fs
join dimcustomer c on fs.customerid = c.customerid
join dimproduct p on fs.productid = p.productid
join dimcategory cat on p.categoryid = cat.categoryid
group by
    c.customerid,
    c.contactname,
    c.region,
    c.country
order by
    numberoftransactions asc,
    purchaseamount asc
limit 5;

-- (4) display a sales chart (with the total amount of sales and the quantity of items sold) for the first week of each month.
-- this involves querying the factsales and dimdate tables.
select 
    month,
    sum(totalamount) as totalsalesamount,
    sum(quantitysold) as totalquantitysold
from  factsales
join dimdate on factsales.dateid = dimdate.dateid
where day between 1 and 7
group by month
order by month;

-- (5) display a weekly sales report (with monthly totals) by product category (period: one year). 
-- this involves querying the factsales, dimdate, and dimproduct tables.
select 
    dp.categoryid,
    dc.categoryname,
    extract(week from dd.date) as week,
    extract(month from dd.date) as month,
    sum(fs.quantitysold) as weeklyquantitysold,
    sum(fs.totalamount) as weeklytotalamount,
    sum(sum(fs.totalamount)) over (partition by extract(month from dd.date)) as monthlytotalamount
from factsales fs
join dimdate dd on fs.dateid = dd.dateid
join dimproduct dp on fs.productid = dp.productid
join  dimcategory dc on dp.categoryid = dc.categoryid
group by 
    dp.categoryid, 
    dc.categoryname, 
    extract(week from dd.date), 
    extract(month from dd.date)
order by 
    extract(month from dd.date), 
    extract(week from dd.date), 
    dp.categoryid;
    
-- (6) display the median monthly sales value by product category and country. 
-- this involves querying the factsales, dimproduct, and dimcustomer tables 
-- and requires a more complex query or a custom function to calculate the median.
select
    extract(month from d.date) as month,
    p.categoryid as productcategory,
    c.country,
    floor(avg(fs.totalamount)) as monthlysales
from factsales fs
join dimproduct p on fs.productid = p.productid
join dimcustomer c on fs.customerid = c.customerid
join dimdate d on fs.dateid = d.dateid
group by
    extract(month from d.date),
    p.categoryid,
    c.country
order by month asc;

-- (7) display sales rankings by product category (with the best-selling categories at the top). 
-- this involves querying the factsales and dimproduct tables.
select 
    dp.categoryid,
    dc.categoryname,
    sum(fs.quantitysold) as totalquantitysold
from factsales fs
join dimproduct dp on fs.productid = dp.productid
join dimcategory dc on dp.categoryid = dc.categoryid
group by 
    dp.categoryid, 
    dc.categoryname
order by totalquantitysold desc;
-- Create database -> import data
CREATE DATABASE WalmartSales 

-------------------------------
select * from WalmartSalesdata

-------------------------------------------------------------------
----------------- Feature Engineering ----------------------------- 
-------------------------------------------------------------------

-- Time_of_date
select time,
( case 
    when time between '00:00:00' and '12:00:00' then 'Morning'
    when time between '12:01:00' and '16:00:00' then 'Afternoon'
    else 'Evening'
    end
) As time_of_date
from walmartsalesdata

ALTER table walmartsalesdata add time_of_date VARCHAR (30)

UPDATE walmartsalesdata
set time_of_date = ( case 
    when time between '00:00:00' and '12:00:00' then 'Morning'
    when time between '12:01:00' and '16:00:00' then 'Afternoon'
    else 'Evening'
    end
) 


-- day name
select date,
datename(DW, date) as day_name
from WalmartSalesdata

alter table walmartsalesdata add day_name VARCHAR(30)

update WalmartSalesdata 
set day_name = datename(DW, date)

-- month name
select date, 
DATENAME(MONTH, date) as month_name
from WalmartSalesdata

alter table walmartsalesdata add month_name VARCHAR(30)

update WalmartSalesdata 
set month_name = DATENAME(month, date)
-------------------------------------------------------------------


--------------------------------------------------
--------------- Generic --------------------------
--------------------------------------------------

------ How many unique cities does data have?
select distinct(city)
from WalmartSalesdata


------ In which city is each branch?
select distinct(branch)
from WalmartSalesdata

select distinct
city, branch
from WalmartSalesdata
order by branch

-------------------------------------------------------------
---------------------- Product ------------------------------
-------------------------------------------------------------

-- How many unique product lines does data have?

select distinct product_line
from WalmartSalesdata

-- What is the most common payment method?
select payment, count(payment) as count 
from WalmartSalesdata
group by payment
order by count(payment) desc

-- What is the most selling product line?
select product_line, count(product_line) as count 
from WalmartSalesdata
group by product_line
order by count(product_line) desc

-- What is the total revenue by month?
select month_name,
sum(total) as revenue
from WalmartSalesdata
group by month_name
order by sum(total) desc

-- What month had the largest COGS?
select month_name,
sum(cogs) as COGS
from WalmartSalesdata
group by month_name
order by sum(cogs) desc

--What product line had the largest revenue?
select product_line,
SUM(total) as total_revenue 
from WalmartSalesdata
group by product_line
order by sum(total) desc

-- What is the city with the largest revenue?
select distinct city, branch,
SUM(total) as total_revenue
from WalmartSalesdata
group by city , branch
order by SUM(total) desc

-- What product line had the largest VAT?
select product_line,
AVG(tax_5) as avg_tax
from WalmartSalesdata
group by product_line
order by avg_tax desc

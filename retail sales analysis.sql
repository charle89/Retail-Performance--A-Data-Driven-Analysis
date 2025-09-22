--- creation of data base
create database retailsales;
use retailsales;

--- check if the data was succesfully imported
select*from retail_sales_dataset;

--- describe information abouts columns of the table
describe retail_sales_dataset;

--- total revenue 
create view total_revenue as
select sum(`total amount`) as total_revenue
from retail_sales_dataset;

--- total revenue by cartegory 
create view revenue_category as
select `product category`, sum(`total amount`) as revenue_category
from retail_sales_dataset
group by `product category`
order by `revenue_category`;

--- average order value  
create view average_order_value as
select avg(`total amount`) as average_order_value
from retail_sales_dataset;

---  Transactions per month
create view average_order_value as
SELECT DATE_FORMAT(date, '%Y-%m') AS month, COUNT(*) AS transactions, SUM(`total amount`) AS revenue
FROM retail_sales_dataset
GROUP BY month
ORDER BY month desc;
select*from retail_sales_dataset;

--- top 10 customer by revenue
create view `top customer` as
select `customer id`, sum(`total amount`) as `top customer`
from retail_sales_dataset
group by `customer id`
order by `top customer`
limit 10;

--- revenue by gender
create view `avg_order_value`as
select gender, COUNT(*) AS transactions, SUM(`total amount`) AS revenue, AVG(`total amount`) AS avg_order_value
from retail_sales_dataset
group by gender;

--- average selling price
create view `average selling price` as
select sum(`total amount`)/sum(`quantity`) as `avg selling price`
from retail_sales_dataset;
 
-- Revenue per Customer
create view revenue_per_customer as
SELECT `customer id`, SUM(`total amount`) AS revenue_per_customer
FROM retail_sales_dataset
GROUP BY `customer id`;
select*from retail_sales_dataset;

-- top 5 product by revenue 
create view `top 5 product by revenue` as
select `product category`, sum(`total amount`) as `top 5 product by revenue `
from retail_sales_dataset
group by `product category`
order by `top 5 product by revenue `desc;

-- Age Group Buckets
create view age_group as 
SELECT 
  CASE 
    WHEN age < 25 THEN '<25'
    WHEN age BETWEEN 25 AND 40 THEN '25-40'
    WHEN age BETWEEN 41 AND 60 THEN '41-60'
    ELSE '60+'
  END AS age_group,
  SUM(`total amount`) AS revenue,
  COUNT(*) AS transactions
FROM retail_sales_dataset
group by age_group;

-- Monthly Revenue Growth %
SELECT 
  DATE_FORMAT(date, '%Y-%m') AS month,
  SUM(`total amount`) AS revenue,
  (SUM(`total amount`) - LAG(SUM(`total amount`)) OVER (ORDER BY DATE_FORMAT(date, '%Y-%m'))) / 
   LAG(SUM(`total amount`)) OVER (ORDER BY DATE_FORMAT(date, '%Y-%m')) * 100 AS growth_percent
FROM retail_sales_dataset
GROUP BY month
ORDER BY month;


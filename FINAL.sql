USE Pizza_sales;

-- KPI
-- 1) TOTAL REVENUE

SELECT * FROM pizzas WHERE pizza_id = 'big_meat_s';

SELECT 
ROUND(SUM(quantity * price),2) AS 'TOTAL REVENUE'
FROM order_details AS o
JOIN pizzas AS p
ON o.pizza_id = p.pizza_id ;


-- 2) AVERAGE ORDER VALUE
-- total order value/ordercount

SELECT 
ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2 )AS 'Average Oder values'
FROM order_details AS o
JOIN pizzas AS p
ON o.pizza_id = p.pizza_id ;


-- 3) TOTAL PIZZA SOLD
-- sum of quantities in order_details

SELECT SUM(quantity) AS 'Total Pizza Sold'
FROM order_details;

-- 4) TOTAL ORDERS
-- Total order_id in order_details

SELECT COUNT(DISTINCT order_id) AS 'Total Orders'
FROM order_details;

-- 5) Average Pizza per Orders
-- pizza sold / number of pizzas

SELECT 
ROUND(SUM(quantity) / COUNT(DISTINCT order_id) ,0 )AS 'Average Pizza per Order'
FROM order_details;



-- QUESTION TO ANSWER

-- 1) DAILY TRENDS FOR TOTAL ORDERS

SELECT 
DAYNAME(date) AS DayofWeek,
COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY DAYNAME(date) 
ORDER BY total_orders DESC;


-- 2) HOURLY TREND FOR TOTAL ORDERS

SELECT 
HOUR(time) AS 'Hour',
COUNT(DISTINCT order_id)
FROM orders
GROUP BY HOUR(time)
ORDER BY HOUR;


-- Q3) Percentage of sales by pizza pizza category
-- a: calculate total revenur per category
-- % sale calculated as (a:/total revenue)*100

SELECT
category,
SUM(quantity * price) AS 'Revenue',
ROUND(SUM(quantity * price) * 100 / (
	SELECT SUM(quantity * price)
    FROM pizzas AS p2
    JOIN order_details AS od2
    ON od2.pizza_id = p2.pizza_id), 2) AS percentage_sales
FROM 
pizzas AS p
JOIN pizza_types as pt 
ON p.pizza_type_id = pt.pizza_type_id   
JOIN order_details AS od 
ON od.pizza_id = p.pizza_id
GROUP BY category
ORDER BY percentage_sales DESC;
 

-- Q4) Percentage of Sales by Pizza size


SELECT
size ,
SUM(quantity * price) AS Revenue,
ROUND(SUM(quantity * price) * 100 / (
	SELECT SUM(quantity * price)
    FROM pizzas AS p2
    JOIN order_details AS od2
    ON od2.pizza_id = p2.pizza_id), 2) AS percentage_sales
FROM 
pizzas AS p
JOIN pizza_types as pt 
ON p.pizza_type_id = pt.pizza_type_id   
JOIN order_details AS od 
ON od.pizza_id = p.pizza_id
GROUP BY size
ORDER BY percentage_sales DESC;



-- Q5) Total Pizza sold by Category


SELECT 
category,
SUM(quantity) AS quantity_sold
FROM 
pizzas AS p
JOIN pizza_types as pt 
ON p.pizza_type_id = pt.pizza_type_id   
JOIN order_details AS od 
ON od.pizza_id = p.pizza_id
GROUP BY category
ORDER BY quantity_sold DESC;

-- Q6) TOP 5 Best Seller By Total Pizza Sold

SELECT 
name , 
SUM(quantity) AS total_pizza_sold
FROM
pizzas AS p
JOIN pizza_types as pt 
ON p.pizza_type_id = pt.pizza_type_id   
JOIN order_details AS od 
ON od.pizza_id = p.pizza_id 
GROUP BY name
ORDER BY total_pizza_sold DESC LIMIT 5 ;


-- Q7) BOTTOM 5 WORST Seller By Total Pizza Sold


SELECT 
name , 
SUM(quantity) AS total_pizza_sold
FROM
pizzas AS p
JOIN pizza_types as pt 
ON p.pizza_type_id = pt.pizza_type_id   
JOIN order_details AS od 
ON od.pizza_id = p.pizza_id 
GROUP BY name
ORDER BY total_pizza_sold ASC LIMIT 5 ;







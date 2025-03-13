--SQL Queries WITH DESCRIPTOR
	
--best performing by category

SELECT
	p.category,
	sum(o.profit)
FROM
	product AS p
INNER JOIN order_item o ON
	p.product_id = o.product_id
GROUP BY
	p.category
ORDER BY
	sum(o.profit) ASC;
--best performing product regardless of colour variation
SELECT
	SPLIT_PART(p.product_name,
	',',
	1) AS product_name_no_colour,
	SUM(oi.profit)
FROM
	offuture.product AS p
INNER JOIN order_item AS oi
    ON
	p.product_id = oi.product_id
GROUP BY
	product_name_no_colour
ORDER BY
	SUM(oi.profit) ASC
LIMIT
    10
;


--worst performing regardless of colour variation

SELECT
	SPLIT_PART(p.product_name,
	',',
	1) AS product_name_no_colour,
	SUM(oi.profit)
FROM
	offuture.product AS p
INNER JOIN order_item AS oi
    ON
	p.product_id = oi.product_id
GROUP BY
	product_name_no_colour
ORDER BY
	SUM(oi.profit) ASC
LIMIT
    10
;


--best performing by units sold

SELECT
	SPLIT_PART(p.product_name,
	',',
	1) AS product_name_no_colour,
	count(oi.product_id)
FROM
	offuture.product AS p
INNER JOIN order_item AS oi
    ON
	p.product_id = oi.product_id
GROUP BY
	product_name_no_colour
ORDER BY
	count(oi.product_id) DESC
LIMIT
    10
;


-- Number of orders from each city, country

SELECT
	COUNT(o.order_id) AS order_count,
	a.city,
	a.country
FROM
	offuture.order AS o
INNER JOIN offuture.address AS a
    ON
	a.address_id = o.address_id
GROUP BY
	a.city,
	a.country
ORDER BY
	order_count DESC
;

    
-- Sub Category Aggregations
    
SELECT
    p.sub_category,
    ROUND(AVG(oi.profit),2) AS avg_profit,
    SUM(oi.quantity) AS total_units,
    ROUND(AVG(oi.quantity),2) AS avg_units_per_order,
    SUM(oi.profit) AS total_profit,
    SUM(oi.sales) AS total_sales,
    p.category,
    c.segment,
    o.order_priority
FROM
    offuture.customer AS c
INNER JOIN offuture."order" AS o
    ON c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON oi.order_id = o.order_id
INNER JOIN offuture.product AS p
    ON p.product_id = oi.product_id
GROUP BY
    p.sub_category,
    p.category,
    c.segment,
    o.order_priority
ORDER BY
    total_profit DESC;



-- Aggregations of Customer segments with category

SELECT
    c.segment,
    SUM(oi.quantity) AS total_units,
    ROUND(AVG(oi.quantity),2) AS avg_units_per_order,
    SUM(oi.profit) AS total_profit,
    ROUND(AVG(oi.profit),2) AS avg_profit,
    SUM(oi.sales) AS total_sales,
    p.category
FROM
    offuture.customer AS c
INNER JOIN offuture.order AS o
    ON c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON oi.order_id = o.order_id
INNER JOIN offuture.product AS p
    ON p.product_id = oi.product_id
GROUP BY
    c.segment,
    p.category
ORDER BY
    c.segment;


-- Aggregations of Tables

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_units,
    ROUND(AVG(oi.quantity),2) AS avg_units_per_order,
    SUM(oi.profit) AS total_profit,
    ROUND(AVG(oi.profit),2) AS avg_profit,
    SUM(oi.sales) AS total_sales
FROM
    offuture.customer AS c
INNER JOIN offuture.order AS o
    ON c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON oi.order_id = o.order_id
INNER JOIN offuture.product AS p
    ON p.product_id = oi.product_id
    WHERE 
        p.sub_category = 'Tables'
GROUP BY
    p.product_name
ORDER BY
    total_profit DESC;

-- All orders containing Tables

SELECT
    o.order_id,
    p.product_name,
    oi.discount,
    oi.quantity,
    oi.profit,
    oi.sales
FROM
    offuture.customer AS c
INNER JOIN offuture.order AS o
    ON c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON oi.order_id = o.order_id
INNER JOIN offuture.product AS p
    ON p.product_id = oi.product_id
    WHERE 
        p.sub_category = 'Tables'
ORDER BY
    oi.profit DESC;


-- All Orders 

SELECT
    DISTINCT o.order_id,
    p.product_name,
    p.category,
    p.sub_category,
    oi.discount,
    oi.quantity,
    oi.profit,
    oi.sales
FROM
    offuture.customer AS c
INNER JOIN offuture.order AS o
    ON c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON oi.order_id = o.order_id
INNER JOIN offuture.product AS p
    ON p.product_id = oi.product_id
INNER JOIN offuture.address AS a
    ON a.address_id = o.address_id
ORDER BY
    oi.profit DESC;



-- average ship time by country

SELECT
	country,
	round (avg (ship_date - order_date),
	2) AS avg_shiptime
FROM
	offuture.order AS ord
INNER JOIN offuture.address AS ADD
    ON
	add.address_id = ord.address_id
GROUP BY
	country
ORDER BY
	country ASC
;


-- Total Units sold and Total profit by segment and category

SELECT
	c.segment,
	SUM(oi.quantity) AS total_units,
	ROUND(AVG(oi.quantity),
	2) AS avg_units_per_order,
	SUM(oi.profit) AS total_profit,
	ROUND(AVG(oi.profit),
	2) AS avg_profit,
	SUM(oi.sales) AS total_sales,
	p.category
FROM
	customer AS c
INNER JOIN offuture.order AS o
    ON
	c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON
	oi.order_id = o.order_id
INNER JOIN offuture.product AS p
	ON
	p.product_id = oi.product_id
GROUP BY
	c.segment,
	p.category
ORDER BY
	c.segment;


-- Total units sold by sub category
    
SELECT
	p.sub_category,
	ROUND(AVG(oi.profit),
	2) AS avg_profit,
	SUM(oi.quantity) AS total_units,
	ROUND(AVG(oi.quantity),
	2) AS avg_units_per_order,
	SUM(oi.profit) AS total_profit,
	SUM(oi.sales) AS total_sales
FROM
	customer AS c
INNER JOIN offuture.order AS o
    ON
	c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON
	oi.order_id = o.order_id
INNER JOIN offuture.product AS p
    ON
	p.product_id = oi.product_id
GROUP BY
	p.sub_category
ORDER BY
	avg_profit DESC;


-- Top performing Copiers (highest profit sub category)

SELECT
	p.product_name,
	ROUND(AVG(oi.profit),
	2) AS avg_profit,
	SUM(oi.profit) AS total_profit,
	SUM(oi.quantity) AS total_qty
FROM
	offuture.product AS p
INNER JOIN offuture.order_item AS oi
    ON
	oi.product_id = p.product_id
WHERE
	p.sub_category = 'Copiers'
GROUP BY
	p.product_name
ORDER BY
	total_profit DESC;


-- Top performing Copiers (no variations)

SELECT
    SPLIT_PART(p.product_name, ',', 1) AS product_name_no_colour,
    ROUND(AVG(oi.profit),2) AS avg_profit,
    SUM(oi.profit) AS total_profit,
    SUM(oi.quantity) AS total_qty
FROM
    offuture.product AS p
INNER JOIN offuture.order_item AS oi
    ON oi.product_id = p.product_id
    WHERE
    p.sub_category = 'Copiers'
GROUP BY
    product_name_no_colour
ORDER BY
    total_profit DESC;


-- Worst performing sub_category (Tables) Profitability and Units sold

SELECT
	p.product_name,
	ROUND(AVG(oi.profit),
	2) AS avg_profit,
	SUM(oi.profit) AS total_profit,
	SUM(oi.quantity) AS total_qty,
	SUM(oi.profit)/ SUM(oi.quantity) AS profit_per_unit,
	p.sub_category,
	p.category,
	p.product_name,
	c.segment
FROM
	offuture.product AS p
INNER JOIN offuture.order_item AS oi
    ON
	oi.product_id = p.product_id
INNER JOIN offuture.order AS o
    ON
	oi.order_id = o.order_id
INNER JOIN offuture.customer AS c
    ON
	c.customer_id_long = o.customer_id
WHERE
	p.sub_category = 'Tables'
GROUP BY
	c.segment,
	p.product_name,
	p.sub_category,
	p.category
ORDER BY
	profit_per_unit ASC;

--analysis worst product sold

select
	round(sum(oi.profit)/ sum(oi.quantity)) as ppu,
	sum(oi.profit) profit,
	sum(oi.quantity) 
from
	offuture.product p
INNER JOIN offuture.order_item AS oi
ON p.product_id = oi.product_id
where
	product_name = 'Cubify CubeX 3D Printer Double Head Print';

--Amount of products per year

select
	o.order_date,
	sum(oi.quantity),
	sum(oi.profit)
from
	offuture.order_item oi 
inner join offuture.order o on oi.order_id = o.order_id
group by
	o.order_date

--items with only one unit sold
	
SELECT 
    SPLIT_PART(p.product_name, ',', 1) AS product_name_no_colour,
    count(oi.product_id)	*	count(oi.quantity) units_sold,
    sum(profit)
FROM 
    offuture.product AS p
INNER JOIN offuture.order_item AS oi
    ON p.product_id = oi.product_id
GROUP BY
    product_name_no_colour
ORDER BY
    units_sold asc
LIMIT
    81;

--profit per item of most profitable

SELECT 
    SPLIT_PART(p.product_name, ',', 1) AS product_name_no_colour,
    round(sum(oi.profit)/sum(oi.quantity),2) as profit_per_item
FROM 
    offuture.product AS p
INNER JOIN offuture.order_item AS oi
    ON p.product_id = oi.product_id
GROUP BY
    product_name_no_colour
ORDER BY
    SUM(oi.profit) desc
LIMIT
    10
;

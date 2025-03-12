SQL Queries with Descriptor 

--best performing by category
select
	p.category,
	sum(o.profit)
from
	product AS p
inner join order_item o on p.product_id = o.product_id
group by
	p.category
order by
	sum(o.profit) asc;



--best performing product regardless of colour variation
SELECT 
    SPLIT_PART(p.product_name, ',', 1) AS product_name_no_colour,
    SUM(oi.profit)
FROM 
    offuture.product AS p
INNER JOIN order_item AS oi
    ON p.product_id = oi.product_id
GROUP BY
    product_name_no_colour
ORDER BY
    SUM(oi.profit) asc
LIMIT
    10
;

--worst performing regardless of colour variation
SELECT 
    SPLIT_PART(p.product_name, ',', 1) AS product_name_no_colour,
    SUM(oi.profit)
FROM 
    offuture.product AS p
INNER JOIN order_item AS oi
    ON p.product_id = oi.product_id
GROUP BY
    product_name_no_colour
ORDER BY
    SUM(oi.profit) asc
LIMIT
    10
;

--best performing by units sold
SELECT 
    SPLIT_PART(p.product_name, ',', 1) AS product_name_no_colour,
    count(oi.product_id)
FROM 
    offuture.product AS p
INNER JOIN order_item AS oi
    ON p.product_id = oi.product_id
GROUP BY
    product_name_no_colour
ORDER BY
    count(oi.product_id) desc
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
    ON a.address_id = o.address_id
GROUP BY
    a.city,
    a.country
ORDER BY
    order_count DESC
;

-- Total units sold by Segement 
    
SELECT
    c.segment,
    SUM(oi.quantity) AS total_units,
    ROUND(AVG(oi.quantity),2) AS avg_units_per_order,
    SUM(oi.profit) AS total_profit,
    ROUND(AVG(oi.profit),2) AS avg_profit,
    SUM(oi.sales) AS total_sales
FROM
    customer AS c
INNER JOIN offuture.order AS o
    ON c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON oi.order_id = o.order_id
GROUP BY
    c.segment;


-- average ship time by country

SELECT
	country,
    round (avg (ship_date - order_date),2) AS avg_shiptime
FROM
     offuture.order AS ord
INNER JOIN offuture.address AS add
    ON add.address_id = ord.address_id
GROUP BY
   country
ORDER BY
    country asc
;


-- average ship time for priority tiers

SELECT
order_priority,
round (avg (ship_date - order_date),2) AS avg_shiptime
FROM
offuture."order"
GROUP BY
order_priority
ORDER BY
order_priority;

-- Total Units sold and Total profit by segment and category

SELECT
    c.segment,
    SUM(oi.quantity) AS total_units,
    ROUND(AVG(oi.quantity),2) AS avg_units_per_order,
    SUM(oi.profit) AS total_profit,
    ROUND(AVG(oi.profit),2) AS avg_profit,
    SUM(oi.sales) AS total_sales,
    p.category
FROM
    customer AS c
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
    
-- Total units sold by sub category
    
SELECT
    p.sub_category,
    ROUND(AVG(oi.profit),2) AS avg_profit,
    SUM(oi.quantity) AS total_units,
    ROUND(AVG(oi.quantity),2) AS avg_units_per_order,
    SUM(oi.profit) AS total_profit,
    SUM(oi.sales) AS total_sales
FROM
    customer AS c
INNER JOIN offuture.order AS o
    ON c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON oi.order_id = o.order_id
INNER JOIN offuture.product AS p
    ON p.product_id = oi.product_id
GROUP BY
    p.sub_category
ORDER BY
    avg_profit DESC;

-- Top performing Copiers (highest profit sub category)

SELECT
    p.product_name,
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
    p.product_name
ORDER BY
    total_profit DESC;









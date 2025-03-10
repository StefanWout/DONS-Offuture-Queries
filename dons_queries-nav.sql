
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

-- Top 10 Products (no variations) by Total Profit

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
    SUM(oi.profit) DESC
LIMIT
    10
;

SELECT DISTINCT
    order_priority
FROM
    offuture.order;

SELECT DISTINCT
    segment
FROM
    customer
    
-- Total units sold by sub category
    
SELECT
    p.sub_category,
    ROUND(AVG(oi.profit),2) AS avg_profit,
    SUM(oi.quantity) AS total_units,
    ROUND(AVG(oi.quantity),2) AS avg_units_per_order,
    SUM(oi.profit) AS total_profit,
    SUM(oi.sales) AS total_sales,
    o.order_date
FROM
    customer AS c
INNER JOIN offuture.order AS o
    ON c.customer_id_long = o.customer_id
INNER JOIN offuture.order_item AS oi
    ON oi.order_id = o.order_id
INNER JOIN offuture.product AS p
    ON p.product_id = oi.product_id
GROUP BY
    p.sub_category,
    o.order_date
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
    SUM(oi.profit) DESC
LIMIT
    10
;

-- Top 10 products by Total Profit

SELECT 
    p.product_name,
    SUM(oi.profit)
FROM 
    offuture.product AS p
INNER JOIN order_item AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_name
ORDER BY
    SUM(oi.profit) DESC
LIMIT 10
;

-- Distinct products

SELECT DISTINCT
    category
FROM
    offuture.product;

select
    p.product_name,
    sum(o.profit),
    p.category
from
    product p
inner join order_item o on p.product_id = o.product_id
group by
    p.product_name,
    p.category
order by
    sum(o.profit) desc
limit 10;


SELECT DISTINCT
    region
FROM
    offuture.order

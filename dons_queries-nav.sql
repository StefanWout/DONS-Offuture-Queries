
-- Number of orders from each city, country

SELECT
    COUNT(o.order_id) AS order_count,
    a.city,
    a.country
FROM
     offuture."order" AS o
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
INNER JOIN offuture.order_item AS oi
    ON p.product_id = oi.product_id
GROUP BY
    product_name_no_colour
ORDER BY
    SUM(oi.profit) DESC
LIMIT
    10
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


-- Top 10 Products (no variations)

SELECT 
    SPLIT_PART(p.product_name, ',', 1) AS product_name_no_colour,
    SUM(oi.profit)
FROM 
    offuture.product AS p
INNER JOIN offuture.order_item AS oi
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
    p.category,
    p.sub_category,
    SUM(oi.profit)
FROM 
    offuture.product AS p
INNER JOIN offuture.order_item AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_name,
    p.category,
    p.sub_category
ORDER BY
    SUM(oi.profit) DESC
LIMIT 10
;

-- Distinct products

SELECT DISTINCT
    category
FROM
    offuture.product;

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

-- Aggregations of Customer segments

SELECT
    c.segment,
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
GROUP BY
    c.segment
ORDER BY
    c.segment;

-- Aggregations of Sub Category

SELECT
    p.sub_category,
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
GROUP BY
    p.sub_category
ORDER BY
    total_profit;

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


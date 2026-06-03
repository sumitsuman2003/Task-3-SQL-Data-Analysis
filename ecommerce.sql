CREATE TABLE customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix INT,
    customer_city TEXT,
    customer_state TEXT
);

SELECT * FROM customers;

CREATE TABLE orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP
);

SELECT * FROM orders;

DROP TABLE orders;

CREATE TABLE orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);


SELECT * FROM orders;


CREATE TABLE order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC
);


SELECT * FROM order_items;

CREATE TABLE products (
    product_id TEXT,
    product_category_name TEXT
);


SELECT * FROM products;

DROP TABLE products;

CREATE TABLE products (
    product_id VARCHAR(100),
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

SELECT * FROM products;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id TEXT,
    product_category_name TEXT,
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);


SELECT column_name
FROM information_schema.columns
WHERE table_name = 'products'
ORDER BY ordinal_position;


SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM products;

-- 1. SELECT

SELECT *
FROM customers
LIMIT 10;

-- 2.WHERE

SELECT *
FROM orders
WHERE order_status = 'delivered';

-- 3. ORDER BY

SELECT *
FROM order_items
ORDER BY price DESC;

-- 4. GROUP BY

SELECT order_id,
       SUM(price) AS total_order_value
FROM order_items
GROUP BY order_id
ORDER BY total_order_value DESC;


-- 5.INNER JOIN

SELECT c.customer_id,
       o.order_id,
       o.order_status
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
LIMIT 20;

-- 6. LEFT JOIN

SELECT c.customer_id,
       o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LIMIT 20;

-- 7. Aggregate Functions (SUM & AVG)

SELECT
SUM(price) AS total_revenue,
AVG(price) AS average_price
FROM order_items;

-- 8. Subquery

SELECT *
FROM order_items
WHERE price >
(
    SELECT AVG(price)
    FROM order_items
);


-- 9. View

CREATE VIEW high_value_orders AS
SELECT *
FROM order_items
WHERE price > 500;

SELECT * FROM high_value_orders;


-- 10. Index

CREATE INDEX idx_customer_id
ON customers(customer_id);

-- 11. Product Category Analysis

SELECT p.product_category_name,
       COUNT(*) AS total_sales
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 10;

-- 12. Average Revenue Per User

SELECT
SUM(oi.price) / COUNT(DISTINCT o.customer_id) AS arpu
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id;


-- 13. RIGHT JOIN

SELECT c.customer_id,
       o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
LIMIT 20;


--14. Top 10 Customers

SELECT customer_id,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;
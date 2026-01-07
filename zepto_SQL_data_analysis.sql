-- =====================================================
-- Retail SQL Inventory Analysis
-- Dataset Source: Kaggle
-- Database: PostgreSQL
-- =====================================================


-- =========================
-- 1. TABLE CREATION
-- =========================
CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(10,2),
    discount_percent NUMERIC(5,2),
    discounted_price NUMERIC(10,2),
    available_quantity INTEGER,
    weight_in_gms INTEGER,
    out_of_stock BOOLEAN,
    quantity INTEGER
);


-- =========================
-- 2. BASIC DATA EXPLORATION
-- =========================

-- Total number of SKUs
SELECT COUNT(*) AS total_skus
FROM zepto;

-- Total distinct product categories
SELECT COUNT(DISTINCT category) AS total_categories
FROM zepto;

-- List of distinct categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- Sample data preview
SELECT *
FROM zepto
LIMIT 10;


-- =========================
-- 3. DATA QUALITY CHECKS
-- =========================

-- Check for NULL values
SELECT *
FROM zepto
WHERE mrp IS NULL
   OR discounted_price IS NULL
   OR category IS NULL;

-- Count in-stock vs out-of-stock products
SELECT out_of_stock, COUNT(*) AS product_count
FROM zepto
GROUP BY out_of_stock;


-- =========================
-- 4. DATA CLEANING
-- =========================

-- Remove invalid price records
DELETE FROM zepto
WHERE mrp <= 0 OR discounted_price <= 0;

-- Convert prices from paise to rupees
UPDATE zepto
SET mrp = mrp / 100,
    discounted_price = discounted_price / 100;


-- =========================
-- 5. DUPLICATE PRODUCT CHECK
-- =========================

-- Products appearing multiple times (different SKUs)
SELECT name, COUNT(*) AS sku_count
FROM zepto
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY sku_count DESC;


-- =========================
-- 6. BUSINESS INSIGHTS
-- =========================

-- Top 10 products with highest discount
SELECT name, category, discount_percent
FROM zepto
ORDER BY discount_percent DESC
LIMIT 10;

-- High MRP products that are out of stock
SELECT name, category, mrp
FROM zepto
WHERE mrp > 500 AND out_of_stock = TRUE
ORDER BY mrp DESC;

-- Estimated revenue per product
SELECT name,
       discounted_price * available_quantity AS estimated_revenue
FROM zepto
ORDER BY estimated_revenue DESC
LIMIT 10;

-- Estimated revenue by category
SELECT category,
       SUM(discounted_price * available_quantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;


-- =========================
-- 7. PRICE & VALUE ANALYSIS
-- =========================

-- Price per gram calculation
SELECT name,
       discounted_price,
       weight_in_gms,
       ROUND(discounted_price / weight_in_gms, 2) AS price_per_gram
FROM zepto
WHERE weight_in_gms > 0
ORDER BY price_per_gram;

-- Expensive products with low discounts
SELECT name, mrp, discount_percent
FROM zepto
WHERE mrp > 500 AND discount_percent < 5
ORDER BY mrp DESC;


-- =========================
-- 8. CATEGORY PERFORMANCE
-- =========================

-- Average discount by category
SELECT category,
       ROUND(AVG(discount_percent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC;

-- Inventory availability by category
SELECT category,
       SUM(available_quantity) AS total_units
FROM zepto
GROUP BY category
ORDER BY total_units DESC;


-- =========================
-- 9. WEIGHT-BASED SEGMENTATION
-- =========================

-- Group products by weight
SELECT name,
       weight_in_gms,
       CASE
           WHEN weight_in_gms < 500 THEN 'Low Weight'
           WHEN weight_in_gms BETWEEN 500 AND 2000 THEN 'Medium Weight'
           ELSE 'Bulk'
       END AS weight_category
FROM zepto;

-- Total inventory weight by category
SELECT category,
       SUM(weight_in_gms * available_quantity) AS total_inventory_weight
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight DESC;


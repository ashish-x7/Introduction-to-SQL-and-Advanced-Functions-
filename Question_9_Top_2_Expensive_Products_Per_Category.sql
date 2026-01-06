
-- ============================================================
-- Question 9: Top 2 Most Expensive Products per Category
-- ============================================================
-- Uses:
-- 1. Common Table Expression (CTE)
-- 2. Window Function (ROW_NUMBER)
-- Displays:
-- CategoryName, ProductName, Price
-- For top 2 most expensive products in each category
-- ============================================================

USE ecommercedb;

WITH RankedProducts AS (
    SELECT
        c.CategoryName,
        p.ProductName,
        p.Price,
        ROW_NUMBER() OVER (
            PARTITION BY c.CategoryName
            ORDER BY p.Price DESC
        ) AS price_rank
    FROM products p
    JOIN categories c
        ON p.CategoryID = c.CategoryID
)

SELECT
    CategoryName,
    ProductName,
    Price
FROM RankedProducts
WHERE price_rank <= 2
ORDER BY CategoryName, Price DESC;


-- ============================================
-- Question 8: Product Information with Category
-- ============================================
-- Displays:
-- ProductName, Price, StockQuantity, CategoryName
-- Ordered by CategoryName, then ProductName (Alphabetically)
-- ============================================

USE ecommercedb;

SELECT
    p.ProductName,
    p.Price,
    p.StockQuantity,
    c.CategoryName
FROM products p
JOIN categories c
    ON p.CategoryID = c.CategoryID
ORDER BY
    c.CategoryName ASC,
    p.ProductName ASC;

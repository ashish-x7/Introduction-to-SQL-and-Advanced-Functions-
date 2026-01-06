
-- ============================================
-- Question 7: Customer Orders Report
-- ============================================
-- This report shows:
-- CustomerName, Email, TotalNumberOfOrders
-- Includes customers with ZERO orders
-- Ordered by CustomerName
-- ============================================

USE ecommercedb;

SELECT 
    c.CustomerName,
    c.Email,
    COUNT(o.OrderID) AS TotalNumberOfOrders
FROM customers c
LEFT JOIN orders o
    ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID,
    c.CustomerName,
    c.Email
ORDER BY 
    c.CustomerName;

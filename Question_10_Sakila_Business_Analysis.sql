
-- ============================================================
-- Question 10: Sakila Video Rentals Business Analysis
-- ============================================================
-- Database: sakila
-- ============================================================

USE sakila;

-- ------------------------------------------------------------
-- 1. Top 5 customers by total amount spent
-- ------------------------------------------------------------
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS CustomerName,
    c.email,
    SUM(p.amount) AS TotalAmountSpent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY TotalAmountSpent DESC
LIMIT 5;

-- ------------------------------------------------------------
-- 2. Top 3 movie categories by rental count
-- ------------------------------------------------------------
SELECT 
    cat.name AS CategoryName,
    COUNT(r.rental_id) AS RentalCount
FROM category cat
JOIN film_category fc ON cat.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY cat.category_id, cat.name
ORDER BY RentalCount DESC
LIMIT 3;

-- ------------------------------------------------------------
-- 3. Films available at each store & never rented films
-- ------------------------------------------------------------
SELECT
    s.store_id,
    COUNT(i.inventory_id) AS TotalFilms,
    SUM(CASE WHEN r.rental_id IS NULL THEN 1 ELSE 0 END) AS NeverRentedFilms
FROM store s
JOIN inventory i ON s.store_id = i.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY s.store_id;

-- ------------------------------------------------------------
-- 4. Total revenue per month for year 2023
-- ------------------------------------------------------------
SELECT
    DATE_FORMAT(p.payment_date, '%Y-%m') AS YearMonth,
    SUM(p.amount) AS TotalRevenue
FROM payment p
WHERE YEAR(p.payment_date) = 2023
GROUP BY YearMonth
ORDER BY YearMonth;

-- ------------------------------------------------------------
-- 5. Customers with more than 10 rentals in last 6 months
-- ------------------------------------------------------------
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS CustomerName,
    c.email,
    COUNT(r.rental_id) AS RentalCount
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(r.rental_id) > 10
ORDER BY RentalCount DESC;

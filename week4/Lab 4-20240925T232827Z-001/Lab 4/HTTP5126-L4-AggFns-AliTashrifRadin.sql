-- YOUR NAME HERE	LAB 4 AGGREGATE FUNCTIONS
-- Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
-- 1 
-- A
SELECT MIN(price) FROM stock_items;
-- B
SELECT MAX(inventory) FROM stock_items;
-- C
SELECT AVG(price) FROM stock_items;
-- D
SELECT SUM(inventory) FROM stock_items;

-- 2
-- A
SELECT COUNT(role), role FROM employees GROUP BY role;
-- B
SELECT COUNT(item), category AS "Mammals" FROM stock_items GROUP BY category HAVING NOT category = 'Piscine';
-- C
SELECT AVG(price), category AS "Average Price ($)" FROM stock_items WHERE NOT inventory =0 GROUP BY category;

-- 3
-- A
SELECT SUM(inventory) AS "Stock", category AS "Species" FROM stock_items GROUP BY category ORDER BY Stock;
-- B
SELECT SUM(inventory), AVG(price), category FROM stock_items GROUP BY category HAVING SUM(inventory)<100 AND AVG(price)<100;

-- 4
SELECT CONCAT((price*inventory),"$") AS 'Potential Earnings', item AS 'Product', price 'Price', inventory AS 'Stock Remaining', category AS 'Species' FROM stock_items ORDER BY price*inventory;
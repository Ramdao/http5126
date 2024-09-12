--  <Tashrif Radin Ali>	ASSIGNMENT 2 ACCESSING DATA PART 1
--  Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
--  1 
-- A 
SELECT * FROM employees;
-- B 
SELECT * FROM stock_items;

--  2
-- A 
SELECT item, price From stock_items;
-- B
SELECT first_name, last_name, role, phone FROM employees;

--  3
-- A
SELECT item AS Product, category AS Animal FROM stock_items;
-- B
SELECT last_name AS "Pet Store Staff", id AS "Emp. ID", sin AS SIN FROM employees;

--  4
-- A
SELECT first_name, phone FROM employees WHERE role = "Sales";
-- B
SELECT item, id , inventory FROM stock_items WHERE inventory <= 12;

--  5
-- A
SELECT item, price FROM stock_items WHERE category ="Feline";
-- B
SELECT first_name, last_name FROM employees WHERE id = 115;
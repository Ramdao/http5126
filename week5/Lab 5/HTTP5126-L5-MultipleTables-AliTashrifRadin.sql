--  LAB 5 MULTIPLE TABLES
--  Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
--  1 
-- A 
SELECT * FROM sales WHERE item = 1004;
-- B 
SELECT sales.date, stock_items.item FROM sales INNER JOIN stock_items ON sales.item = stock_items.id;

--  2
-- A 
SELECT * FROM employees WHERE id = 111;
-- B
SELECT sales.date, employees.first_name,sales.item FROM sales INNER JOIN employees ON sales.employee = employees.id WHERE employees.id=111;  

--  3
-- A
SELECT sales.date, sales.item, employees.first_name FROM sales INNER JOIN employees ON sales.employee = employees.id WHERE sales.date BETWEEN "2024-09-12" AND "2024-09-18";
-- B
SELECT COUNT(sales.employee) AS count, employees.first_name, employees.last_name, sales.item FROM sales INNER JOIN employees ON sales.employee = employees.id GROUP BY employees.id ORDER BY count DESC;

--  4
-- A
SELECT s.date, si.item, si.price,si.category, e.first_name FROM sales s INNER JOIN employees e ON s.employee = e.id INNER JOIN stock_items si ON si.id = s.item WHERE first_name = 'Farud';
-- B
SELECT COUNT(s.item) AS 'Times Sold', si.id, si.item, si.price, si.category FROM sales s RIGHT JOIN stock_items si ON si.id=s.item GROUP BY si.id;

--  5
-- A <Times sold By employee Farud by date>
-- B
SELECT COUNT(s.item) AS 'Times Sold', e.first_name, s.date FROM sales s RIGHT JOIN employees e ON e.id=s.employee WHERE e.first_name= 'Farud' GROUP BY s.date;

select count(sales.employee) as count, employees.first_name from sales inner join employees on employees.id = sales.employee group by employee
select employees.first_name, sales.item, stock_items.item from employees inner join sales on sales.employee = employees.id inner join stock_items on sales.item = stock_items.id where first_name= "Henry" group by sales.item
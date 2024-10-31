--  LAB 8 CRUD
--  Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
--  1 
-- A 
CREATE TABLE customer (email VARCHAR(100),name VARCHAR(100) NOT NULL, PRIMARY KEY(email));
-- B 
CREATE TABLE supplier (supplier_id INT AUTO_INCREMENT,name VARCHAR(100) NOT NULL, location VARCHAR(100) NOT NULL ,PRIMARY KEY(supplier_id));
-- C 
CREATE TABLE `order` (order_id INT AUTO_INCREMENT, email VARCHAR(100) NOT NULL, FOREIGN KEY(email) REFERENCES customer (email) ,PRIMARY KEY(order_id));
-- D
CREATE TABLE product (product_id INT AUTO_INCREMENT, supplier_id INT NOT NULL ,name VARCHAR(100) NOT NULL,price INT NOT NULL,brand VARCHAR(100) NOT NULL ,FOREIGN KEY(supplier_id) REFERENCES supplier (supplier_id) ,PRIMARY KEY(product_id));
-- E 
CREATE TABLE order_product (product_id INT,order_id INT, PRIMARY KEY (product_id,order_id));

--  2 
-- A 
INSERT INTO customer(email, name) VALUES ('john@gmail.com', 'John'),('jane@gmail.com', 'Jane'),('alice@gmail.com', 'Alice')
-- B 
INSERT INTO supplier(name, location) VALUES ('XYZ Electronics', 'Toronto'),('ABC Gadgets', 'Montreal'),('XYZ Furniture', 'Vancouver')
-- C 
INSERT INTO `order` (email) VALUES ('john@gmail.com'),('jane@gmail.com'),('john@gmail.com'),('alice@gmail.com');
-- D
INSERT INTO product (name,price,brand,supplier_id) VALUES ('Laptop', 800, 'Dell', 1),('Smartphone', 600, 'Apple', 2),('Smartphone', 600, 'Samsung', 2),('Camera', 300, 'Canon', 1),('Chair', 100, 'Herman Miller', 3);
-- E 
INSERT INTO order_product (order_id, product_id) VALUES (1,1),(2,2),(2,3),(3,4),(4,5);

--  3 
-- A 
ALTER TABLE product ADD CHECK (price >=0);
-- B 
UPDATE order_product SET product_id =4 WHERE product_id =2;

--  4 
-- A 
ALTER TABLE product DROP FOREIGN KEY product_ibfk_1;
-- B 
ALTER TABLE product DROP COLUMN supplier_id;
-- C 
DROP TABLE supplier;



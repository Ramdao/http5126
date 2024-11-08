--
-- Database: http5126-lab-9
--

--
-- Table structure for table employees
--
CREATE TABLE employees (
  id int(255) AUTO_INCREMENT,
  last_name varchar(30) NOT NULL,
  first_name varchar(30) NOT NULL,
  sin int(20) UNSIGNED NOT NULL,
  phone int(20) UNSIGNED NOT NULL,
  role varchar(20) NOT NULL,
  PRIMARY KEY (id)
);
ALTER TABLE employees AUTO_INCREMENT=110;

--
-- Dumping data for table employees
--
INSERT INTO employees (last_name, first_name, sin, phone, role) VALUES
('Maracle', 'James', 123456789, 4165551234, 'Manager'),
('Marquis', 'Henry', 987654321, 4165551235, 'Sales'),
('Kaur', 'Jas', 456123789, 4165551236, 'Sales'),
('Neema', 'Hank', 654987321, 4165551237, 'Assistant'),
('Said', 'Farud', 258741369, 4165551238, 'Sales'),
('Fitzpatrick', 'Henry', 753951842, 4165551239, 'Stock'),
('Chovey', 'Ann', 453911842, 2895551230, 'Sales'),
('Bugg', 'Aida', 953951999, 4169998888, 'Stock'),
('Legge', 'Scout', 75396789, 4168082034, 'Sales'),
('Shin', 'Ray', 753922344, 41652324567, 'Stock');

--
-- Table structure for table sales
--
CREATE TABLE sales (
  id int(255) AUTO_INCREMENT,
  `date` date NOT NULL,
  item varchar(255) NOT NULL,
  employee int(255) NOT NULL,
  PRIMARY KEY (id)
);
ALTER TABLE sales AUTO_INCREMENT=21000;

--
-- Dumping data for table sales
--
INSERT INTO sales (date, item, employee) VALUES
('2021-06-09', '1002', 111),
('2021-06-09', '1003', 111),
('2021-06-09', '1004', 111),
('2021-06-10', '1005', 112),
('2021-06-10', '1011', 114),
('2021-06-11', '1012', 111),
('2021-06-11', '1002', 111),
('2021-06-12', '1010', 114),
('2021-06-12', '1009', 114),
('2021-06-12', '1005', 111),
('2021-06-12', '1017', 114),
('2021-06-12', '1018', 114),
('2021-06-12', '1014', 112),
('2021-06-13', '1003', 112),
('2021-06-13', '1004', 112),
('2021-06-13', '1005', 112),
('2021-06-13', '1002', 116),
('2021-06-14', '1019', 114),
('2021-06-14', '1020', 112),
('2021-06-15', '1014', 111),
('2021-06-15', '1011', 114),
('2021-06-15', '1004', 114),
('2021-06-15', '1009', 118),
('2021-06-16', '1019', 111),
('2021-06-16', '1018', 111),
('2021-06-16', '1014', 114),
('2021-06-16', '1010', 111),
('2021-06-17', '1003', 114),
('2021-06-17', '1005', 114),
('2021-06-17', '1014', 112),
('2021-06-17', '1011', 112),
('2021-06-18', '1020', 114),
('2021-06-18', '1004', 111),
('2021-06-18', '1006', 114),
('2021-06-19', '1014', 112),
('2021-06-19', '1011', 112),
('2021-06-19', '1020', 111),
('2021-06-20', '1007', 114),
('2021-06-20', '1117', 114),
('2021-06-20', '1020', 112),
('2021-06-20', '1008', 111);

--
-- Table structure for table stock_items
--
CREATE TABLE stock_items (
  id smallint(5) AUTO_INCREMENT,
  item varchar(30) NOT NULL,
  price decimal(10,0) NOT NULL,
  inventory smallint(4) NOT NULL,
  category varchar(7) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT chk_inventory CHECK (inventory>=0)
);
ALTER TABLE stock_items AUTO_INCREMENT=1001;

--
-- Dumping data for table stock_items
--
INSERT INTO stock_items (item, price, inventory, category) VALUES
('Luxury dog bed', 95, 2, 'Canine'),
('Super size chew toy', 15, 45, 'Canine'),
('Water dish', 87, 11, 'Feline'),
('Fish bowl starter kit', 46, 22, 'Piscine'),
('Luxury cat bed', 89, 0, 'Feline'),
('Just as good dog bed', 74, 14, 'Canine'),
('Deluxe Aquarium', 12, 10, 'Piscine'),
('Terrarium', 231, 24, 'Murine'),
('Cat stand', 55, 6, 'Feline'),
('Premium Terrarium', 524, 2, 'Murine'),
('Water dish', 10, 88, 'Canine'),
('Giant clam aerator', 15, 12, 'Piscine'),
('Small cage', 20, 26, 'Murine'),
('Small chew toy', 6, 123, 'Canine'),
('Collar', 12, 65, 'Feline'),
('Collar', 15, 87, 'Canine'),
('Air pump', 18, 36, 'Piscine'),
('Hamster tubes', 65, 12, 'Murine'),
('Large cage', 30, 11, 'Murine'),
('Leash', 18, 88, 'Canine');

--
-- Table structure for table stock_items_log
--
CREATE TABLE stock_items_log (
  id int AUTO_INCREMENT,
  `action` char(6),
  item_id int NOT NULL,
  old_item varchar(30),
  old_price decimal(10,0),
  old_inventory smallint(4),
  old_category varchar(7),
  timestamp datetime,
  PRIMARY KEY (id)
);

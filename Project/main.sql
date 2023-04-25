SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `Mall_MS` ;
CREATE SCHEMA IF NOT EXISTS `Mall_MS` DEFAULT CHARACTER SET utf8mb4 ;
USE `Mall_MS` ;



CREATE TABLE Customers (
  customer_ID INT PRIMARY KEY,
  password VARCHAR(255),
  reward_points INT,
  phone_number VARCHAR(20),
  registration_time DATE
);

CREATE TABLE Suppliers (
  supplier_ID INT PRIMARY KEY,
  supplier_name VARCHAR(255),
  phone_number VARCHAR(20)
);

CREATE TABLE Employees (
  employee_ID INT PRIMARY KEY,
  first_name VARCHAR(50),
  middle_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(50),
  phone_number VARCHAR(20),
  hire_date DATE,
  job_ID INT,
  salary FLOAT(10,2),
  department_ID INT,
  manager_ID INT,
  FOREIGN KEY (job_ID) REFERENCES Jobs(job_ID),
  -- FOREIGN KEY (department_ID) REFERENCES Departments(department_ID),
  FOREIGN KEY (manager_ID) REFERENCES Employees(employee_ID)
);

CREATE TABLE Jobs (
  job_ID INT PRIMARY KEY,
  job_title VARCHAR(50),
  min_salary FLOAT(10, 2),
  max_salary FLOAT(10, 2)
);

CREATE TABLE Departments (
  department_ID INT PRIMARY KEY,
  department_name VARCHAR(50),
  manager_ID INT,
  location VARCHAR(50),
  FOREIGN KEY (manager_ID) REFERENCES Employees(employee_ID)
);

CREATE TABLE Goods (
  goods_ID INT PRIMARY KEY,
  goods_name VARCHAR(255),
  brand VARCHAR(255),
  category VARCHAR(255),
  price FLOAT(10, 2)
);

CREATE TABLE Inventory (
  goods_ID INT PRIMARY KEY,
  inventory INT,
  cost FLOAT(10, 2),
  inventory_location VARCHAR(255),
  FOREIGN KEY (goods_ID) REFERENCES Goods(goods_ID)
);

CREATE TABLE Purchase_Orders (
  order_ID INT PRIMARY KEY,
  supplier_ID INT,
  employee_ID INT,
  purchase_date DATE,
  goods_ID INT,
  purchase_amount FLOAT(10, 2),
  total_cost FLOAT(15, 2),
  FOREIGN KEY (supplier_ID) REFERENCES Suppliers(supplier_ID),
  FOREIGN KEY (employee_ID) REFERENCES Employees(employee_ID),
  FOREIGN KEY (goods_ID) REFERENCES Goods(goods_ID)
);

CREATE TABLE Sales (
  sale_ID INT PRIMARY KEY,
  customer_ID INT,
  sale_date DATETIME,
  sale_time TIME,
  total_cost FLOAT(10, 2),
  FOREIGN KEY (customer_ID) REFERENCES Customers(customer_ID)
);

CREATE TABLE Sales_Items (
  sale_ID INT,
  goods_ID INT,
  quantity INT,
  total_price FLOAT(10, 2),
  PRIMARY KEY (sale_ID, goods_ID),
  FOREIGN KEY (sale_ID) REFERENCES Sales(sale_ID),
  FOREIGN KEY (goods_ID) REFERENCES Goods(goods_ID)
);


-- -----------------------------------------------------
-- End of coding
-- -----------------------------------------------------

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
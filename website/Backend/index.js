const express = require('express');
const mysql = require('mysql');

const app = express();

// 添加 CORS 头
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '123456789',
  database: 'mall_ms'
});

app.get('/api/data', (req, res) => {
    const minPrice = req.query.minPrice;
    const maxPrice = req.query.maxPrice;
    const category = req.query.category;
    const brand = req.query.brand;
    const totalSales = req.query.totalSales;
    const rewardPoints = req.query.rewardPoints;
    const customerID = req.query.customerID;
    const registrationDate = req.query.registrationDate;
    const phoneNumbers = req.query.phoneNumbers;
    const avgSalary = req.query.avgSalary;
    const numEmployees = req.query.numEmployees;
    const employeesBySalary = req.query.employeesBySalary;
    const minSalary = req.query.minSalary;
    let query = '';
    let queryParams = [];
    
    if (minPrice && maxPrice) {
      query = 'SELECT * FROM Goods WHERE price BETWEEN ? AND ?';
      queryParams.push(minPrice, maxPrice);
    } else if (category) {
      query = 'SELECT * FROM Goods WHERE category = ?';
      queryParams.push(category);
    } else if (brand) {
      query = 'SELECT * FROM Goods WHERE brand = ?';
      queryParams.push(brand);
    } else if (totalSales) {
        query = `SELECT g.goods_name, SUM(si.quantity) as total_quantity, SUM(si.total_price) as total_sales
FROM Sales s
JOIN Sales_Items si ON s.sale_ID = si.sale_ID
JOIN Goods g ON si.goods_ID = g.goods_ID
GROUP BY g.goods_name
ORDER BY total_sales DESC LIMIT ${totalSales}`;
    } else if (rewardPoints) {
        query = 'SELECT customer_ID, reward_points FROM Customers WHERE reward_points > ?';
        queryParams.push(rewardPoints);
    } else if (customerID) {
        query = 'SELECT * FROM Customers WHERE customer_ID = ?';
        queryParams.push(customerID);
    } else if (registrationDate) {
        query = 'SELECT customer_ID FROM Customers WHERE registration_time >= ?';
        queryParams.push(registrationDate);
    } else if (phoneNumbers) {
        query = 'SELECT phone_number FROM Customers';
    } else if (avgSalary) {
        query = `SELECT d.department_name, AVG(e.salary) as avg_salary
FROM Employees e
JOIN Departments d ON e.department_ID = d.department_ID
GROUP BY d.department_name`;
    } else if (numEmployees) {
        query = `SELECT department_name, COUNT(*) as num_employees
FROM Employees e
JOIN Departments d ON e.department_ID = d.department_ID
GROUP BY department_name`;
    } else if (employeesBySalary) {
        query = `SELECT employee_ID, salary
FROM Employees
ORDER BY salary ASC`;
    } else if (minSalary) {
        query = `SELECT CONCAT(first_name, ' ', middle_name, ' ', last_name) AS name, salary
FROM Employees
WHERE salary > ?`;
        queryParams.push(minSalary);
    }
    
    connection.query(query, queryParams, (error, results) => {
      if (error) throw error;
      res.json(results);
    });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
-- the names and salaries of all employees whose salary is greater than #
SELECT CONCAT(first_name, ' ', middle_name, ' ', last_name) AS name, salary
FROM Employees
WHERE salary > 50000;


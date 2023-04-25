-- Retrieve the average salary of employees in each department, along with the department name:

SELECT d.department_name, AVG(e.salary) as avg_salary
FROM Employees e
JOIN Departments d ON e.department_ID = d.department_ID
GROUP BY d.department_name;

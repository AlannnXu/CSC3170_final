-- Retrieve the department names and the number of employees in each department:

SELECT department_name, COUNT(*) as num_employees
FROM Employees e
JOIN Departments d ON e.department_ID = d.department_ID
GROUP BY department_name;

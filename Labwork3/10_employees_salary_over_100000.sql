-- Labwork 3 - MySQL employees database
USE employees;

-- 10. Employees who have ever earned more than 100000.
SELECT DISTINCT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE s.salary > 100000;

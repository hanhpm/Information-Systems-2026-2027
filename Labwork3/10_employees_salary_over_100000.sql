-- Labwork 3 - MySQL employees database
USE employees;

-- 10. Employees who have ever earned more than 100000.
SELECT DISTINCT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) full_name
FROM employees
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE salaries.salary > 100000;

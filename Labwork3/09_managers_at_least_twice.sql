-- Labwork 3 - MySQL employees database
USE employees;

-- 9. Managers appointed to at least two different departments.
SELECT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) full_name
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
GROUP BY employees.emp_no, employees.first_name, employees.last_name
HAVING COUNT(DISTINCT dept_manager.dept_no) >= 2;

-- Labwork 3 - MySQL employees database
USE employees;

-- 5. Employees in Sales.
SELECT DISTINCT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) full_name
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales';

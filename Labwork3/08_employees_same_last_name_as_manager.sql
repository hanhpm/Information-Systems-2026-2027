-- Labwork 3 - MySQL employees database
USE employees;

-- 8. Employees sharing a last name with a manager of their department.
SELECT employees.first_name, employees.last_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN dept_manager ON dept_emp.dept_no = dept_manager.dept_no
JOIN employees AS managers ON dept_manager.emp_no = managers.emp_no
WHERE employees.last_name = managers.last_name;
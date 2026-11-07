-- Labwork 3 - MySQL employees database
USE employees;

-- 6. Male employees in Finance.
SELECT DISTINCT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) full_name
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE employees.gender = 'M' AND departments.dept_name = 'Finance';

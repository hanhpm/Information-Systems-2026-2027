-- Labwork 3 - MySQL employees database
USE employees;

-- 6. Male employees in Finance.
SELECT DISTINCT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE e.gender = 'M' AND d.dept_name = 'Finance';

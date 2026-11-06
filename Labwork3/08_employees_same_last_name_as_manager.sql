-- Labwork 3 - MySQL employees database
USE employees;

-- 8. Employees sharing a last name with a manager of their department.
SELECT DISTINCT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN dept_manager AS dm ON dm.dept_no = de.dept_no
JOIN employees AS m ON m.emp_no = dm.emp_no
WHERE e.last_name = m.last_name AND e.emp_no <> m.emp_no
  AND de.from_date <= dm.to_date AND de.to_date >= dm.from_date;

-- Labwork 3 - MySQL employees database
USE employees;

-- 9. Managers appointed to at least two different departments.
SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name
HAVING COUNT(DISTINCT dm.dept_no) >= 2;

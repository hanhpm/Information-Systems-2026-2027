-- Labwork 3 - MySQL employees database
USE employees;

-- 11. Departments employing someone while they earned more than 100000.
SELECT DISTINCT d.dept_no, d.dept_name
FROM departments AS d
JOIN dept_emp AS de ON de.dept_no = d.dept_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE s.salary > 100000
  AND s.from_date <= de.to_date AND s.to_date >= de.from_date;

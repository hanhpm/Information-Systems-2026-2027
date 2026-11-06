-- Labwork 3 - MySQL employees database
USE employees;

-- 7. Salary records of female employees in Marketing.
SELECT e.emp_no, s.salary, s.from_date, s.to_date
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE e.gender = 'F' AND d.dept_name = 'Marketing'
  AND s.from_date <= de.to_date AND s.to_date >= de.from_date;

USE employees;

-- 1. Employees whose first and last names match a Finance manager.
SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
WHERE (e.first_name, e.last_name) IN (
    SELECT m.first_name, m.last_name
    FROM employees AS m
    JOIN dept_manager AS dm ON dm.emp_no = m.emp_no
    JOIN departments AS d ON d.dept_no = dm.dept_no
    WHERE d.dept_name = 'Finance'
);

-- 2. Production employees hired after its most recently appointed manager.
SELECT DISTINCT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name,
       e.hire_date
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Production'
  AND e.hire_date > (
      SELECT MAX(dm.from_date)
      FROM dept_manager AS dm
      JOIN departments AS manager_dept ON manager_dept.dept_no = dm.dept_no
      WHERE manager_dept.dept_name = 'Production'
  );

-- 3. Average salary by department, highest first.
SELECT dept_name, avg_salary
FROM (
    SELECT d.dept_name, ROUND(AVG(s.salary), 2) AS avg_salary
    FROM departments AS d
    JOIN dept_emp AS de ON de.dept_no = d.dept_no
    JOIN salaries AS s ON s.emp_no = de.emp_no
        AND s.from_date <= de.to_date AND s.to_date >= de.from_date
    GROUP BY d.dept_no, d.dept_name
) AS department_averages
ORDER BY avg_salary DESC;

-- 4. Average salary by Engineer title, highest first.
SELECT title, avg_salary
FROM (
    SELECT t.title, ROUND(AVG(s.salary), 2) AS avg_salary
    FROM titles AS t
    JOIN salaries AS s ON s.emp_no = t.emp_no
        AND s.from_date <= COALESCE(t.to_date, '9999-01-01')
        AND s.to_date >= t.from_date
    WHERE t.title LIKE '%Engineer%'
    GROUP BY t.title
) AS engineer_averages
ORDER BY avg_salary DESC;

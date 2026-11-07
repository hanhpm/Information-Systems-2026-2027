USE employees;

-- 1. Employees whose first and last names match a Finance manager.
CREATE OR REPLACE VIEW lab4c_finance_manager_names AS
SELECT m.first_name, m.last_name
FROM employees AS m
JOIN dept_manager AS dm ON dm.emp_no = m.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE d.dept_name = 'Finance';

SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
WHERE (e.first_name, e.last_name) IN (
    SELECT first_name, last_name
    FROM lab4c_finance_manager_names
);

-- 2. Production employees hired after its most recently appointed manager.
CREATE OR REPLACE VIEW lab4c_production_last_manager AS
SELECT MAX(dm.from_date) AS promotion_date
FROM dept_manager AS dm
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE d.dept_name = 'Production';

SELECT DISTINCT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name,
       e.hire_date
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN lab4c_production_last_manager AS lm ON e.hire_date > lm.promotion_date
WHERE d.dept_name = 'Production';

-- 3. Average salary of each department, highest first.
-- A salary record counts when its dates overlap the department assignment.
CREATE OR REPLACE VIEW lab4c_department_average_salary AS
SELECT d.dept_no, d.dept_name, ROUND(AVG(s.salary), 2) AS avg_salary
FROM departments AS d
JOIN dept_emp AS de ON de.dept_no = d.dept_no
JOIN salaries AS s ON s.emp_no = de.emp_no
    AND s.from_date <= de.to_date
    AND s.to_date >= de.from_date
GROUP BY d.dept_no, d.dept_name;

SELECT dept_no, dept_name, avg_salary
FROM lab4c_department_average_salary
ORDER BY avg_salary DESC;

-- 4. Average salary of each Engineer title, highest first.
-- A salary record counts when its dates overlap the title period.
CREATE OR REPLACE VIEW lab4c_engineer_average_salary AS
SELECT t.title, ROUND(AVG(s.salary), 2) AS avg_salary
FROM titles AS t
JOIN salaries AS s ON s.emp_no = t.emp_no
    AND s.from_date <= COALESCE(t.to_date, '9999-01-01')
    AND s.to_date >= t.from_date
WHERE t.title LIKE '%Engineer%'
GROUP BY t.title;

SELECT title, avg_salary
FROM lab4c_engineer_average_salary
ORDER BY avg_salary DESC;

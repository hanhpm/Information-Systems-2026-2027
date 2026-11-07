USE employees;

-- 1. Employees whose first and last names match a Finance manager.
SELECT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) full_name
FROM employees
WHERE (employees.first_name, employees.last_name) IN (
    SELECT finance_manager.first_name, finance_manager.last_name
    FROM employees finance_manager
    JOIN dept_manager ON dept_manager.emp_no = finance_manager.emp_no
    JOIN departments ON departments.dept_no = dept_manager.dept_no
    WHERE departments.dept_name = 'Finance'
);

-- 2. Production employees hired after its most recently appointed manager.
SELECT DISTINCT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) full_name,
       employees.hire_date
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Production'
  AND employees.hire_date > (
      SELECT MAX(dept_manager.from_date)
      FROM dept_manager
      JOIN departments manager_department ON manager_department.dept_no = dept_manager.dept_no
      WHERE manager_department.dept_name = 'Production'
  );

-- 3. Average salary by department, highest first.
SELECT departments.dept_name, ROUND(AVG(salaries.salary), 2) avg_salary
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON salaries.emp_no = dept_emp.emp_no
    AND salaries.from_date <= dept_emp.to_date
    AND salaries.to_date >= dept_emp.from_date
GROUP BY departments.dept_no, departments.dept_name
ORDER BY avg_salary DESC;

-- 4. Average salary by Engineer title, highest first.
SELECT titles.title, ROUND(AVG(salaries.salary), 2) avg_salary
FROM titles
JOIN salaries ON salaries.emp_no = titles.emp_no
    AND salaries.from_date <= COALESCE(titles.to_date, '9999-01-01')
    AND salaries.to_date >= titles.from_date
WHERE titles.title LIKE '%Engineer%'
GROUP BY titles.title
ORDER BY avg_salary DESC;

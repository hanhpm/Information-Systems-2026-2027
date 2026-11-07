-- Labwork 3 - MySQL employees database
USE employees;

-- 11. Departments employing someone while they earned more than 100000.
SELECT DISTINCT departments.dept_no, departments.dept_name
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON salaries.emp_no = dept_emp.emp_no
WHERE salaries.salary > 100000
  AND salaries.from_date <= dept_emp.to_date AND salaries.to_date >= dept_emp.from_date;

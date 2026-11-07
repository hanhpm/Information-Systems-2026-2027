-- Labwork 3 - MySQL employees database
USE employees;

-- 7. Salary records of female employees in Marketing.
SELECT employees.emp_no, salaries.salary, salaries.from_date, salaries.to_date
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE employees.gender = 'F' AND departments.dept_name = 'Marketing'
  AND salaries.from_date <= dept_emp.to_date AND salaries.to_date >= dept_emp.from_date;

-- Labwork 3 - MySQL employees database
USE employees;

-- 7. Salary records of female employees in Marketing.
SELECT salaries.salary, employees.gender
FROM salaries
JOIN employees ON salaries.emp_no = employees.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE employees.gender = "F" AND departments.dept_name = "Marketing";

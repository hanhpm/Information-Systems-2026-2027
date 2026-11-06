USE employees;

-- what is the avg salary of each employee?
SELECT emp_no, ROUND(AVG(salary), 2) AS avg_salary 
FROM salaries 
GROUP BY emp_no;

-- how much was each employee paid in total?
SELECT emp_no, SUM(salary) as total_salary 
FROM salaries 
GROUP BY emp_no;

-- minimum, maximum and total salaries of each department?
SELECT dept_emp.dept_no, MIN(salaries.salary) AS min_salary, MAX(salaries.salary) AS max_salary, SUM(salaries.salary) AS sum_salary
FROM dept_emp 
JOIN salaries ON dept_emp.emp_no = salaries.emp_no 
GROUP BY dept_emp.dept_no;

-- Which departments have paid more than 20 billion dollars for their employees?
SELECT dept_emp.dept_no , SUM(salaries.salary) as total_salaries 
FROM dept_emp 
JOIN salaries ON dept_emp.emp_no = salaries.emp_no 
GROUP BY dept_emp.dept_no 
HAVING total_salaries > 20000000000;

-- Total salaries of male employees in each department?
SELECT dept_emp.dept_no, SUM(salaries.salary) as total_salary
FROM dept_emp 
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE employees.gender='M'
GROUP BY dept_emp.dept_no;

-- Total salaries of department managers for each department,from highest to lowest?
SELECT dept_no, SUM(salaries.salary) AS total_salary
FROM dept_manager
JOIN salaries ON dept_manager.emp_no = salaries.emp_no
GROUP BY dept_no
ORDER BY total_salary DESC;





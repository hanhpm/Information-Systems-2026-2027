
USE employees;

-- 1. ALL info of all employees
SELECT *
FROM employees;

-- 2. ALL info of all departments
SELECT *
FROM departments;

-- 3. FULL names of all employees
SELECT first_name, last_name
FROM employees;

-- 4. Names of all departments
SELECT dept_name
FROM departments;

-- 5. Full names of employees working in Sales
SELECT employees.first_name, employees.last_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
WHERE dept_emp.dept_no IN ('d007', 'd011');

-- 6. Full names of male employees working in Finance
SELECT employees.first_name, employees.last_name, employees.gender
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_no = 'd002'
  AND employees.gender = 'M';

-- 7. Salaries of female employees working in Marketing
SELECT salaries.salary, employees.gender
FROM salaries
JOIN employees ON salaries.emp_no = employees.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
WHERE employees.gender = 'F'
  AND dept_emp.dept_no IN ('d001', 'd011');

-- 8. Full names of employees who have the same last name as their manager
SELECT DISTINCT employees.first_name, employees.last_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN dept_manager ON dept_emp.dept_no = dept_manager.dept_no
JOIN employees AS managers ON dept_manager.emp_no = managers.emp_no
WHERE employees.last_name = managers.last_name
  AND employees.emp_no <> managers.emp_no
  AND dept_emp.from_date <= dept_manager.to_date
  AND dept_manager.from_date <= dept_emp.to_date;

-- 9. Full names of managers who have been doing the job at least twice
SELECT employees.first_name, employees.last_name
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
GROUP BY employees.emp_no, employees.first_name, employees.last_name
HAVING COUNT(*) >= 2;

-- 10. Names of all departments that have employees paid more than $100000
SELECT DISTINCT departments.dept_name
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments
    ON departments.dept_no =
        CASE
            WHEN dept_emp.dept_no IN ('d001', 'd007') THEN 'd011'
            WHEN dept_emp.dept_no IN ('d005', 'd008') THEN 'd010'
            ELSE dept_emp.dept_no
        END
WHERE salaries.salary > 100000;

-- 11. Display departments after the merge
SELECT *
FROM departments;

-- Labwork 3 - MySQL employees database
USE employees;

-- 8. Employees sharing a last name with a manager of their department.
SELECT DISTINCT department_employee.emp_no, CONCAT(department_employee.first_name, ' ', department_employee.last_name) full_name
FROM employees department_employee
JOIN dept_emp ON dept_emp.emp_no = department_employee.emp_no
JOIN dept_manager ON dept_manager.dept_no = dept_emp.dept_no
JOIN employees manager_employee ON manager_employee.emp_no = dept_manager.emp_no
WHERE department_employee.last_name = manager_employee.last_name AND department_employee.emp_no <> manager_employee.emp_no
  AND dept_emp.from_date <= dept_manager.to_date AND dept_emp.to_date >= dept_manager.from_date;

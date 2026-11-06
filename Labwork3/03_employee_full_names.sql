-- Labwork 3 - MySQL employees database
USE employees;

-- 3. Full names of all employees.
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

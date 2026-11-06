-- Labwork 3 - MySQL employees database
USE employees;

-- 12. Merge departments. Run this section once, after reviewing the SELECTs.
-- Existing assignments in both source departments are combined into one
-- date span because dept_emp/dept_manager allow only one row per employee
-- and department. Keep a backup if separate assignment spells matter.
START TRANSACTION;

INSERT INTO departments (dept_no, dept_name) VALUES
  ('d010', 'Research and Development'),
  ('d011', 'Marketing and Sales');

INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
SELECT emp_no,
       CASE WHEN dept_no IN ('d005', 'd008') THEN 'd010' ELSE 'd011' END,
       MIN(from_date), MAX(to_date)
FROM dept_emp
WHERE dept_no IN ('d005', 'd008', 'd001', 'd007')
GROUP BY emp_no, CASE WHEN dept_no IN ('d005', 'd008') THEN 'd010' ELSE 'd011' END
ON DUPLICATE KEY UPDATE
  from_date = LEAST(dept_emp.from_date, VALUES(from_date)),
  to_date = GREATEST(dept_emp.to_date, VALUES(to_date));

INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date)
SELECT emp_no,
       CASE WHEN dept_no IN ('d005', 'd008') THEN 'd010' ELSE 'd011' END,
       MIN(from_date), MAX(to_date)
FROM dept_manager
WHERE dept_no IN ('d005', 'd008', 'd001', 'd007')
GROUP BY emp_no, CASE WHEN dept_no IN ('d005', 'd008') THEN 'd010' ELSE 'd011' END
ON DUPLICATE KEY UPDATE
  from_date = LEAST(dept_manager.from_date, VALUES(from_date)),
  to_date = GREATEST(dept_manager.to_date, VALUES(to_date));

DELETE FROM departments WHERE dept_no IN ('d005', 'd008', 'd001', 'd007');
COMMIT;

SELECT dept_no, dept_name FROM departments WHERE dept_no IN ('d010', 'd011');

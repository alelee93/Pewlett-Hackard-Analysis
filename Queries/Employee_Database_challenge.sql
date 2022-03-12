
-- ****************************************** 
-- CHALLENGE 1
-- ****************************************** 


-- (1) CREATE A RETIREMENT TITELS TABLE 
SELECT ti.emp_no, em.first_name, em.last_name, ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees AS em
JOIN titles as ti on em.emp_no = ti.emp_no
WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY em.emp_no;


-- ****************************************** 
-- (2) CREATE UNIQUE TITLES TABLE 

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;


-- ****************************************** 
-- (3) CREATE A RETIRING TITLES TABLE 
-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT count(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- View reiring_titles table
SELECT * from retiring_titles;


 
-- ******************************************
-- CHALLENGE 2
-- ****************************************** 

SELECT DISTINCT ON (emp_no) em.emp_no, 
em.first_name, 
em.last_name, 
em.birth_date, 
de.from_date, 
de.to_date, 
ti.title
INTO mentorship_eligibility
FROM employees AS em
JOIN dept_emp AS de ON em.emp_no = de.emp_no
JOIN titles AS ti ON em.emp_no = ti.emp_no
WHERE de.to_date = '9999-01-01'
AND em.birth_date BETWEEN '01-01-1965' AND '12-31-1965'
ORDER BY em.emp_no

SELECT * from mentorship_eligibility

-- **** EXTRA FOR Analysis

--Create table with current employees
SELECT DISTINCT ON (titles.emp_no) dept_emp.emp_no, 
	dept_emp.dept_no, dept_emp.from_date AS "hire_date", 
	dept_emp.to_date, 
	titles.title
INTO active_employees_by_title
FROM dept_emp
JOIN titles ON dept_emp.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01'
ORDER BY titles.emp_no, titles.to_date DESC

-- look at currently employees by title
SELECT COUNT(emp_no) as "# of Current Employees", title
from active_employees_by_title
GROUP BY title
ORDER BY "# of Current Employees" DESC


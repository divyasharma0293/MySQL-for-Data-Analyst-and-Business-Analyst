/*Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. */
SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no;
    

/*Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
See if the output contains a manager with that name.  
‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.*/
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY dept_no DESC , e.emp_no;


/*Extract a list containing information about all managers’ employee number, first and last name, 
department number, and hire date. Use the old type of join syntax to obtain the result.*/
SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
    employees e,
    dept_manager dm
WHERE
    e.emp_no = dm.emp_no
ORDER BY dept_no DESC , emp_no;


/*Select the first and last name, the hire date, 
and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.*/
SELECT 
    first_name, last_name, hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON t.emp_no = e.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch';


/*cross join with Department Manager and Departments to see possible combination*/
SELECT 
    dm.emp_no, d.dept_name
FROM
    departments d
        CROSS JOIN
    dept_manager dm
ORDER BY dm.emp_no , d.dept_no;


/*cross join with Department Manager and Departments to see possible combination
but except for the department he/she already in*/
SELECT 
    dm.emp_no, d.dept_name, dm.dept_no
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    dm.dept_no <> d.dept_no;


/*Use a CROSS JOIN to return a list with all possible combinations between managers 
from the dept_manager table and department number 9.*/
SELECT 
    *
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    dm.dept_no = 'd009';
    

/*Return a list with the first 10 employees with all the departments they can be assigned to.
Hint: Don’t use LIMIT; use a WHERE clause.*/
SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no <= '10010'
ORDER BY e.emp_no , d.dept_name;


/*Select all managers’ first and last name, hire date, job title, start date, and department name.*/
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    dept_manager dm
        JOIN
    titles t ON t.emp_no = dm.emp_no
        JOIN
    departments d ON d.dept_no = dm.dept_no
        JOIN
    employees e ON t.emp_no = e.emp_no
WHERE
    title = 'Manager'
ORDER BY e.emp_no;


/*How many male and how many female managers do we have in the ‘employees’ database?*/
SELECT 
    e.gender, COUNT(e.gender) AS total
FROM
    employees e
        JOIN
    titles t ON t.emp_no = e.emp_no
WHERE
    title = 'Manager'
GROUP BY e.gender;


/*Average salary of employees by each department */
SELECT 
    d.dept_name, AVG(s.salary)
FROM
    departments d
        JOIN
    dept_emp de ON de.dept_no = d.dept_no
        JOIN
    salaries s ON s.emp_no = de.emp_no
GROUP BY d.dept_no;

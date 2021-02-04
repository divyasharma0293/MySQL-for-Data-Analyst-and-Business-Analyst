/*************************************************/
/*        MySQL CASE                             */
/*************************************************/

/*Technique 1*/
SELECT 
    first_name,
    last_name,
    emp_no,
    CASE
        WHEN gender = 'F' THEN 'Female'
        ELSE 'Male'
    END AS gender
FROM
    employees;
 
/*Technique 2*/
SELECT 
    emp_no,
    first_name,
    last_name,
    CASE gender
        WHEN 'F' THEN 'Female'
        ELSE 'Male'
    END AS gender
FROM
    employees;

/*-------------------------------------*/

SELECT 
    emp_no,
    first_name,
    last_name,
    IF(gender = 'F', 'Female', 'Male') AS genders
FROM
    employees;


/******************************************************/

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Regular Employee'
    END AS manager_or_employee
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;


/*Extract a dataset containing the following information: 
employee number, first name, and last name. Add two columns at the end – 
one showing the difference between the maximum and minimum salary of that employee, and another one saying 
whether this salary raise was higher than $30,000 or NOT.
If possible, provide more than one solution.*/
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    (MAX(s.salary) - MIN(s.salary)) AS difference,
    CASE
        WHEN (MAX(s.salary) - MIN(s.salary)) > 30000 THEN 'Yes'
        ELSE 'No'
    END AS salary_raise
FROM
    employees e
        JOIN
    salaries s ON s.emp_no = e.emp_no
GROUP BY e.emp_no
ORDER BY e.emp_no;

/*Using IF*/
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    (MAX(s.salary) - MIN(s.salary)) AS salary_difference,
    IF((MAX(s.salary) - MIN(s.salary)) > 30000,
        'Yes',
        'No') AS salary_raise
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no
ORDER BY 1;


/*Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column,
 called “current_employee” saying “Is still employed” if the employee is still working in the company, or 
 “Not an employee anymore” if they aren’t.
Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. */
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > CURDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS 'current_employee'
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY e.emp_no;

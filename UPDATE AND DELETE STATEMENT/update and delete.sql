/*COMMIT AND ROLL BACK */

-- for testing purpose, disable autocommit
SET autocommit = 0;
SELECT 
    *
FROM
    employees
WHERE
    emp_no = '999903';

UPDATE employees 
SET 
    first_name = 'Stella',
    gender = 'M'
WHERE
    emp_no = '999903';

ROLLBACK;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = '999903';

UPDATE employees 
SET 
    first_name = 'Sally'
WHERE
    emp_no = '999903';

COMMIT;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = '999903';

ROLLBACK;


-- now the changes are aready commmited, it cannot be rollback

SELECT 
    *
FROM
    employees
WHERE
    emp_no = '999903';
SET autocommit = 1;

/*------------------------------------------------------------------*/

/*Change the “Business Analysis” department name to “Data Analysis”.
Hint: To solve this exercise, use the “departments” table.*/
insert into departments values('d010','Business Analysis');

SELECT 
    *
FROM
    departments;

commit;

UPDATE departments 
SET 
    dept_name = 'Data Analysis'
WHERE
    dept_no = 'd010';

SELECT 
    *
FROM
    departments;

/*Remove the department number 10 record from the “departments” table.*/
DELETE FROM departments 
WHERE
    dept_no = 'd010';

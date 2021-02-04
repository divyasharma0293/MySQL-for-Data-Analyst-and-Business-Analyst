/* There can be multiple entries for an employee who has changed to different departments*/
SELECT 
    emp_no, from_date, to_date, COUNT(emp_no)
FROM
    dept_emp
GROUP BY emp_no
HAVING COUNT(emp_no) > 1;


/*get the latest department info of the employee using VIEW*/
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no,
        MAX(from_date) AS latest_from_date,
        MAX(to_date) AS latest_to_date
    FROM
        dept_emp
    GROUP BY emp_no;

SELECT 
    *
FROM
    v_dept_emp_latest_date;
    

/*Create a view that will extract the average salary of all managers registered in the database. 
Round this value to the nearest cent.
you should obtain the value of 67047.29.*/
CREATE OR REPLACE VIEW v_Average_salary_managers AS
    SELECT 
        ROUND(AVG(s.salary), 2) AS average_salary
    FROM
        dept_manager dm
            JOIN
        salaries s ON dm.emp_no = s.emp_no;

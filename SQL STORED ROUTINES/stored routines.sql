/*************************************************/
/*                STORED ROUTINES                */
/*************************************************/

/* -----------------------------------------------------*/
/*           select all employees limit 100             */
/* -----------------------------------------------------*/
DROP PROCEDURE IF EXISTS select_employees;
delimiter $$
create procedure first_100_emp() 
begin
SELECT 
    *
FROM
    employees
LIMIT 100;

end $$
delimiter ;


/* -----------------------------------------------------*/
/*           Avarage salary of all employees            */
/* -----------------------------------------------------*/
delimiter $$
create procedure average_salary()
begin
select avg(salary) from salaries;

end $$
delimiter ;


/* -----------------------------------------------------*/
/*         Store Procedure with INPUT parameter         */
/* Select employee salary by specific employee number   */
/* -----------------------------------------------------*/
delimiter $$
create procedure emp_spec_salary(
in employee_no int )
begin 
select e.emp_no, e.first_name, e.last_name, s.salary, s.from_date, s.to_date
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no = employee_no;

end $$
delimiter ;


/* -----------------------------------------------------*/
/*         Store Procedure with INPUT parameter         */
/*         Average Salary of employee by emp_no         */
/* -----------------------------------------------------*/
delimiter $$
create procedure avg_salary_per_emp(
in emp_number int)
begin
	SELECT 
		e.emp_no,
		e.first_name,
		e.last_name,
		AVG(s.salary) AS average_salary
	FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE
		emp_number = e.emp_no
	GROUP BY e.emp_no;

end $$
delimiter ;


/* -----------------------------------------------------*/
/*   Store Procedure with INPUT and OUTPUT parameter    */
/*         Average Salary of employee by emp_no         */
/* -----------------------------------------------------*/
delimiter $$
create procedure avg_salary_per_employee(
in emp_number int,
out salary_avg decimal(10,2))
begin
SELECT 
    AVG(s.salary)
INTO salary_avg FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    emp_number = e.emp_no
GROUP BY e.emp_no;

end $$
delimiter ;


/* ----------------------------------------------------------------------------------*/
/*  Create a procedure called ‘emp_info’ that uses as parameters                     */
/* the first and the last name of an individual, and returns their employee number.  */
/* ----------------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS emp_info;
delimiter $$

CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(250), p_last_name VARCHAR(250), OUT p_emp_no INTEGER)
BEGIN 
	SELECT e.emp_no
		INTO p_emp_no 
	FROM employees e
	WHERE e.first_name = p_first_name AND e.last_name = p_last_name
	LIMIT 1;
END $$
delimiter ;

SELECT 
    *
FROM
    employees;

/* -------------------------------------------------------------*/
SELECT F_AVG_SAL(10001);






/* -------------------------------------------------------------*/
/*                   User Defined Functions                     */
/* -------------------------------------------------------------*/

/*Syntax*/ 
/*
DELIMITER $$
CREATE FUNCTION function_name(parameter data_type) RETURNS data_type
BEGIN
	DECLARE variable_name data_type;
		SELECT ......
	RETURN variable_name;
END $$
DELIMITER ;
*/

/* -------------------------------------------------------------*/
/*    Average salary of an employee by emp_no                   */
/* -------------------------------------------------------------*/
DROP FUNCTION IF EXISTS f_avg_sal;
delimiter $$
create function f_avg_sal(emp_no int) returns decimal(10,2)
deterministic
begin
	declare v_avg_salary decimal(10,2);
		SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = emp_no
GROUP BY e.emp_no;
    return v_avg_salary;
end $$
delimiter ;


/* ----------------------------------------------------------------------------------------------------------*/
/*    Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee,  */
/*and returns the salary from the newest contract of that employee.                                          */
/* ----------------------------------------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS emp_info;
delimiter $$
create function emp_info(p_first_name varchar(50), p_last_name varchar(50)) returns decimal(10,2)
deterministic 
begin
	declare v_hire_salary decimal(10,2);
		SELECT 
    s.salary
INTO v_hire_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
ORDER BY s.from_date DESC
LIMIT 1;
	return v_hire_salary;
end $$
delimiter ;


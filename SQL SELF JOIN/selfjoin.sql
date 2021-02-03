/*From emp_manager table, extract the record only for those employees who are manager as well*/
SELECT 
    e.*
FROM
    emp_manager e
        JOIN
    emp_manager em
WHERE
    e.emp_no = em.manager_no
GROUP BY e.emp_no;

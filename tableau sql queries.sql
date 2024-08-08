use employees_mod;

/* Task 1:
Create a visualization that provides a breakdown between the male and female employees working 
in the company each year, starting from 1990
*/
select year(d.from_date) as calander_year, e.gender, count(e.emp_no) as no_of_emp from t_employees e join t_dept_emp d on e.emp_no = d.emp_no 
group by e.gender, calander_year having calander_year >= '1990' order by calander_year;

/* Task 2:
Compare the number of male managers to the number of female managers from different departments
for each year, starting from 1990
*/
select dm.emp_no, d.dept_name, dm.dept_no, dm.from_date, dm.to_date, ee.gender, e.calander_year, 
case when year(dm.to_date)>= e.calander_year and year(dm.from_date) <= e.calander_year then 1 else 0 end as active_or_not from
(select year(hire_date) as calander_year from t_employees group by calander_year) e
cross join t_dept_manager dm join t_departments d on dm.dept_no = d.dept_no join t_employees ee on dm.emp_no = ee.emp_no 
 order by dm.emp_no,calander_year;

/* Task 3:
Compare the average salary of female versus male employees in the entire company until year 2002,
and add a filter allowing you to see that per each department.
*/
select e.gender, d.dept_name, round(avg(s.salary), 2) as avg_salary, year(s.from_date) as calander_year
from t_employees e join t_salaries s on e.emp_no = s.emp_no 
join t_dept_emp dp on s.emp_no = dp.emp_no
join t_departments d on dp.dept_no = d.dept_no
group by e.gender, d.dept_no, calander_year having calander_year <= '2002' order by calander_year, d.dept_no;

/* Task 4:
Create an SQL stored procedure that will allow you to obtain the average male and female salary per department
within a certain salary range. Let this range be defined by two values the user can insert when calling the procedure.
*/

drop PROCEDURE if EXISTS filter_salary;

delimiter $$
create procedure filter_salary ( in mim_filter float, in max_filter float)
begin
select d.dept_name, e.gender, round(avg(s.salary), 2) as salary
from t_salaries s join t_employees e on s.emp_no = e.emp_no
join t_dept_emp dp on dp.emp_no = s.emp_no
join t_departments d on dp.dept_no = d.dept_no
where s.salary between mim_filter and max_filter group by e.gender, dp.dept_no;
end$$
delimiter ;  
call filter_salary (50000, 90000);
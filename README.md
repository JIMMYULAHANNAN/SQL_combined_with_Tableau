The provided SQL queries are designed to analyze employee data in the "employees_mod" database, with the results visualized using Tableau. Here’s a breakdown of each query:

### Task 1: Gender Breakdown of Employees by Year (Starting from 1990)
- **Objective:** Visualize the number of male and female employees working in the company each year, starting from 1990.
- **Explanation:** 
  - The query joins the `t_employees` table with the `t_dept_emp` table using the employee number (`emp_no`).
  - It uses the `year(d.from_date)` function to extract the year from the `from_date` field and labels it as `calendar_year`.
  - The data is grouped by gender (`e.gender`) and calendar year (`calander_year`), with the count of employees per group using `count(e.emp_no)`.
  - A `HAVING` clause filters results for years starting from 1990.
  - The `ORDER BY` clause orders the results by calendar year.
  - The output gives a year-by-year breakdown of male and female employees.

### Task 2: Comparison of Male and Female Managers by Department and Year
- **Objective:** Compare the number of male and female managers in different departments for each year, starting from 1990.
- **Explanation:**
  - The query cross-joins a subquery that generates a list of years from the `t_employees` table.
  - It then joins the `t_dept_manager` table (which contains department managers) with the `t_employees` and `t_departments` tables to access employee details and department names.
  - A `CASE` statement checks whether the manager was active in the specific year, based on their start and end dates (`from_date` and `to_date`).
  - The query counts how many male and female managers were active in each department for each year.
  - The result shows the number of active male and female managers for each department across different years.

### Task 3: Average Salary Comparison Between Male and Female Employees (Up to 2002)
- **Objective:** Compare the average salary of male versus female employees until the year 2002, with a filter to see data per department.
- **Explanation:**
  - The query joins the `t_employees`, `t_salaries`, `t_dept_emp`, and `t_departments` tables.
  - It groups the data by gender, department, and year, calculating the average salary (`round(avg(s.salary), 2)`).
  - The `HAVING` clause filters the results for years less than or equal to 2002.
  - The result shows the average salary for male and female employees in each department per year up until 2002.

### Task 4: Stored Procedure for Average Salary by Gender and Salary Range
- **Objective:** Create a stored procedure to obtain the average salary by gender within a specified salary range for each department.
- **Explanation:**
  - The stored procedure, `filter_salary`, accepts two input parameters: `mim_filter` (minimum salary) and `max_filter` (maximum salary).
  - The procedure joins the `t_salaries`, `t_employees`, `t_dept_emp`, and `t_departments` tables to access salary and department data.
  - It filters the results to show only salaries between the provided range (`s.salary BETWEEN mim_filter AND max_filter`).
  - The result groups the data by gender and department, calculating the average salary (`round(avg(s.salary), 2)`).
  - The procedure can be called with specific salary ranges (e.g., `call filter_salary(50000, 90000);`) to get the desired output.

### Visualization in Tableau:
- (https://public.tableau.com/app/profile/jimmy.ulahannan/viz/MySampleDashboard_17163056652720/Dashboard1)

These SQL queries provide valuable insights into employee data, such as gender diversity, managerial distribution, salary comparison, and customized salary analysis for different departments.

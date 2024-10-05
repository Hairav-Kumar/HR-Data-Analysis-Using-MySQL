
-- Q1 What is the average salary of employees in each department?
select department,round(avg(salary),0) as average_salary from employees group by department;

-- Q2 Rank the employees by salary within each department?
select department, first_name, last_name, salary, rank() over(partition by department order by salary desc)  AS salary_rank from employees;

-- Q3 Find the number of employees hired in each year?
select year(hire_date) as hire_year,count(employee_id) as no_of_employee from employees group by hire_year;

-- Q4 Which departments have more than 3 employees?
select department,count(*) as number_of_emp from employees group by department having count(*) >3;

-- Q5 Which employee has the highest performance rating in the IT department?
select first_name,last_name from employees where department = "IT" order by performance_rating desc limit 1;

-- Q6 List the employees who have more than 10 years of experience and earn more than $80,000?
select first_name,last_name from employees where years_of_experience >10 and salary > 80000;

-- Q7 Find the average salary of employees by gender?
select gender,round(avg(salary),0) as average_Salary from employees group by gender;

-- Q8 Which employees have been hired in the last 2 years?
select first_name,last_name from employees where hire_date > date_sub(curdate(),interval 2 year);

-- Q9 Find the employee(s) with the highest salary in each department?
select first_name,last_name,department from employees as e1 where salary = (select max(e2.salary) from employees as e2 where e2.department =e1.department) order by 
department;
-- or 
with cte as(select *,dense_rank() over(partition by department order by salary desc) as rnk from  employees)
select first_name,last_name,department from cte where rnk =1 order by department;

-- Q10 Calculate the total salary expenditure by department?
select department,round(sum(salary),0) AS total_salary from employees group by department;

-- Q11 Find the employees who earn more than the average salary of their department?
select first_name,last_name,salary from employees as e1 where salary >(select avg(e2.salary) from employees 
as e2 where e2.department = e1.department);

-- Q12 List the top 3 highest paid employees across the company?
select first_name,last_name,salary from employees order by salary desc limit 3;

-- Q13 Identify the department with the highest average performance rating?
select department,avg(performance_rating) AS avg_performance from employees group by department order by avg_performance desc limit 1;

-- Q14 Which department has the most employees with a performance rating of 5?
select department,count(*) as high_performers from employees where performance_rating = 5 group by department order by high_performers desc limit 1;

-- Q15 Find the second-highest salary employee for each department?
select first_name,last_name,department,salary from (select *,dense_rank() over(partition by department order by salary desc) 
as sal_rnk from employees) sal where sal_rnk=2;

-- Q16 What is the year-over-year (YoY) growth percentage in hiring for the organization?
with cte as(select year(hire_date) as year, count(*) as no_of_emp,lag(count(*),1,count(*)) over(order by year(hire_date)) as prv_yr from employees group by 1)
select * , round((no_of_emp - prv_yr)*100/prv_yr,1) as YoY_growth_percentage from cte;







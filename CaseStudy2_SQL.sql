
Create database Case_Study_2

use Case_Study_2

Create table LOCATION (
Location_Id Smallint Primary Key,
City Varchar (20)
);


Insert into Location Values 
(122,'New York'),
(123,'Dallas'),
(124,'Chicago'),
(167,'Boston');


Create Table DEPARTMENT(
Department_Id tinyint Primary Key,
Name Varchar(50),
Location_Id smallint
Foreign Key (Location_Id) references Location (Location_id)
);

Insert into Department Values
(10,'Accounting',122),
(20,'Sales',124),
(30,'Research',123),
(40,'Operations',167);

Create Table JOB
(Job_id int Primary Key,
Designation varchar(100));

Insert into Job values
(667,'Clerk'),
(668,'Staff'),
(669,'Analyst'),
(670,'Sales Person'),
(671,'Manager'),
(672,'President');

Create Table EMPLOYEE
(Employee_Id int,
Last_name Varchar(50),
First_name varchar (50),
Middle_name Varchar(50),
Job_id int Foreign key (Job_id)References Job(Job_Id),
Hire_Date date,
Salary Int,
Comm int,
Department_Id tinyint Foreign Key (Department_Id) References Department (Department_Id),
)


Insert into EMPLOYEE values
(7369,'Smith','John','Q',667,'1984-12-17',800,Null,20),
(7499,'Allen','Kevin','J',670,'1985-02-20',1600,300,30),
(755,'Doyle','Jean','K',671,'1985-04-04',2850,Null,30),
(756,'Dennis','Lynn','S',671,'1985-05-15',2750,Null,30),
(757,'Baker','Leslie','D',671,'1985-06-10',2200,Null,40),
(7521,'Wark','Cynthia','D',670,'1985-02-22',1250,50,30);
					


--Simple Queries:
--1. List all the employee details.

Select * from EMPLOYEE

--2. List all the department details.

Select * from DEPARTMENT

--3. List all job details.

Select * from Job

--4. List all the locations.

Select * from location

--5. List out the First Name, Last Name, Salary, Commission for all Employees.

select First_Name, Last_Name, Salary, Comm from EMPLOYEE

--6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".

Select Employee_ID as 'ID of the Employee',Last_Name as 'Name of the Employee',Department_ID as 'Dep_id' from EMPLOYEE

--7. List out the annual salary of the employees with their names only.

Select First_Name,Middle_name, Last_Name, Salary*12 as 'Annual Salary' from Employee 

--WHERE Condition:


--1. List the details about "Smith".
Select * from Employee where Last_name = 'Smith'

--2. List out the employees who are working in department 20.
Select * from Employee where Department_Id=20

--3. List out the employees who are earning salary between 2000 and 3000.
Select * from Employee where Salary >=2000 and Salary<=3000

--4. List out the employees who are working in department 10 or 20.

Select * from Employee where Department_Id=20 or Department_Id=10

--5. Find out the employees who are not working in department 10 or 30.

Select * from Employee where Department_Id <> 10 and Department_Id <> 30

--6. List out the employees whose name starts with 'L'.

Select * from Employee where First_Name like 'L%' 

--7. List out the employees whose name starts with 'L' and ends with 'E'.

Select * from Employee where First_name like 'L%E'

--8. List out the employees whose name length is 4 and start with 'J'.

Select * from Employee where First_name like 'J___'

--9. List out the employees who are working in department 30 and draw the salaries more than 2500.
Select * from Employee where department_Id = 30 and Salary >= 2500


--10. List out the employees who are not receiving commission.
Select * from Employee where Comm Like Null

--ORDER BY Clause:


--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.

Select Employee_ID,Last_Name from Employee order by Employee_Id asc;

--2. List out the Employee ID and Name in descending order based on salary.

Select Employee_ID,Concat (First_name,' ',Middle_name,' ',Last_Name) as Name From Employee order by Salary desc;

--3. List out the employee details according to their Last Name in ascending-order.

Select * from Employee order by Last_name Asc


--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.

Select * from Employee ORDER BY Last_name ASC,Department_Id DESC;

--GROUP BY and HAVING Clause:


--1. List out the department wise maximum salary, minimum salary and average salary of the employees.

Select Department_Id,Max(Salary) as 'Maximum Salary',Min(Salary) as 'Minimum Salary',Avg(Salary) as 'Average Salary'
from Employee
Group by Department_Id


--2. List out the job wise maximum salary, minimum salary and average salary of the employees.

Select Job_id,Max(Salary) as 'Maximum Salary',Min(Salary) as 'Minimum Salary',Avg(Salary) as 'Average Salary'
from Employee
Group by Job_id

--3. List out the number of employees who joined each month in ascending order.

Select Month (Hire_date) as Join_month, count(*) as No_of_employees from employee group by Month (Hire_date) order by Join_month Asc

--4. List out the number of employees for each month and year in ascending order based on the year and month.

Select Year(Hire_date) as Join_year, Month (Hire_date) as Join_month ,count(*) as No_of_employees from employee 
group by Year(Hire_date),Month (Hire_date)
order by Join_year Asc,Join_month Asc;

--5. List out the Department ID having at least four employees.

Select Department_id from employee group by department_id Having Count(Employee_id)>=4;


--6. How many employees joined in February month.

Select Count(*) as No_of_employees from employee where Month(Hire_date) = 2;

--7. How many employees joined in May or June month.

Select Count(*) as No_of_employees from employee where Month(Hire_date) in (5,6);


--8. How many employees joined in 1985?

Select Count(*) as No_of_employees from Employee where Year(Hire_date)='1985';

--9. How many employees joined each month in 1985?

Select Month(Hire_date) as Join_Month,Count(*) as No_of_employees from Employee where Year(Hire_date)='1985' group by Month(Hire_date);


--10. How many employees were joined in April 1985?

Select Count(*) as No_of_employees from Employee where Month(Hire_date) =4  and Year(Hire_date)='1985';

--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?

Select Department_id ,Count(*) as No_of_employees from Employee where Month(Hire_date) =4  and Year(Hire_date)='1985' group by Department_id having Count(*)>=3;

--Joins:


--1. List out employees with their department names.

Select e.*,d.Name as Department_name from Employee e Inner Join Department d on e.Department_id=d.department_Id

--2. Display employees with their designations.

Select e.*, j.Designation from Employee e Inner Join job j on e.job_id=j.Job_id

--3. Display the employees with their department names and city.

Select e.*,d.Name as Department_name,l.city as City from Employee e Inner Join Department d on e.Department_id=d.department_Id Inner Join Location l on d.Location_Id=l.location_id

--4. How many employees are working in different departments? Display with department names.

Select Count(e.Employee_Id) as No_of_employees,d.Name as Department_name from Employee e Inner Join Department d on e.Department_id=d.department_Id group by d.Name


--5. How many employees are working in the sales department?
 
 Select Count(*) as No_of_employees,d.Name as Department_name from Employee e Inner Join Department d on e.Department_id=d.department_Id group by d.Name having D.Name in ('Sales')


--6. Which is the department having greater than or equal to 3 employees and display the department names in ascending order.

Select Count(*) as No_of_employees,d.Name as Department_name from Employee e Inner Join Department d on e.Department_id=d.department_Id group by d.Name having Count(e.Employee_Id)>=3order by D.Name ASC 


--7. How many employees are working in 'Dallas'?

Select Count(*) as 'No_of_employees' from Employee e Inner Join Department d on e.Department_id=d.department_Id Inner Join Location l on d.Location_Id=l.location_id where city = 'Dallas';


--8. Display all employees in sales or operation departments.

Select e.*,D.name as Departnment_name from Employee e Inner Join  Department d on e.department_id=D.department_id where D.name in ('sales','Operations');


--CONDITIONAL STATEMENT


--1. Display the employee details with salary grades. Use conditional statement to create a grade column.

SELECT *,
CASE 
WHEN SALARY >= 2500 THEN 'A'
WHEN SALARY >= 2000 THEN 'B'
WHEN SALARY >= 1500 THEN 'C'
ELSE 'D' END AS Grade FROM EMPLOYEE;



--2. List out the number of employees grade wise. Use conditional statement to create a grade column.

SELECT CASE 
WHEN SALARY >= 2500 THEN 'A'
WHEN SALARY >= 2000 THEN 'B'
WHEN SALARY >= 1500 THEN 'C'
ELSE 'D' END AS Grade ,
COUNT(*)as No_of_employees from Employee 
Group by Case
WHEN SALARY >= 2500 THEN 'A'
WHEN SALARY >= 2000 THEN 'B'
WHEN SALARY >= 1500 THEN 'C'
ELSE 'D' END;


--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.

SELECT 
CASE 
WHEN SALARY >= 2500 THEN 'A'
WHEN SALARY >= 2000 THEN 'B'
WHEN SALARY >= 1500 THEN 'C'
ELSE 'D'
END AS Grade,
COUNT(*) AS NumEmployees
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000 AND 5000
GROUP BY CASE 
WHEN SALARY >= 2500 THEN 'A'
WHEN SALARY >= 2000 THEN 'B'
WHEN SALARY >= 1500 THEN 'C'
ELSE 'D'
END;


--Subqueries:

--1. Display the employees list who got the maximum salary.

Select * from Employee where Salary= (Select Max(salary) from Employee);

--2. Display the employees who are working in the sales department.

Select * from Employee where Department_Id = (Select Department_Id from Department where Name = 'Sales');

--3. Display the employees who are working as 'Clerk'.

Select * from Employee where Job_id = (Select Job_id from Job where Designation = 'Clerk');

--4. Display the list of employees who are living in 'Boston'.

Select * from Employee where Department_Id in (Select Department_Id from Department where Location_id = (select Location_id from Location where City = 'Boston'));

--5. Find out the number of employees working in the sales department.

Select Count(*) as No_of_employees from Employee where Department_Id = (Select Department_Id from Department where Name = 'Sales');

--6. Update the salaries of employees who are working as clerks on the basis of 10%.
 
 Update Employee 
 Set Salary =Salary*1.1
 where Job_id=(Select job_id from Job where designation = 'Clerk');


--7. Display the second highest salary drawing employee details.

Select Top 1 * from Employee where Salary <(Select Max(Salary) from Employee) order by salary desc;

--8. List out the employees who earn more than every employee in department 30.

Select * from Employee where Salary =(Select Max(salary) from employee where department_id=30);

--9. Find out which department has no employees.

Select * from DEPARTMENT where Department_id not in (select Department_Id from employee);

--10. Find out the employees who earn greater than the average salary for their department.

Select * from Employee e where Salary > (Select Avg(Salary) from Employee where department_id = e.department_id);



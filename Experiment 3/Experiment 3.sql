create database exp3;

use exp3;

-- Easy Task
-- Generate employee relation with only 1 attribute (  ID )
-- Find the max id but excluding the duplicates

create table employees_tbl(
    e_id int
);

insert into employees_tbl values
(1),
(1),
(2),
(3),
(3),
(4),
(5),
(5),
(6),
(7),
(7);

select max(a.e_id) as max_distinct_id from (select e_id, count(e_id) as id_cnt from employees_tbl group by e_id) as a where a.id_cnt = 1;



---- Task 2:
-- select product which has not been sold once
-- find the total quantity of sold for each respective product
CREATE TABLE TBL_PRODUCTS
(
	ID INT PRIMARY KEY IDENTITY,
	[NAME] NVARCHAR(50),
	[DESCRIPTION] NVARCHAR(250)
)

CREATE TABLE TBL_PRODUCTSALES
(
	ID INT PRIMARY KEY IDENTITY,
	PRODUCTID INT FOREIGN KEY REFERENCES TBL_PRODUCTS(ID),
	UNITPRICE INT,
	QUALTITYSOLD INT
)

INSERT INTO TBL_PRODUCTS VALUES ('TV','52 INCH BLACK COLOR LCD TV')
INSERT INTO TBL_PRODUCTS VALUES ('LAPTOP','VERY THIIN BLACK COLOR ACER LAPTOP')
INSERT INTO TBL_PRODUCTS VALUES ('DESKTOP','HP HIGH PERFORMANCE DESKTOP')


INSERT INTO TBL_PRODUCTSALES VALUES (3,450,5)
INSERT INTO TBL_PRODUCTSALES VALUES (2,250,7)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,4)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,9)

select * from TBL_PRODUCTS
select * from TBL_PRODUCTSALES
select * from TBL_PRODUCTS where TBL_PRODUCTS.ID not in (select distinct PRODUCTID from TBL_PRODUCTSALES);

select Name, (select SUM(TBL_PRODUCTSALES.QUALTITYSOLD) from TBL_PRODUCTSALES where PRODUCTID = TBL_PRODUCTS.ID) as [PRODUCT SALES] from TBL_PRODUCTS;

--------------------EXPERIMENT 03: (MEDIUM LEVEL)
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);


-- Insert into Department Table
INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

-- Insert into Employee Table
INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

select e.salary, e.name, t.m_salary, t.dept_name  from employee e
    join
        (select e.department_id, d.dept_name, max(e.salary) as m_salary from employee e join department d
        on e.department_id = d.id  group by e.department_id, d.dept_name)
            t on t.department_id = e.department_id and t.m_salary = e.salary;


-- Hard level
create table emp_a_tbl(
    empid int,
    empname varchar(255),
    salary int
);

create table emp_b_tbl(
    empid int,
    empname varchar(255),
    salary int
);
insert into emp_a_tbl values
                          (1, 'AA', 1000),
                          (2, 'BB', 300);

insert into emp_b_tbl values
                          (2, 'BB', 400),
                          (3, 'CC', 100);

select t.empid, min(t.empname), min(t.salary) from (select * from emp_a_tbl union (select * from emp_b_tbl)) t group by t.empid;
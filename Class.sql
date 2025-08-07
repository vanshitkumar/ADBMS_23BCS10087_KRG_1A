create database pst;
use pst;
CREATE TABLE Person (
    PersonID INT IDENTITY(1,1) PRIMARY KEY, -- Auto-increment primary key
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    Email VARCHAR(100)
);

INSERT INTO Person (FirstName, LastName, Age, Email)
VALUES
('John', 'Doe', 30, 'john.doe@example.com'),
('Jane', 'Smith', 25, 'jane.smith@example.com'),
('Ravi', 'Kumar', 28, 'ravi.kumar@example.in');


CREATE TABLE MovieRating (
    RatingID INT IDENTITY(1,1) PRIMARY KEY,
    PersonID INT,         -- FK to Person table
    MovieName VARCHAR(100),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    RatingDate DATE,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);


-- Suppose PersonID 1 and 2 rated movies
INSERT INTO MovieRating (PersonID, MovieName, Rating, RatingDate)
VALUES
(1, 'Inception', 5, '2023-01-01'),
(1, 'Interstellar', 4, '2023-01-03'),
(2, 'Titanic', 3, '2023-02-10');

select PersonID, count(*) as 'Rating Count' from MovieRating group by PersonID;

create database rev;

use rev;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100)
);


INSERT INTO Users (user_id, name) VALUES
(1, 'Anna'),
(2, 'Bob'),
(3, 'Alice'),
(4, 'Eve'),
(5, 'David');

select * from Users where substring(name, 1, 1) = substring(name, len(name), 1);

select * from Users where left(name, 1) = right(name, 1);

CREATE TABLE Orderss (
    OrderId INT PRIMARY KEY,
    OrderDate DATETIME,
    DeliveryDate DATETIME
);

INSERT INTO Orderss (OrderId, OrderDate, DeliveryDate) VALUES
(1, '2025-01-15', '2025-01-20'), -- Same month
(2, '2025-02-28', '2025-03-01'), -- Different month, same year
(3, '2025-03-15', '2025-03-25'), -- Same month
(4, '2025-04-30', '2025-05-01'), -- Different month, same year
(5, '2024-12-31', '2025-01-01'), -- Different year
(6, '2025-06-10', '2025-06-15'), -- Same month
(7, '2025-07-01', '2025-08-01'); -- Different month, same year

select  * from Orderss where year(OrderDate) = year(DeliveryDate) and month(OrderDate) != month(DeliveryDate);


CREATE TABLE EmployeeLogs (
    log_id INT PRIMARY KEY,
    emp_id INT,
    emp_name VARCHAR(100),
    log_time DATETIME,
    log_type VARCHAR(10)  -- 'IN' or 'OUT'
);

INSERT INTO EmployeeLogs (log_id, emp_id, emp_name, log_time, log_type) VALUES
(1, 101, 'Alice', '2025-07-20 08:50:00', 'IN'),
(2, 101, 'Alice', '2025-07-20 17:15:00', 'OUT'),
(3, 102, 'Bob',   '2025-07-20 09:05:00', 'IN'),
(4, 102, 'Bob',   '2025-07-20 18:00:00', 'OUT'),
(5, 101, 'Alice', '2025-07-21 08:55:00', 'IN'),
(6, 101, 'Alice', '2025-07-21 17:00:00', 'OUT'),
(7, 102, 'Bob',   '2025-07-21 09:10:00', 'IN');  -- Incomplete, no OUT

select e1.emp_id, e1.emp_name, FORMAT(e1.log_time, 'yyyy-MM-dd'), format( e2.log_time-e1.log_time, 'hh:mm')
from EmployeeLogs as e1
    join EmployeeLogs as e2
    on e1.log_id = e2.log_id-1
           and e1.emp_id = e2.emp_id;


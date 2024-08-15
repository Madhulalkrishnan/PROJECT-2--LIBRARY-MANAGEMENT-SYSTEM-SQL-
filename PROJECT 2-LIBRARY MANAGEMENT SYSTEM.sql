CREATE DATABASE library;
USE library;
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3), -- 'yes' or 'no'
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, 'MG Road, Kochi', '0484-1234567'),
(2, 102, 'SM Street, Kozhikode', '0495-2345678'),
(3, 103, 'Statue, Thiruvananthapuram', '0471-3456789'),
(4, 104, 'East Fort, Thrissur', '0487-4567890');
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'Anil Kumar', 'Manager', 70000, 1),
(102, 'Bina Raj', 'Manager', 68000, 2),
(103, 'Chetan K', 'Clerk', 30000, 1),
(104, 'Divya S', 'Assistant', 35000, 2),
(105, 'Elan A', 'Clerk', 32000, 3),
(106, 'Fathima N', 'Manager', 72000, 3),
(107, 'Gopi C', 'Assistant', 34000, 4),
(108, 'Hema R', 'Manager', 69000, 4),
(109, 'Irfan M', 'Clerk', 31000, 2);
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('9781234560012', 'Kochi: Queen of the Arabian Sea', 'History', 50.00, 'yes', 'A. R. Raj', 'Manorama Books'),
('9781234560029', 'The Backwaters of Kerala', 'Travel', 30.00, 'no', 'B. K. Nair', 'DC Books'),
('9781234560036', 'God\'s Own Country', 'Tourism', 45.00, 'yes', 'C. P. Menon', 'Current Books'),
('9781234560043', 'Kerala: A Culinary Journey', 'Food', 60.00, 'yes', 'D. S. Ramesh', 'Penguin India'),
('9781234560050', 'The Art of Kathakali', 'Culture', 55.00, 'no', 'E. T. John', 'Mathrubhumi Books'),
('9781234560067', 'Ayurveda: The Science of Life', 'Health', 40.00, 'yes', 'F. U. Pillai', 'H&C Books');
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(201, 'Arun V', 'Vytilla, Kochi', '2021-12-31'),
(202, 'Beena P', 'Kallai, Kozhikode', '2022-01-15'),
(203, 'Chitra S', 'Palayam, Thiruvananthapuram', '2021-11-20'),
(204, 'Dinesh K', 'Punkunnam, Thrissur', '2022-02-10'),
(205, 'Elina J', 'Cherai, Kochi', '2023-01-05'),
(206, 'Firoz H', 'Kozhikode Beach, Kozhikode', '2023-03-22');
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(301, 201, 'Kochi: Queen of the Arabian Sea', '2023-06-15', '9781234560012'),
(302, 202, 'The Backwaters of Kerala', '2023-06-18', '9781234560029'),
(303, 203, 'God\'s Own Country', '2023-07-05', '9781234560036');
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(401, 201, 'Kochi: Queen of the Arabian Sea', '2023-06-20', '9781234560012'),
(402, 202, 'The Backwaters of Kerala', '2023-06-25', '9781234560029');

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
  AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);
  
  SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

SELECT Customer.Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

SELECT Book_title
FROM Books
WHERE Category LIKE '%History%';

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

SELECT Employee.Emp_name, Branch.Branch_address
FROM Branch
JOIN Employee ON Branch.Manager_Id = Employee.Emp_Id;

SELECT Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;


INSERT INTO information.students(
	studentid, studentname)
	VALUES (10, 'Vidya');

SELECT * FROM information.newstudents;

TRUNCATE TABLE information.students;

SELECT * FROM information.students;


INSERT INTO information.students(
studentid, studentname)
VALUES (10, 'Vidya');
	
UPDATE information.students
	SET studentname='SWARAA'
	WHERE studentid=10;

ALTER TABLE information.students RENAME TO infostudets;

SELECT * FROM information.infostudets;

ALTER TABLE information.infostudets RENAME TO infostudents;

SELECT * FROM information.infostudents;

INSERT INTO information.infostudents(
studentid, studentname)
VALUES (11, 'Veena'),VALUES (12, 'Geeta'),VALUES (13, 'Ashok');
VALUES (14, 'Mita');

SELECT * FROM information.infostudents
ORDER BY studentid ASC;

SELECT * FROM information.infostudents
ORDER BY studentid DESC;

DROP TABLE information.infostudents;

CREATE TABLE information.newstudents ( Studentid INT , Studentname VARCHAR(50));

INSERT INTO information.newstudents(
Studentid, Studentname)
VALUES (11, 'Veena');

ALTER TABLE information.newstudents ADD Age INT;

SELECT * FROM information.newstudents;

ALTER TABLE information.newstudents
ADD DateOfBirth DATE;

ALTER TABLE information.newstudents ALTER COLUMN Age TYPE character;

ALTER TABLE information.newstudents DROP COLUMN Age;

ALTER TABLE information.newstudents RENAME COLUMN DateOfBirth TO DOB;


------------------------------------------------------------------------------------------------------------------------------------------------
-------------creating table with key and constraints

CREATE TABLE information.Company (
    company_id INT PRIMARY KEY,                        -- Primary key
    companyname VARCHAR(100) NOT NULL,                 -- Not null constraint
    registration_number VARCHAR(50) UNIQUE,            -- Unique constraint
    email VARCHAR(100) CHECK (email LIKE '%@%.%'),     -- Check constraint
    country VARCHAR(50) DEFAULT 'USA',                 -- Default value
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP     -- Timestamp default
);

SELECT * from Company;


CREATE TABLE information.employee (
    employee_id INT PRIMARY KEY,                            -- Primary key
    first_name VARCHAR(50) NOT NULL,                        -- Not null constraint
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,                              -- Unique constraint
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,                                -- Not null constraint
    job_title VARCHAR(50) CHECK (job_title <> ''),          -- Check constraint
    salary DECIMAL(10, 2) CHECK (salary > 0),               -- Check constraint
    company_id INT,                                         -- Foreign key
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,         -- Default value
    FOREIGN KEY (company_id) REFERENCES company(company_id) -- Foreign key constraint
);

------------------------------DML commands-------------------------------------------------------------------------


INSERT INTO company (company_id, name, registration_number, email, country)
VALUES 
(1, 'TechNova Inc.', 'REG123456', 'contact@technova.com','USA'),
(2, 'InnoWorks Ltd.', 'REG654321', 'info@innoworks.co.uk','UK');


INSERT INTO employee VALUES
(101, 'Alice', 'Smith', 'alice.smith@technova.com', '123-456-7890', '2022-03-01', 'Software Engineer', 70000.00, 1),
(102, 'Bob', 'Johnson', 'bob.johnson@technova.com', '123-555-7890', '2023-01-15', 'QA Analyst', 60000.00, 1),
(103, 'Carol', 'Evans', 'carol.evans@innoworks.co.uk', '555-222-1234', '2021-08-10', 'Product Manager', 85000.00, 2);


SELECT * from company;
SELECT * from employee;

CREATE TABLE information.departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    manager_id INT,
    company_id INT NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES employee(employee_id),
    FOREIGN KEY (company_id) REFERENCES company(company_id)
);

SELECT * from departments;

CREATE TABLE information.department_location (
    location_id INT PRIMARY KEY,
    department_id INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE information.projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12, 2) CHECK (budget > 0),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE information.works_on (
    employee_id INT,
    project_id INT,
    hours_per_week DECIMAL(4, 1) CHECK (hours_per_week BETWEEN 0 AND 40),
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE TABLE information.dependents (
    dependent_id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    relationship VARCHAR(50) NOT NULL CHECK (relationship IN ('Spouse', 'Child', 'Parent', 'Other')),
    birth_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);


INSERT INTO departments (department_id, department_name, company_id)
VALUES 
(1, 'Engineering', 1),
(2, 'Marketing', 1),
(3, 'R&D', 2);


INSERT INTO department_location (location_id, department_id, address, city, state, zip_code)
VALUES 
(1, 1, '123 Innovation Drive', 'San Francisco', 'CA', '94107'),
(2, 2, '456 Brand Ave', 'New York', 'NY', '10001'),
(3, 3, '789 Future St', 'London', 'London', 'EC1A 1BB');

INSERT INTO projects (project_id, project_name, department_id, start_date, end_date, budget)
VALUES 
(101, 'NextGen App', 1, '2024-01-10', '2024-12-31', 200000.00),
(102, 'Ad Campaign 2025', 2, '2025-02-01', '2025-08-01', 50000.00),
(103, 'AI Research', 3, '2023-05-15', NULL, 300000.00);

INSERT INTO works_on (employee_id, project_id, hours_per_week)
VALUES 
(101, 101, 20.0),
(102, 101, 15.0),
(102, 102, 10.0),
(103, 103, 30.0);

INSERT INTO dependents (dependent_id, employee_id, full_name, relationship, birth_date)
VALUES 
(1, 101, 'Emma Smith', 'Child', '2015-06-12'),
(2, 101, 'Mark Smith', 'Spouse', '1987-03-22'),
(3, 102, 'Tom Johnson', 'Child', '2018-09-05');


SELECT * from company;
SELECT * from employee;
SELECT * from departments;
SELECT * from department_location ;
SELECT * from projects;
SELECT * from works_on;
SELECT * from dependents;


UPDATE departments SET manager_id = 101 WHERE department_id = 1; -- Alice manages Engineering
UPDATE departments SET manager_id = 102 WHERE department_id = 2; -- Bob manages Marketing
UPDATE departments SET manager_id = 103 WHERE department_id = 3; -- Carol manages R&D




















	
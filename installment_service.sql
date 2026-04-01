CREATE DATABASE IF NOT EXISTS installment_manager;
USE installment_manager;

DROP TABLE IF EXISTS tblPaymentReceipts;
DROP TABLE IF EXISTS tblPaymentSchedules;
DROP TABLE IF EXISTS tblContracts;
DROP TABLE IF EXISTS tblPartners;
DROP TABLE IF EXISTS tblCustomers;
DROP TABLE IF EXISTS tblUsers;

CREATE TABLE tblUsers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE tblCustomers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE tblPartners (
    id INT PRIMARY KEY AUTO_INCREMENT,
    partner_name VARCHAR(100) NOT NULL,
    discount_policy VARCHAR(255)
);

CREATE TABLE tblContracts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    contract_code VARCHAR(50) NOT NULL UNIQUE,
    customer_id INT NOT NULL,
    partner_id INT NOT NULL,
    sign_date DATE,
    total_loan DECIMAL(15,2) NOT NULL,
    term_months INT NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    remaining_balance DECIMAL(15,2) NOT NULL,
    status VARCHAR(30) NOT NULL,
    partner_paid TINYINT(1) DEFAULT 0,
    CONSTRAINT fk_contract_customer FOREIGN KEY (customer_id) REFERENCES tblCustomers(id),
    CONSTRAINT fk_contract_partner FOREIGN KEY (partner_id) REFERENCES tblPartners(id)
);

CREATE TABLE tblPaymentSchedules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    contract_id INT NOT NULL,
    installment_no INT NOT NULL,
    due_date DATE NOT NULL,
    amount_due DECIMAL(15,2) NOT NULL,
    principal_amount DECIMAL(15,2) NOT NULL,
    interest_amount DECIMAL(15,2) NOT NULL,
    paid_amount DECIMAL(15,2) DEFAULT 0,
    remaining_after DECIMAL(15,2) NOT NULL,
    status VARCHAR(30) NOT NULL,
    CONSTRAINT fk_schedule_contract FOREIGN KEY (contract_id) REFERENCES tblContracts(id)
);

CREATE TABLE tblPaymentReceipts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    contract_id INT NOT NULL,
    payment_date DATETIME NOT NULL,
    amount_paid DECIMAL(15,2) NOT NULL,
    payment_method VARCHAR(50),
    note VARCHAR(255),
    CONSTRAINT fk_receipt_contract FOREIGN KEY (contract_id) REFERENCES tblContracts(id)
);

INSERT INTO tblUsers(username, password, role)
VALUES ('manager', '12345', 'MANAGER');

INSERT INTO tblCustomers(full_name, phone, address) VALUES
('Nguyen Van A', '0901111111', 'Ha Noi'),
('Tran Thi B', '0902222222', 'Hai Phong'),
('Le Van C', '0903333333', 'Da Nang');

INSERT INTO tblPartners(partner_name, discount_policy) VALUES
('Partner One', 'Giam 5%'),
('Partner Two', 'Giam 10%');

INSERT INTO tblContracts(contract_code, customer_id, partner_id, sign_date, total_loan, term_months, interest_rate, remaining_balance, status, partner_paid) VALUES
('HD001', 1, 1, '2025-01-15', 50000000, 12, 1.50, 30000000, 'ACTIVE', 1),
('HD002', 2, 2, '2025-02-10', 30000000, 10, 1.20, 12000000, 'ACTIVE', 0),
('HD003', 3, 1, '2025-03-01', 40000000, 8, 1.80, 25000000, 'OVERDUE', 0);

INSERT INTO tblPaymentSchedules(contract_id, installment_no, due_date, amount_due, principal_amount, interest_amount, paid_amount, remaining_after, status) VALUES
(1, 1, '2025-02-15', 5000000, 4000000, 1000000, 5000000, 45000000, 'PAID'),
(1, 2, '2025-03-15', 5000000, 4000000, 1000000, 5000000, 40000000, 'PAID'),
(1, 3, '2025-04-15', 5000000, 4000000, 1000000, 0, 35000000, 'UNPAID'),

(2, 1, '2025-03-10', 3200000, 2800000, 400000, 3200000, 26800000, 'PAID'),
(2, 2, '2025-04-10', 3200000, 2800000, 400000, 0, 23600000, 'UNPAID'),

(3, 1, '2025-04-01', 5500000, 4500000, 1000000, 0, 34500000, 'OVERDUE'),
(3, 2, '2025-05-01', 5500000, 4500000, 1000000, 0, 29000000, 'UNPAID');

INSERT INTO tblPaymentReceipts(contract_id, payment_date, amount_paid, payment_method, note) VALUES
(1, '2025-02-15 10:00:00', 5000000, 'CASH', 'Ky 1'),
(1, '2025-03-15 10:30:00', 5000000, 'BANK', 'Ky 2'),
(2, '2025-03-10 09:00:00', 3200000, 'BANK', 'Ky 1');
-- 1. Tổng dư nợ toàn hệ thống
SELECT SUM(remaining_balance) AS total_debt
FROM tblContracts;

-- 2. Dư nợ theo từng khách hàng
SELECT 
    c.id,
    c.full_name,
    SUM(ct.remaining_balance) AS customer_total_debt
FROM tblCustomers c
JOIN tblContracts ct ON c.id = ct.customer_id
GROUP BY c.id, c.full_name
ORDER BY customer_total_debt DESC;

-- 3. Số tiền còn phải trả của từng kỳ
SELECT
    id,
    contract_id,
    installment_no,
    amount_due,
    paid_amount,
    (amount_due - paid_amount) AS unpaid_amount
FROM tblPaymentSchedules;

-- 4. Danh sách các khoản nợ quá hạn
SELECT
    ps.contract_id,
    ct.contract_code,
    ps.installment_no,
    ps.due_date,
    (ps.amount_due - ps.paid_amount) AS overdue_amount,
    DATEDIFF(CURDATE(), ps.due_date) AS overdue_days
FROM tblPaymentSchedules ps
JOIN tblContracts ct ON ps.contract_id = ct.id
WHERE ps.due_date < CURDATE()
  AND ps.paid_amount < ps.amount_due;

-- 5. Tổng dư nợ quá hạn
SELECT
    SUM(amount_due - paid_amount) AS total_overdue_debt
FROM tblPaymentSchedules
WHERE due_date < CURDATE()
  AND paid_amount < amount_due;
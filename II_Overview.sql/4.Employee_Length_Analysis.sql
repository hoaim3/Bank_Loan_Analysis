SELECT
    emp_length,
    COUNT (id) AS total_loan_applications,
    SUM (loan_amount) AS total_funded_amount,
    SUM (total_payment) AS total_amount_received
FROM bank_loan
GROUP BY emp_length 
ORDER BY total_loan_applications DESC;
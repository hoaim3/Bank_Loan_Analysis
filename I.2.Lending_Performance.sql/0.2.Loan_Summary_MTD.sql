SELECT
    loan_status,
    SUM (loan_amount) AS MTD_total_funded_amount,
    SUM (total_payment) AS MTD_total_amount_received
FROM bank_loan
GROUP BY loan_status
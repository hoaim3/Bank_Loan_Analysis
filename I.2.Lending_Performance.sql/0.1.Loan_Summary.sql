SELECT
    loan_status,
    COUNT (id) AS total_applications,
    SUM (loan_amount) AS total_funded_amount,
    SUM (total_payment) AS total_amount_received,
    ROUND (AVG (int_rate), 4) AS avg_int_rate,
    ROUND (AVG (dti),4) AS avg_dti
FROM bank_loan
GROUP BY loan_status
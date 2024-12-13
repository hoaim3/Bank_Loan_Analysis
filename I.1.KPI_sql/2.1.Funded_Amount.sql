SELECT
    'Total funded amount' AS metric,
    SUM (loan_amount) AS value
FROM bank_loan 

UNION ALL

SELECT 
    'MTD Total funded amount' AS metric,
    SUM (loan_amount) AS value
FROM bank_loan
WHERE EXTRACT (MONTH FROM issue_date) = 12

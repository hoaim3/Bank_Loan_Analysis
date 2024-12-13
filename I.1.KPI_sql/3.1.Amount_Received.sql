SELECT
    'Total amount received' AS metric,
    SUM (total_payment) AS value
FROM bank_loan

UNION ALL

SELECT 
    'MTD Total amount received' AS metric,
    SUM (total_payment) AS value
FROM bank_loan
WHERE EXTRACT (MONTH FROM issue_date) = 12


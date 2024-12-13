SELECT
    'Average interest rate' AS metric,
    ROUND (AVG (int_rate)*100, 4) AS value
FROM bank_loan

UNION ALL

SELECT 
    'MTD Average interest rate' AS metric,
    ROUND (AVG (int_rate)*100, 4) AS value
FROM bank_loan
WHERE EXTRACT (MONTH FROM issue_date) = 12
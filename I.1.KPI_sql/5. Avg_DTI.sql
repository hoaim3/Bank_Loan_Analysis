SELECT
    'Average debt-to-income' AS metric,
    ROUND (AVG (dti)*100, 4) AS value
FROM bank_loan

UNION ALL

SELECT 
    'MTD Average interest rate' AS metric,
    ROUND (AVG (dti)*100, 4) AS value
FROM bank_loan
WHERE EXTRACT (MONTH FROM issue_date) = 12
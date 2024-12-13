SELECT
    'Total Loan Applications' AS metric,
    COUNT (id) AS value
FROM bank_loan

UNION ALL

SELECT
    'MTD Loan Application' AS metric,
    COUNT (id) AS value
FROM bank_loan
WHERE EXTRACT (MONTH FROM issue_date) = 12


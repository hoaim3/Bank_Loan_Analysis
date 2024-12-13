-- % Changes in Total Funded Amount Over Time 
SELECT 
    EXTRACT (MONTH FROM issue_date) AS month,
    SUM (loan_amount) AS monthly_loan_amount,
    ROUND (
        (SUM (loan_amount) - LAG (SUM (loan_amount)) OVER (ORDER BY EXTRACT (MONTH FROM issue_date)))*100/
        NULLIF (LAG (SUM (loan_amount)) OVER (ORDER BY EXTRACT (MONTH FROM issue_date)), 0),
        2
    ) AS MoM_change_percent
FROM bank_loan
GROUP BY month 
ORDER BY month ASC;
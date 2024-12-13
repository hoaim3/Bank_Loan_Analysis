-- % Changes in Total Amount Received Over Time 
SELECT 
    EXTRACT (MONTH FROM issue_date) AS month,
    SUM (total_payment) AS monthly_amount_received,
    ROUND (
        (SUM (total_payment) - LAG (SUM (total_payment)) OVER (ORDER BY EXTRACT (MONTH FROM issue_date)))*100/
        NULLIF (LAG (SUM (total_payment)) OVER (ORDER BY EXTRACT (MONTH FROM issue_date)), 0),
        2
    ) AS MoM_change_percent
FROM bank_loan
GROUP BY month 
ORDER BY month ASC;
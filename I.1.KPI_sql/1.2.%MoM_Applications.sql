-- % Changes in Loan Applications Over Time 
SELECT 
    EXTRACT (MONTH FROM issue_date) AS month,
    COUNT (id) AS monthly_loan_applications,
    /*
    Capturing the total number of loan applications from the previous month:
        LAG (COUNT (id)) OVER (ORDER BY EXTRACT (MONTH FROM issue_date)) AS previous_month_applications,
    */
    ROUND (
        (COUNT (id) - LAG (COUNT (id)) OVER (ORDER BY EXTRACT (MONTH FROM issue_date)))*100/
        NULLIF (LAG (COUNT (id)) OVER (ORDER BY EXTRACT (MONTH FROM issue_date)), 0),
        2
    ) AS MoM_change_percent
FROM bank_loan
GROUP BY month 
ORDER BY month ASC;
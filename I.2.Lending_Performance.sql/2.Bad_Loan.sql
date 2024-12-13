SELECT 
        '# of Applications' AS Bad_Loan_KPIs,
        COUNT (id) AS value
FROM bank_loan
WHERE loan_status = 'Charged Off'

UNION

SELECT 
    '% of total applications' AS Bad_Loan_KPIs,
    ROUND (
        COUNT (CASE WHEN loan_status = 'Charged Off' THEN id END) * 100/ COUNT (id), 
        2
    ) AS value
FROM bank_loan 

UNION

SELECT 
    'Funded amount' AS Bad_Loan_KPIs,
    SUM (loan_amount) AS value
FROM bank_loan 
WHERE loan_status = 'Charged Off'

UNION

SELECT
    'Received amount' AS Bad_Loan_KPIs,
    SUM (total_payment) AS value
FROM bank_loan 
WHERE loan_status = 'Charged Off'
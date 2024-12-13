SELECT 
    '# of Applications' AS Good_Loan_KPIs,
    COUNT (id) AS value
FROM bank_loan
WHERE loan_status IN ('Fully Paid', 'Current')

UNION

SELECT 
    '% of total applications' AS Good_Loan_KPIs,
    ROUND (
        COUNT (CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100/ COUNT (id), 
        2
    ) AS value
FROM bank_loan 

UNION

SELECT 
    'Funded amount' AS Good_Loan_KPIs,
    SUM (loan_amount) AS value
FROM bank_loan 
WHERE loan_status IN ('Fully Paid', 'Current')

UNION

SELECT
    'Received amount' AS Good_Loan_KPIs,
    SUM (total_payment) AS value
FROM bank_loan 
WHERE loan_status IN ('Fully Paid', 'Current')


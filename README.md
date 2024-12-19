# Introduction
📊 Dive into the bank loan data! Focusing on the bank's lending activities and performance, this project provides insights into key loan-related mentrics and their changes over time 📈. It enables monitoring the health of the loan portfolio 🔍, as well as refining lending strategies for better outcomes ✨.
# Background
Inspired by [Data Tutorials](https://www.youtube.com/watch?v=OVIunrZUzd0), this project replicates his work to enhance proficiency in SQL and Power BI. Building on his foundation, additional insights and practical applications were developed to deepen understanding.
### Key focus areas
1. Overview
    - Analyze the bank's 2021 lending activities through KPIs: total applications, funded amounts, received amounts, average interest rate, and debt-to-income ratio.

    - Evaluate the 2021 lending performance by comparing "good" loans versus "bad" loans in the portfolio.

3. Explore 2021 lending trends:
    - Are there seasonal patterns?
    - Which regions show the highest activity?
    - What is the most common loan term?
    - Which employment lengths dominate loan applications?
    -  What are the most common loan purposes?
    - Which homeownership statuses are most associated with taking on debt?
# Tools I used
For my deep dive into the bank's lending activities and performance, I harnessed the power of several key tools:
- **PostgreSQL :** The chosen database management system for its reliability and functionality.
- **SQL :** The backbone of my analysis, allowing me to query the database and unearth critical insights. SQL query results were also used to verify and cross-check calculations in Power BI.
- **Visual Studio Code :** My go-to for database management and executing SQL queries.
- **Power BI :**  An essential tool for visualizing data and presenting key findings effectively.
- **Git & GitHub :** Vital for version control and sharing my SQL scripts and analysis, as well as publish Power BI dashboard reports.
# The Analysis
Each query aimed at investigating the dynamics of the bank's lending activities and performance. Here’s how I approached each are:

## 1. Overview
### <ins>_KPIs_
Queries to identify key metrics related lending activities and performance are presented as follow:
- Total loan application & MTD application
```sql
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
```
- Changes in loan applications over time
```sql 
SELECT 
    EXTRACT (MONTH FROM issue_date) AS month,
    COUNT (id) AS monthly_loan_applications,
    ROUND (
        (COUNT (id) - LAG (COUNT (id)) OVER (ORDER BY EXTRACT (MONTH FROM issue_date)))*100/
        NULLIF (LAG (COUNT (id)) OVER (ORDER BY EXTRACT (MONTH FROM issue_date)), 0),
        2
    ) AS MoM_change_percent
FROM bank_loan
GROUP BY month 
ORDER BY month ASC;
```
_Similar queries were developed to calculate other metrics, including metrics related to funded amount, amount received, average interest rate, and average debt-to-income ratio_ 

### <ins>_Good Loan vs Bad Loan_
To further assess the health of lending portfolio, loans are classified into good loans and bad loans. 
- Good loans: those that are full paid or currently active
```sql
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
```
- Bad loans: those are charged off
```sql
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
```
### _<ins>A snapshot of the report from Power BI_
![Summary](https://github.com/user-attachments/assets/0928878a-86f4-4ae9-8939-3f00f58784fc)
### <ins>_Key insights_
- **Proportion of Good Loans :** Over 86% of the loans issued are classified as good loans, indicating a strong overall lending performance. Good loans include those that are either fully paid or currently active, demonstrating the bank's ability to manage and maintain a healthy loan portfolio.

- **Interest Rates and Debt-to-Income Ratios:** Loans that are fully paid exhibit the lowest average interest rates and debt-to-income ratios, reflecting the lower risk associated with these borrowers. Charged-off loans rank next, showing moderately higher averages in these metrics, likely due to the increased risk that led to default. Current loans, however, have the highest average interest rates and debt-to-income ratios, possibly indicating that borrowers with active loans tend to take on higher financial burdens or are charged higher rates based on risk assessment.
## 3. Lending trends
Investigating trends across different areas are essential to form and refine lending strategies.
### <ins>_SQL queries_
- Monthly trends
```sql
SELECT
    EXTRACT (MONTH FROM issue_date) AS month,
    COUNT (id) AS total_loan_applications,
    SUM (loan_amount) AS total_funded_amount,
    SUM (total_payment) AS total_amount_received
FROM bank_loan
GROUP BY month 
ORDER BY month;
```
- Regional analysis
```sql
SELECT
    address_state,
    COUNT (id) AS total_loan_applications,
    SUM (loan_amount) AS total_funded_amount,
    SUM (total_payment) AS total_amount_received
FROM bank_loan
GROUP BY address_state 
ORDER BY total_loan_applications DESC;
```
- Loan term analysis
```sql
SELECT
    term,
    COUNT (id) AS total_loan_applications,
    SUM (loan_amount) AS total_funded_amount,
    SUM (total_payment) AS total_amount_received
FROM bank_loan
GROUP BY term 
ORDER BY term;
```
- Employee length analysis
```sql
SELECT
    emp_length,
    COUNT (id) AS total_loan_applications,
    SUM (loan_amount) AS total_funded_amount,
    SUM (total_payment) AS total_amount_received
FROM bank_loan
GROUP BY emp_length 
ORDER BY total_loan_applications DESC;
```
- Home ownership analysis
```sql
SELECT
    home_ownership,
    COUNT (id) AS total_loan_applications,
    SUM (loan_amount) AS total_funded_amount,
    SUM (total_payment) AS total_amount_received
FROM bank_loan
GROUP BY home_ownership 
ORDER BY total_loan_applications DESC;
```
### <ins>_A snapshot of the report from Power BI_
![Overview](https://github.com/user-attachments/assets/1450b6b5-38da-44fb-a827-e61ca31c2e2c)

### <ins>_Key insights_
- **Monthly trends :** Total applications, funded amounts, and amounts received show consistent growth throughout the year, reflecting steady increases in lending activity.
- **Regional analysis :** States such as California, Texas, Florida, and New York lead in lending activity, dominating across total applications, funded amounts, and amounts received.
- **Loan term analysis :** Short-term loans make up the largest share of total loan applications, representing over 26.8%. However, long-term loans account for a higher average funded amount per application, with more than 37% of the total funds distributed allocated to long-term loans.
- **Enployment length analysis :** Borrowers with over 10 years of employment represent the majority of both loan applications and funded amounts. Interestingly, individuals with less than one year of employment submit more applications than those with two years of employment but tend to borrow smaller amounts.
- **Home ownership analysis :** While renters make up the majority of loan applicants, the highest funded amounts are granted to borrowers with mortgages.
# What I learned
Throughout this project, I've significantly refined my SQL and Power BI skills:
- 🔍 Query Drafting: Strengthened my ability to perform basic SQL queries, enhancing my foundation for more complex data analysis.
- 📊 Data Aggregation: Got comfortable with GROUP BY and aggregate functions like COUNT() and AVG(), making data summarization quick and intuitive.
- 📈 Data Visualization: Leveraged Power BI to create effective and engaging reports, turning raw data into visually compelling insights.
- 🧠 Analytical Problem-Solving: Improved my ability to transform business questions into actionable insights through well-crafted SQL queries.


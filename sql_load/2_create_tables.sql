CREATE TABLE bank_loan
(
    id INT,
    address_state VARCHAR(50),
    application_type VARCHAR (50),
    emp_length VARCHAR (50),
    emp_title VARCHAR (255),
    grade VARCHAR (20),
    home_ownership VARCHAR (50),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR (50),
    next_payment_date DATE,
    member_id INT,
    purpose VARCHAR (50),
    sub_grade VARCHAR (50),
    term VARCHAR (50),
    verification_status VARCHAR (50),
    annual_income INT,
    dti NUMERIC,
    installment NUMERIC,
    int_rate NUMERIC,
    loan_amount INT,
    total_acc INT,
    total_payment INT
)

ALTER TABLE bank_loan
ALTER COLUMN annual_income TYPE NUMERIC;

ALTER TABLE bank_loan
ALTER COLUMN loan_amount TYPE NUMERIC;

ALTER TABLE bank_loan
ALTER COLUMN total_payment TYPE NUMERIC;


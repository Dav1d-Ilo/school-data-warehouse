TRUNCATE TABLE Silver.academics_enrollment;
PRINT '>>Inserting enrollment data'
INSERT INTO Silver.academics_enrollment
(
    enrollment_id,
    student_id,
    class,
    arm,
    academic_year,
    enrollment_term,
    enrollment_date,
    exit_year,
    exit_term,
    enrollment_status
)
SELECT
    TRIM(enrollment_id) AS enrollment_id,
    TRIM(student_id) AS student_id,
    UPPER(TRIM(class)) AS class,
    UPPER(TRIM(arm)) AS arm,
    REPLACE(TRIM(academic_year), ' ', '') AS academic_yaer,
    TRIM(enrollment_term) AS enrollment_term,
    enrollment_date,
    exit_year,
    TRIM(exit_term) AS exit_term,
    CASE
        WHEN LOWER(TRIM(enrollment_status)) = 'active' THEN 'Active'
        WHEN LOWER(TRIM(enrollment_status)) = 'left' THEN 'Left'
        WHEN LOWER(TRIM(enrollment_status)) = 'graduated' THEN 'Graduated'
        ELSE NULL
    END AS enrollment_status
FROM Bronze.academics_enrollment;

TRUNCATE TABLE Silver.academics_exam;
PRINT 'Inserting exam data'
INSERT INTO Silver.academics_exam
(
    exam_id,
    class,
    academic_year,
    term,
    exam_type,
    exam_name
)
SELECT
    TRIM(exam_id) AS exam_id,
    UPPER(TRIM(class)) AS class,
    REPLACE(TRIM(academic_year), ' ', '') AS academic_year,
    TRIM(term) AS term,
    UPPER(TRIM(exam_type)) AS exam_type,
    TRIM(exam_name) AS exam_name
FROM Bronze.academics_exam;

TRUNCATE TABLE Silver.academics_exam_results;
PRINT 'Inserting exam_results'
INSERT INTO Silver.academics_exam_results
(
    result_id,
    student_id,
    exam_id,
    subject_id,
    score
)
SELECT
    TRIM(result_id) AS result_id,
    TRIM(student_id) AS student_id,
    TRIM(exam_id) AS exam_id,
    UPPER(TRIM(subject_id)) AS subject_id,
    score
FROM Bronze.academics_exam_results;


TRUNCATE TABLE Silver.academics_student_info;
PRINT 'Inserting student_info'
INSERT INTO Silver.academics_student_info
(
    student_id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    guardian_name,
    guardian_phone,
    home_address
)
SELECT
    TRIM(student_id) AS student_id,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    date_of_birth,
    CASE
        WHEN LOWER(TRIM(gender)) = 'male' THEN 'Male'
        WHEN LOWER(TRIM(gender)) = 'female' THEN 'Female'
        ELSE NULL
    END AS gender,
    TRIM(guardian_name) AS guardian_name,
    TRIM(guardian_phone) AS guardian_phone,
    TRIM(home_address) AS home_address
FROM Bronze.academics_student_info;

TRUNCATE TABLE Silver.academics_subjects;
PRINT 'Inserting Subjects Data'
INSERT INTO Silver.academics_subjects
(
    subject_id,
    subject_name,
    subject_category
)
SELECT
    TRIM(subject_id) AS subject_id,
    TRIM(subject_name) AS subject_name,
    TRIM(subject_category) AS subject_category
FROM Bronze.academics_subjects;


TRUNCATE TABLE Silver.finance_fee
PRINT 'Inserting Fee Data'
INSERT INTO Silver.finance_fee
(
    fee_id,
    fee_name,
    academic_year,
    term,
    amount
)
SELECT
    TRIM(fee_id) AS fee_id,

    CASE
        WHEN LOWER(TRIM(fee_name)) = 'tuition fee' THEN 'Tuition Fee'
        WHEN LOWER(TRIM(fee_name)) = 'examination fee' THEN 'Examination Fee'
        WHEN LOWER(TRIM(fee_name)) = 'sports fee' THEN 'Sports Fee'
        ELSE NULL
    END AS fee_name,

    REPLACE(TRIM(academic_year), ' ', '') AS academic_year,

    CASE
        WHEN LOWER(TRIM(term)) = '1st' THEN '1st'
        WHEN LOWER(TRIM(term)) = '2nd' THEN '2nd'
        WHEN LOWER(TRIM(term)) = '3rd' THEN '3rd'
        ELSE NULL
    END AS term,

    amount AS amount
FROM Bronze.finance_fee;


TRUNCATE TABLE Silver.finance_invoice
PRINT 'Inserting Invoice Data'
INSERT INTO Silver.finance_invoice
(
    invoice_id,
    student_id,
    academic_year,
    term,
    invoice_date,
    total_amount
)
SELECT
    TRIM(invoice_id) AS invoice_id,
    TRIM(student_id) AS student_id,
    REPLACE(TRIM(academic_year), ' ', '') AS academic_year,

    CASE
        WHEN LOWER(TRIM(term)) = '1st' THEN '1st'
        WHEN LOWER(TRIM(term)) = '2nd' THEN '2nd'
        WHEN LOWER(TRIM(term)) = '3rd' THEN '3rd'
        ELSE NULL
    END AS term,

    invoice_date AS invoice_date,
    total_amount AS total_amount

FROM Bronze.finance_invoice;

TRUNCATE TABLE Silver.finance_payment
PRINT 'Inserting Payment Data'
INSERT INTO Silver.finance_payment
(
    payment_id,
    invoice_id,
    student_id,
    payment_date,
    amount_paid,
    payment_mode
)
SELECT
    TRIM(payment_id) AS payment_id,
    TRIM(invoice_id) AS invoice_id,
    TRIM(student_id) AS student_id,
    payment_date AS payment_date,
    amount_paid AS amount_paid,
    CASE
        WHEN LOWER(TRIM(payment_mode)) = 'cash' THEN 'Cash'
        WHEN LOWER(TRIM(payment_mode)) = 'transfer' THEN 'Transfer'
        ELSE NULL
    END AS payment_mode
FROM Bronze.finance_payment;


TRUNCATE TABLE Silver.hr_employee
PRINT 'Inserting Employee Data'
INSERT INTO Silver.hr_employee
(
    employee_id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    phone,
    email,
    home_address
)
SELECT
    TRIM(employee_id) AS employee_id,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    date_of_birth AS date_of_birth,
    CASE
        WHEN UPPER(TRIM(gender)) = 'M' THEN 'Male'
        WHEN UPPER(TRIM(gender)) = 'F' THEN 'Female'
        ELSE NULL
    END AS gender,
    TRIM(phone) AS phone,
    TRIM(email) AS email,
    TRIM(home_address) AS home_adress
FROM Bronze.hr_employee;


TRUNCATE TABLE Silver.hr_employment
PRINT 'Inserting Employment Data'
INSERT INTO Silver.hr_employment
(
    employment_id,
    employee_id,
    department,
    job_title,
    employment_date,
    end_date,
    employment_status
)
SELECT
    TRIM(employment_id) AS employment_id,
    TRIM(employee_id) AS employee_id,
    TRIM(department) AS department,
    TRIM(job_title) AS job_title,

    COALESCE(
        TRY_CONVERT(DATE, TRIM(employment_date), 23),
        TRY_CONVERT(DATE, TRIM(employment_date), 103)
    ) AS employment_date,

    COALESCE(
        TRY_CONVERT(DATE, NULLIF(TRIM(end_date), ''), 23),
        TRY_CONVERT(DATE, NULLIF(TRIM(end_date), ''), 103)
    ) AS end_date,

    CASE
        WHEN LOWER(TRIM(employment_status)) = 'active' THEN 'Active'
        WHEN LOWER(TRIM(employment_status)) = 'left' THEN 'Left'
        ELSE NULL
    END AS employment_status

FROM Bronze.hr_employment;

TRUNCATE TABLE Silver.hr_teacher_assignment
PRINT 'Inserting Teacher_Assignment Data'
INSERT INTO Silver.hr_teacher_assignment
(
    assignment_id,
    employee_id,
    subject_id,
    class,
    arm,
    academic_year,
    term
)
SELECT
    TRIM(assignment_id) AS assignment_id,
    TRIM(employee_id) AS employee_id,
    UPPER(TRIM(subject_id)) AS subject_id,
    UPPER(TRIM(class)) AS class,
    UPPER(TRIM(arm)) AS arm,
    REPLACE(TRIM(academic_year), ' ', '') AS academic_year,
    CASE
        WHEN LOWER(TRIM(term)) = '1st' THEN '1st'
        WHEN LOWER(TRIM(term)) = '2nd' THEN '2nd'
        WHEN LOWER(TRIM(term)) = '3rd' THEN '3rd'
        ELSE NULL
    END AS term
FROM Bronze.hr_teacher_assignment;

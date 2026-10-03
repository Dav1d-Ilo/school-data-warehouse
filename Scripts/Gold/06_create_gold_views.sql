/*
=============================================================
Create Gold Layer Views
=============================================================
Script Purpose:
    This script creates the Gold layer views for the School
    Data Warehouse. The Gold layer provides business-ready
    dimensions and fact views built from the cleaned Silver layer.

    Existing Gold views are dropped and recreated.
=============================================================
*/


IF OBJECT_ID ('Gold.dim_student_info' , 'U') IS NOT NULL
   DROP TABLE Gold.dim_student_info;
CREATE VIEW Gold.dim_student_info AS
SELECT
  ROW_NUMBER() OVER (ORDER BY student_id) AS student_key,
	student_id AS student_id,
	first_name AS first_name,
	last_name AS last_name,
	date_of_birth AS date_of_birth,
	gender AS gender,
	guardian_name AS guardian_name,
	guardian_phone AS guardian_phone,
	home_address AS home_address
FROM Silver.academics_student_info;

IF OBJECT_ID ('Gold.dim_employee' , 'U') IS NOT NULL
   DROP TABLE Gold.dim_employee;
CREATE VIEW gold.dim_employee AS
SELECT 
 ROW_NUMBER() OVER (ORDER BY e.employee_id) AS employee_key,
	e.employee_id AS employee_id,
	e.first_name AS first_name,
	e.last_name AS last_name,
	e.date_of_birth AS date_of_birth,
	e.gender AS gender,
	e.phone AS phone,
	e.email AS email,
	e.home_address AS home_address,
	em.department AS department,
	em.job_title AS job_title,
	em.employment_date AS employment_date, 
	em.end_date AS end_date,
	em.employment_status AS employment_status
FROM Silver.hr_employee e
LEFT JOIN Silver.hr_employment em
  ON e.employee_id = em.employee_id;

IF OBJECT_ID ('Gold.dim_subjects' , 'U') IS NOT NULL
   DROP TABLE Gold.dim_subjects;
CREATE VIEW Gold.dim_subjects AS
SELECT 
ROW_NUMBER() OVER (ORDER BY subject_id) AS subject_key,
  subject_id AS subject_id,
  subject_name AS subject_name,
  subject_category AS subject_category
FROM Silver.academics_subjects;

IF OBJECT_ID ('Gold.dim_exam' , 'U') IS NOT NULL
   DROP TABLE Gold.dim_exam;
CREATE VIEW Gold.dim_exam AS
SELECT
ROW_NUMBER() OVER (ORDER BY exam_id) AS exam_key,
exam_id AS exam_id,
class AS class,
academic_year AS academic_year,
term AS term,
exam_type AS exam_type,
exam_name AS exam_name
FROM Silver.academics_exam;

IF OBJECT_ID ('Gold.dim_fee' , 'U') IS NOT NULL
   DROP TABLE Gold.dim_fee;
CREATE VIEW Gold.dim_fee AS
SELECT
ROW_NUMBER() OVER (ORDER BY fee_id) AS fee_key,
fee_id AS  fee_id,
fee_name AS fee_name,
academic_year AS academic_year,
term AS term,
amount AS amount
FROM Silver.finance_fee

IF OBJECT_ID ('Gold.fact_invoice' , 'U') IS NOT NULL
   DROP TABLE Gold.fact_invoice;
CREATE VIEW Gold.fact_invoice AS
SELECT
    i.invoice_id,
    s.student_key,
    i.academic_year,
    i.term,
    i.invoice_date,
    i.total_amount
FROM silver.finance_invoice i
LEFT JOIN Gold.dim_student_info s
    ON i.student_id = s.student_id;

IF OBJECT_ID ('Gold.fact_payment' , 'U') IS NOT NULL
   DROP TABLE Gold.dim_payment;
CREATE VIEW Gold.fact_payment AS
SELECT
	p.payment_id AS payment_id,
	p.invoice_id AS invoice_id,
	s.student_key AS student_key,
	p.payment_date AS paymnet_date,
	p.amount_paid AS amount_paid,
	p.payment_mode AS payment_mode
FROM Silver.finance_payment p
LEFT JOIN Gold.dim_student_info s
    ON p.student_id = s.student_id;

IF OBJECT_ID ('Gold.dim_teacher_assignment' , 'U') IS NOT NULL
   DROP TABLE Gold.dim_teacher_assignment;
CREATE VIEW Gold.fact_teacher_assignment AS
SELECT 
	ta.assignment_id AS assignment_id,
	e.employee_key AS employee_key,
	s.subject_key AS subject_key,
	ta.class AS class,
	ta.arm AS arm,
	ta.academic_year AS academic_year,
	ta.term AS term
FROM Silver.hr_teacher_assignment ta
LEFT JOIN Gold.dim_employee e
ON e.employee_id = ta.employee_id
LEFT JOIN Gold.dim_subjects s
ON s.subject_id = ta.subject_id;

IF OBJECT_ID ('Gold.fact_enrollment' , 'U') IS NOT NULL
   DROP TABLE Gold.fact_enrollment;
CREATE VIEW Gold.fact_enrollment AS
SELECT
e.enrollment_id AS enrollment_id,
s.student_key AS student_key,
e.class AS class,
e.arm AS arm,
e.academic_year AS academic_year,
e.enrollment_term AS enrollment_term,
e.enrollment_date AS enrollment_date,
e.exit_year AS exit_year,
e.exit_term AS exit_term,
e.enrollment_status AS enrollment_status
FROM Silver.academics_enrollment e
LEFT JOIN Gold.dim_student_info s
 ON e.student_id = s.student_id;

 IF OBJECT_ID ('Gold.dim_fee' , 'U') IS NOT NULL
   DROP TABLE Gold.dim_fee;
CREATE VIEW Gold.fact_exam_result AS
 SELECT
 er.result_id AS result_id,
 s.student_key AS student_key,
 e.exam_key AS exam_key,
 su.subject_key AS subject_key,
 er.score AS score
 FROM Silver.academics_exam_results er
 LEFT JOIN gold.dim_student_info s
 ON er.student_id = s.student_id
 LEFT JOIN gold.dim_exam e
 ON e.exam_id = er.exam_id
 LEFT JOIN gold.dim_subjects su
 ON su.subject_id = er.subject_id;

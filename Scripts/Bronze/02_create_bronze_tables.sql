/*
=============================================================
Create Bronze Layer Tables
=============================================================
Script Purpose:
    This script creates the Bronze layer tables for the School
    Data Warehouse. The Bronze layer stores raw data loaded
    from source CSV files.

    Existing Bronze tables are dropped and recreated.
=============================================================
*/
IF OBJECT_ID ('Bronze.academics_enrollment' , 'U') IS NOT NULL
   DROP TABLE Bronze.academics_enrollment;
CREATE TABLE Bronze.academics_enrollment(
enrollment_id VARCHAR(25),
student_id VARCHAR(25),
class VARCHAR(6),
arm VARCHAR(3),
academic_year VARCHAR(12),
enrollment_term VARCHAR(5),
enrollment_date DATE,
exit_year VARCHAR(12),
exit_term VARCHAR(5),
enrollment_status VARCHAR(15)
);

IF OBJECT_ID ('Bronze.academics_student_info' , 'U') IS NOT NULL
   DROP TABLE Bronze.academics_student_info;
CREATE TABLE Bronze.academics_student_info(
student_id VARCHAR(25),
first_name NVARCHAR(30),
last_name NVARCHAR(30),
date_of_birth DATE,
gender VARCHAR(10),
guardian_name NVARCHAR(30),
guardian_phone VARCHAR(20),
adress NVARCHAR(50)
);

IF OBJECT_ID ('Bronze.academics_subjects' , 'U') IS NOT NULL
   DROP TABLE Bronze.academics_subjects;
CREATE TABLE Bronze.academics_subjects(
subject_id VARCHAR(15),
subject_name VARCHAR(50),
subject_category VARCHAR(15)
);

IF OBJECT_ID ('Bronze.academics_exam' , 'U') IS NOT NULL
   DROP TABLE Bronze.academics_exam;
CREATE TABLE Bronze.academics_exam(
exam_id VARCHAR(15),
class VARCHAR(15),
academic_year VARCHAR(12),
term VARCHAR(10),
exam_type VARCHAR(5),
exam_name VARCHAR(30),
);

IF OBJECT_ID ('Bronze.academics_exam_results' , 'U') IS NOT NULL
   DROP TABLE Bronze.academics_exam_results;
CREATE TABLE Bronze.academics_exam_results(
result_id VARCHAR(15),
student_id VARCHAR(15),
exam_id VARCHAR(15),
subject_id VARCHAR(15),
score INT
);

IF OBJECT_ID ('Bronze.hr_employee' , 'U') IS NOT NULL
   DROP TABLE Bronze.hr_employee;
CREATE TABLE Bronze.hr_employee(
employee_id VARCHAR(15),
first_name NVARCHAR(30),
last_name NVARCHAR(30),
date_of_birth DATE,
gender VARCHAR(10),
phone VARCHAR(15),
email VARCHAR(50),
adress NVARCHAR(50)
);

IF OBJECT_ID ('Bronze.hr_employment' , 'U') IS NOT NULL
   DROP TABLE Bronze.hr_employment;
CREATE TABLE Bronze.hr_employment(
employment_id VARCHAR(15),
employee_id VARCHAR(15),
department VARCHAR(30),
job_title VARCHAR(30),
employment_date DATE,
end_date  DATE,
employment_status VARCHAR(30)
);

IF OBJECT_ID ('Bronze.hr_teacher_assignment' , 'U') IS NOT NULL
   DROP TABLE Bronze.hr_teacher_assignment;
CREATE TABLE Bronze.hr_teacher_assignment(
assignment_id VARCHAR(30),
employee_id VARCHAR(30),
subject_id VARCHAR(30),
class VARCHAR(10),
arm VARCHAR(3),
academic_year VARCHAR(12),
term VARCHAR(5)
);

IF OBJECT_ID ('Bronze.finance_fee' , 'U') IS NOT NULL
   DROP TABLE Bronze.finance_fee;
CREATE TABLE Bronze.finance_fee(
fee_id VARCHAR(10),
fee_name VARCHAR(25),
academic_year VARCHAR(12),
term VARCHAR(15),
amount INT
);

IF OBJECT_ID ('Bronze.finance_invoice' , 'U') IS NOT NULL
   DROP TABLE Bronze.finance_invoice;
CREATE TABLE Bronze.finance_invoice(
invoice_id VARCHAR(25),
student_id VARCHAR(25),
academic_year VARCHAR(12),
term VARCHAR(5),
invoice_date DATE,
total_amount INT
);

IF OBJECT_ID ('Bronze.finance_payment' , 'U') IS NOT NULL
   DROP TABLE Bronze.finance_payment;
CREATE TABLE Bronze.finance_payment(
payment_id VARCHAR(25),
invoice_id VARCHAR(25),
student_id VARCHAR(25),
payment_date DATE,
amount_paid INT
);


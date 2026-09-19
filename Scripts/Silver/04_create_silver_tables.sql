IF OBJECT_ID ('Silver.academics_enrollment' , 'U') IS NOT NULL
   DROP TABLE Silver.academics_enrollment;
CREATE TABLE Silver.academics_enrollment(
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

IF OBJECT_ID ('Silver.academics_student_info' , 'U') IS NOT NULL
   DROP TABLE Silver.academics_student_info;
CREATE TABLE Silver.academics_student_info(
student_id VARCHAR(25),
first_name NVARCHAR(30),
last_name NVARCHAR(30),
date_of_birth DATE,
gender VARCHAR(10),
guardian_name NVARCHAR(30),
guardian_phone VARCHAR(20),
adress NVARCHAR(50)
);

IF OBJECT_ID ('Silver.academics_subjects' , 'U') IS NOT NULL
   DROP TABLE Silver.academics_subjects;
CREATE TABLE Silver.academics_subjects(
subject_id VARCHAR(15),
subject_name VARCHAR(50),
subject_category VARCHAR(15)
);

IF OBJECT_ID ('Silver.academics_exam' , 'U') IS NOT NULL
   DROP TABLE Silver.academics_exam;
CREATE TABLE Silver.academics_exam(
exam_id VARCHAR(15),
class VARCHAR(15),
academic_year VARCHAR(12),
term VARCHAR(10),
exam_type VARCHAR(5),
exam_name VARCHAR(30),
);

IF OBJECT_ID ('Silver.academics_exam_results' , 'U') IS NOT NULL
   DROP TABLE Silver.academics_exam_results;
CREATE TABLE Silver.academics_exam_results(
result_id VARCHAR(15),
student_id VARCHAR(15),
exam_id VARCHAR(15),
subject_id VARCHAR(15),
score INT
);

IF OBJECT_ID ('Silver.hr_employee' , 'U') IS NOT NULL
   DROP TABLE Silver.hr_employee;
CREATE TABLE Silver.hr_employee(
employee_id VARCHAR(15),
first_name NVARCHAR(30),
last_name NVARCHAR(30),
date_of_birth DATE,
gender VARCHAR(10),
phone VARCHAR(15),
email VARCHAR(50),
adress NVARCHAR(50)
);

IF OBJECT_ID ('Silver.hr_employment' , 'U') IS NOT NULL
   DROP TABLE Silver.hr_employment;
CREATE TABLE Silver.hr_employment(
employment_id VARCHAR(15),
employee_id VARCHAR(15),
department VARCHAR(30),
job_title VARCHAR(30),
employment_date VARCHAR(30),
end_date  VARCHAR(30),
employment_status VARCHAR(30)
);

IF OBJECT_ID ('Silver.hr_teacher_assignment' , 'U') IS NOT NULL
   DROP TABLE Silver.hr_teacher_assignment;
CREATE TABLE Silver.hr_teacher_assignment(
assignment_id VARCHAR(30),
employee_id VARCHAR(30),
subject_id VARCHAR(30),
class VARCHAR(10),
arm VARCHAR(3),
academic_year VARCHAR(12),
term VARCHAR(5)
);

IF OBJECT_ID ('Silver.finance_fee' , 'U') IS NOT NULL
   DROP TABLE Silver.finance_fee;
CREATE TABLE Silver.finance_fee(
fee_id VARCHAR(10),
fee_name VARCHAR(25),
academic_year VARCHAR(12),
term VARCHAR(15),
amount INT
);

IF OBJECT_ID ('Silver.finance_invoice' , 'U') IS NOT NULL
   DROP TABLE Silver.finance_invoice;
CREATE TABLE Silver.finance_invoice(
invoice_id VARCHAR(25),
student_id VARCHAR(25),
academic_year VARCHAR(12),
term VARCHAR(5),
invoice_date DATE,
total_amount INT
);

IF OBJECT_ID ('Silver.finance_payment' , 'U') IS NOT NULL
   DROP TABLE Silver.finance_payment;
CREATE TABLE Silver.finance_payment(
payment_id VARCHAR(25),
invoice_id VARCHAR(25),
student_id VARCHAR(25),
payment_date DATE,
amount_paid INT,
payment_mode VARCHAR(20)
);

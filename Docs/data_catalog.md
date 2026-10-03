# Data Catalog — Gold Layer

## Overview

The Gold Layer contains business-ready views designed for analysis and reporting across the school's academic, finance, and human resources processes.

The Gold Layer is organized into **dimension views** and **fact views**. Dimension views provide descriptive information about key entities, while fact views record business events and relationships such as examinations, enrollment, invoicing, payments, and teacher assignments.

Surrogate keys are generated for dimensions and used by related fact views to connect records across the analytical model.

---

# Dimension Views

## 1. `gold.dim_student_info`

### Purpose

Provides descriptive information about students and generates a surrogate key used by related fact views.

| Column           | Data Type    | Description                                      |
| ---------------- | ------------ | ------------------------------------------------ |
| `student_key`    | BIGINT       | Surrogate key generated for each student record. |
| `student_id`     | VARCHAR(25)  | Business identifier assigned to the student.     |
| `first_name`     | NVARCHAR(30) | Student's first name.                            |
| `last_name`      | NVARCHAR(30) | Student's last name.                             |
| `date_of_birth`  | DATE         | Student's date of birth.                         |
| `gender`         | VARCHAR(10)  | Student's gender.                                |
| `guardian_name`  | NVARCHAR(30) | Name of the student's guardian.                  |
| `guardian_phone` | VARCHAR(20)  | Guardian's contact phone number.                 |
| `home_address`   | NVARCHAR(50) | Student's residential address.                   |

---

## 2. `gold.dim_employee`

### Purpose

Provides employee information together with employment details for workforce analysis.

| Column              | Data Type    | Description                                   |
| ------------------- | ------------ | --------------------------------------------- |
| `employee_key`      | BIGINT       | Surrogate key generated for the employee.     |
| `employee_id`       | VARCHAR(15)  | Business identifier assigned to the employee. |
| `first_name`        | NVARCHAR(30) | Employee's first name.                        |
| `last_name`         | NVARCHAR(30) | Employee's last name.                         |
| `date_of_birth`     | DATE         | Employee's date of birth.                     |
| `gender`            | VARCHAR(10)  | Employee's gender.                            |
| `phone`             | VARCHAR(15)  | Employee's contact phone number.              |
| `email`             | VARCHAR(50)  | Employee's email address.                     |
| `home_address`      | NVARCHAR(50) | Employee's residential address.               |
| `department`        | VARCHAR(30)  | Department in which the employee works.       |
| `job_title`         | VARCHAR(30)  | Employee's job title.                         |
| `employment_date`   | DATE         | Date employment began.                        |
| `end_date`          | DATE         | Date employment ended, where applicable.      |
| `employment_status` | VARCHAR(30)  | Employment status.                            |

---

## 3. `gold.dim_subjects`

### Purpose

Provides information about subjects taught and examined within the school.

| Column             | Data Type   | Description                                                      |
| ------------------ | ----------- | ---------------------------------------------------------------- |
| `subject_key`      | BIGINT      | Surrogate key generated for the subject.                         |
| `subject_id`       | VARCHAR(15) | Business identifier assigned to the subject.                     |
| `subject_name`     | VARCHAR(50) | Name of the subject.                                             |
| `subject_category` | VARCHAR(15) | Subject category, such as General, Science, Arts, or Commercial. |

---

## 4. `gold.dim_exam`

### Purpose

Provides descriptive information about examinations conducted across classes, academic years, terms, and examination types.

| Column          | Data Type   | Description                                      |
| --------------- | ----------- | ------------------------------------------------ |
| `exam_key`      | BIGINT      | Surrogate key generated for the examination.     |
| `exam_id`       | VARCHAR(15) | Business identifier assigned to the examination. |
| `class`         | VARCHAR(15) | Senior secondary class: SS1, SS2, or SS3.        |
| `academic_year` | VARCHAR(12) | Academic year of the examination.                |
| `term`          | VARCHAR(10) | Academic term of the examination.                |
| `exam_type`     | VARCHAR(5)  | Examination component, such as CA or EX.         |
| `exam_name`     | VARCHAR(30) | Name or description of the examination.          |

---

## 5. `gold.dim_fee`

### Purpose

Provides information about school fees applicable to each academic year and term.

| Column          | Data Type   | Description                                               |
| --------------- | ----------- | --------------------------------------------------------- |
| `fee_key`       | BIGINT      | Surrogate key generated for the fee record.               |
| `fee_id`        | VARCHAR(10) | Business identifier assigned to the fee.                  |
| `fee_name`      | VARCHAR(25) | Name of the fee, such as Tuition, Examination, or Sports. |
| `academic_year` | VARCHAR(12) | Academic year in which the fee applies.                   |
| `term`          | VARCHAR(15) | Academic term in which the fee applies.                   |
| `amount`        | INT         | Fee amount in whole currency units.                       |

---

# Fact Views

## 6. `gold.fact_invoice`

### Purpose

Records student invoices issued for school fees and links each invoice to the corresponding student through `student_key`.

| Column          | Data Type   | Description                                              |
| --------------- | ----------- | -------------------------------------------------------- |
| `invoice_id`    | VARCHAR(25) | Business identifier assigned to the invoice.             |
| `student_key`   | BIGINT      | Surrogate key linking the invoice to `dim_student_info`. |
| `academic_year` | VARCHAR(12) | Academic year associated with the invoice.               |
| `term`          | VARCHAR(5)  | Academic term associated with the invoice.               |
| `invoice_date`  | DATE        | Date the invoice was issued.                             |
| `total_amount`  | INT         | Total amount charged on the invoice.                     |

---

## 7. `gold.fact_payment`

### Purpose

Records payments made against student invoices and links each payment to the corresponding student.

| Column         | Data Type   | Description                                              |
| -------------- | ----------- | -------------------------------------------------------- |
| `payment_id`   | VARCHAR(25) | Business identifier assigned to the payment.             |
| `invoice_id`   | VARCHAR(25) | Identifier of the invoice being paid.                    |
| `student_key`  | BIGINT      | Surrogate key linking the payment to `dim_student_info`. |
| `payment_date` | DATE        | Date the payment was made.                               |
| `amount_paid`  | INT         | Amount paid in whole currency units.                     |
| `payment_mode` | VARCHAR     | Method used to make the payment.                         |

---

## 8. `gold.fact_teacher_assignment`

### Purpose

Records teacher assignments to subjects, classes, and arms during specific academic periods.

**Grain:** One teacher assigned to one subject for one class/arm during one academic year and term.

| Column          | Data Type   | Description                                                                             |
| --------------- | ----------- | --------------------------------------------------------------------------------------- |
| `assignment_id` | VARCHAR(30) | Business identifier assigned to the teacher assignment.                                 |
| `employee_key`  | BIGINT      | Surrogate key linking the assignment to `dim_employee`.                                 |
| `subject_key`   | BIGINT      | Surrogate key linking the assignment to `dim_subjects`.                                 |
| `class`         | VARCHAR(10) | Senior secondary class assigned to the teacher.                                         |
| `arm`           | VARCHAR(3)  | Class arm assigned to the teacher. `ALL` indicates the subject applies across all arms. |
| `academic_year` | VARCHAR(12) | Academic year of the assignment.                                                        |
| `term`          | VARCHAR(5)  | Academic term of the assignment.                                                        |

---

## 9. `gold.fact_enrollment`

### Purpose

Records student enrollment within a class, arm, and academic period.

**Grain:** One student's enrollment for a specific class, arm, academic year, and term.

| Column              | Data Type   | Description                                                 |
| ------------------- | ----------- | ----------------------------------------------------------- |
| `enrollment_id`     | VARCHAR(25) | Business identifier assigned to the enrollment record.      |
| `student_key`       | BIGINT      | Surrogate key linking the enrollment to `dim_student_info`. |
| `class`             | VARCHAR(6)  | Senior secondary class in which the student is enrolled.    |
| `arm`               | VARCHAR(3)  | Class arm assigned to the student.                          |
| `academic_year`     | VARCHAR(12) | Academic year of the enrollment.                            |
| `enrollment_term`   | VARCHAR(5)  | Term in which the enrollment occurred.                      |
| `enrollment_date`   | DATE        | Date the enrollment became effective.                       |
| `exit_year`         | VARCHAR(12) | Academic year in which enrollment ended, where applicable.  |
| `exit_term`         | VARCHAR(5)  | Term in which enrollment ended, where applicable.           |
| `enrollment_status` | VARCHAR(15) | Enrollment status, such as active, left, or graduated.      |

---

## 10. `gold.fact_exam_result`

### Purpose

Records student examination results and connects each result to the student, examination, and subject dimensions.

**Grain:** One student's result for one subject in one examination.

| Column        | Data Type   | Description                                             |
| ------------- | ----------- | ------------------------------------------------------- |
| `result_id`   | VARCHAR(15) | Business identifier assigned to the examination result. |
| `student_key` | BIGINT      | Surrogate key linking the result to `dim_student_info`. |
| `exam_key`    | BIGINT      | Surrogate key linking the result to `dim_exam`.         |
| `subject_key` | BIGINT      | Surrogate key linking the result to `dim_subjects`.     |
| `score`       | INT         | Student's score for the subject in the examination.     |

---

# Data Standards & Constraints

* Academic scope covers **2023/2024 through 2025/2026**.
* The school model covers **SS1, SS2, and SS3**.
* Class arms are **A (Science), B (Arts), and C (Commercial)**.
* **SS3 does not have a third term.**
* `CA` represents continuous assessment and `EX` represents examination.
* Teacher assignments use `ALL` where a subject applies across all arms.
* Student and employee business identifiers are retained in dimensions.
* Surrogate keys are generated in the Gold dimension views and used by related fact views.
* `class`, `academic_year`, and `term` remain attributes of the relevant fact views because separate class, term, or academic-period dimensions are not part of this model.
* Enrollment and teacher assignment are modeled as **factless facts**, as they primarily record business relationships rather than numerical measurements.

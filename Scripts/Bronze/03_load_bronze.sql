/*
=============================================================
Load Bronze Layer
=============================================================
Script Purpose:
    This script loads raw data from source CSV files into the
    Bronze layer tables of the School Data Warehouse.

    Existing Bronze data is truncated before each load to
    ensure a clean and consistent data load.
=============================================================
*/


CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
  DECLARE @start_time DATETIME2;
  DECLARE @end_time DATETIME2;
 BEGIN TRY

 SET @start_time = SYSDATETIME();

   PRINT 'Loading Bronze Layer';
   PRINT '=====================';
   PRINT 'Start Time: ' + CONVERT(VARCHAR, @start_time, 120);
   

   PRINT '------------------------';
   PRINT 'Loading ACADEMICS Tables';
   PRINT '------------------------';

   PRINT '>> Loading Enrollment Data.....'
	TRUNCATE TABLE Bronze.academics_enrollment
	BULK INSERT Bronze.academics_enrollment
	FROM 'C:\Users\DAVID\Documents\Academics\Enrollment01.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

	PRINT '>> Loading Exam Data.....'
	TRUNCATE TABLE Bronze.academics_exam
	BULK INSERT Bronze.academics_exam
	FROM 'C:\Users\DAVID\Documents\Academics\exam.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

	PRINT '>> Loading Exam_Results Data.....'
	TRUNCATE TABLE Bronze.academics_exam_results
	BULK INSERT Bronze.academics_exam_results
	FROM 'C:\Users\DAVID\Documents\Academics\exam_results.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

	PRINT '>> Loading Student_Info Data.....'
	TRUNCATE TABLE Bronze.academics_student_info
	BULK INSERT Bronze.academics_student_info
	FROM 'C:\Users\DAVID\Documents\Academics\student_info.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

	PRINT '>> Loading Subjects Data.....'
	TRUNCATE TABLE Bronze.academics_subjects
	BULK INSERT Bronze.academics_subjects
	FROM 'C:\Users\DAVID\Documents\Academics\subjects.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

   PRINT '------------------------';
   PRINT 'Loading FINANCE Tables';
   PRINT '------------------------';

   PRINT '>> Loading Fee Data.....'
	TRUNCATE TABLE Bronze.finance_fee
	BULK INSERT Bronze.finance_fee
	FROM 'C:\Users\DAVID\Documents\Finance\fee.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 FIELDQUOTE = '"',
	 TABLOCK,
	 MAXERRORS = 100
	);

	PRINT '>> Loading Invoice Data.....'
	TRUNCATE TABLE Bronze.finance_invoice
	BULK INSERT Bronze.finance_invoice
	FROM 'C:\Users\DAVID\Documents\Finance\invoice.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

	PRINT '>> Loading Payment Data.....'
	TRUNCATE TABLE Bronze.finance_payment
	BULK INSERT Bronze.finance_payment
	FROM 'C:\Users\DAVID\Documents\Finance\payment.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

   PRINT '------------------------';
   PRINT 'Loading HR Tables';
   PRINT '------------------------';

   PRINT '>> Loading Employee Data.....'
	TRUNCATE TABLE Bronze.hr_employee
	BULK INSERT Bronze.hr_employee
	FROM 'C:\Users\DAVID\Documents\HR\employee.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

	PRINT '>> Loading Employment Data.....'
	TRUNCATE TABLE Bronze.hr_employment
	BULK INSERT Bronze.hr_employment
	FROM 'C:\Users\DAVID\Documents\HR\employment.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

	PRINT '>> Loading Teacher_Assignment Data.....'
	TRUNCATE TABLE Bronze.hr_teacher_assignment
	BULK INSERT Bronze.hr_teacher_assignment
	FROM 'C:\Users\DAVID\Documents\HR\teacher_assignment.csv'
	WITH(
	 FIELDTERMINATOR = ',',
	 FIRSTROW = 2,
	 ROWTERMINATOR = '0x0a',
	 TABLOCK,
	 MAXERRORS = 100
	);

SET @end_time = SYSDATETIME();

PRINT '================================================';
PRINT 'Bronze Layer Load Completed';
PRINT 'End Time: ' + CONVERT(VARCHAR, @end_time, 120);
PRINT 'Duration: '
    + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(20))
    + ' seconds';
PRINT '================================================';
 END TRY
 BEGIN CATCH

    SET @end_time = SYSDATETIME();

    PRINT '============================================';
    PRINT 'ERROR OCCURRED DURING BRONZE LOAD';
    PRINT '============================================';

    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(10));
    PRINT 'Duration Before Failure: '
        + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(20))
        + ' seconds';

    THROW;

END CATCH
END

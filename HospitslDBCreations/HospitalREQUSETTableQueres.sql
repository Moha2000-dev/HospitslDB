-- 1. List all patients who visited a certain doctor (e.g., Dr. Ahmed Ali)
SELECT P.PatientID, P.Name AS PatientName, D.Name AS DoctorName
FROM Appointments A
JOIN Patients P ON A.PatientID = P.PatientID
JOIN Doctors D ON A.DoctorsID = D.DoctorsID
WHERE D.Name = 'Dr. Ahmed Ali';

-- 2. Count of appointments per department
SELECT D.DepartmentName, COUNT(*) AS AppointmentCount
FROM Appointments A
JOIN Doctors D ON A.DoctorsID = D.DoctorsID
GROUP BY D.DepartmentName;

-- 3. Retrieve doctors who have more than 5 appointments in a month
SELECT D.DoctorsID, D.Name AS DoctorName, COUNT(*) AS TotalAppointments
FROM Appointments A
JOIN Doctors D ON A.DoctorsID = D.DoctorsID
WHERE MONTH(A.Time) = 6 AND YEAR(A.Time) = 2024
GROUP BY D.DoctorsID, D.Name
HAVING COUNT(*) > 5;

-- 4. JOIN across 3–4 tables: Patient, Doctor, Department, MedicalRecords
SELECT P.Name AS PatientName, D.Name AS DoctorName, D.DepartmentName, M.Diagnosis
FROM MedicalRecords M
JOIN Patients P ON M.PatientID = P.PatientID
JOIN Doctors D ON M.DoctorsID = D.DoctorsID;

-- 5. Use GROUP BY, HAVING, and aggregate: Average service cost per department
SELECT D.DepartmentName, AVG(S.ServiceCost) AS AvgCost
FROM Services S
JOIN Billing B ON S.BillingID = B.BillingID
JOIN Patients P ON B.PatientID = P.PatientID
JOIN MedicalRecords M ON M.PatientID = P.PatientID
JOIN Doctors D ON M.DoctorsID = D.DoctorsID
GROUP BY D.DepartmentName
HAVING AVG(S.ServiceCost) > 300;

-- 6. Use EXISTS: List patients who have medical records
SELECT P.Name
FROM Patients P
WHERE EXISTS (
    SELECT 1 FROM MedicalRecords M
    WHERE M.PatientID = P.PatientID
);

-- 7. Use NOT EXISTS: List patients who never had an appointment
SELECT P.Name
FROM Patients P
WHERE NOT EXISTS (
    SELECT 1 FROM Appointments A
    WHERE A.PatientID = P.PatientID
);

-- 8. Total services and cost per patient
SELECT P.Name AS PatientName, COUNT(S.ServiceID) AS ServicesReceived, SUM(S.ServiceCost) AS TotalCost
FROM Patients P
JOIN Billing B ON P.PatientID = B.PatientID
JOIN Services S ON B.BillingID = S.BillingID
GROUP BY P.Name;

-- 9. Find doctors who treated patients for 'Cancer'
SELECT DISTINCT D.Name AS DoctorName
FROM MedicalRecords M
JOIN Doctors D ON M.DoctorsID = D.DoctorsID
WHERE CAST(M.Diagnosis AS VARCHAR(100)) = 'Cancer';

-- 10. Number of admissions per room
SELECT R.RoomNumber, COUNT(*) AS AdmissionsCount
FROM Admit A
JOIN Room R ON A.RoomNumber = R.RoomNumber
GROUP BY R.RoomNumber;

-- 11. List doctors who are available (Availability = 1) and have future appointments
SELECT DISTINCT D.Name
FROM Doctors D
JOIN Appointments A ON D.DoctorsID = A.DoctorsID
WHERE D.Availability = 1 AND A.Time > GETDATE();

-- 12. Top 3 departments with most appointments
SELECT TOP 3 D.DepartmentName, COUNT(*) AS AppointmentsCount
FROM Appointments A
JOIN Doctors D ON A.DoctorsID = D.DoctorsID
GROUP BY D.DepartmentName
ORDER BY AppointmentsCount DESC;
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Functions & Stored Procedures//////////////////////////////////////////////////////////////////////////////////////////////////
--  1. Scalar function to calculate patient age from DOB
GO
CREATE FUNCTION dbo.GetPatientAge(@DOB DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DOB, GETDATE())
END;
GO


--  2. Procedure to admit a patient (adds admission + updates room)
GO
CREATE PROCEDURE AdmitPatient
    @PatientID INT,
    @DateIn DATE,
    @DateOut DATE,
    @RoomNumber INT
AS
BEGIN
    INSERT INTO Admit (PatientID, DateIn, DateOut, RoomNumber)
    VALUES (@PatientID, @DateIn, @DateOut, @RoomNumber);

    UPDATE Room
    SET Availability = 0
    WHERE RoomNumber = @RoomNumber;
END;
GO


--  3. Procedure to generate invoice (adds record into Billing)
GO
CREATE PROCEDURE GenerateInvoice
    @PatientID INT,
    @Diagnosis VARCHAR(100),
    @InsuranceDiscount DECIMAL(5,2),
    @Date DATE
AS
BEGIN
    INSERT INTO Billing (PatientID, Diagnosis, InsuranceDiscount, Date)
    VALUES (@PatientID, @Diagnosis, @InsuranceDiscount, @Date);
END;
GO


--  4. Procedure to assign doctor to department and shift
GO
CREATE PROCEDURE AssignDoctorToDepartment
    @StaffID INT,
    @DoctorsID INT,
    @DepartmentName VARCHAR(100),
    @DepartmentNumber INT,
    @Shift VARCHAR(50)
AS
BEGIN
    UPDATE Staff
    SET DoctorsID = @DoctorsID,
        DepartmentName = @DepartmentName,
        DepartmentNumber = @DepartmentNumber,
        Shift = @Shift
    WHERE StaffID = @StaffID;
END;
GO


--  5. : Procedure to mark a room as available ( after discharge)
GO
CREATE PROCEDURE MarkRoomAvailable
    @RoomNumber INT
AS
BEGIN
    UPDATE Room
    SET Availability = 1
    WHERE RoomNumber = @RoomNumber;
END;
GO


--  6.: Procedure to delete a patient and related data ( billing & admit)
GO
CREATE PROCEDURE DeletePatientData
    @PatientID INT
AS
BEGIN
    DELETE FROM Billing WHERE PatientID = @PatientID;
    DELETE FROM Admit WHERE PatientID = @PatientID;
    DELETE FROM Appointments WHERE PatientID = @PatientID;
    DELETE FROM MedicalRecords WHERE PatientID = @PatientID;
    DELETE FROM Patients WHERE PatientID = @PatientID;
END;
GO
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// triggers //////////////////////////////////////////////////////////////////////////////////////////////////
--  1. AFTER INSERT on Appointments then Automatically insert into MedicalRecords
GO
CREATE TRIGGER trg_AutoInsertMedicalRecord
ON Appointments
AFTER INSERT
AS
BEGIN
    INSERT INTO MedicalRecords (PatientID, DoctorsID, MedicalRecordsID, Diagnosis, TreatmentPlans, Date, Notes)
    SELECT 
        i.PatientID,
        i.DoctorsID,
        (SELECT ISNULL(MAX(MedicalRecordsID), 0) + 1 FROM MedicalRecords),  -- auto ID
        'To be updated',
        'To be updated',
        GETDATE(),
        'Auto-generated from appointment'
    FROM inserted i;
END;
GO

--  2. INSTEAD OF DELETE on Patients then Prevent deletion if billing exists
GO
CREATE TRIGGER trg_PreventDeletePatientWithBills
ON Patients
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Billing B
        JOIN deleted d ON B.PatientID = d.PatientID
    )
    BEGIN
        RAISERROR('Cannot delete patient with existing billing records.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM Patients WHERE PatientID IN (SELECT PatientID FROM deleted);
    END
END;
GO

--  3. AFTER UPDATE on Room  Prevent multiple patients in same room
GO
CREATE TRIGGER trg_NoDoubleOccupancy
ON Admit
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT RoomNumber
        FROM Admit
        GROUP BY RoomNumber, DateIn, DateOut
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR('Room conflict detected: two patients in the same room.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--  4. EXTRA: Prevent Appointments in the past
GO
CREATE TRIGGER trg_NoPastAppointments
ON Appointments
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted WHERE Time < GETDATE()
    )
    BEGIN
        RAISERROR('Cannot schedule appointment in the past.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--  5. EXTRA: After new Billing then insert default Service
GO
CREATE TRIGGER trg_DefaultServiceOnBilling
ON Billing
AFTER INSERT
AS
BEGIN
    INSERT INTO Services (BillingID, Service, ServiceCost)
    SELECT i.BillingID, 'General Consultation', 100.00
    FROM inserted i;
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// SQL Security //////////////////////////////////////////////////////////////////////////////////////////////////
--  Create Roles
CREATE ROLE DoctorUser;
CREATE ROLE AdminUser;

--  Grant SELECT only on Patients and Appointments to DoctorUser
GRANT SELECT ON Patients TO DoctorUser;
GRANT SELECT ON Appointments TO DoctorUser;

--  Grant INSERT, UPDATE on ALL tables to AdminUser
GRANT INSERT, UPDATE ON DATABASE::HospitalDB TO AdminUser;

--  Revoke DELETE permission on Doctors from everyone (or specific role if needed)
REVOKE DELETE ON Doctors TO PUBLIC; -- Or use: TO DoctorUser / AdminUser

--  EXTRA 1: Prevent DoctorUser from updating Patients table
DENY UPDATE ON Patients TO DoctorUser;

--  EXTRA 2: Allow AdminUser to create stored procedures (for automation tasks)
GRANT CREATE PROCEDURE TO AdminUser;
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////Transaction Control Language//////////////////////////////////////////////////////////////////////////////////////////////

--  Simulate a transaction: admit patient + update room + create billing + record service
BEGIN TRANSACTION;

BEGIN TRY
    --  Insert into Admit table
    INSERT INTO Admit (PatientID, DateIn, DateOut, RoomNumber)
    VALUES (21, '2025-06-25', '2025-06-30', 1);

    --  Update Room availability
    UPDATE Room
    SET Availability = 0
    WHERE RoomNumber = 1;

    --  Insert into Billing
    INSERT INTO Billing (BillingID, PatientID, Diagnosis, InsuranceDiscount, Date)
    VALUES (21, 21, 'Infection', 0.10, GETDATE());

    --  EXTRA: Insert a service linked to billing
    INSERT INTO Services (ServiceID, BillingID, Service, ServiceCost)
    VALUES (21, 21, 'Antibiotics Therapy', 250.00);

    --  EXTRA: Log to MedicalRecords for reference
    INSERT INTO MedicalRecords (PatientID, DoctorsID, MedicalRecordsID, Diagnosis, TreatmentPlans, Date, Notes)
    VALUES (21, 5, 21, 'Infection', 'Antibiotics', GETDATE(), 'Auto-log from transaction');

    --  Commit all if successful
    COMMIT;
    PRINT 'Transaction completed successfully.';

END TRY
BEGIN CATCH
    --  Rollback if any error occurs
    ROLLBACK;
    PRINT 'Transaction failed. Rolled back due to error: ' + ERROR_MESSAGE();
END CATCH;
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Views //////////////////////////////////////////////////////////////////////////////////////////////
--  1. vw_DoctorSchedule: Upcoming appointments per doctor
GO
CREATE VIEW vw_DoctorSchedule AS
SELECT 
    D.DoctorsID,
    D.Name AS DoctorName,
    A.PatientID,
    A.Time AS AppointmentTime
FROM Doctors D
JOIN Appointments A ON D.DoctorsID = A.DoctorsID
WHERE A.Time > GETDATE();
GO

--  2. vw_PatientSummary: Patient info with latest visit
GO
CREATE VIEW vw_PatientSummary AS
SELECT 
    P.PatientID,
    P.Name AS PatientName,
    MAX(A.Time) AS LastVisit
FROM Patients P
LEFT JOIN Appointments A ON P.PatientID = A.PatientID
GROUP BY P.PatientID, P.Name;
GO

-- 3. vw_DepartmentStats: Number of doctors and patients per department
GO
CREATE VIEW vw_DepartmentStats AS
SELECT 
    D.DepartmentName,
    COUNT(DISTINCT Doc.DoctorsID) AS TotalDoctors,
    COUNT(DISTINCT A.PatientID) AS TotalPatients
FROM Departments D
LEFT JOIN Staff S ON D.DepartmentNumber = S.DepartmentNumber
LEFT JOIN Doctors Doc ON S.DoctorsID = Doc.DoctorsID
LEFT JOIN Appointments A ON Doc.DoctorsID = A.DoctorsID
GROUP BY D.DepartmentName;
GO

-- 4. vw_ServiceCosts: Total cost of services per patient
GO
CREATE VIEW vw_ServiceCosts AS
SELECT 
    B.PatientID,
    SUM(S.ServiceCost) AS TotalServiceCost
FROM Billing B
JOIN Services S ON B.BillingID = S.BillingID
GROUP BY B.PatientID;
GO

-- 5. vw_UpcomingAdmissions: Patients with scheduled admissions
GO
CREATE VIEW vw_UpcomingAdmissions AS
SELECT 
    A.PatientID,
    A.RoomNumber,
    A.DateIn,
    A.DateOut
FROM Admit A
WHERE A.DateIn > GETDATE();
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////// JOB //////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////DR REPORT 
CREATE TABLE DoctorDailyScheduleLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    LogDate DATETIME DEFAULT GETDATE(),
    DoctorID INT,
    DoctorName VARCHAR(100),
    AppointmentTime DATETIME,
    PatientID INT
);
GO
CREATE PROCEDURE InsertDailyDoctorSchedule
AS
BEGIN
    INSERT INTO DoctorDailyScheduleLog (DoctorID, DoctorName, AppointmentTime, PatientID)
    SELECT 
        D.DoctorsID, 
        D.Name,
        A.Time,
        A.PatientID
    FROM Appointments A
    JOIN Doctors D ON A.DoctorsID = D.DoctorsID
    WHERE CONVERT(DATE, A.Time) = CONVERT(DATE, GETDATE());
END;
GO

-- Create the job
EXEC msdb.dbo.sp_add_job  
    @job_name = N'Doctor_Daily_Schedule_Report';  

-- Add the job step
EXEC msdb.dbo.sp_add_jobstep  
    @job_name = N'Doctor_Daily_Schedule_Report',
    @step_name = N'Run InsertDailyDoctorSchedule',
    @subsystem = N'TSQL',
    @command = N'EXEC InsertDailyDoctorSchedule;',
    @database_name = N'HospitalDB';

-- Create a 7:00 AM daily schedule
EXEC msdb.dbo.sp_add_schedule  
    @schedule_name = N'Daily_7AM_Schedule',  
    @freq_type = 4,  -- Daily
    @freq_interval = 1,  -- Every day
    @active_start_time = 111200;  -- 07:00 AM

-- Attach the schedule to the job
EXEC msdb.dbo.sp_attach_schedule  
    @job_name = N'Doctor_Daily_Schedule_Report',  
    @schedule_name = N'Daily_7AM_Schedule';

-- Add the job to the server
EXEC msdb.dbo.sp_add_jobserver  
    @job_name = N'Doctor_Daily_Schedule_Report';



--////////////////////////BACKUP////////////////////////

-- Step 1: Create the backup job
EXEC msdb.dbo.sp_add_job  
    @job_name = N'Daily_HospitalDB_Backup';  

-- Step 2: Add a step to perform the database backup
EXEC msdb.dbo.sp_add_jobstep  
    @job_name = N'Daily_HospitalDB_Backup',
    @step_name = N'Backup HospitalDB',
    @subsystem = N'TSQL',
    @command = N'
        BACKUP DATABASE HospitalDB 
        TO DISK = ''C:\Backups\HospitalDB.bak'' 
        WITH FORMAT, INIT, NAME = ''Full Backup of HospitalDB'', SKIP, NOREWIND, NOUNLOAD, STATS = 10;
    ',
    @database_name = N'master';

-- Step 3: Create a schedule for 2:00 AM daily
EXEC msdb.dbo.sp_add_schedule  
    @schedule_name = N'Daily_2AM_Schedule',  
    @freq_type = 4,  -- Daily  
    @freq_interval = 1,  -- Every day  
    @active_start_time = 020000;  -- 2:00 AM (HHMMSS)

-- Step 4: Attach the schedule to the job
EXEC msdb.dbo.sp_attach_schedule  
   @job_name = N'Daily_HospitalDB_Backup',  
   @schedule_name = N'Daily_2AM_Schedule';

-- Step 5: Add the job to the server
EXEC msdb.dbo.sp_add_jobserver  
    @job_name = N'Daily_HospitalDB_Backup';

--/////////////////////////////////////////////////////////////////////////BOUNES ////////////////////////////////////
-- Add job step to check appointments and send email
EXEC msdb.dbo.sp_add_jobstep  
    @job_name = N'DoctorAppointmentAlert_5Appointments',
    @step_name = N'CheckAndSendEmail',
    @subsystem = N'TSQL',
    @command = N'
IF EXISTS (
    SELECT DoctorsID 
    FROM Appointments
    WHERE CAST(Time AS DATE) = CAST(GETDATE() AS DATE)
    GROUP BY DoctorsID
    HAVING COUNT(*) > 5
)
BEGIN
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = ''YourMailProfile'',  -- Replace with actual Database Mail profile
        @recipients = ''ahmad.k@hospital.com'',
        @subject = ''Doctor Appointment Alert'',
        @body = ''At least one doctor has more than 5 appointments today.'';
END
',
    @database_name = N'HospitalDB';

-- Optional: Add daily schedule at 9 AM
EXEC msdb.dbo.sp_add_schedule  
    @schedule_name = N'Daily_9AM_AppointmentAlert',  
    @freq_type = 4,           -- Daily  
    @freq_interval = 1,       -- Every 1 day  
    @active_start_time = 090000;  -- 9:00 AM


-- Attach schedule to job
EXEC msdb.dbo.sp_attach_schedule  
    @job_name = N'DoctorAppointmentAlert_5Appointments',  
    @schedule_name = N'Daily_9AM_AppointmentAlert';

-- Add job to server
EXEC msdb.dbo.sp_add_jobserver  
    @job_name = N'DoctorAppointmentAlert_5Appointments';




--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Bounes  2///////////////////////////////////////////////////////////////////////
-- 1. Enable advanced options and CmdExec
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Agent XPs', 1;
RECONFIGURE;
EXEC sp_configure 'allow updates', 0;
RECONFIGURE;


-- Enable CmdExec
USE msdb;
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Agent XPs', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- 2. Create folder for export (manually or via powershell from SQLCMD)
EXEC xp_cmdshell 'mkdir C:\Exports';


-- 3. Create the Job
EXEC msdb.dbo.sp_add_job  
    @job_name = N'Weekly_Billing_Export';

-- 4. Add Step to run bcp export
EXEC msdb.dbo.sp_add_jobstep  
    @job_name = N'Weekly_Billing_Export',
    @step_name = N'ExportBillingCSV',
    @subsystem = N'CmdExec',
    @command = N'bcp "SELECT * FROM HospitalDB.dbo.Billing" queryout "C:\Exports\BillingSummary.csv" -c -t, -T -S localhost',
    @retry_attempts = 1,
    @retry_interval = 5;

-- 5. Create schedule to run every Sunday at 9:00 AM
-- 5. Create schedule to run every Sunday at 9:00 AM
EXEC msdb.dbo.sp_add_schedule  
    @schedule_name = N'Weekly_Sunday_9AM',  
    @freq_type = 8,               -- Weekly  
    @freq_interval = 1,          -- Sunday  
    @freq_recurrence_factor = 1, -- Every 1 week  
    @active_start_time = 090000; -- 9:00 AM


-- 6. Attach schedule to job
EXEC msdb.dbo.sp_attach_schedule  
    @job_name = N'Weekly_Billing_Export',  
    @schedule_name = N'Weekly_Sunday_9AM';

-- 7. Enable job server
EXEC msdb.dbo.sp_add_jobserver  
    @job_name = N'Weekly_Billing_Export';


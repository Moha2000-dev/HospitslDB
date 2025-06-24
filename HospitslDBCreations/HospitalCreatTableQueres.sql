-- Create the database
CREATE DATABASE HospitalDB;

-- Switch to the database
USE HospitalDB;

-- 1. Departments
CREATE TABLE Departments (
    DepartmentNumber INT,
    DepartmentName VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Departments PRIMARY KEY (DepartmentNumber)
);

-- 2. Patients
CREATE TABLE Patients (
    PatientID INT,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Gender VARCHAR(10),
    Name VARCHAR(100),
    DOB DATE,
    PhoneNumbers VARCHAR(100),
    CONSTRAINT PK_Patients PRIMARY KEY (PatientID)
);

-- 3. Room
CREATE TABLE Room (
    RoomNumber INT,
    RoomType VARCHAR(50),
    Availability BIT,
    CONSTRAINT PK_Room PRIMARY KEY (RoomNumber)
);

-- 4. Doctors
CREATE TABLE Doctors (
    DoctorsID INT,
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    Specialization VARCHAR(100),
    Availability BIT,
    DepartmentName VARCHAR(100),
    DepartmentNumber INT,
    StaffID INT,
    CONSTRAINT PK_Doctors PRIMARY KEY (DoctorsID),
    CONSTRAINT FK_Doctors_Department FOREIGN KEY (DepartmentNumber) REFERENCES Departments(DepartmentNumber)
);

-- 5. Admit
CREATE TABLE Admit (
    RoomNumber INT,
    DateIn DATE,
    DateOut DATE,
    PatientID INT,
    CONSTRAINT PK_Admit PRIMARY KEY (RoomNumber, PatientID),
    CONSTRAINT FK_Admit_Room FOREIGN KEY (RoomNumber) REFERENCES Room(RoomNumber),
    CONSTRAINT FK_Admit_Patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- 6. Appointments
CREATE TABLE Appointments (
    PatientID INT,
    DoctorsID INT,
    Time DATETIME,
    CONSTRAINT PK_Appointments PRIMARY KEY (PatientID, DoctorsID, Time),
    CONSTRAINT FK_Appointments_Patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT FK_Appointments_Doctor FOREIGN KEY (DoctorsID) REFERENCES Doctors(DoctorsID)
);

-- 7. MedicalRecords
CREATE TABLE MedicalRecords (
    PatientID INT,
    DoctorsID INT,
    MedicalRecordsID INT,
    Diagnosis TEXT,
    TreatmentPlans TEXT,
    Date DATE,
    Notes TEXT,
    CONSTRAINT PK_MedicalRecords PRIMARY KEY (MedicalRecordsID),
    CONSTRAINT FK_MedicalRecords_Patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT FK_MedicalRecords_Doctor FOREIGN KEY (DoctorsID) REFERENCES Doctors(DoctorsID)
);

-- 8. Billing
CREATE TABLE Billing (
    PatientID INT,
    BillingID INT,
    Diagnosis TEXT,
    InsuranceDiscount DECIMAL(10,2),
    Date DATE,
    CONSTRAINT PK_Billing PRIMARY KEY (BillingID),
    CONSTRAINT FK_Billing_Patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- 9. Services
CREATE TABLE Services (
    ServiceID INT,
    BillingID INT,
    Service VARCHAR(100),
    ServiceCost DECIMAL(10,2),
    CONSTRAINT PK_Services PRIMARY KEY (ServiceID),
    CONSTRAINT FK_Services_Billing FOREIGN KEY (BillingID) REFERENCES Billing(BillingID)
);

-- 10. Staff
CREATE TABLE Staff (
    StaffID INT,
    ServiceID INT,
    AssignedDep VARCHAR(100),
    Shift VARCHAR(50),
    DoctorsID INT,
    DepartmentName VARCHAR(100),
    DepartmentNumber INT,
    CONSTRAINT PK_Staff PRIMARY KEY (StaffID),
    CONSTRAINT FK_Staff_Service FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),
    CONSTRAINT FK_Staff_Doctor FOREIGN KEY (DoctorsID) REFERENCES Doctors(DoctorsID),
    CONSTRAINT FK_Staff_Department FOREIGN KEY (DepartmentNumber) REFERENCES Departments(DepartmentNumber)
);

-- 11. Users
CREATE TABLE Users (
    UserName VARCHAR(50),
    Password VARCHAR(100),
    Role VARCHAR(50),
    Shift VARCHAR(50),
    StaffID INT,
    CONSTRAINT PK_Users PRIMARY KEY (UserName),
    CONSTRAINT FK_Users_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
-- 12.PHONES 
CREATE TABLE PatientPhoneNumbers (
    PatientID INT NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    CONSTRAINT PK_PatientPhone PRIMARY KEY (PatientID, PhoneNumber),
    CONSTRAINT FK_PatientPhone_Patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);



ALTER TABLE Doctors
ADD Name VARCHAR(100);

ALTER TABLE Users
DROP COLUMN Shift;


UPDATE Doctors SET Name = 'Dr. Ahmed Ali' WHERE DoctorsID = 1;
UPDATE Doctors SET Name = 'Dr. Fatima Noor' WHERE DoctorsID = 2;
UPDATE Doctors SET Name = 'Dr. Khalid Zahir' WHERE DoctorsID = 3;
UPDATE Doctors SET Name = 'Dr. Layla Hamed' WHERE DoctorsID = 4;
UPDATE Doctors SET Name = 'Dr. Omar Yasin' WHERE DoctorsID = 5;
UPDATE Doctors SET Name = 'Dr. Salma Jaber' WHERE DoctorsID = 6;
UPDATE Doctors SET Name = 'Dr. Tariq Hussein' WHERE DoctorsID = 7;
UPDATE Doctors SET Name = 'Dr. Maha Saif' WHERE DoctorsID = 8;
UPDATE Doctors SET Name = 'Dr. Youssef Nabil' WHERE DoctorsID = 9;
UPDATE Doctors SET Name = 'Dr. Rania Adel' WHERE DoctorsID = 10;
UPDATE Doctors SET Name = 'Dr. Sami Ghanem' WHERE DoctorsID = 11;
UPDATE Doctors SET Name = 'Dr. Noor Alwani' WHERE DoctorsID = 12;
UPDATE Doctors SET Name = 'Dr. Bassam Halim' WHERE DoctorsID = 13;
UPDATE Doctors SET Name = 'Dr. Huda Saleh' WHERE DoctorsID = 14;
UPDATE Doctors SET Name = 'Dr. Zainab Tariq' WHERE DoctorsID = 15;
UPDATE Doctors SET Name = 'Dr. Fadi Kassem' WHERE DoctorsID = 16;
UPDATE Doctors SET Name = 'Dr. Amal Younis' WHERE DoctorsID = 17;
UPDATE Doctors SET Name = 'Dr. Waleed Fahad' WHERE DoctorsID = 18;
UPDATE Doctors SET Name = 'Dr. Mona Eissa' WHERE DoctorsID = 19;
UPDATE Doctors SET Name = 'Dr. Hussein Maher' WHERE DoctorsID = 20;

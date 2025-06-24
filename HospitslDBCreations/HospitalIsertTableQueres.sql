
-- 1. insert Departments  data
INSERT INTO Departments (DepartmentName, DepartmentNumber) VALUES
('Cardiology', 101),
('Neurology', 102),
('Orthopedics', 103),
('Pediatrics', 104),
('Oncology', 105),
('Radiology', 106),
('Surgery', 107),
('Emergency', 108),
('Dermatology', 109),
('Urology', 110),
('ENT', 111),
('Gastroenterology', 112),
('Endocrinology', 113),
('Nephrology', 114),
('Psychiatry', 115),
('Ophthalmology', 116),
('Hematology', 117),
('Pulmonology', 118),
('Infectious Diseases', 119),
('Rehabilitation', 120);


-- 2. insert Patients  data
INSERT INTO Patients (PatientID, Email, Gender, Name, DOB) VALUES
(1, 'ali@example.com', 'Male', 'Ali Nasser', '1990-01-01'),
(2, 'fatma@example.com', 'Female', 'Fatma Said', '1995-03-12'),
(3, 'khalid@example.com', 'Male', 'Khalid Amer', '1988-07-21'),
(4, 'salma@example.com', 'Female', 'Salma Noor', '1992-06-30'),
(5, 'hassan@example.com', 'Male', 'Hassan Mubarak', '1985-09-10'),
(6, 'layla@example.com', 'Female', 'Layla Rashid', '1997-11-25'),
(7, 'ahmed@example.com', 'Male', 'Ahmed Majid', '1994-02-14'),
(8, 'noor@example.com', 'Female', 'Noor Hana', '2000-05-05'),
(9, 'yousef@example.com', 'Male', 'Yousef Nabil', '1989-12-18'),
(10, 'reem@example.com', 'Female', 'Reem Talib', '1993-08-07'),
(11, 'salim@example.com', 'Male', 'Salim Saif', '1991-04-22'),
(12, 'iman@example.com', 'Female', 'Iman Basma', '1996-10-19'),
(13, 'omar@example.com', 'Male', 'Omar Hilal', '1987-03-03'),
(14, 'sara@example.com', 'Female', 'Sara Jamila', '1999-09-09'),
(15, 'majed@example.com', 'Male', 'Majed Tarek', '1988-12-01'),
(16, 'mona@example.com', 'Female', 'Mona Zeinab', '1990-06-11'),
(17, 'fahad@example.com', 'Male', 'Fahad Qasim', '1986-05-17'),
(18, 'huda@example.com', 'Female', 'Huda Siham', '1992-01-28'),
(19, 'zayed@example.com', 'Male', 'Zayed Tariq', '1994-07-13'),
(20, 'asma@example.com', 'Female', 'Asma Layth', '2001-10-03');


-- 3. insert PatientPhoneNumbers  data
INSERT INTO PatientPhoneNumbers (PatientID, PhoneNumber) VALUES
(1, '967402644'),
(2, '951752555'),
(3, '929022986'),
(4, '955427564'),
(5, '911988976'),
(6, '937688488'),
(7, '971142478'),
(8, '922579413'),
(9, '962510991'),
(10, '937281782'),
(11, '960643238'),
(12, '971168300'),
(13, '948096137'),
(14, '950515521'),
(15, '988716539'),
(16, '971292399'),
(17, '983255336'),
(18, '923090320'),
(19, '976199456'),
(20, '947122047');



-- 4.  insert Rooms data
INSERT INTO Room (RoomNumber, RoomType, Availability) VALUES
(1, 'Private', 0),
(2, 'General', 1),
(3, 'Semi-Private',1),
(4, 'Private', 1),
(5, 'General', 0),
(6, 'ICU', 1),
(7, 'Semi-Private', 0),
(8, 'Semi-Private', 0),
(9, 'ICU', 0),
(10, 'Semi-Private', 0),
(11, 'Private', 1),
(12, 'Semi-Private', 0),
(13, 'Private', 0),
(14, 'ICU', 0),
(15, 'Private', 1),
(16, 'ICU', 1),
(17, 'Semi-Private', 1),
(18, 'Private', 1),
(19, 'ICU', 0),
(20, 'General', 1);

-- 5. insert Doctors  data
INSERT INTO Doctors (DoctorsID, PhoneNumber, Email, Specialization, Availability, DepartmentName, DepartmentNumber, StaffID)
VALUES
(1, '912345678', 'ahmad.k@hospital.com', 'Cardiology', 1, 'Cardiology', 101, 1),
(2, '912345679', 'sara.n@hospital.com', 'Neurology', 1, 'Neurology', 102, 2),
(3, '913456780', 'khaled.h@hospital.com', 'Orthopedics', 0, 'Orthopedics', 103, 3),
(4, '914567891', 'salma.f@hospital.com', 'Pediatrics', 1, 'Pediatrics', 104, 4),
(5, '915678902', 'hassan.m@hospital.com', 'Oncology', 0, 'Oncology', 105, 5),
(6, '916789013', 'layla.r@hospital.com', 'Radiology', 1, 'Radiology', 106, 6),
(7, '917890124', 'ahmed.j@hospital.com', 'Surgery', 1, 'Surgery', 107, 7),
(8, '918901235', 'noor.a@hospital.com', 'Emergency', 1, 'Emergency', 108, 8),
(9, '919012346', 'yousef.k@hospital.com', 'Dermatology', 0, 'Dermatology', 109, 9),
(10, '920123457', 'reem.s@hospital.com', 'Urology', 1, 'Urology', 110, 10),
(11, '921234568', 'salim.b@hospital.com', 'ENT', 0, 'ENT', 111, 11),
(12, '922345679', 'iman.z@hospital.com', 'Gastroenterology', 1, 'Gastroenterology', 112, 12),
(13, '923456780', 'omar.l@hospital.com', 'Endocrinology', 0, 'Endocrinology', 113, 13),
(14, '924567891', 'sara.k@hospital.com', 'Nephrology', 1, 'Nephrology', 114, 14),
(15, '925678902', 'majed.t@hospital.com', 'Psychiatry', 1, 'Psychiatry', 115, 15),
(16, '926789013', 'mona.y@hospital.com', 'Ophthalmology', 0, 'Ophthalmology', 116, 16),
(17, '927890124', 'fahad.q@hospital.com', 'Hematology', 1, 'Hematology', 117, 17),
(18, '928901235', 'huda.e@hospital.com', 'Pulmonology', 1, 'Pulmonology', 118, 18),
(19, '929012346', 'zayed.i@hospital.com', 'Infectious Diseases', 0, 'Infectious Diseases', 119, 19),
(20, '930123457', 'asma.a@hospital.com', 'Rehabilitation', 1, 'Rehabilitation', 120, 20);


--6. insert Billing data
INSERT INTO Billing (BillingID, PatientID, Diagnosis, InsuranceDiscount, Date)
VALUES
(1, 1, 'Diabetes', 0.10, '2024-01-10'),
(2, 2, 'Hypertension', 0.15, '2024-01-12'),
(3, 3, 'Flu', 0.05, '2024-01-13'),
(4, 4, 'Fracture', 0.20, '2024-01-14'),
(5, 5, 'Asthma', 0.10, '2024-01-15'),
(6, 6, 'Allergy', 0.10, '2024-01-16'),
(7, 7, 'Infection', 0.05, '2024-01-17'),
(8, 8, 'COVID-19', 0.20, '2024-01-18'),
(9, 9, 'Migraine', 0.05, '2024-01-19'),
(10, 10, 'Obesity', 0.15, '2024-01-20'),
(11, 11, 'Arthritis', 0.10, '2024-01-21'),
(12, 12, 'Depression', 0.05, '2024-01-22'),
(13, 13, 'Ulcer', 0.10, '2024-01-23'),
(14, 14, 'Cyst', 0.10, '2024-01-24'),
(15, 15, 'Kidney Stones', 0.15, '2024-01-25'),
(16, 16, 'Heart Disease', 0.20, '2024-01-26'),
(17, 17, 'Fever', 0.05, '2024-01-27'),
(18, 18, 'Cancer', 0.25, '2024-01-28'),
(19, 19, 'Back Pain', 0.05, '2024-01-29'),
(20, 20, 'Skin Rash', 0.10, '2024-01-30');

--7.  insert Services  data
INSERT INTO Services (ServiceID, BillingID, Service, ServiceCost) VALUES
(1, 1, 'X-Ray', 150.00),
(2, 2, 'MRI Scan', 1200.00),
(3, 3, 'Blood Test', 75.00),
(4, 4, 'CT Scan', 1000.00),
(5, 5, 'Ultrasound', 300.00),
(6, 6, 'ECG', 200.00),
(7, 7, 'Surgery - Minor', 2500.00),
(8, 8, 'Surgery - Major', 8000.00),
(9, 9, 'Consultation', 100.00),
(10, 10, 'Physical Therapy', 500.00),
(11, 11, 'Vaccination', 50.00),
(12, 12, 'Endoscopy', 700.00),
(13, 13, 'Dialysis', 600.00),
(14, 14, 'Chemotherapy', 3000.00),
(15, 15, 'Radiation Therapy', 4000.00),
(16, 16, 'Psych Evaluation', 450.00),
(17, 17, 'Orthopedic Service', 1000.00),
(18, 18, 'Dermatology Checkup', 150.00),
(19, 19, 'Eye Exam', 120.00),
(20, 20, 'Dental Cleaning', 200.00);


--8. insert Staff  data
INSERT INTO Staff (StaffID, serviceID, AssignedDep, shift, DoctorsID, DepartmentName, DepartmentNumber)
VALUES
(1, 201, 'Cardiology', 'Morning', 1, 'Cardiology', 101),
(2, 202, 'Neurology', 'Evening', 2, 'Neurology', 102),
(3, 203, 'Orthopedics', 'Night', 3, 'Orthopedics', 103),
(4, 204, 'Pediatrics', 'Morning', 4, 'Pediatrics', 104),
(5, 205, 'Oncology', 'Evening', 5, 'Oncology', 105),
(6, 206, 'Radiology', 'Night', 6, 'Radiology', 106),
(7, 207, 'Surgery', 'Morning', 7, 'Surgery', 107),
(8, 208, 'Emergency', 'Evening', 8, 'Emergency', 108),
(9, 209, 'Dermatology', 'Night', 9, 'Dermatology', 109),
(10, 210, 'Urology', 'Morning', 10, 'Urology', 110),
(11, 211, 'ENT', 'Evening', 11, 'ENT', 111),
(12, 212, 'Gastroenterology', 'Night', 12, 'Gastroenterology', 112),
(13, 213, 'Endocrinology', 'Morning', 13, 'Endocrinology', 113),
(14, 214, 'Nephrology', 'Evening', 14, 'Nephrology', 114),
(15, 215, 'Psychiatry', 'Night', 15, 'Psychiatry', 115),
(16, 216, 'Ophthalmology', 'Morning', 16, 'Ophthalmology', 116),
(17, 217, 'Hematology', 'Evening', 17, 'Hematology', 117),
(18, 218, 'Pulmonology', 'Night', 18, 'Pulmonology', 118),
(19, 219, 'Infectious Diseases', 'Morning', 19, 'Infectious Diseases', 119),
(20, 220, 'Rehabilitation', 'Evening', 20, 'Rehabilitation', 120);


--9.  insert StaffID   data
INSERT INTO Staff (StaffID, ServiceID, AssignedDep, Shift, DoctorsID, DepartmentName, DepartmentNumber)
VALUES
(201, 1, 'Cardiology', 'Morning', 1, 'Cardiology', 101),
(202, 2, 'Neurology', 'Evening', 2, 'Neurology', 102),
(203, 3, 'Orthopedics', 'Night', 3, 'Orthopedics', 103),
(204, 4, 'Pediatrics', 'Morning', 4, 'Pediatrics', 104),
(205, 5, 'Oncology', 'Evening', 5, 'Oncology', 105),
(206, 6, 'Radiology', 'Night', 6, 'Radiology', 106),
(207, 7, 'Surgery', 'Morning', 7, 'Surgery', 107),
(208, 8, 'Emergency', 'Evening', 8, 'Emergency', 108),
(209, 9, 'Dermatology', 'Night', 9, 'Dermatology', 109),
(210, 10, 'Urology', 'Morning', 10, 'Urology', 110),
(211, 11, 'ENT', 'Evening', 11, 'ENT', 111),
(212, 12, 'Gastroenterology', 'Night', 12, 'Gastroenterology', 112),
(213, 13, 'Endocrinology', 'Morning', 13, 'Endocrinology', 113),
(214, 14, 'Nephrology', 'Evening', 14, 'Nephrology', 114),
(215, 15, 'Psychiatry', 'Night', 15, 'Psychiatry', 115),
(216, 16, 'Ophthalmology', 'Morning', 16, 'Ophthalmology', 116),
(217, 17, 'Hematology', 'Evening', 17, 'Hematology', 117),
(218, 18, 'Pulmonology', 'Night', 18, 'Pulmonology', 118),
(219, 19, 'Infectious Diseases', 'Morning', 19, 'Infectious Diseases', 119),
(220, 20, 'Rehabilitation', 'Evening', 20, 'Rehabilitation', 120);
  
  --10. insert User data
INSERT INTO Users (Username, Password, Role, Shift, StaffID)
VALUES
('doc_ali', 'passAli123', 'DoctorUser', 'Morning', 201),
('doc_fatima', 'passFatima123', 'DoctorUser', 'Evening', 202),
('doc_khalid', 'passKhalid123', 'DoctorUser', 'Night', 203),
('doc_salma', 'passSalma123', 'DoctorUser', 'Morning', 204),
('doc_hassan', 'passHassan123', 'DoctorUser', 'Evening', 205),
('doc_layla', 'passLayla123', 'DoctorUser', 'Night', 206),
('doc_ahmed', 'passAhmed123', 'DoctorUser', 'Morning', 207),
('doc_noor', 'passNoor123', 'DoctorUser', 'Evening', 208),
('doc_yousef', 'passYousef123', 'DoctorUser', 'Night', 209),
('doc_reem', 'passReem123', 'DoctorUser', 'Morning', 210),
('admin_salim', 'adminSalim456', 'AdminUser', 'Morning', 211),
('admin_iman', 'adminIman456', 'AdminUser', 'Evening', 212),
('admin_omar', 'adminOmar456', 'AdminUser', 'Night', 213),
('admin_sara', 'adminSara456', 'AdminUser', 'Morning', 214),
('admin_majed', 'adminMajed456', 'AdminUser', 'Evening', 215),
('admin_mona', 'adminMona456', 'AdminUser', 'Night', 216),
('admin_fahad', 'adminFahad456', 'AdminUser', 'Morning', 217),
('admin_huda', 'adminHuda456', 'AdminUser', 'Evening', 218),
('admin_zayed', 'adminZayed456', 'AdminUser', 'Night', 219),
('admin_asma', 'adminAsma456', 'AdminUser', 'Evening', 220);


 --11. insert Appointments  data
INSERT INTO Appointments (PatientID, DoctorsID, Time)
VALUES
(1, 1, '2024-06-01 09:00:00'),
(2, 2, '2024-06-01 10:00:00'),
(3, 3, '2024-06-01 11:00:00'),
(4, 4, '2024-06-01 12:00:00'),
(5, 5, '2024-06-01 13:00:00'),
(6, 6, '2024-06-01 14:00:00'),
(7, 7, '2024-06-02 09:00:00'),
(8, 8, '2024-06-02 10:00:00'),
(9, 9, '2024-06-02 11:00:00'),
(10, 10, '2024-06-02 12:00:00'),
(11, 11, '2024-06-02 13:00:00'),
(12, 12, '2024-06-02 14:00:00'),
(13, 13, '2024-06-03 09:00:00'),
(14, 14, '2024-06-03 10:00:00'),
(15, 15, '2024-06-03 11:00:00'),
(16, 16, '2024-06-03 12:00:00'),
(17, 17, '2024-06-03 13:00:00'),
(18, 18, '2024-06-03 14:00:00'),
(19, 19, '2024-06-04 09:00:00'),
(20, 20, '2024-06-04 10:00:00');


 --12. insert MedicalRecords  data
INSERT INTO MedicalRecords (PatientID, DoctorsID, MedicalRecordsID, Diagnosis, TreatmentPlans, Date, Notes)
VALUES
(1, 1, 1, 'Diabetes', 'Insulin therapy', '2024-06-01', 'Monitor glucose levels daily'),
(2, 2, 2, 'Hypertension', 'Beta-blockers', '2024-06-01', 'Avoid salt and stress'),
(3, 3, 3, 'Flu', 'Rest and fluids', '2024-06-01', 'Prescribed Tamiflu'),
(4, 4, 4, 'Fracture', 'Casting', '2024-06-01', 'Follow up in 2 weeks'),
(5, 5, 5, 'Asthma', 'Inhaler use', '2024-06-01', 'Avoid allergens'),
(6, 6, 6, 'Allergy', 'Antihistamines', '2024-06-02', 'Pollen sensitivity'),
(7, 7, 7, 'Infection', 'Antibiotics', '2024-06-02', 'Bacterial throat infection'),
(8, 8, 8, 'COVID-19', 'Isolation + meds', '2024-06-02', 'Mild case'),
(9, 9, 9, 'Migraine', 'Painkillers + rest', '2024-06-02', 'Recurring issue'),
(10, 10, 10, 'Obesity', 'Diet plan + exercise', '2024-06-02', 'Track weekly progress'),
(11, 11, 11, 'Arthritis', 'Pain management', '2024-06-03', 'Joint stiffness'),
(12, 12, 12, 'Depression', 'Therapy sessions', '2024-06-03', 'Monitor response'),
(13, 13, 13, 'Ulcer', 'Proton pump inhibitors', '2024-06-03', 'Avoid spicy food'),
(14, 14, 14, 'Cyst', 'Surgical removal', '2024-06-03', 'Scheduled surgery'),
(15, 15, 15, 'Kidney Stones', 'Hydration + medication', '2024-06-03', 'Small stones present'),
(16, 16, 16, 'Heart Disease', 'Statins + monitoring', '2024-06-04', 'Family history'),
(17, 17, 17, 'Fever', 'Paracetamol', '2024-06-04', 'Monitor temperature'),
(18, 18, 18, 'Cancer', 'Chemotherapy', '2024-06-04', 'Stage II breast cancer'),
(19, 19, 19, 'Back Pain', 'Physiotherapy', '2024-06-04', 'Work-related strain'),
(20, 20, 20, 'Skin Rash', 'Topical cream', '2024-06-04', 'Suspected allergic reaction');


 --13. insert Admit  data
INSERT INTO Admit (PatientID, DateIn, DateOut, RoomNumber)
VALUES
(1,  '2024-05-20', '2024-05-25', 1),
(2,  '2024-05-21', '2024-05-26', 2),
(3,  '2024-05-22', '2024-05-27', 3),
(4,  '2024-05-23', '2024-05-28', 4),
(5,  '2024-05-24', '2024-05-29', 5),
(6,  '2024-05-25', '2024-05-30', 6),
(7,  '2024-05-26', '2024-05-31', 7),
(8,  '2024-05-27', '2024-06-01', 8),
(9,  '2024-05-28', '2024-06-02', 9),
(10,  '2024-05-29', '2024-06-03', 10),
(11,  '2024-05-30', '2024-06-04', 11),
(12,  '2024-05-31', '2024-06-05', 12),
(13,  '2024-06-01', '2024-06-06', 13),
(14,  '2024-06-02', '2024-06-07', 14),
(15,  '2024-06-03', '2024-06-08', 15),
(16,  '2024-06-04', '2024-06-09', 16),
(17,  '2024-06-05', '2024-06-10', 17),
(18,  '2024-06-06', '2024-06-11', 18),
(19,  '2024-06-07', '2024-06-12', 19),
(20,  '2024-06-08', '2024-06-13', 20);


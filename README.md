



````markdown
#  HospitalDB Management System

This SQL-based project simulates a complete Hospital Database Management System (HospitalDB), including patient records, doctor assignments, room bookings, billing, reporting, and automation. It uses SQL Server features like stored procedures, views, triggers, transactions, and SQL Agent Jobs.

---

##  Contents

- [Overview](#overview)
- [Features](#features)
- [Setup Instructions](#setup-instructions)
- [Usage Guide](#usage-guide)
- [Components Explained](#components-explained)
- [Error Handling](#error-handling)
- [Contributors](#contributors)

---

##  Overview

The project is a full hospital system that manages:

- Patient admissions and appointments
- Room and department allocation
- Billing and services
- Doctors and staff
- Daily and weekly reports (automated using SQL Jobs)

---

##  Setup Instructions

1. **Create Database:**
   ```sql
   CREATE DATABASE HospitalDB;
   USE HospitalDB;
````

2. **Create Tables:**
   Define tables like `Patients`, `Doctors`, `Appointments`, `MedicalRecords`, `Room`, `Billing`, etc.
   Design follows **3NF** to avoid redundancy.

3. **Insert Sample Data:**
   Add dummy data for 20+ doctors, patients, rooms, and departments.

4. **Implement Core Logic:**
   Add stored procedures, triggers, views, jobs, and security roles.

---

##  Features

* Dynamic queries (JOIN, GROUP BY, EXISTS)
* Stored procedures for admission, billing, etc.
* Triggers to automate medical record creation
* Views for easy reporting
* SQL Jobs for daily reports and weekly backups
* Transaction control and rollback
* Security roles and permissions

---

##  Components Explained

###  What is a Stored Procedure?

A saved SQL block that runs when called. It can automate insert/update logic.

**In this project:**

* `AdmitPatient` – admits patient and marks room occupied
* `GenerateInvoice` – creates billing
* `AssignDoctorToDepartment` – assigns shift and department
* `DeletePatientData` – deletes all related records

---

###  What is a Trigger?

Runs **automatically** when a table is modified (INSERT/UPDATE/DELETE).

**In this project:**

* Automatically logs medical record after appointment
* Prevents deleting patients with billing records
* Prevents scheduling appointments in the past
* Avoids assigning multiple patients to same room

---

###  What is a SQL Job?

A scheduled task handled by **SQL Server Agent**. Used for **automation**.

**In this project:**

* `Doctor_Daily_Schedule_Report`: logs doctor appointments daily at 7 AM
* `Daily_HospitalDB_Backup`: creates daily DB backups at 2 AM
* `DoctorAppointmentAlert_5Appointments`: sends an email if any doctor has more than 5 appointments
* `Weekly_Billing_Export`: exports billing data to CSV every Sunday at 9 AM

---

##  Views

* `vw_DoctorSchedule`: All upcoming appointments for doctors
* `vw_PatientSummary`: Patient with latest visit
* `vw_DepartmentStats`: Stats per department
* `vw_ServiceCosts`: Total cost of services per patient
* `vw_UpcomingAdmissions`: Admissions scheduled for future

---

##  Sample Queries

* Find all patients of Dr. Ahmed Ali
* Doctors with more than 5 appointments in June
* Avg. service cost per department
* Patients with no appointments (NOT EXISTS)
* Total services and cost per patient

---

##  Error Handling

| Error                         | Cause                           | Fix                           |
| ----------------------------- | ------------------------------- | ----------------------------- |
| Msg 402: incompatible types   | Wrong type in condition         | Use CAST/CONVERT              |
| CREATE must be only statement | Multiple `CREATE` in same batch | Use `GO` between              |
| Agent XPs not enabled         | SQL Agent is off                | Use `sp_configure` to enable  |
| Job/schedule already exists   | Duplicate name                  | Rename or delete existing job |
| Cannot delete patient         | Trigger blocked deletion        | Delete related billing first  |

---




---

##  Notes

* Make sure folders `C:\Backups\` and `C:\Exports\` exist.
* Set up Database Mail profile for job-based alerts.
* Run SQL Server Agent for job execution.

---

##  Technologies Used

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* T-SQL, Triggers, Jobs, Transactions
* Relational Database Design (3NF)

---

 **HospitalDB**: A complete smart hospital system using SQL.

```






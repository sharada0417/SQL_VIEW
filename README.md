# SQL view

This project implements a basic hospital management system using MySQL/MariaDB. It covers essential entities such as doctors, patients, appointments, treatments, and prescriptions. It also defines helpful SQL views for common queries to simplify data analysis and reporting.

```sql
-- Create the database and switch to it
CREATE DATABASE Hospital;
USE Hospital;

-- Doctor table: stores doctor details
CREATE TABLE Doctor(
    Doctor_id INT,
    Name VARCHAR(255),
    Specialisation VARCHAR(255),
    Phone VARCHAR(255),
    PRIMARY KEY(Doctor_id)
);

-- Patient table: stores patient information
CREATE TABLE Patient(
    Patient_id INT,
    Name VARCHAR(255),
    Birth_date DATE,
    Gender VARCHAR(255),
    Address VARCHAR(255),
    PRIMARY KEY(Patient_id)
);

-- Appoinmnet table: stores appointment details between doctors and patients
CREATE TABLE Appoinmnet(
    Appoinmnet_id INT,
    Patient_id INT,
    Doctor_id INT,
    Appoinmnet_date DATE,
    Status VARCHAR(100),
    PRIMARY KEY(Appoinmnet_id)
);

-- Treatment table: stores treatments linked to appointments
CREATE TABLE Treatment(
    Treatment_id INT,
    Appointment_id INT,
    Description VARCHAR(255),
    Cost FLOAT(10,2),
    PRIMARY KEY(Treatment_id)
);

-- Prescription table: stores prescriptions linked to appointments
CREATE TABLE Prescription(
    Prescription_id INT,
    Appoinmnet_id INT,
    Medicine VARCHAR(255),
    Desage VARCHAR(255),
    PRIMARY KEY(Prescription_id)
);

-- Set up foreign key relationships
ALTER TABLE Appoinmnet ADD FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id);
ALTER TABLE Appoinmnet ADD FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id);
ALTER TABLE Prescription ADD FOREIGN KEY (Appoinmnet_id) REFERENCES Appoinmnet(Appoinmnet_id);
ALTER TABLE Treatment ADD FOREIGN KEY (Appointment_id) REFERENCES Appoinmnet(Appoinmnet_id);

-- Views

-- View all doctor records
CREATE VIEW View_Doctor AS SELECT * FROM Doctor;

-- View all female patients
CREATE VIEW View_FemalePateints AS SELECT * FROM Patient WHERE Gender = 'Female';

-- View all appointments (filterable by patient_id)
CREATE VIEW View_AppointmentsByPatient AS SELECT * FROM Appoinmnet;

-- View all treatments with cost information
CREATE VIEW View_TreatmentsCost AS SELECT Treatment_id, Description, Cost FROM Treatment;

-- View total treatment cost per patient
CREATE VIEW View_TotalTreatmentCostPerPatient AS SELECT A.Patient_id, SUM(T.Cost) AS TotalCost FROM Treatment T JOIN Appoinmnet A ON T.Appointment_id = A.Appoinmnet_id GROUP BY A.Patient_id;

-- View all doctors specialized in Cardiology
CREATE VIEW View_CardiologyDoctors AS SELECT * FROM Doctor WHERE Specialisation = 'Cardiology';

-- View appointments scheduled after 2025-04-15
CREATE VIEW View_RecentAppointments AS SELECT * FROM Appoinmnet WHERE Appoinmnet_date > '2025-04-15';

-- View patients who have appointments with Neurology specialists and are currently scheduled
CREATE VIEW View_PatientsWithNeurologyAppointments AS SELECT DISTINCT P.* FROM Patient P JOIN Appoinmnet A ON P.Patient_id = A.Patient_id JOIN Doctor D ON A.Doctor_id = D.Doctor_id WHERE D.Specialisation = 'Neurology' AND A.Status = 'Scheduled';

-- View doctors and count of their appointments
CREATE VIEW View_DoctorsAppointmentsCount AS SELECT D.Doctor_id, D.Name, COUNT(A.Appoinmnet_id) AS TotalAppointments FROM Doctor D LEFT JOIN Appoinmnet A ON D.Doctor_id = A.Doctor_id GROUP BY D.Doctor_id, D.Name;

-- View frequency of prescribed medicines
CREATE VIEW View_MedicineFrequency AS SELECT Medicine, COUNT(*) AS Frequency FROM Prescription GROUP BY Medicine;

-- View average treatment cost per appointment
CREATE VIEW View_AvgTreatmentCostPerAppointment AS SELECT Appointment_id, AVG(Cost) AS AvgCost FROM Treatment GROUP BY Appointment_id;

-- View treatments with related patient details
CREATE VIEW View_TreatmentsWithPatients AS SELECT T.Treatment_id, T.Description, P.Patient_id, P.Name AS PatientName FROM Treatment T JOIN Appoinmnet A ON T.Appointment_id = A.Appoinmnet_id JOIN Patient P ON A.Patient_id = P.Patient_id;

# Hospital Database

This project contains the SQL schema and views for managing a simple hospital database system. The database tracks doctors, patients, appointments, treatments, and prescriptions.

---

## Database Setup

### 1. Create the database and tables

```sql
CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE Doctor(
    Doctor_id INT,
    Name VARCHAR(255),
    Specialisation VARCHAR(255),
    Phone VARCHAR(255),
    PRIMARY KEY(Doctor_id)
);

CREATE TABLE Patient(
    Patient_id INT,
    Name VARCHAR(255),
    Birth_date DATE,
    Gender VARCHAR(255),
    Address VARCHAR(255),
    PRIMARY KEY(Patient_id)
);

CREATE TABLE Appoinmnet(
    Appoinmnet_id INT,
    Patient_id INT,
    Doctor_id INT,
    Appoinmnet_date DATE,
    Status VARCHAR(100),
    PRIMARY KEY(Appoinmnet_id)
);

CREATE TABLE Treatment(
    Treatment_id INT,
    Appointment_id INT,
    Description VARCHAR(255),
    Cost FLOAT(10,2),
    PRIMARY KEY(Treatment_id)
);

CREATE TABLE Prescription(
    Prescription_id INT,
    Appoinmnet_id INT,
    Medicine VARCHAR(255),
    Desage VARCHAR(255),
    PRIMARY KEY(Prescription_id)
);

ALTER TABLE Appoinmnet
ADD FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id);

ALTER TABLE Appoinmnet
ADD FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id);

ALTER TABLE Prescription
ADD FOREIGN KEY (Appoinmnet_id) REFERENCES Appoinmnet(Appoinmnet_id);

ALTER TABLE Treatment
ADD FOREIGN KEY (Appointment_id) REFERENCES Appoinmnet(Appoinmnet_id);

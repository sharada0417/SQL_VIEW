create database Hospital;

use Hospital;

create table Doctor(
	Doctor_id int,
	Name varchar(255),
	Specialisation  varchar(255),
	Phone varchar(255),
	PRIMARY KEY(Doctor_id)
);	

create table Patient(
	Patient_id int,
	Name varchar(255),
	Birth_date Date,
	Gender varchar(255),
	Address varchar(255),
	PRIMARY KEY(Patient_id)
);

create table Appoinmnet(
	Appoinmnet_id int,
	Patient_id int,
	Doctor_id int,
	Appoinmnet_date date,
	Status varchar(100),
	PRIMARY KEY(Appoinmnet_id)
);

create table Treatment(
	Treatment_id  int,
	Appointment_id  int,
	 Description varchar(255),
	 Cost FLOAT(10,2),
	 PRIMARY KEY(Treatment_id)
);

create table Prescription(
	Prescription_id int,
	Appoinmnet_id int,
	Medicine varchar(255),
	Desage varchar(255),
	PRIMARY KEY(Prescription_id)
);

ALTER TABLE Appoinmnet
ADD FOREIGN KEY (Patient_id)
REFERENCES Patient(Patient_id);

ALTER TABLE Appoinmnet
ADD FOREIGN KEY (Doctor_id)
REFERENCES Doctor(Doctor_id);

ALTER TABLE Prescription
ADD FOREIGN KEY (Appoinmnet_id)
REFERENCES Appoinmnet(Appoinmnet_id);

ALTER TABLE Treatment
ADD FOREIGN KEY (Appointment_id)
REFERENCES Appoinmnet(Appoinmnet_id);


CREATE VIEW View_Doctor AS
SELECT *
FROM doctor;
select * from View_Doctor;


CREATE VIEW View_FemalePateints AS 
SELECT *
FROM Patient
WHERE Gender = 'Female';
SELECT * from View_FemalePateints;

-- View 3: All appointments for a given patient (replace 3 with parameter when querying)
CREATE VIEW View_AppointmentsByPatient AS
SELECT * FROM Appoinmnet;
SELECT * FROM View_AppointmentsByPatient;

-- When you query this view, use:
-- SELECT * FROM View_AppointmentsByPatient WHERE Patient_id = 3;

-- View 4: Treatments with costs
CREATE VIEW View_TreatmentsCost AS
SELECT Treatment_id, Description, Cost FROM Treatment;
SELECT * FROM View_TreatmentsCost;

-- View 5: Total cost of treatments per patient
CREATE VIEW View_TotalTreatmentCostPerPatient AS
SELECT A.Patient_id, SUM(T.Cost) AS TotalCost
FROM Treatment T
JOIN Appoinmnet A ON T.Appointment_id = A.Appoinmnet_id
GROUP BY A.Patient_id;
SELECT * FROM ew_TotalTreatmentCostPerPatient;

-- View 6: Doctors specialized in Cardiology
CREATE VIEW View_CardiologyDoctors AS
SELECT * FROM Doctor WHERE Specialisation = 'Cardiology';
SELECT * FROM

-- View 7: Appointments after a certain date
CREATE VIEW View_RecentAppointments AS
SELECT * FROM Appoinmnet
WHERE Appoinmnet_date > '2025-04-15';
SELECT * FROM View_RecentAppointments;

-- View 9: Patients with appointments with Neurology doctors and status scheduled
CREATE VIEW View_PatientsWithNeurologyAppointments AS
SELECT DISTINCT P.*
FROM Patient P
JOIN Appoinmnet A ON P.Patient_id = A.Patient_id
JOIN Doctor D ON A.Doctor_id = D.Doctor_id
WHERE D.Specialisation = 'Neurology' AND A.Status = 'Scheduled';
SELECT * FROM View_PatientsWithNeurologyAppointments;

-- View 11: Doctors and their total appointments
CREATE VIEW View_DoctorsAppointmentsCount AS
SELECT D.Doctor_id, D.Name, COUNT(A.Appoinmnet_id) AS TotalAppointments
FROM Doctor D
LEFT JOIN Appoinmnet A ON D.Doctor_id = A.Doctor_id
GROUP BY D.Doctor_id, D.Name;
SELECT * FROM

-- View 12: Most commonly prescribed medicine with count
CREATE VIEW View_MedicineFrequency AS
SELECT Medicine, COUNT(*) AS Frequency
FROM Prescription
GROUP BY Medicine;
SELECT * FROM View_MedicineFrequency

-- View 15: Average cost of treatments per appointment
CREATE VIEW View_AvgTreatmentCostPerAppointment AS
SELECT Appointment_id, AVG(Cost) AS AvgCost
FROM Treatment
GROUP BY Appointment_id;
SELECT * FROM View_AvgTreatmentCostPerAppointment;

-- View 17: Treatments with patient info
CREATE VIEW View_TreatmentsWithPatients AS
SELECT T.Treatment_id, T.Description, P.Patient_id, P.Name AS PatientName
FROM Treatment T
JOIN Appoinmnet A ON T.Appointment_id = A.Appoinmnet_id
JOIN Patient P ON A.Patient_id = P.Patient_id;
SELECT * FROM View_TreatmentsWithPatients;
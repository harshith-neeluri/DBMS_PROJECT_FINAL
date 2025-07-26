-- Create the database and select it
CREATE DATABASE OrganBank;
USE OrganBank;

-- Hospital Information
CREATE TABLE Hospital (
    HospitalId INT PRIMARY KEY AUTO_INCREMENT,
    HospitalName VARCHAR(100),
    HospitalAddress VARCHAR(255),
    HospitalCity VARCHAR(50),
    HospitalState VARCHAR(50),
    HospitalContactNumber VARCHAR(15)
);

-- Donor Details
CREATE TABLE Donor (
    DonorId INT PRIMARY KEY AUTO_INCREMENT,
    DonorFullName VARCHAR(100),
    DonorAge INT,
    DonorGender ENUM('Male', 'Female', 'Other'),
    DonorBloodGroup VARCHAR(5),
    DonatedOrgans VARCHAR(255),
    DonationCategory ENUM('Living', 'Deceased'),
    DonorStatus ENUM('Available', 'Donated', 'Expired'),
    DonationDate DATE,
    DonorHospitalId INT,
    FOREIGN KEY (DonorHospitalId) REFERENCES Hospital(HospitalId)
);

-- Donor Consent
CREATE TABLE DonorConsent (
    ConsentId INT PRIMARY KEY AUTO_INCREMENT,
    ConsentDonorId INT,
    ConsentType ENUM('Self', 'Family', 'Legal'),
    ConsentGivenDate DATE,
    ConsentWitnessName VARCHAR(100),
    ConsentRemarks TEXT,
    FOREIGN KEY (ConsentDonorId) REFERENCES Donor(DonorId)
);

-- Recipient Details
CREATE TABLE Recipient (
    RecipientId INT PRIMARY KEY AUTO_INCREMENT,
    RecipientFullName VARCHAR(100),
    RecipientAge INT,
    RecipientGender ENUM('Male', 'Female', 'Other'),
    RecipientBloodGroup VARCHAR(5),
    RequiredOrgan VARCHAR(50),
    UrgencyLevel ENUM('High', 'Medium', 'Low'),
    RecipientStatus ENUM('Waiting', 'Transplanted', 'Deceased'),
    RegistrationDate DATE,
    RecipientHospitalId INT,
    FOREIGN KEY (RecipientHospitalId) REFERENCES Hospital(HospitalId)
);

-- Recipient Medical History
CREATE TABLE RecipientMedicalHistory (
    HistoryId INT PRIMARY KEY AUTO_INCREMENT,
    RelatedRecipientId INT,
    MedicalCondition VARCHAR(100),
    DiagnosisDate DATE,
    MedicalNotes TEXT,
    FOREIGN KEY (RelatedRecipientId) REFERENCES Recipient(RecipientId)
);

-- Organ Records
CREATE TABLE Organ (
    OrganId INT PRIMARY KEY AUTO_INCREMENT,
    OrganType VARCHAR(50),
    AssociatedDonorId INT,
    OrganStatus ENUM('Available', 'Matched', 'Transplanted'),
    StorageHospitalId INT,
    OrganStorageDate DATE,
    FOREIGN KEY (AssociatedDonorId) REFERENCES Donor(DonorId),
    FOREIGN KEY (StorageHospitalId) REFERENCES Hospital(HospitalId)
);

-- Organ Compatibility Test
CREATE TABLE OrganCompatibilityTest (
    CompatibilityTestId INT PRIMARY KEY AUTO_INCREMENT,
    CompatibleOrganId INT,
    CompatibleRecipientId INT,
    CompatibilityResult ENUM('Compatible', 'Incompatible', 'Further Tests Needed'),
    CompatibilityTestDate DATE,
    CompatibilityNotes TEXT,
    FOREIGN KEY (CompatibleOrganId) REFERENCES Organ(OrganId),
    FOREIGN KEY (CompatibleRecipientId) REFERENCES Recipient(RecipientId)
);

-- Organ Transport
CREATE TABLE OrganTransport (
    TransportId INT PRIMARY KEY AUTO_INCREMENT,
    TransportedOrganId INT,
    SourceHospitalId INT,
    DestinationHospitalId INT,
    TransportDate DATE,
    TransportMode VARCHAR(50),
    TransportStatus ENUM('In Transit', 'Delivered', 'Delayed'),
    FOREIGN KEY (TransportedOrganId) REFERENCES Organ(OrganId),
    FOREIGN KEY (SourceHospitalId) REFERENCES Hospital(HospitalId),
    FOREIGN KEY (DestinationHospitalId) REFERENCES Hospital(HospitalId)
);

-- Transplant Event Records
CREATE TABLE Transplant (
    TransplantId INT PRIMARY KEY AUTO_INCREMENT,
    TransplantedOrganId INT,
    TransplantRecipientId INT,
    TransplantDonorId INT,
    SurgeryDate DATE,
    TransplantOutcome ENUM('Successful', 'Failed', 'Ongoing'),
    PerformingSurgeonName VARCHAR(100),
    FOREIGN KEY (TransplantedOrganId) REFERENCES Organ(OrganId),
    FOREIGN KEY (TransplantRecipientId) REFERENCES Recipient(RecipientId),
    FOREIGN KEY (TransplantDonorId) REFERENCES Donor(DonorId)
);

-- Surgeon Details
CREATE TABLE Surgeon (
    SurgeonId INT PRIMARY KEY AUTO_INCREMENT,
    SurgeonFullName VARCHAR(100),
    SurgeonSpecialization VARCHAR(100),
    YearsOfExperience INT,
    SurgeonContactNumber VARCHAR(15),
    AssociatedHospitalId INT,
    FOREIGN KEY (AssociatedHospitalId) REFERENCES Hospital(HospitalId)
);

-- Medical Staff Information
CREATE TABLE MedicalStaff (
    StaffId INT PRIMARY KEY AUTO_INCREMENT,
    StaffFullName VARCHAR(100),
    StaffRole VARCHAR(50),
    StaffContactNumber VARCHAR(15),
    StaffHospitalId INT,
    FOREIGN KEY (StaffHospitalId) REFERENCES Hospital(HospitalId)
);

-- Test Records for Donors/Recipients
CREATE TABLE TestRecords (
    TestId INT PRIMARY KEY AUTO_INCREMENT,
    TestPatientType ENUM('Donor', 'Recipient'),
    RelatedPatientId INT,
    TestName VARCHAR(100),
    TestResult VARCHAR(255),
    TestPerformedDate DATE
);


-- Hospital (5 records)
INSERT INTO Hospital (HospitalName, HospitalAddress, HospitalCity, HospitalState, HospitalContactNumber) VALUES
('City Hospital', '123 Main St', 'Hyderabad', 'Telangana', '9999999991'),
('Care Hospital', '45 Lake Rd', 'Bangalore', 'Karnataka', '9999999992'),
('Green Valley Hospital', '78 River St', 'Chennai', 'Tamil Nadu', '9999999993'),
('Sunrise Hospital', '90 Park Ave', 'Mumbai', 'Maharashtra', '9999999994'),
('Hope Medical Center', '12 Lakeview Rd', 'Pune', 'Maharashtra', '9999999995');

-- Donor (5 records)
INSERT INTO Donor (DonorFullName, DonorAge, DonorGender, DonorBloodGroup, DonatedOrgans, DonationCategory, DonorStatus, DonationDate, DonorHospitalId) VALUES
('A', 30, 'Male', 'O+', 'Kidney', 'Living', 'Donated', '2023-08-01', 1),
('B', 25, 'Female', 'A+', 'Liver', 'Deceased', 'Expired', '2024-01-15', 2),
('C', 40, 'Male', 'B+', 'Cornea', 'Living', 'Available', '2024-04-10', 3),
('D', 50, 'Female', 'AB-', 'Heart', 'Deceased', 'Available', '2024-05-20', 4),
('E', 35, 'Other', 'O-', 'Lung', 'Living', 'Donated', '2023-12-11', 5);

-- DonorConsent (5 records)
INSERT INTO DonorConsent (ConsentDonorId, ConsentType, ConsentGivenDate, ConsentWitnessName, ConsentRemarks) VALUES
(1, 'Self', '2023-07-30', 'Z', 'Approved by donor A'),
(2, 'Family', '2024-01-10', 'Y', 'Approved by B’s family'),
(3, 'Self', '2024-04-01', 'X', 'Approved by donor C'),
(4, 'Legal', '2024-05-10', 'W', 'Court authorized consent'),
(5, 'Self', '2023-12-10', 'V', 'Approved by donor E');

-- Recipient (5 records)
INSERT INTO Recipient (RecipientFullName, RecipientAge, RecipientGender, RecipientBloodGroup, RequiredOrgan, UrgencyLevel, RecipientStatus, RegistrationDate, RecipientHospitalId) VALUES
('F', 40, 'Male', 'O+', 'Kidney', 'High', 'Transplanted', '2023-07-15', 1),
('G', 35, 'Female', 'A+', 'Liver', 'Medium', 'Waiting', '2024-01-01', 2),
('H', 55, 'Male', 'B+', 'Cornea', 'Low', 'Waiting', '2024-03-20', 3),
('I', 45, 'Female', 'AB-', 'Heart', 'High', 'Waiting', '2024-04-15', 4),
('J', 60, 'Other', 'O-', 'Lung', 'Medium', 'Waiting', '2023-11-30', 5);

-- RecipientMedicalHistory (5 records)
INSERT INTO RecipientMedicalHistory (RelatedRecipientId, MedicalCondition, DiagnosisDate, MedicalNotes) VALUES
(1, 'Chronic Kidney Disease', '2022-12-01', 'Stage 4 CKD'),
(2, 'Liver Cirrhosis', '2023-11-05', 'Requires transplant'),
(3, 'Cataract', '2023-09-12', 'Gradual vision loss'),
(4, 'Cardiomyopathy', '2024-01-22', 'Heart muscle disease'),
(5, 'Chronic Obstructive Pulmonary Disease', '2023-10-10', 'Breathing difficulty');

-- Organ (5 records)
INSERT INTO Organ (OrganType, AssociatedDonorId, OrganStatus, StorageHospitalId, OrganStorageDate) VALUES
('Kidney', 1, 'Transplanted', 1, '2023-08-01'),
('Liver', 2, 'Available', 2, '2024-01-15'),
('Cornea', 3, 'Available', 3, '2024-04-10'),
('Heart', 4, 'Available', 4, '2024-05-20'),
('Lung', 5, 'Transplanted', 5, '2023-12-11');

-- OrganCompatibilityTest (5 records)
INSERT INTO OrganCompatibilityTest (CompatibleOrganId, CompatibleRecipientId, CompatibilityResult, CompatibilityTestDate, CompatibilityNotes) VALUES
(1, 1, 'Compatible', '2023-07-31', '100% match'),
(2, 2, 'Compatible', '2024-01-14', 'Liver match confirmed'),
(3, 3, 'Compatible', '2024-04-05', 'Suitable for transplant'),
(4, 4, 'Compatible', '2024-05-15', 'Heart match confirmed'),
(5, 5, 'Compatible', '2023-12-10', 'Lung match confirmed');

-- OrganTransport (5 records)
INSERT INTO OrganTransport (TransportedOrganId, SourceHospitalId, DestinationHospitalId, TransportDate, TransportMode, TransportStatus) VALUES
(1, 1, 1, '2023-08-01', 'Ambulance', 'Delivered'),
(2, 2, 2, '2024-01-16', 'Helicopter', 'In Transit'),
(3, 3, 3, '2024-04-11', 'Van', 'Delivered'),
(4, 4, 4, '2024-05-21', 'Ambulance', 'Delivered'),
(5, 5, 5, '2023-12-12', 'Airplane', 'Delivered');

-- Transplant (5 records)
INSERT INTO Transplant (TransplantedOrganId, TransplantRecipientId, TransplantDonorId, SurgeryDate, TransplantOutcome, PerformingSurgeonName) VALUES
(1, 1, 1, '2023-08-01', 'Successful', 'Dr. X'),
(5, 5, 5, '2023-12-12', 'Successful', 'Dr. Z');

-- Surgeon (5 records)
INSERT INTO Surgeon (SurgeonFullName, SurgeonSpecialization, YearsOfExperience, SurgeonContactNumber, AssociatedHospitalId) VALUES
('Dr. X', 'Nephrology', 15, '8888888881', 1),
('Dr. Y', 'Hepatology', 12, '8888888882', 2),
('Dr. Z', 'Ophthalmology', 10, '8888888883', 3),
('Dr. W', 'Cardiology', 18, '8888888884', 4),
('Dr. V', 'Pulmonology', 20, '8888888885', 5);

-- MedicalStaff (5 records)
INSERT INTO MedicalStaff (StaffFullName, StaffRole, StaffContactNumber, StaffHospitalId) VALUES
('Nurse A', 'Nurse', '7777777771', 1),
('Technician B', 'Lab Technician', '7777777772', 2),
('Nurse C', 'Nurse', '7777777773', 3),
('Technician D', 'Radiology Tech', '7777777774', 4),
('Nurse E', 'Nurse', '7777777775', 5);

-- TestRecords (5 records)
INSERT INTO TestRecords (TestPatientType, RelatedPatientId, TestName, TestResult, TestPerformedDate) VALUES
('Donor', 1, 'Blood Test', 'Normal', '2023-07-28'),
('Recipient', 1, 'Crossmatch', 'Compatible', '2023-07-30'),
('Donor', 2, 'Liver Panel', 'Healthy', '2024-01-13'),
('Recipient', 2, 'MRI', 'Clear for surgery', '2024-01-14'),
('Donor', 3, 'Vision Test', 'Normal', '2024-04-09');


-- 1. Most donated organ type
SELECT OrganType, COUNT(*) AS TotalDonations
FROM Organ
GROUP BY OrganType
ORDER BY TotalDonations DESC
LIMIT 1;

-- 2. Donors who contributed to successful transplants
SELECT DISTINCT D.DonorFullName, D.DonorId
FROM Donor D
JOIN Transplant T ON D.DonorId = T.TransplantDonorId
WHERE T.TransplantOutcome = 'Successful';

-- 3. Average age of recipients by urgency level
SELECT UrgencyLevel, AVG(RecipientAge) AS AverageAge
FROM Recipient
GROUP BY UrgencyLevel;

-- 4. Organs stored for more than 30 days
SELECT OrganId, OrganType, OrganStorageDate, DATEDIFF(CURDATE(), OrganStorageDate) AS DaysStored
FROM Organ
WHERE OrganStatus = 'Available' AND DATEDIFF(CURDATE(), OrganStorageDate) > 30;

-- 5. Hospitals with both donors and recipients registered
SELECT H.HospitalName, H.HospitalCity
FROM Hospital H
JOIN Donor D ON H.HospitalId = D.DonorHospitalId
JOIN Recipient R ON H.HospitalId = R.RecipientHospitalId
GROUP BY H.HospitalId;

-- 6. Transplants performed by each surgeon
SELECT PerformingSurgeonName, COUNT(*) AS TransplantCount
FROM Transplant
GROUP BY PerformingSurgeonName
ORDER BY TransplantCount DESC;

-- 7. Organs that have never been transplanted
SELECT O.OrganId, O.OrganType
FROM Organ O
LEFT JOIN Transplant T ON O.OrganId = T.TransplantedOrganId
WHERE T.TransplantedOrganId IS NULL;

-- 8. Recipient test results overview
SELECT R.RecipientFullName, R.RecipientId, T.TestName, T.TestResult
FROM Recipient R
JOIN TestRecords T ON T.TestPatientType = 'Recipient' AND R.RecipientId = T.RelatedPatientId;

-- 9. Top 3 hospitals by number of donors
SELECT H.HospitalName, COUNT(D.DonorId) AS DonorCount
FROM Hospital H
JOIN Donor D ON H.HospitalId = D.DonorHospitalId
GROUP BY H.HospitalId
ORDER BY DonorCount DESC
LIMIT 3;

-- 10. Donors with organs used in multiple transplants
SELECT T.TransplantDonorId AS DonorId, COUNT(*) AS NumberOfTransplants
FROM Transplant T
GROUP BY T.TransplantDonorId
HAVING COUNT(*) > 1;

-- 11. List of surgeons and their specialization
SELECT SurgeonFullName, SurgeonSpecialization, YearsOfExperience
FROM Surgeon
ORDER BY YearsOfExperience DESC;

-- 12. Medical staff count per hospital
SELECT H.HospitalName, COUNT(MS.StaffId) AS StaffCount
FROM Hospital H
LEFT JOIN MedicalStaff MS ON H.HospitalId = MS.StaffHospitalId
GROUP BY H.HospitalId;



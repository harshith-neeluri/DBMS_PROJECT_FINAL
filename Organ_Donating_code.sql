-- Create the database and select it
CREATE DATABASE OrganBank;
USE OrganBank;

-- Hospital Information
CREATE TABLE Hospital (
    HospitalID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ContactNumber VARCHAR(15)
);

-- Donor Details
CREATE TABLE Donor (
    DonorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Age INT,
    Gender ENUM('Male', 'Female', 'Other'),
    BloodGroup VARCHAR(5),
    OrgansDonated VARCHAR(255),
    DonationType ENUM('Living', 'Deceased'),
    Status ENUM('Available', 'Donated', 'Expired'),
    DateOfDonation DATE,
    HospitalID INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
);

-- Recipient Details
CREATE TABLE Recipient (
    RecipientID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Age INT,
    Gender ENUM('Male', 'Female', 'Other'),
    BloodGroup VARCHAR(5),
    OrganNeeded VARCHAR(50),
    PriorityLevel ENUM('High', 'Medium', 'Low'),
    Status ENUM('Waiting', 'Transplanted', 'Deceased'),
    RegistrationDate DATE,
    HospitalID INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
);

-- Organ Records
CREATE TABLE Organ (
    OrganID INT PRIMARY KEY AUTO_INCREMENT,
    OrganType VARCHAR(50),
    DonorID INT,
    Status ENUM('Available', 'Matched', 'Transplanted'),
    StoredAtHospitalID INT,
    DateStored DATE,
    FOREIGN KEY (DonorID) REFERENCES Donor(DonorID),
    FOREIGN KEY (StoredAtHospitalID) REFERENCES Hospital(HospitalID)
);

-- Transplant Event Records
CREATE TABLE Transplant (
    TransplantID INT PRIMARY KEY AUTO_INCREMENT,
    OrganID INT,
    RecipientID INT,
    DonorID INT,
    TransplantDate DATE,
    Outcome ENUM('Successful', 'Failed', 'Ongoing'),
    SurgeonName VARCHAR(100),
    FOREIGN KEY (OrganID) REFERENCES Organ(OrganID),
    FOREIGN KEY (RecipientID) REFERENCES Recipient(RecipientID),
    FOREIGN KEY (DonorID) REFERENCES Donor(DonorID)
);

-- Medical Staff Information
CREATE TABLE MedicalStaff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Role VARCHAR(50),
    ContactNumber VARCHAR(15),
    HospitalID INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
);

-- Test Records for Donors/Recipients
CREATE TABLE TestRecords (
    TestID INT PRIMARY KEY AUTO_INCREMENT,
    PatientType ENUM('Donor', 'Recipient'),
    PatientID INT,
    TestType VARCHAR(100),
    Result VARCHAR(255),
    TestDate DATE
);

INSERT INTO Hospital (Name, Address, City, State, ContactNumber) VALUES
('Apollo Hospital', '123 Health Street', 'Hyderabad', 'Telangana', '0401234567'),
('AIIMS Delhi', 'Mathura Road', 'Delhi', 'Delhi', '01123456789'),
('KIMS', 'Begumpet', 'Hyderabad', 'Telangana', '0409876543'),
('Fortis Hospital', 'MG Road', 'Bangalore', 'Karnataka', '0801234987'),
('CMC', 'Hospital Road', 'Vellore', 'Tamil Nadu', '0416222333');

INSERT INTO Donor (Name, Age, Gender, BloodGroup, OrgansDonated, DonationType, Status, DateOfDonation, HospitalID) VALUES
('Ravi Kumar', 45, 'Male', 'A+', 'Kidney,Liver', 'Deceased', 'Available', '2025-07-01', 1),
('Sita Devi', 32, 'Female', 'O-', 'Kidney', 'Living', 'Donated', '2025-06-15', 2),
('John Doe', 50, 'Male', 'B+', 'Heart', 'Deceased', 'Expired', '2025-05-10', 3),
('Anjali Sharma', 29, 'Female', 'AB+', 'Lung', 'Living', 'Donated', '2025-06-25', 4),
('Ali Khan', 40, 'Male', 'O+', 'Liver', 'Deceased', 'Available', '2025-07-03', 1);

INSERT INTO Recipient (Name, Age, Gender, BloodGroup, OrganNeeded, PriorityLevel, Status, RegistrationDate, HospitalID) VALUES
('Meena Rani', 60, 'Female', 'A+', 'Kidney', 'High', 'Waiting', '2025-06-01', 1),
('Rajesh Gupta', 48, 'Male', 'O-', 'Liver', 'Medium', 'Waiting', '2025-06-10', 2),
('Priya Nair', 35, 'Female', 'B+', 'Heart', 'High', 'Transplanted', '2025-06-12', 3),
('Vikram Singh', 25, 'Male', 'AB+', 'Lung', 'Low', 'Waiting', '2025-06-20', 4),
('Sneha Patil', 52, 'Female', 'O+', 'Kidney', 'High', 'Waiting', '2025-07-05', 1);


INSERT INTO Organ (OrganType, DonorID, Status, StoredAtHospitalID, DateStored) VALUES
('Kidney', 1, 'Available', 1, '2025-07-01'),
('Liver', 1, 'Available', 1, '2025-07-01'),
('Heart', 3, 'Transplanted', 3, '2025-05-10'),
('Lung', 4, 'Transplanted', 4, '2025-06-25'),
('Liver', 5, 'Available', 1, '2025-07-03');


INSERT INTO Transplant (OrganID, RecipientID, DonorID, TransplantDate, Outcome, SurgeonName) VALUES
(3, 3, 3, '2025-06-14', 'Successful', 'Dr. Ramesh Rao'),
(4, 4, 4, '2025-06-27', 'Ongoing', 'Dr. Neha Sinha');


INSERT INTO MedicalStaff (Name, Role, ContactNumber, HospitalID) VALUES
('Dr. Ramesh Rao', 'Surgeon', '9998877766', 3),
('Dr. Neha Sinha', 'Transplant Surgeon', '8887766554', 4),
('Nurse Anita', 'Nurse', '7776655443', 1),
('Dr. Manoj Verma', 'Coordinator', '6665544332', 2),
('Dr. Kavitha', 'Nephrologist', '5554433221', 1);


INSERT INTO TestRecords (PatientType, PatientID, TestType, Result, TestDate) VALUES
('Donor', 1, 'Blood Test', 'A+', '2025-06-30'),
('Recipient', 1, 'Compatibility', 'Match Found', '2025-07-02'),
('Donor', 2, 'X-Ray', 'Clear', '2025-06-12'),
('Recipient', 2, 'Liver Function', 'Stable', '2025-06-18'),
('Donor', 5, 'MRI', 'Suitable', '2025-07-01');


-- Most donated organ type
SELECT OrganType, COUNT(*) AS Total
FROM Organ
GROUP BY OrganType
ORDER BY Total DESC
LIMIT 1;

-- Donors who contributed to successful transplants
SELECT DISTINCT D.DonorID, D.Name
FROM Donor D
JOIN Transplant T ON D.DonorID = T.DonorID
WHERE T.Outcome = 'Successful';

-- Average age of recipients grouped by priority
SELECT PriorityLevel, AVG(Age) AS AvgAge
FROM Recipient
GROUP BY PriorityLevel;

-- Organs stored more than 30 days
SELECT OrganID, OrganType, DateStored, DATEDIFF(CURDATE(), DateStored) AS DaysInStorage
FROM Organ
WHERE Status = 'Available' AND DATEDIFF(CURDATE(), DateStored) > 30;

-- Hospitals with both donors and recipients
SELECT H.Name
FROM Hospital H
JOIN Donor D ON H.HospitalID = D.HospitalID
JOIN Recipient R ON H.HospitalID = R.HospitalID
GROUP BY H.HospitalID;

-- Transplants performed by each surgeon
SELECT SurgeonName, COUNT(*) AS TransplantCount
FROM Transplant
GROUP BY SurgeonName
ORDER BY TransplantCount DESC;

-- Organs not used in transplants
SELECT O.OrganID, O.OrganType
FROM Organ O
LEFT JOIN Transplant T ON O.OrganID = T.OrganID
WHERE T.OrganID IS NULL;

-- Recipient test results
SELECT R.RecipientID, R.Name, T.TestType, T.Result
FROM Recipient R
JOIN TestRecords T ON T.PatientType = 'Recipient' AND R.RecipientID = T.PatientID;

-- Top 3 hospitals by donor count
SELECT H.Name, COUNT(D.DonorID) AS DonorCount
FROM Hospital H
JOIN Donor D ON H.HospitalID = D.HospitalID
GROUP BY H.HospitalID
ORDER BY DonorCount DESC
LIMIT 3;

-- Donors whose organs were used in multiple transplants
SELECT DonorID, COUNT(*) AS TransplantCount
FROM Transplant
GROUP BY DonorID
HAVING COUNT(*) > 1;


-- 1. Automatically update organ status to 'Transplanted' after a transplant record is inserted
DELIMITER //
CREATE TRIGGER trg_update_organ_status
AFTER INSERT ON Transplant
FOR EACH ROW
BEGIN
  UPDATE Organ
  SET Status = 'Transplanted'
  WHERE OrganID = NEW.OrganID;
END;
//
DELIMITER ;

-- 2. Prevent inserting a donor if donation type is 'Deceased' and age is less than 18
DELIMITER //
CREATE TRIGGER trg_prevent_underage_deceased_donor
BEFORE INSERT ON Donor
FOR EACH ROW
BEGIN
  IF NEW.DonationType = 'Deceased' AND NEW.Age < 18 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Deceased donors must be at least 18 years old';
  END IF;
END;
//
DELIMITER ;

-- 3. Log transplant insertion events in TransplantLog table
CREATE TABLE IF NOT EXISTS TransplantLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    TransplantID INT,
    Message TEXT,
    LogTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_log_transplant
AFTER INSERT ON Transplant
FOR EACH ROW
BEGIN
  INSERT INTO TransplantLog (TransplantID, Message)
  VALUES (NEW.TransplantID, CONCAT('Transplant performed by ', NEW.SurgeonName));
END;
//
DELIMITER ;

-- 4. Function to count how many available organs of a given type exist
DELIMITER //
CREATE FUNCTION CountAvailableOrgans(organName VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE countOrgans INT;
  SELECT COUNT(*) INTO countOrgans
  FROM Organ
  WHERE OrganType = organName AND Status = 'Available';
  RETURN countOrgans;
END;
//
DELIMITER ;

-- 5. Function to calculate the percentage of successful transplants at a given hospital
DELIMITER //
CREATE FUNCTION HospitalSuccessRate(hospID INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
  DECLARE total INT;
  DECLARE successful INT;

  SELECT COUNT(*) INTO total
  FROM Transplant T
  JOIN Organ O ON T.OrganID = O.OrganID
  WHERE O.StoredAtHospitalID = hospID;

  SELECT COUNT(*) INTO successful
  FROM Transplant T
  JOIN Organ O ON T.OrganID = O.OrganID
  WHERE O.StoredAtHospitalID = hospID AND T.Outcome = 'Successful';

  IF total = 0 THEN
    RETURN 0.00;
  END IF;

  RETURN (successful / total) * 100;
END;
//
DELIMITER ;

-- Example calls to the functions

SELECT CountAvailableOrgans('Liver') AS AvailableLivers;

SELECT HospitalSuccessRate(1) AS SuccessRateHospital1;


DROP DATABASE IF EXISTS utc504;

CREATE DATABASE utc504;

USE utc504;

DROP TABLE IF EXISTS apprentice;

CREATE TABLE apprentice(
   idApprenticeNumber INT AUTO_INCREMENT,
   name VARCHAR(20)  NOT NULL,
   surname VARCHAR(20)  NOT NULL,
   Birthday DATE NOT NULL,
   streetNumber VARCHAR(50) ,
   streetLabel VARCHAR(50)  NOT NULL,
   streetName VARCHAR(50)  NOT NULL,
   postCode VARCHAR(5)  NOT NULL,
   town VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   status ENUM('youngGraduate','employee','jobless') NOT NULL,
   PRIMARY KEY(idApprenticeNumber)
);

DROP TABLE IF EXISTS training;
CREATE TABLE training(
   idTraining INT AUTO_INCREMENT,
   entitled VARCHAR(100)  NOT NULL,
   level VARCHAR(50)  NOT NULL,
   lengthType ENUM('short','medium','long') NOT NULL,
   PRIMARY KEY(idTraining)
);

DROP TABLE IF EXISTS unit;
CREATE TABLE unit(
   idUnit INT AUTO_INCREMENT,
   content VARCHAR(100)  NOT NULL,
   level TINYINT NOT NULL,
   hourPrice DECIMAL(19,4) NOT NULL,
   domain ENUM('computing','economy','history') NOT NULL,
   PRIMARY KEY(idUnit)
);

DROP TABLE IF EXISTS school_year;
CREATE TABLE school_year(
   idSchoolYear INT AUTO_INCREMENT,
   schoolYear VARCHAR(50) ,
   PRIMARY KEY(idSchoolYear)
);

DROP TABLE IF EXISTS scheduling;
CREATE TABLE scheduling(
   idScheduling INT AUTO_INCREMENT,
   startingDate DATE NOT NULL,
   endDate DATE NOT NULL,
   hourNumber SMALLINT NOT NULL,
   availablePlace SMALLINT NOT NULL,
   idUnit INT NOT NULL,
   PRIMARY KEY(idScheduling),
   FOREIGN KEY(idUnit) REFERENCES unit(idUnit)
);

DROP TABLE IF EXISTS offer;
CREATE TABLE offer(
   idOffer INT AUTO_INCREMENT,
   offerDate DATE NOT NULL,
   totalHour TINYINT NOT NULL,
   status ENUM('accepted', 'aborted','inProgress') NOT NULL,
   financingType ENUM('personnel','financingCentre','shared') NOT NULL,
   idTraining INT,
   PRIMARY KEY(idOffer),
   FOREIGN KEY(idTraining) REFERENCES training(idTraining)
);

DROP TABLE IF EXISTS invoice;
CREATE TABLE invoice(
   idInvoice INT AUTO_INCREMENT,
   invoiceDate DATE NOT NULL,
   isPaid BOOLEAN NOT NULL,
   hourNumber TINYINT NOT NULL,
   expiryDate DATE NOT NULL,
   idApprenticeNumber INT,
   idOffer INT NOT NULL,
   PRIMARY KEY(idInvoice),
   FOREIGN KEY(idApprenticeNumber) REFERENCES apprentice(idApprenticeNumber),
   FOREIGN KEY(idOffer) REFERENCES offer(idOffer)
);

DROP TABLE IF EXISTS financing_center;
CREATE TABLE financing_center(
   idFinancingCenter INT AUTO_INCREMENT,
   type VARCHAR(50) ,
   maximumNumberOfHoursPaidPerYear INT NOT NULL,
   maximumHourlyRatePaid INT NOT NULL,
   streetNumber VARCHAR(50) ,
   streetLabel VARCHAR(50)  NOT NULL,
   streetName VARCHAR(50)  NOT NULL,
   postCode VARCHAR(50)  NOT NULL,
   town VARCHAR(50)  NOT NULL,
   contactName VARCHAR(50) ,
   contactSurname VARCHAR(50) ,
   contactEmail VARCHAR(50) ,
   contactTel VARCHAR(10) ,
   PRIMARY KEY(idFinancingCenter)
);

DROP TABLE IF EXISTS public_type;
CREATE TABLE public_type(
   idPublicType INT AUTO_INCREMENT,
   name VARCHAR(50)  NOT NULL,
   PRIMARY KEY(idPublicType),
   UNIQUE(name)
);

DROP TABLE IF EXISTS training_unit_schoolYear;
CREATE TABLE training_unit_schoolYear(
   idTraining INT,
   idUnit INT,
   idSchoolYear INT,
   PRIMARY KEY(idTraining, idUnit, idSchoolYear),
   FOREIGN KEY(idTraining) REFERENCES training(idTraining),
   FOREIGN KEY(idUnit) REFERENCES unit(idUnit),
   FOREIGN KEY(idSchoolYear) REFERENCES school_year(idSchoolYear)
);

DROP TABLE IF EXISTS register;
CREATE TABLE register(
   idApprenticeNumber INT,
   idScheduling INT,
   idOffer INT,
   isValid BOOLEAN NOT NULL,
   type ENUM('continuousTraining','priorLearningAssessment','learning','other') NOT NULL,
   PRIMARY KEY(idApprenticeNumber, idScheduling, idOffer),
   FOREIGN KEY(idApprenticeNumber) REFERENCES apprentice(idApprenticeNumber),
   FOREIGN KEY(idScheduling) REFERENCES scheduling(idScheduling),
   FOREIGN KEY(idOffer) REFERENCES offer(idOffer)
);

DROP TABLE IF EXISTS required_unit;
CREATE TABLE required_unit(
   idUnitRequired INT,
   idUnit INT,
   PRIMARY KEY(idUnitRequired, idUnit),
   FOREIGN KEY(idUnitRequired) REFERENCES unit(idUnit),
   FOREIGN KEY(idUnit) REFERENCES unit(idUnit)
);

DROP TABLE IF EXISTS validated_unit;
CREATE TABLE validated_unit(
   idApprenticeNumber INT,
   idUnit INT,
   PRIMARY KEY(idApprenticeNumber, idUnit),
   FOREIGN KEY(idApprenticeNumber) REFERENCES apprentice(idApprenticeNumber),
   FOREIGN KEY(idUnit) REFERENCES unit(idUnit)
);

DROP TABLE IF EXISTS request_funding;
CREATE TABLE request_funding(
   idApprenticeNumber INT,
   idFinancingCenter INT,
   status ENUM('rejected','partiallyGranted','fullyGranted') NOT NULL,
   PRIMARY KEY(idApprenticeNumber, idFinancingCenter),
   FOREIGN KEY(idApprenticeNumber) REFERENCES apprentice(idApprenticeNumber),
   FOREIGN KEY(idFinancingCenter) REFERENCES financing_center(idFinancingCenter)
);

DROP TABLE IF EXISTS invoice_financing_center;
CREATE TABLE invoice_financing_center(
   idInvoice INT,
   proofOfAttendance VARCHAR(50) ,
   idFinancingCenter INT NOT NULL,
   PRIMARY KEY(idInvoice),
   UNIQUE(proofOfAttendance),
   FOREIGN KEY(idInvoice) REFERENCES invoice(idInvoice),
   FOREIGN KEY(idFinancingCenter) REFERENCES financing_center(idFinancingCenter)
);

DROP TABLE IF EXISTS training_publicType;
CREATE TABLE training_publicType(
   idTraining INT,
   idPublicType INT,
   PRIMARY KEY(idTraining, idPublicType),
   FOREIGN KEY(idTraining) REFERENCES training(idTraining),
   FOREIGN KEY(idPublicType) REFERENCES public_type(idPublicType)
);
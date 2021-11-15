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

INSERT INTO apprentice
(
    name,
    surname,
    Birthday,
    streetNumber,
    streetLabel,
    streetName,
    postCode,
    town,
    email,
    status
)
VALUES
("Dupond", "José", "1980-05-21", "40", "Rue", "des cerisiers", "31000", "Toulouse", "dupond@email.fr", "employee"),
("Martin", "Florent", "1980-05-21", "40", "Rue", "des cerisiers", "31000", "Toulouse", "martin@email.fr", "jobless"),
("Menard", "Roger", "1980-05-21", "40", "Rue", "des cerisiers", "31000", "Toulouse", "menard@email.fr", "youngGraduate"),
("Bertrand", "Pascale", "1980-05-21", "40", "Rue", "des cerisiers", "31000", "Toulouse", "bertrand@email.fr", "employee"),
("Victor", "Robert", "1980-05-21", "40", "Rue", "des cerisiers", "31000", "Toulouse", "victor@email.fr", "jobless");

INSERT INTO training 
(
    entitled,
    lengthType,
    level
) 
VALUES
-- FORMATION 1
("concepteur developpeur d'applications" ,"long", "6"),
-- FORMATION 2
("analyste programmeur", "short", "5"),
-- FORMATION 3
("histoire", "medium", "5");

INSERT INTO unit
(
    content,
    level,
    hourPrice,
    domain
)
VALUES
-- FORMATION 1
("Module pour apprendre les bases des sytèmes d'information", "5", "50", "computing"),
("Module pour apprendre la programmation orientée objet", "5", "45", "computing"),
("Module pour apprendre la cyber-sécurité", "5", "55", "computing"),
-- FORMATION 2
("Module avancé POO ", "5", "53", "computing"),
("Module avancé systèmes ", "5", "46", "computing"),
("Module avancé Réseaux ", "5", "58", "computing"),
-- FORMATION 3
("Module pour apprendre l'histoire de France", "5", "52", "history"),
("Module pour apprendre l'histoire des navires", "5", "48", "history"),
("Module pour apprendre l'histoire de l'industrie", "5", "56", "history");

INSERT INTO school_year
(schoolYear)
VALUES 
("2020-2021"),
("2021-2022");

INSERT INTO scheduling
(
    startingDate,
    endDate,
    hourNumber,
    availablePlace,
    idUnit
)
VALUES
-- FORMATION 1
-- 2020 
("2020-05-01", "2020-05-30", 30, 20, 1),
("2020-05-01", "2020-05-30", 40, 20, 2),
("2020-05-01", "2020-05-30", 20, 20, 3),
-- 2021
("2021-05-01", "2021-05-30", 30, 20, 1),
("2021-05-01", "2021-05-30", 40, 20, 2),
("2021-05-01", "2021-05-30", 20, 20, 3),
-- FORMATION 2
-- 2020
("2020-06-01", "2020-06-30", 50, 20, 4),
("2020-06-01", "2020-06-30", 35, 20, 5),
("2020-06-01", "2020-06-30", 40, 20, 6),
-- 2021
("2021-06-01", "2021-06-30", 50, 20, 4),
("2021-06-01", "2021-06-30", 35, 20, 5),
("2021-06-01", "2021-06-30", 40, 20, 6),
-- FORMATION 3
-- 2020
("2020-06-01", "2020-06-30", 50, 20, 7),
("2020-06-01", "2020-06-30", 35, 20, 8),
("2020-06-01", "2020-06-30", 40, 20, 9),
-- 2021
("2021-06-01", "2021-06-30", 50, 20, 7),
("2021-06-01", "2021-06-30", 35, 20, 8),
("2021-06-01", "2021-06-30", 40, 20, 9);

INSERT INTO offer
(
    offerDate,
    totalHour,
	status,
	financingType,
    idTraining  
)
VALUES
-- APPRENTI 1
("2020-01-01", 0, "Accepted", "personnel", 1),
-- APPRENTI 2
("2021-01-01", 0, "inProgress", "personnel", 2),
-- APPRENTI 3
("2021-01-01", 0, "inProgress", "financingCentre", 3),
-- APPRENTI 4
("2021-01-01", 0, "Accepted", "financingCentre", 1),
-- APPRENTI 5
("2021-01-01", 0, "Accepted", "shared", 1);

INSERT INTO invoice
(
    invoiceDate,
    isPaid,
    hourNumber,
    expiryDate,
    idApprenticeNumber,
    idOffer
)
VALUES
-- APPRENTI 4
("2021-01-01", False, 0, "2021-12-31", 4, 4),
-- APPRENTI 5
("2021-01-01", False, 0, "2021-12-31", 5, 5),
("2021-01-01", False, 0, "2021-12-31", 5, 5);

INSERT INTO financing_center
(
   type,
   maximumNumberOfHoursPaidPerYear,
   maximumHourlyRatePaid,
   streetNumber,
   streetLabel,
   streetName,
   postCode,
   town,
   contactName,
   contactSurname,
   contactEmail,
   contactTel 
)
VALUES
("Privé", 20000, 30, "40", "Rue", "des oliviers", "31000", "Toulouse", "Verin", "Sylvie", "verin@email.fr", "0501020304"),
("Public", 50000, 40,  "40", "Rue", "des oliviers", "31000", "Toulouse", "Bouteille", "Jerome", "bouteille@email.fr", "0502030405");

INSERT INTO public_type
(name)
VALUES
("Demandeur d'emploi"),
("Salarié"),
("Cadre"),
("Situation d'handicap"),
("Etudiant");

INSERT INTO training_unit_schoolYear
(
    idTraining,
    idUnit,
    idSchoolYear
)
VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 1),
(1, 1, 2),
(1, 2, 2),
(1, 3, 2),
(2, 4, 1),
(2, 5, 1),
(2, 6, 1),
(2, 4, 2),
(2, 5, 2),
(2, 6, 2),
(3, 7, 1),
(3, 8, 1),
(3, 9, 1),
(3, 7, 2),
(3, 8, 2),
(3, 9, 2);

INSERT INTO register
(
    idApprenticeNumber,
    idScheduling,
    idOffer,
    isValid,
    type
)
VALUES
-- APPRENTI 1
-- Formation 1 / 2020
-- Offre validé
-- personnel
(1, 1, 1, True, "continuousTraining"),
(1, 2, 1, True, "continuousTraining"),
(1, 3, 1, True, "continuousTraining"),
-- APPRENTI 2
-- Formation 2 / 2021
-- Offre en cours
-- personnel
(2, 10, 2, False, "learning"),
(2, 11, 2, False, "learning"),
(2, 12, 2, False, "learning"),
-- APPRENTI 3
-- Formation 3 / 2021
-- Offre validé
-- Centre financier
(3, 16, 3, True, "other"),
(3, 17, 3, True, "other"),
(3, 18, 3, True, "other"),
-- APPRENTI 4
-- Formation 1 / 2021
-- Offre validé
-- Centre financier
-- Facture non payée
(4, 4, 4, True, "priorLearningAssessment"),
(4, 5, 4, True, "priorLearningAssessment"),
(4, 6, 4, True, "priorLearningAssessment"),
-- APPRENTI 5
-- Formation 1 / 2021
-- Offre validé
(5, 4, 5, True, "learning"),
(5, 5, 5, True, "learning"),
(5, 6, 5, True, "learning");

INSERT INTO required_unit
(
    idUnit,
    idUnitRequired
)
VALUES
(5, 1),
(5, 2),
(4, 2),
(6, 3);

INSERT INTO validated_unit
(
    idApprenticeNumber,
    idUnit
)
VALUES
-- APPRENTI 2
-- A VALIDER MODULES FORMATION 1
(2, 1),
(2, 2),
(2, 3);

INSERT INTO request_funding
(
    idApprenticeNumber,
    idFinancingCenter,
    status
)
VALUES
(3, 1, "fullyGranted"),
(4, 2, "fullyGranted"),
(5, 2, "fullyGranted");

INSERT INTO invoice_financing_center
(
    idInvoice,
    proofOfAttendance,
    idFinancingCenter
)
VALUES
(1, "https://file1.pdf", 2),
(3, "https://file2.pdf", 2);

INSERT INTO training_publicType
(
    idTraining,
    idPublicType
)
VALUES
-- FORMATION 1
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
-- FORMATION 2
(2, 2),
(2, 3),
(2, 4),
-- FORMATION 3
(3, 5),
(3, 4);
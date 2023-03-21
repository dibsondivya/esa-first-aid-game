CREATE TABLE `InjuryList` (
	`injuryid` INT NOT NULL AUTO_INCREMENT,
	`injuryname` VARCHAR(255) NOT NULL UNIQUE,
	`injurytypeid` INT NOT NULL,
	`injuryspecsid` INT NOT NULL,
	`filename` VARCHAR(255) NOT NULL UNIQUE,
	`emergency` BOOLEAN NOT NULL,
	`treatmentid` INT NOT NULL,
	PRIMARY KEY (`injuryid`)
);

CREATE TABLE `InjuryType` (
	`injurytypeid` INT NOT NULL AUTO_INCREMENT,
	`injurytypename` VARCHAR(255) NOT NULL UNIQUE,
	`filename` VARCHAR(255) NOT NULL UNIQUE,
	`hintid` INT NOT NULL,
	`questionid` INT NOT NULL,
	PRIMARY KEY (`injurytypeid`)
);

CREATE TABLE `InjurySpecifications` (
	`injuryspecsid` INT NOT NULL AUTO_INCREMENT,
	`injuryspecsname` VARCHAR(255) NOT NULL UNIQUE,
	`injurytypeid` INT NOT NULL,
	`filename` VARCHAR(255) NOT NULL UNIQUE,
	`hintid` INT NOT NULL,
	`questionid` INT NOT NULL,
	PRIMARY KEY (`injuryspecsid`)
);

CREATE TABLE `CallAmbulance` (
	`emergency` BOOLEAN NOT NULL,
	`filename` VARCHAR(255) NOT NULL UNIQUE,
	`hintid` INT NOT NULL,
	`questionid` INT NOT NULL,
	PRIMARY KEY (`emergency`)
);

CREATE TABLE `Hint` (
	`hintid` INT NOT NULL AUTO_INCREMENT,
	`hintdescription` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`hintid`)
);

CREATE TABLE `TreatmentList` (
	`treatmentid` INT NOT NULL AUTO_INCREMENT,
	`treatmentname` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY (`treatmentid`)
);

CREATE TABLE `QuestionBank` (
	`questionid` INT NOT NULL AUTO_INCREMENT,
	`questiontext` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY (`questionid`)
);

CREATE TABLE `TreatmentOrder` (
	`treatmentorderid` INT NOT NULL AUTO_INCREMENT,
	`treatmentid` INT NOT NULL,
	`ordernumber` INT NOT NULL,
	`questionid` INT NOT NULL,
	`treatmentstepid` INT NOT NULL,
	PRIMARY KEY (`treatmentorderid`)
);

CREATE TABLE `TreatmentSteps` (
	`treatmentstepid` INT NOT NULL AUTO_INCREMENT,
	`steptext` VARCHAR(255) NOT NULL UNIQUE,
	`filename` VARCHAR(255) NOT NULL UNIQUE,
	`questionid` INT NOT NULL,
	PRIMARY KEY (`treatmentstepid`)
);

CREATE TABLE `InjuryBandage` (
	`bandagecaseid` INT NOT NULL AUTO_INCREMENT,
	`injuryid` INT NOT NULL,
	`bandageid` INT NOT NULL,
	`questionid` INT NOT NULL,
	PRIMARY KEY (`bandagecaseid`)
);

CREATE TABLE `BandageOptions` (
	`bandageid` INT NOT NULL AUTO_INCREMENT,
	`bandagename` VARCHAR(255) NOT NULL UNIQUE,
	`filename` VARCHAR(255) NOT NULL UNIQUE,
	`questionid` INT NOT NULL,
	PRIMARY KEY (`bandageid`)
);

CREATE TABLE `FirstAidScore` (
	`playerid` INT NOT NULL,
	`score` INT NOT NULL,
	`asoftime` DATETIME NOT NULL
);

CREATE TABLE `PlayerInfo` (
	`playerid` INT NOT NULL AUTO_INCREMENT,
	`playername` VARCHAR(255) NOT NULL UNIQUE,
	`password` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`playerid`)
);

CREATE TABLE `GameState` (
	`playerid` INT NOT NULL,
	`turnstate` INT NOT NULL,
	`jsongamestate` varchar(14000) NOT NULL,
	`jsongamestate2` varchar(2000) NOT NULL
);


ALTER TABLE `InjuryList` ADD CONSTRAINT `InjuryList_fk0` FOREIGN KEY (`injurytypeid`) REFERENCES `InjuryType`(`injurytypeid`);

ALTER TABLE `InjuryList` ADD CONSTRAINT `InjuryList_fk1` FOREIGN KEY (`injuryspecsid`) REFERENCES `InjurySpecifications`(`injuryspecsid`);

ALTER TABLE `InjuryList` ADD CONSTRAINT `InjuryList_fk2` FOREIGN KEY (`emergency`) REFERENCES `CallAmbulance`(`emergency`);

ALTER TABLE `InjuryList` ADD CONSTRAINT `InjuryList_fk3` FOREIGN KEY (`treatmentid`) REFERENCES `TreatmentList`(`treatmentid`);

ALTER TABLE `InjuryType` ADD CONSTRAINT `InjuryType_fk0` FOREIGN KEY (`hintid`) REFERENCES `Hint`(`hintid`);

ALTER TABLE `InjuryType` ADD CONSTRAINT `InjuryType_fk1` FOREIGN KEY (`questionid`) REFERENCES `QuestionBank`(`questionid`);

ALTER TABLE `InjurySpecifications` ADD CONSTRAINT `InjurySpecifications_fk0` FOREIGN KEY (`injurytypeid`) REFERENCES `InjuryType`(`injurytypeid`);

ALTER TABLE `InjurySpecifications` ADD CONSTRAINT `InjurySpecifications_fk1` FOREIGN KEY (`hintid`) REFERENCES `Hint`(`hintid`);

ALTER TABLE `InjurySpecifications` ADD CONSTRAINT `InjurySpecifications_fk2` FOREIGN KEY (`questionid`) REFERENCES `QuestionBank`(`questionid`);

ALTER TABLE `CallAmbulance` ADD CONSTRAINT `CallAmbulance_fk0` FOREIGN KEY (`hintid`) REFERENCES `Hint`(`hintid`);

ALTER TABLE `CallAmbulance` ADD CONSTRAINT `CallAmbulance_fk1` FOREIGN KEY (`questionid`) REFERENCES `QuestionBank`(`questionid`);

ALTER TABLE `TreatmentOrder` ADD CONSTRAINT `TreatmentOrder_fk0` FOREIGN KEY (`treatmentid`) REFERENCES `TreatmentList`(`treatmentid`);

ALTER TABLE `TreatmentOrder` ADD CONSTRAINT `TreatmentOrder_fk1` FOREIGN KEY (`questionid`) REFERENCES `QuestionBank`(`questionid`);

ALTER TABLE `TreatmentOrder` ADD CONSTRAINT `TreatmentOrder_fk2` FOREIGN KEY (`treatmentstepid`) REFERENCES `TreatmentSteps`(`treatmentstepid`);

ALTER TABLE `TreatmentSteps` ADD CONSTRAINT `TreatmentSteps_fk0` FOREIGN KEY (`questionid`) REFERENCES `QuestionBank`(`questionid`);

ALTER TABLE `InjuryBandage` ADD CONSTRAINT `InjuryBandage_fk0` FOREIGN KEY (`injuryid`) REFERENCES `InjuryList`(`injuryid`);

ALTER TABLE `InjuryBandage` ADD CONSTRAINT `InjuryBandage_fk1` FOREIGN KEY (`bandageid`) REFERENCES `BandageOptions`(`bandageid`);

ALTER TABLE `InjuryBandage` ADD CONSTRAINT `InjuryBandage_fk2` FOREIGN KEY (`questionid`) REFERENCES `QuestionBank`(`questionid`);

ALTER TABLE `BandageOptions` ADD CONSTRAINT `BandageOptions_fk0` FOREIGN KEY (`questionid`) REFERENCES `QuestionBank`(`questionid`);



ALTER TABLE `FirstAidScore` ADD CONSTRAINT `FirstAidScore_fk0` FOREIGN KEY (`playerid`) REFERENCES `PlayerInfo`(`playerid`);

ALTER TABLE `GameState` ADD CONSTRAINT `GameState_fk0` FOREIGN KEY (`playerid`) REFERENCES `PlayerInfo`(`playerid`);




ALTER TABLE TreatmentOrder 
ADD steptext varchar(255);

ALTER TABLE TreatmentOrder 
ADD filename varchar(255);

ALTER TABLE InjuryList
ADD treatmentsequence varchar(255);

ALTER TABLE InjuryBandage
ADD filename varchar(255);

ALTER TABLE InjuryList
ADD bandageid int(11);
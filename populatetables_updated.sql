INSERT INTO PlayerInfo(playerid ,playername,password) VALUES(1,'KeenPrettyWeather','q');


INSERT INTO Hint (hintdescription) VALUES
	 ('Open Fracture: Deformity with shortening of limb, skin above fracture no longer intact.'),
	 ('Closed Fracture: Bruising and swelling with difficulty in moving limb but skin above fracture still intact.'),
	 ('Incision: A clean cut by a sharp object.'),
	 ('Laceration: An irregular cut or tear by a sharp object.'),
	 ('Abrasion: Bruising from grazing or scraping against another surface.'),
	 ('Contusion: Brusing from falling or jamming the body against a hard surface.'),
	 ('Puncture: A deep wound due to something sharp and pointed.'),
	 ('Impaled Object: Puncturing of body by an object that is still embedded in the body.'),
	 ('Gunshot Wound: Puncturing of body by a bullet from a firearm.'),
	 ('Amputation: The clean removal of a limb from the body.');
INSERT INTO Hint (hintdescription) VALUES
	 ('Minor Arterial Bleeding: Bright red blood flowing slowly and steadily from the wound.'),
	 ('Minor Venous Bleeding: Light flow of dark red blood from the wound.'),
	 ('Minor Capillary Bleeding: Light bruising under the skin with blood slowly oozing from wound.'),
	 ('Serious Arterial Bleeding: Spurting bright red blood that is difficult to control.'),
	 ('Serious Venous Bleeding: Heavy flow of dark red blood from the wound.'),
	 ('Serious Capillary Bleeding: Heavy bruising under the skin with blood oozing from the wound.'),
	 ('Non-snake Bite: Wound caused by teeth resulting in skin laceration.'),
	 ('Snake Bite: Two puncture wounds from fangs of snake, resulting in swelling and redness around the wound as well as nausea.'),
	 ('Call 995: Require immediate medical attention from professionals.'),
	 ('Continue: Minor wound that can be self-monitored.');
INSERT INTO Hint (hintdescription) VALUES
	 ('Fracture: A break in the bone, resulting in bruising and swelling.'),
	 ('Wound: Injury to the body resulting in a tear or bruising of skin.'),
	 ('Bleeding: Internal or external loss of blood.'),
	 ('Animal Bite: Puncture or laceration wound as a result of an animal.');

	
INSERT INTO QuestionBank (questionid, questiontext) VALUES
	 (1,'Select injury type'),
	 (2,'Select injury specifications'),
	 (3,'Call an ambulance'),
	 (4,'Select treatment steps in the appropriate order they are to be conducted in'),
	 (5,'Select the appropriate bandaging as required');
	
INSERT INTO BandageOptions (bandageid,bandagename,filename,questionid) VALUES
	 (1,'Head','www/Head.png',5),
	 (2,'Collarbone Sling','www/Collarbone Sling.png',5),
	 (3,'Arm','www/Arm.png',5),
	 (4,'Elbow','www/Elbow.png',5),
	 (5,'Fingers','www/Fingers.png',5),
	 (6,'Kneecap','www/Kneecap.png',5),
	 (7,'Ankle','www/Ankle.png',5),
	 (8,'No bandage','www/No bandage.png',5);
	

INSERT INTO CallAmbulance (emergency,filename,hintid,questionid) VALUES
	 (0,'www/continue.png',20,3),
	 (1,'www/call.png',19,3);

	
INSERT INTO InjuryType (injurytypename,filename,hintid,questionid) VALUES
	 ('Fracture','www/fr.png',21,1),
	 ('Wound','www/w.png',22,1),
	 ('Bleeding','www/b.png',23,1),
	 ('Animal Bite','www/ab.png',24,1);


INSERT INTO InjurySpecifications (injuryspecsname,injurytypeid,filename,hintid,questionid) VALUES
	 ('Open Fracture',1,'www/opfr.png',1,2),
	 ('Closed Fracture',1,'www/clfr.png',2,2),
	 ('Incision',2,'www/incw.png',3,2),
	 ('Laceration',2,'www/lacw.png',4,2),
	 ('Abrasion',2,'www/abrw.png',5,2),
	 ('Contusion',2,'www/contw.png',6,2),
	 ('Puncture',2,'www/puncw.png',7,2),
	 ('Impaled Object',2,'www/impw.png',8,2),
	 ('Gunshot Wound',2,'www/gunw.png',9,2),
	 ('Amputation',2,'www/ampw.png',10,2);
INSERT INTO InjurySpecifications (injuryspecsname,injurytypeid,filename,hintid,questionid) VALUES
	 ('Minor Arterial Bleeding',3,'www/mab.png',11,2),
	 ('Minor Venous Bleeding',3,'www/mvb.png',12,2),
	 ('Minor Capillary Bleeding',3,'www/mcb.png',13,2),
	 ('Serious Arterial Bleeding',3,'www/sab.png',14,2),
	 ('Serious Venous Bleeding',3,'www/svb.png',15,2),
	 ('Serious Capillary Bleeding',3,'www/scb.png',16,2),
	 ('Non-snake Bite',4,'www/nonsnb.png',17,2),
	 ('Snake Bite',4,'www/snb.png',18,2);
	

INSERT INTO TreatmentList (treatmentid,treatmentname) VALUES
   (3,'Abrasion'),
   (8,'Amputation'),
   (4,'Contusion'),
   (1,'Fracture'),
   (7,'Gunshot'),
   (6,'Impaled Object'),
   (2,'Incision and Laceration'),
   (9,'Minor Bleeding'),
   (11,'Non-snake bite'),
   (5,'Puncture'),
   (10,'Serious Bleeding'),
   (12,'Snake bite');
	

INSERT INTO InjuryList (injuryname,injurytypeid,injuryspecsid,filename,emergency,treatmentid,treatmentsequence,bandageid) VALUES
	 ('opfr1',1,1,'www/opfr1.png',0,1,'1,2,3,4',3),
	 ('clfr1',1,2,'www/clfr1.png',0,1,'1,2,3,4',6),
	 ('opfr2',1,1,'www/opfr2.png',0,1,'1,2,3,4',7),
	 ('clfr2',1,2,'www/clfr2.png',0,1,'1,2,3,4',2),
	 ('incw1',2,3,'www/incw1.png',1,2,'2,5,6',8),
	 ('lacw1',2,4,'www/lacw1.png',1,2,'2,5,6',8),
	 ('abrw1',2,5,'www/abrw1.png',0,3,'7,19',6),
	 ('contw1',2,6,'www/contw1.png',0,4,'8,9',1),
	 ('puncw1',2,7,'www/puncw1.png',0,5,'19,6',8),
	 ('impw1',2,8,'www/impw1.png',1,6,'10,11,12',7);
INSERT INTO InjuryList (injuryname,injurytypeid,injuryspecsid,filename,emergency,treatmentid,treatmentsequence,bandageid) VALUES
	 ('gunw1',2,9,'www/gunw1.png',1,7,'11,6',7),
	 ('ampw1',2,10,'www/ampw1.png',1,8,'13,14,15,6',3),
	 ('incw2',2,3,'www/incw2.png',1,2,'2,5,6',8),
	 ('lacw2',2,4,'www/lacw2.png',1,2,'2,5,6',8),
	 ('abrw2',2,5,'www/abrw2.png',0,3,'7,19',6),
	 ('contw2',2,6,'www/contw2.png',0,4,'8,9',6),
	 ('puncw2',2,7,'www/puncw2.png',0,5,'19,6',8),
	 ('impw2',2,8,'www/impw2.png',1,6,'10,11,12',5),
	 ('gunw2',2,9,'www/gunw2.png',1,7,'11,6',2),
	 ('ampw2',2,10,'www/ampw2.png',1,8,'13,14,15,6',5);
INSERT INTO InjuryList (injuryname,injurytypeid,injuryspecsid,filename,emergency,treatmentid,treatmentsequence,bandageid) VALUES
	 ('mab1',3,11,'www/mab1.png',0,9,'7,19',6),
	 ('mvb1',3,12,'www/mvb1.png',0,9,'7,19',6),
	 ('mcb1',3,13,'www/mcb1.png',0,9,'7,19',6),
	 ('sab1',3,14,'www/sab1.png',1,10,'2,16,17,18,19,6',5),
	 ('svb1',3,15,'www/svb1.png',1,10,'2,16,17,18,19,6',6),
	 ('scb1',3,16,'www/scb1.png',1,10,'2,16,17,18,19,6',6),
	 ('mab2',3,11,'www/mab2.png',0,9,'7,19',6),
	 ('mvb2',3,12,'www/mvb2.png',0,9,'7,19',3),
	 ('mcb2',3,13,'www/mcb2.png',0,9,'7,19',6),
	 ('sab2',3,14,'www/sab2.png',1,10,'2,16,17,18,19,6',6);
INSERT INTO InjuryList (injuryname,injurytypeid,injuryspecsid,filename,emergency,treatmentid,treatmentsequence,bandageid) VALUES
	 ('svb2',3,15,'www/svb2.png',1,10,'2,16,17,18,19,6',6),
	 ('scb2',3,16,'www/scb2.png',1,10,'2,16,17,18,19,6',6),
	 ('nonsnb1',4,17,'www/nonsnb1.png',0,11,'7,1',3),
	 ('snb1',4,18,'www/snb1.png',1,12,'20,21,22,23,1,17,24,6',7),
	 ('nonsnb2',4,17,'www/nonsnb2.png',0,11,'7,1',3),
	 ('snb2',4,18,'www/snb2.png',1,12,'20,21,22,23,1,17,24,6',3);
	


INSERT INTO InjuryBandage (injuryid,bandageid,questionid,filename) VALUES
	 (1,3,5,'www/Arm.png'),
	 (2,6,5,'www/Kneecap.png'),
	 (3,7,5,'www/Ankle.png'),
	 (4,2,5,'www/Collarbone Sling.png'),
	 (5,8,5,'www/No bandage.png'),
	 (6,8,5,'www/No bandage.png'),
	 (7,6,5,'www/Kneecap.png'),
	 (8,1,5,'www/Head.png'),
	 (9,8,5,'www/No bandage.png'),
	 (10,7,5,'www/Ankle.png');
INSERT INTO InjuryBandage (injuryid,bandageid,questionid,filename) VALUES
	 (11,7,5,'www/Ankle.png'),
	 (12,3,5,'www/Arm.png'),
	 (13,8,5,'www/No bandage.png'),
	 (14,8,5,'www/No bandage.png'),
	 (15,6,5,'www/Kneecap.png'),
	 (16,6,5,'www/Kneecap.png'),
	 (17,8,5,'www/No bandage.png'),
	 (18,5,5,'www/Fingers.png'),
	 (19,2,5,'www/Collarbone Sling.png'),
	 (20,5,5,'www/Fingers.png');
INSERT INTO InjuryBandage (injuryid,bandageid,questionid,filename) VALUES
	 (21,6,5,'www/Kneecap.png'),
	 (22,6,5,'www/Kneecap.png'),
	 (23,6,5,'www/Kneecap.png'),
	 (24,5,5,'www/Fingers.png'),
	 (25,6,5,'www/Kneecap.png'),
	 (26,6,5,'www/Kneecap.png'),
	 (27,6,5,'www/Kneecap.png'),
	 (28,3,5,'www/Arm.png'),
	 (29,6,5,'www/Kneecap.png'),
	 (30,6,5,'www/Kneecap.png');
INSERT INTO InjuryBandage (injuryid,bandageid,questionid,filename) VALUES
	 (31,6,5,'www/Kneecap.png'),
	 (32,6,5,'www/Kneecap.png'),
	 (33,3,5,'www/Arm.png'),
	 (34,7,5,'www/Ankle.png'),
	 (35,3,5,'www/Arm.png'),
	 (36,3,5,'www/Arm.png');

	
INSERT INTO TreatmentSteps (steptext,filename,questionid) VALUES
	 ('Cover wound with sterile dressing','step1',4),
	 ('Apply pressure around wound to control bleeding','step2',4),
	 ('Ensure pressure is not over protruding bone','step3',4),
	 ('Secure the dressing with a bandage','step4',4),
	 ('Elevate the injury','step5',4),
	 ('Seek medical attention','step6',4),
	 ('Wash with antiseptic and water','step7',4),
	 ('Use icepack to reduce bleeding','step8',4),
	 ('Note that severe bleeding may indicate deeper damage such as a fracture','step9',4),
	 ('Refrain from removing the object','step10',4);
INSERT INTO TreatmentSteps (steptext,filename,questionid) VALUES
	 ('Apply bandage','step11',4),
	 ('Stabilize the object','step12',4),
	 ('Put severed part in a plastic bag','step13',4),
	 ('Place plastic bag in a container full of crushed ice','step14',4),
	 ('Mark container with time of injury, name and IC of casualty','step15',4),
	 ('Check if injured individual has a fracture','step16',4),
	 ('If no fracture, elevate by raising above heart level','step17',4),
	 ('If there is further bleeding, apply second dressing','step18',4),
	 ('Cover with gauze','step19',4),
	 ('Keep casualty calm and quiet','step20',4);
INSERT INTO TreatmentSteps (steptext,filename,questionid) VALUES
	 ('Remove an rings or constricting items','step21',4),
	 ('Clean bite after allowing it to bleed freely for 15-30s','step22',4),
	 ('Create a loose splint to help restrict movement of area','step23',4),
	 ('Apply pressure on artery to stop bleeding','step24',4);


INSERT INTO TreatmentOrder (treatmentid,ordernumber,questionid,treatmentstepid,steptext,filename) VALUES
	 (1,1,4,1,'Cover wound with sterile dressing','www/step1.png'),
	 (1,2,4,2,'Apply pressure around wound to control bleeding','www/step2.png'),
	 (1,3,4,3,'Ensure pressure is not over protruding bone','www/step3.png'),
	 (1,4,4,4,'Secure the dressing with a bandage','www/step4.png'),
	 (2,1,4,2,'Apply pressure around wound to control bleeding','www/step2.png'),
	 (2,2,4,5,'Elevate the injury','www/step5.png'),
	 (2,3,4,6,'Seek medical attention','www/step6.png'),
	 (3,1,4,7,'Wash with antiseptic and water','www/step7.png'),
	 (3,2,4,19,'Cover with gauze','www/step19.png'),
	 (4,1,4,8,'Use icepack to reduce bleeding','www/step8.png');
INSERT INTO TreatmentOrder (treatmentid,ordernumber,questionid,treatmentstepid,steptext,filename) VALUES
	 (4,2,4,9,'Note that severe bleeding may indicate deeper damage such as a fracture','www/step9.png'),
	 (5,1,4,19,'Cover with gauze','www/step19.png'),
	 (5,2,4,6,'Seek medical attention','www/step6.png'),
	 (6,1,4,10,'Refrain from removing the object','www/step10.png'),
	 (6,2,4,11,'Apply bandage','www/step11.png'),
	 (6,3,4,12,'Stabilize the object','www/step12.png'),
	 (7,1,4,11,'Apply bandage','www/step11.png'),
	 (7,2,4,6,'Seek medical attention','www/step6.png'),
	 (8,1,4,13,'Put severed part in a plastic bag','www/step13.png'),
	 (8,2,4,14,'Place plastic bag in a container full of crushed ice','www/step14.png');
INSERT INTO TreatmentOrder (treatmentid,ordernumber,questionid,treatmentstepid,steptext,filename) VALUES
	 (8,3,4,15,'Mark container with time of injury, name and IC of casualty','www/step15.png'),
	 (8,4,4,6,'Seek medical attention','www/step6.png'),
	 (9,1,4,7,'Wash with antiseptic and water','www/step7.png'),
	 (9,2,4,19,'Cover with gauze','www/step19.png'),
	 (10,1,4,19,'Cover with gauze','www/step19.png'),
	 (10,2,4,2,'Apply pressure around wound to control bleeding','www/step2.png'),
	 (10,3,4,16,'Check if injured individual has a fracture','www/step16.png'),
	 (10,4,4,17,'If no fracture, elevate by raising above heart level','www/step17.png'),
	 (10,5,4,18,'If there is further bleeding, apply second dressing','www/step18.png'),
	 (10,6,4,6,'Seek medical attention','www/step6.png');
INSERT INTO TreatmentOrder (treatmentid,ordernumber,questionid,treatmentstepid,steptext,filename) VALUES
	 (11,1,4,7,'Wash with antiseptic and water','www/step7.png'),
	 (11,2,4,1,'Cover wound with sterile dressing','www/step1.png'),
	 (12,1,4,20,'Keep casualty calm and quiet','www/step20.png'),
	 (12,2,4,21,'Remove any rings or constricting items','www/step21.png'),
	 (12,3,4,22,'Clean bite after allowing it to bleed freely for 15-30s','www/step22.png'),
	 (12,4,4,23,'Create a loose splint to help restrict movement of area','www/step23.png'),
	 (12,5,4,1,'Cover wound with sterile dressing','www/step1.png'),
	 (12,6,4,17,'If no fracture, elevate by raising above heart level','www/step17.png'),
	 (12,7,4,24,'Apply pressure on artery to stop bleeding','www/step24.png'),
	 (12,8,4,6,'Seek medical attention','www/step6.png');



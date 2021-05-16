#drop database cowinNew;
create database cowinNew;
use cowinNew;
#use cowin1234;
 
#1 Zone
CREATE TABLE Zone (
  Zone_ID int NOT NULL,
  Zone_Name varchar(100) NOT NULL,
  PRIMARY KEY (Zone_ID)
);

#2 State
CREATE TABLE State (
  State_ID int NOT NULL,
  State_Name varchar(100) NOT NULL,
  Zone_ID int NOT NULL,
  PRIMARY KEY (State_ID),
  FOREIGN KEY (Zone_ID) REFERENCES Zone (Zone_ID) on delete cascade
);

#3 District
CREATE TABLE District (
  District_ID int NOT NULL,
  District_Name varchar(100) NOT NULL,
  State_ID int NOT NULL,
  PRIMARY KEY (District_ID),
  FOREIGN KEY (State_ID) REFERENCES State(State_ID) on delete cascade
);

#4 Users
CREATE TABLE Users (
  User_ID int NOT NULL,
    First_Name varchar(100) NOT NULL,
    Last_Name varchar(100) NOT NULL,
  Age int NOT NULL,
  District_ID int NOT NULL,
    Gender varchar(10) NOT NULL,
    check(Gender in ('Male', 'Female', 'NonBinary')),
  PRIMARY KEY (User_ID),
  FOREIGN KEY (District_ID) REFERENCES District (District_ID) on delete cascade
);

#5 Phone_Directory
create table Phone_Directory(
  Phone_No VARCHAR(10) PRIMARY KEY,
  User_ID INT NOT NULL,
  FOREIGN KEY(User_ID) REFERENCES Users(User_ID) on delete cascade
);

#6 Official
create table Official(
  Official_ID int NOT NULL,
    FOREIGN KEY(Official_ID) REFERENCES Users(User_ID) on delete cascade,
    primary key(Official_ID)
);

#7 Central_Official
create table Central_Official(
  Central_Official_ID int NOT NULL,
    FOREIGN KEY(Central_Official_ID) REFERENCES Official(Official_ID) on delete cascade,
    primary key(Central_Official_ID)
);

#8 State_Official
create table State_Official(
  State_Official_ID int NOT NULL,
    FOREIGN KEY(State_Official_ID) REFERENCES Official(Official_ID) on delete cascade,
    primary key(State_Official_ID)
);

#9 District_Official
create table District_Official(
  District_Official_ID int NOT NULL,
    FOREIGN KEY(District_Official_ID) REFERENCES Official(Official_ID)on delete cascade,
    primary key(District_Official_ID)
);


#10 Population
create table Population(
  Population_ID int NOT NULL,
    FOREIGN KEY(Population_ID) REFERENCES Users(User_ID) on delete cascade,
    PRIMARY KEY(Population_ID)
);


#11 Vaccine_Supplier
create table Vaccine_Supplier(
  Supplier_ID int NOT NULL,
    Money_Earned float NOT NULL,
    check(Money_Earned>=0),
    FOREIGN KEY(Supplier_ID) REFERENCES Users(User_ID) on delete cascade,
    PRIMARY KEY(Supplier_ID)
);

#12 Hospital
#drop table Hospital;
create table Hospital(
	Hospital_ID int NOT NULL,
    Hospital_Name varchar(100) NOT NULL,
    HelpLine varchar(10) NOT NULL,
    District_ID int NOT NULL,
    FOREIGN KEY(District_ID) REFERENCES District(District_ID) on delete cascade,
    PRIMARY KEY(Hospital_ID)
);




#13 HealthCare_Worker
#drop table HealthCare_Worker;
create table HealthCare_Worker(
	HCW_ID int NOT NULL,
    Hospital_ID int NOT NULL,
    FOREIGN KEY(HCW_ID) REFERENCES Population(Population_ID),
    FOREIGN KEY(Hospital_ID) REFERENCES Hospital(Hospital_ID),
    PRIMARY KEY(HCW_ID)
);

create table Administer(
	Hospital_ID int NOT NULL,
	Administer_ID int NOT NULL,
    foreign key(Administer_ID) REFERENCES HealthCare_Worker(HCW_ID) on delete cascade,
    foreign key(Hospital_ID) references Hospital(Hospital_ID) on delete cascade,
    primary key(Administer_ID)
);

#14 Department
create table Department(
  Department_ID int NOT NULL,
    Department_Name varchar(50) NOT NULL,
    PRIMARY KEY(Department_ID)
);

#15 FrontLine_Worker
create table FrontLine_Worker(
  FLW_ID int NOT NULL,
    Department_ID int NOT NULL,
    FOREIGN KEY(Department_ID) REFERENCES Department(Department_ID) on delete cascade,
    FOREIGN KEY(FLW_ID) REFERENCES Population(Population_ID) on delete cascade,
    PRIMARY KEY(FLW_ID)
);

#16 General_Population
create table General_Population(
  General_Population_ID int NOT NULL,
    FOREIGN KEY(General_Population_ID) REFERENCES Population(Population_ID) on delete cascade,
    PRIMARY KEY(General_Population_ID)
);

#17 Vaccine
#drop table Vaccine;
create table Vaccine(
  Vaccine_ID int NOT NULL,
    Vaccine_Name varchar(50) NOT NULL,
    Per_Unit_Cost int NOT NULL default 0,
    check(Per_Unit_Cost>=0),
    PRIMARY KEY(Vaccine_ID)
);


#18 Official_Has_Vaccine
create table Official_Has_Vaccine(
  Official_ID int NOT NULL,
    Vaccine_ID int NOt NULL,
    Quantity int NOT NULL default 0,
    check(Quantity>=0),
    FOREIGN KEY(Official_ID) references Official(Official_ID) on delete cascade,
    FOREIGN KEY(Vaccine_ID) references Vaccine(Vaccine_ID) on delete cascade,
    primary key(Official_ID, Vaccine_ID)
);


#19 CS_Distribution
create table CS_Distribution(
  CS_Distribution_ID int NOT NULL,
    Central_Official_ID int NOT NULL,
    State_Official_ID int NOT NULL,
    Vaccine_ID int NOT NULL,
    Quantity int NOT NULL,
    check(Quantity>0),
    Distribution_Date Date NOT NULL,
    foreign key(Central_Official_ID) references Central_Official(Central_Official_ID) on delete cascade,
    foreign key(Vaccine_ID) references Vaccine(Vaccine_ID) on delete cascade,
    foreign key(State_Official_ID) references State_Official(State_Official_ID) on delete cascade,
    primary key(CS_Distribution_ID)
);


#20 SD_Distribution
create table SD_Distribution(
  SD_Distribution_ID int NOT NULL,
    State_Official_ID int NOT NULL,
    District_Official_ID int NOT NULL,
    Vaccine_ID int NOT NULL,
    Quantity int NOT NULL,
    check(Quantity>0),
    Distribution_Date Date NOT NULL,
    foreign key(District_Official_ID) references District_Official(District_Official_ID) on delete cascade,
    foreign key(Vaccine_ID) references Vaccine(Vaccine_ID) on delete cascade,
    foreign key(State_Official_ID) references State_Official(State_Official_ID) on delete cascade,
    primary key(SD_Distribution_ID)
);

#21 DH_Distribution
create table DH_Distribution(
  DH_Distribution_ID int NOT NULL,
    District_Official_ID int NOT NULL,
    Hospital_ID int NOT NULL,
    Vaccine_ID int NOT NULL,
    Quantity int NOT NULL,
    check(Quantity>0),
    Distribution_Date Date NOT NULL,
    foreign key(District_Official_ID) references District_Official(District_Official_ID) on delete cascade,
    foreign key(Vaccine_ID) references Vaccine(Vaccine_ID) on delete cascade,
    foreign key(Hospital_ID) references Hospital(Hospital_ID) on delete cascade,
    primary key(DH_Distribution_ID)
);




#24 Application_Form
create table Application_Form(
  Population_ID int NOT NULL,
    Application_No int NOT NULL,
    Covid_Status varchar(10) NOT NULL,
    check(Covid_Status in('YES','NO')),
    Registration_Date date NOT nULL,
    foreign key(Population_ID) references Population(Population_ID) on delete cascade,
    primary key(Population_ID, Application_No)
);

#25 Verify
create table Verify(
  District_Official_ID int NOT NULL,
    Population_ID int NOT NULL,
    Verified_Date date NOt NULL,
    foreign key(District_Official_ID) references District_Official(District_Official_ID) on delete cascade,
    foreign key(Population_ID) references Application_Form(Population_ID) on delete cascade,
    primary key(Population_ID)
);

#22 Vaccination
create table Vaccination(
  Population_ID int NOT NULL,
    HCW_ID int NOT NULL,
    Vaccine_ID int NOT NULL,
    Vaccination_Date Date NOT NULL,
    foreign key(Population_ID) references Verify(Population_ID) on delete cascade,
    foreign key(HCW_ID) references HealthCare_Worker(HCW_ID) on delete cascade,
    foreign key(Vaccine_ID) references Vaccine(Vaccine_ID) on delete cascade,
    primary key(Population_ID, Vaccination_Date)
);



#23 Generates_Medical_Record
create table Generates_Medical_Record(
  District_Official_ID int NOT NULL,
    Population_ID int NOT NULL,
    Vaccine_Dose1_Date Date NOT NULL,
    Vaccine_Dose2_Date Date NOT NULL,
    check(Vaccine_Dose1_Date<Vaccine_Dose2_Date),
    Dose1_Status varchar(20) NOT NULL,
    Dose2_Status varchar(20) NOT NULL,
    check(Dose1_Status in('Completed', 'Pending') and Dose2_Status in('Completed','Pending')),
    foreign key(District_Official_ID) references District_Official(District_Official_ID) on delete cascade,
    foreign key(Population_ID) references Verify(Population_ID) on delete cascade,
    PRIMARY KEY(Population_ID)
);

#26 Supply_Vaccine
#drop table Supply_Vaccine;
create table Supply_Vaccine(
  Supply_ID int NOT NULL,
    Supplier_ID int NOT NULL,
    Central_Official_ID int NOT NULL,
  Vaccine_ID int NOT NULL,
    Quantity int NOT NULL,
    check(Quantity>0),
    Supply_Date Date NOT NULL,
    foreign key(Supplier_ID) references Vaccine_Supplier(Supplier_ID) on delete cascade,
    foreign key(Vaccine_ID) references Vaccine(Vaccine_ID) on delete cascade,
    foreign key(Central_Official_ID) references Central_Official(Central_Official_ID) on delete cascade,
    primary key(Supply_ID)
);


#27 Hospital_Has_Vaccine
create table Hospital_Has_Vaccine(
  Hospital_ID int NOT NULL,
    Vaccine_ID int NOt NULL,
    Quantity int NOT NULL default 0,
    check(Quantity>=0),
    FOREIGN KEY(Hospital_ID) references Hospital(Hospital_ID) on delete cascade,
    FOREIGN KEY(Vaccine_ID) references Vaccine(Vaccine_ID) on delete cascade,
    primary key(Hospital_ID, Vaccine_ID)
);

INSERT INTO Zone VALUES (1,'North'),(2,'East'),(3,'South'),(4,'West');

INSERT INTO State VALUES (1,'Punjab',1),(2,'Haryana',1),(3,'Assam',2),(4,'Tripura',2);
insert into State values (5,'Kerala',3),(6,'Tamil  Nadu',3),(7,'Rajasthan',4),(8,'Gujarat',4);

INSERT INTO District VALUES (1,'Amritsar',1),(2,'Jalandhar',1),(3,'Panipat',2),(4,'Faridabad',2),(5,'Baksa',3),(6,'Chirang',3),(7,'Dhalai',4);
insert into District values (8,'Unakoti',4),(9,'Wayanad',5),(10,'Kollam',5),(11,'chennai',6),(12,'madurai',6),(13,'Jaipur',7),(14,'Jodhpur',7);
insert into District values(15,'Surat',8),(16,'Rajkot',8);

INSERT INTO Users VALUES (1,'Hilly','Morrissey',29,1,'Male'),(2,'Eric','Hayzer',26,2,'Male'),(3,'Krissy','Sumpter',23,3,'Female');
INSERT INTO Users VALUES (4,'Glenine','Sallnow',50,4,'Male'),(5,'Richart','Anwell',45,5,'Female'),(6,'Marion','Falla',38,6,'Male');
INSERT INTO Users VALUES(7,'Iggie','Fahrenbach',52,7,'Male'),(8,'Ema','Cady',37,1,'Female'),(9,'Joana','Burchill',28,4,'Female');
INSERT INTO Users VALUES(10,'Fenelia','Anglish',35,5,'Male'),(11,'Olivia','Ghiotto',32,7,'Female'),(12,'Kalina','Samwayes',42,10,'Male');
INSERT INTO Users VALUES(13,'Morty','Stobbes',51,11,'Male'),(14,'Edvard','Ciobutaru',39,14,'Male'),(15,'Kippy','Le Grice',27,15,'Male');
INSERT INTO Users VALUES(16,'Karissa','Kynson',57,16,'Male'),(17,'Pace','Alexsandrov',30,1,'Female'),(18,'Waldemar','Prosser',28,2,'Male');
INSERT INTO Users VALUES(19,'Wilone','Degg',45,3,'Female'),(20,'Shae','Gotcliff',44,4,'Male'),(21,'Mechelle','Sears',54,5,'Male');
INSERT INTO Users VALUES(22,'Lion','Hammon',53,6,'Male'),(23,'Codie','Seldon',39,7,'Female'),(24,'Tildie','Pengelley',40,8,'Male');
INSERT INTO Users VALUES(25,'Edwin','Minker',50,9,'Male'),(26,'Huntley','Gaitung',30,10,'Male'),(27,'Stavro','Van der Hoeven',44,11,'Female');
INSERT INTO Users VALUES(28,'Brenden','Fishburn',45,12,'Female'),(29,'Celka','Pavlenko',55,13,'Male'),(30,'Jodi','Benesevich',49,14,'Male');
INSERT INTO Users VALUES(31,'Natale','Sail',34,15,'Male'),(32,'Doug','Pfleger',37,16,'Female'),(33,'Katleen','Vankeev',47,16,'Female');
INSERT INTO Users VALUES(34,'Sabrina','Rablin',49,1,'Female'),(35,'Natalee','Meltetal',50,1,'Female'),(36,'Doti','Croster',30,2,'Male');
INSERT INTO Users VALUES(37,'Leigh','Pidon',44,3,'Female'),(38,'Gery','Lippard',45,4,'Female'),(39,'Sofia','Twycross',36,5,'Male');
INSERT INTO Users VALUES(40,'Hilde','Atwool',29,6,'Male'),(41,'Zsazsa','Gauntlett',44,7,'Female'),(42,'Lorry','Perree',42,8,'Female');
INSERT INTO Users VALUES(43,'Calley','Pichan',32,9,'Male'),(44,'Derrek','Marlowe',38,10,'Female'),(45,'Genvieve','Shevlane',39,11,'Female');
INSERT INTO Users VALUES(46,'Jeanine','Barney',26,12,'Female'),(47,'Godart','Pollie',25,13,'Female'),(48,'Randall','Crumbie',34,14,'Female');
INSERT INTO Users VALUES(49,'Lanny','Gehringer',33,15,'Female'),(50,'Melisa','Donat',43,16,'Male'),(51,'Sibylla','Treadgold',55,1,'Female');
INSERT INTO Users VALUES(52,'Valeda','Caltun',49,1,'Male'),(53,'Gabriello','Gerrels',34,2,'Male'),(54,'Aksel','Denerley',37,2,'Female');
INSERT INTO Users VALUES(55,'Sanford','Kissell',47,3,'Female'),(56,'Willie','Gulliman',49,3,'Male'),(57,'Katharina','Smithson',50,4,'Female');
INSERT INTO Users VALUES(58,'Alyda','Rubinowitz',30,4,'Male'),(59,'Susanetta','Bergin',44,5,'Female'),(60,'Sher','Bellocht',45,5,'Female');
INSERT INTO Users VALUES(61,'Laraine','Sturzaker',36,6,'Male'),(62,'Lenard','Yankin',29,6,'Male'),(63,'Sherlock','Speechley',44,7,'Female');
INSERT INTO Users VALUES(64,'Yurik','Snook',42,7,'Female'),(65,'Rurik','Quinnelly',32,8,'Female'),(66,'Katy','Killelay',23,8,'Male');
INSERT INTO Users VALUES(67,'Christin','Oldknowe',50,9,'Female'),(68,'Chelsie','Corzon',45,9,'Male'),(69,'Nico','Hecks',38,10,'Female');
INSERT INTO Users VALUES(70,'Christabella','Enrich',52,10,'Male'),(71,'Andeee','Lattin',37,11,'Female'),(72,'Lindy','Caffery',28,11,'Female');
INSERT INTO Users VALUES(73,'Ashleigh','Casazza',35,12,'Male'),(74,'Mervin','Dorrins',32,12,'Male'),(75,'Donn','Gianiello',42,13,'Male');
INSERT INTO Users VALUES(76,'Erek','Fancett',51,13,'Male'),(77,'Kingsley','Hark',39,14,'Male'),(78,'Vin','Gillmor',27,14,'Female');
INSERT INTO Users VALUES(79,'Jordan','Grodden',57,15,'Female'),(80,'Ambrosius','Greally',28,15,'Male'),(81,'Armand','Domegan',45,16,'Male');
INSERT INTO Users VALUES(82,'Kaleena','Sitford',44,16,'Male'),(83,'Victoria','Umbert',54,1,'Male'),(84,'Fedora','Kroger',53,1,'Female');
INSERT INTO Users VALUES(85,'Lee','Pauleit',29,2,'Male'),(86,'Tersina','McIvor',39,2,'Male'),(87,'Mariska','Cardello',43,1,'Female');
INSERT INTO Users VALUES(88,'Dominick','Sperry',30,2,'Male'),(89,'Tandy','Halwood',39,3,'Male'),(90,'Gregorius','Swinnard',75,4,'Female');
INSERT INTO Users VALUES(91,'Fairleigh','Pontin',42,5,'Male'),(92,'Rupert','Shoreman',25,6,'Female'),(93,'Ermin','Hrihorovich',81,7,'Male');
INSERT INTO Users VALUES(94,'Daryle','Van Oort',76,8,'Male'),(95,'Jervis','Leverson',63,9,'Male'),(96,'Laverna','Whale',85,10,'Male');
INSERT INTO Users VALUES(97,'Giulio','Lambrecht',75,11,'Female'),(98,'Kim','Vanyushin',54,12,'Female'),(99,'Alison','Ramstead',51,13,'Female');
INSERT INTO Users VALUES(100,'Cayla','Dunne',33,14,'NonBinary'),(101,'Linette','Fortesquieu',37,15,'Female'),(102,'Harriot','Gearing',27,16,'Male');
INSERT INTO Users VALUES(103,'Clim','Bilsford',55,1,'Female'),(104,'Kristan','Giraudot',76,2,'Female'),(105,'Dona','Filipovic',27,3,'Female');
INSERT INTO Users VALUES(106,'Marnie','Quesne',46,4,'Female'),(107,'Pieter','Alessandretti',73,5,'Male'),(108,'Gabriel','Farrow',42,6,'Female');
INSERT INTO Users VALUES(109,'Ulric','Beane',47,7,'Male'),(110,'Eloisa','Daniaud',33,8,'Male'),(111,'Germain','Suett',60,9,'Female');
INSERT INTO Users VALUES(112,'Sonia','Stoppe',57,10,'NonBinary'),(113,'Hanan','Strooband',86,11,'Female'),(114,'Sol','Arckoll',55,12,'Male');
INSERT INTO Users VALUES(115,'Jorrie','Greatreax',52,13,'Female'),(116,'Hunt','Kingaby',88,14,'Female'),(117,'Willie','Dillinton',77,15,'Female');
INSERT INTO Users VALUES(118,'Lew','Mashal',70,16,'Male'),(119,'Dagny','Wiseman',72,1,'Female'),(120,'Joice','Jardein',33,2,'Male');
INSERT INTO Users VALUES(121,'Sarita','Rosenberg',84,3,'Male'),(122,'Cari','Hynard',48,4,'Male'),(123,'Aubrey','Pitfield',38,5,'Female');
INSERT INTO Users VALUES(124,'Dorise','Stonier',82,6,'Male'),(125,'Mada','Hasnip',56,7,'Female'),(126,'Antonino','Girardy',84,8,'Male');
INSERT INTO Users VALUES(127,'Pamela','Pointing',69,9,'Female'),(128,'Teodorico','Beszant',29,10,'Female'),(129,'Cornie','Rispin',63,11,'Male');
INSERT INTO Users VALUES(130,'Fina','Shimony',37,12,'NonBinary'),(131,'Lief','Pavolillo',28,13,'Male'),(132,'Jermain','Van Brug',35,14,'Female');
INSERT INTO Users VALUES(133,'Matthias','Cattell',32,15,'Male'),(134,'Carlie','Suermeiers',42,16,'Male');

INSERT INTO Phone_Directory VALUES ('9999108850',1),('9999108849',2),('9999108848',3),('9999108847',4),('9999108846',5),('9999108845',6);
INSERT INTO Phone_Directory VALUES('9999108844',7),('9999108843',8),('9999108842',9),('9999108841',10),('9999108840',11),('9999108839',12);
INSERT INTO Phone_Directory VALUES('9999108838',13),('9999108837',14),('9999108836',15),('9999108835',16),('9999108834',17),('9999108833',18);
INSERT INTO Phone_Directory VALUES('9999108832',19),('9999108831',20),('9999108830',21),('8999108850',22),('8999108849',23),('8999108848',24);
INSERT INTO Phone_Directory VALUES('8999108847',25),('8999108846',26),('3999108842',27),('8999108845',27),('3999108841',28),('8999108844',28);
INSERT INTO Phone_Directory VALUES('3999108840',29),('8999108843',29),('3999108839',30),('8999108842',30),('3999108838',31),('8999108841',31);
INSERT INTO Phone_Directory VALUES('3999108837',32),('8999108840',32),('3999108836',33),('8999108839',33),('3999108835',34),('8999108838',34);
INSERT INTO Phone_Directory VALUES('3999108834',35),('8999108837',35),('3999108833',36),('8999108836',36),('3999108832',37),('8999108835',37);
INSERT INTO Phone_Directory VALUES('3999108831',38),('8999108834',38),('8999108833',39),('8999108832',40),('8999108831',41),('8999108830',42);
INSERT INTO Phone_Directory VALUES('9899108850',43),('9899108849',44),('9899108848',45),('9899108847',46),('9899108846',47),('9899108845',48);
INSERT INTO Phone_Directory VALUES('9899108844',49),('9899108843',50),('9899108842',51),('9899108841',52),('9899108840',53),('9899108839',54);
INSERT INTO Phone_Directory VALUES('9899108838',55),('9899108837',56),('9899108836',57),('9899108835',58),('9899108834',59),('9899108833',60);
INSERT INTO Phone_Directory VALUES('9899108832',61),('9899108831',62),('9899108830',63),('8899108850',64),('8899108849',65),('8899108848',66);
INSERT INTO Phone_Directory VALUES('8899108847',67),('8899108846',68),('8899108845',69),('8899108844',70),('8899108843',71),('8899108842',72);
INSERT INTO Phone_Directory VALUES('8899108841',73),('8899108840',74),('8899108839',75),('8899108838',76),('8899108837',77),('8899108836',78);
INSERT INTO Phone_Directory VALUES('8899108835',79),('8899108834',80),('8899108833',81),('8899108832',82),('8899108831',83),('8899108830',84);
INSERT INTO Phone_Directory VALUES('1999108850',85),('1999108849',86),('1999108848',87),('1999108847',88),('1999108846',89),('1999108845',90);
INSERT INTO Phone_Directory VALUES('1999108844',91),('1999108843',92),('1999108842',93),('1999108841',94),('1999108840',95),('1999108839',96);
INSERT INTO Phone_Directory VALUES('1999108838',97),('1999108837',98),('1999108836',99),('1999108835',100),('1999108834',101),('1999108833',102);
INSERT INTO Phone_Directory VALUES('1999108832',103),('1999108831',104),('1999108830',105),('2999108850',106),('2999108849',107),('2999108848',108);
INSERT INTO Phone_Directory VALUES('2999108847',109),('2999108846',110),('2999108845',111),('2999108844',112),('2999108843',113),('2999108842',114);
INSERT INTO Phone_Directory VALUES('2999108841',115),('2999108840',116),('2999108839',117),('2999108838',118),('2999108837',119),('2999108836',120);
INSERT INTO Phone_Directory VALUES('2999108835',121),('2999108834',122),('2999108833',123),('2999108832',124),('2999108831',125),('2999108830',126);
INSERT INTO Phone_Directory VALUES('3999108850',127),('3999108849',128),('3999108848',129),('3999108830',130),('3999108847',130),('3999108846',131);
INSERT INTO Phone_Directory VALUES('3999108845',132),('3999108844',133),('3999108843',134);

INSERT INTO Official VALUES (4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28);
INSERT INTO Official VALUES(29),(30),(31),(32),(33),(34);

INSERT INTO Central_official VALUES (4),(5),(6),(7);

INSERT INTO State_official VALUES (8),(9),(10),(11),(12),(13),(14),(15),(16);

INSERT INTO District_official VALUES (17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31),(32),(33),(34);

INSERT INTO Population VALUES (35),(36),(37),(38),(39),(40),(41),(42),(43),(44),(45),(46),(47),(48),(49),(50),(51),(52),(53),(54),(55),(56),(57);
INSERT INTO Population VALUES(58),(59),(60),(61),(62),(63),(64),(65),(66),(67),(68),(69),(70),(71),(72),(73),(74),(75),(76),(77),(78),(79),(80);
INSERT INTO Population VALUES(81),(82),(83),(84),(85),(86),(87),(88),(89),(90),(91),(92),(93),(94),(95),(96),(97),(98),(99),(100),(101),(102),(103);
INSERT INTO Population VALUES(104),(105),(106),(107),(108),(109),(110),(111),(112),(113),(114),(115),(116),(117),(118),(119),(120),(121),(122),(123);
INSERT INTO Population VALUES(124),(125),(126),(127),(128),(129),(130),(131),(132),(133),(134);

insert into Hospital values (1, 'AIIMS', '9373839737', 1),(2, 'APOLLO', '8276738753',2),(3, 'FORTIS', '9876354533', 3),(4, 'MAX', '7839536453', 4);
insert into Hospital values(5, 'SRI GANGA RAM HOSPITAL', '8387636898', 5),(6, 'MANIPAL HOSPITAL', '8987567876', 6),(7, 'SAROJ HOSPITAL', '9829873667', 7);
insert into Hospital values(8, 'BALA JI ACTION HOSPITAL', '9836876446', 8),(9, 'COLUMBIA ASIA ', '9876564644', 9),(10, 'ARTEMIS', '7383639231', 10);
insert into Hospital values(11, 'WOCKHARDT HOSPITAL', '9191725736', 11),(12, 'RUBY HALL CLINIC', '8973863468', 12),(13, 'PGIMER', '9373373952', 13);
insert into Hospital values(14, 'JIPMER', '8363896821', 14),(15, 'SGPGI', '7288253953', 15),(16, 'BILLROTH', '7288253953', 16);
insert into Hospital values(17, 'CARE HOSPITAL', '7288255677', 1),(18, 'VASAN HEALTHCARE', '9818253953', 2);

insert into HealthCare_Worker VALUES (51,1),(52,1),(53,2),(54,2),(55,3),(56,3),(57,4),(58,4),(59,5),(60,5),(61,6),(62,6),(63,7),(64,7),(65,8),(66,8);
insert into HealthCare_Worker VALUES(67,9),(68,9),(69,10),(70,10),(71,11),(72,11),(73,12),(74,12),(75,13),(76,13),(77,14);
insert into HealthCare_Worker VALUES(78,14),(79,15),(80,15),(81,16),(82,16),(83,17),(84,17),(85,18),(86,18);

insert into Administer values(1,51),(2,53),(3,55),(4,57),(5,59),(6,61),(7,63),(8,65),(9,67),(10,69),(11,71),(12,73),(13,75);
insert into Administer values(14,77),(15,79),(16,81),(17,83),(18,85);

insert into Department values (1, 'FINANCE' ),(2,'BPO'),(3,'EDUCATION'),(4,'BANK'),(5,'MCD'),(6,'SECURITY'),(7,'REVENUE'),(8,'ANM WORKER'),(9,'IT');
insert into Department values(10,'CIVIL SERVICES'),(11,'SALES'),(12,'HUMAN RESOURCE'),(13,'MARKETING'),(14,'MECHANICAL'),(15,'MANAGEMENT');

insert into VACCINE values (1, 'COVISHIELD', 10),(2, 'COVAXIN', 20),(3, 'PFIZER-BIONTECH', 15),(4, 'COVIVAC', 25);

INSERT INTO  Frontline_Worker VALUES (35,1),(36,2),(37,3),(38,4),(39,5),(40,6),(41,7),(42,8),(43,9),(44,10),(45,11);
INSERT INTO  Frontline_Worker VALUES(46,12),(47,13),(48,14),(49,15),(50,1);

INSERT INTO General_Population VALUES (87),(88),(89),(90),(91),(92),(93),(94),(95),(96),(97),(98),(99),(100),(101),(102),(103),(104),(105),(106);
INSERT INTO General_Population VALUES(107),(108),(109),(110),(111),(112),(113),(114),(115),(116),(117),(118),(119),(120),(121),(122),(123),(124);
INSERT INTO General_Population VALUES(125),(126),(127),(128),(129),(130),(131),(132),(133),(134);

INSERT INTO Hospital_Has_Vaccine VALUES (1,1,200),(2,2,100),(3,3,50),(4,4,100),(5,1,100),(6,2,60),(7,3,20),(8,4,100),(9,1,150),(10,2,250),(11,3,225);
INSERT INTO Hospital_Has_Vaccine VALUES(12,4,65),(13,1,45),(14,2,90),(15,3,1000),(16,4,400),(17,1,800),(18,2,500);

insert into vaccine_supplier values (1, 4000.0);insert into vaccine_supplier values (2, 3500.0);

insert into vaccine_supplier values (3, 3600.0);

INSERT INTO Supply_Vaccine VALUES (1,1,4,2,2000,'2021-02-03'),(2,2,5,1,1000,'2021-02-28'),(3,3,6,4,5000,'2021-02-23'),(4,1,7,3,1000,'2021-02-19');
INSERT INTO Supply_Vaccine VALUES(5,2,4,2,6000,'2021-02-15'),(6,3,5,1,2000,'2021-03-03'),(7,1,6,4,15000,'2021-02-23'),(8,2,6,3,2500,'2021-02-13');
INSERT INTO Supply_Vaccine VALUES(9,3,7,2,22500,'2021-03-03'),(10,1,4,1,6500,'2021-02-03');

INSERT INTO Application_Form VALUES (102,1,'NO','2021-02-24'),(103,2,'YES','2021-02-03'),(104,3,'NO','2021-02-20'),(105,4,'NO','2021-02-21');
INSERT INTO Application_Form VALUES(106,5,'YES','2021-02-22'),(107,6,'NO','2021-02-25'),(108,7,'NO','2021-02-26'),(109,8,'NO','2021-01-31');
INSERT INTO Application_Form VALUES(110,9,'YES','2021-02-01'),(111,10,'NO','2021-02-02'),(112,11,'YES','2021-02-03'),(113,12,'NO','2021-02-20');
INSERT INTO Application_Form VALUES(114,13,'NO','2021-02-21'),(115,14,'YES','2021-02-22'),(116,15,'NO','2021-02-25'),(117,16,'NO','2021-02-26');
INSERT INTO Application_Form VALUES(118,17,'NO','2021-02-02'),(119,18,'YES','2021-02-03'),(120,19,'NO','2021-02-20'),(121,20,'NO','2021-02-21');
INSERT INTO Application_Form VALUES(122,21,'YES','2021-02-22'),(123,22,'NO','2021-02-25'),(124,23,'NO','2021-02-26'),(125,24,'NO','2021-01-31');
INSERT INTO Application_Form VALUES(126,25,'YES','2021-02-01'),(127,26,'NO','2021-02-02'),(128,27,'YES','2021-02-03'),(129,28,'NO','2021-02-20');
INSERT INTO Application_Form VALUES(130,29,'NO','2021-02-21');

INSERT INTO Verify VALUES (17,103,'2021-03-01'),(18,104,'2021-03-02'),(19,105,'2021-03-03'),(20,106,'2021-03-04'),(21,107,'2021-03-05');
INSERT INTO Verify VALUES(22,108,'2021-03-05'),(23,109,'2021-03-06'),(24,110,'2021-03-07'),(25,111,'2021-03-08'),(26,112,'2021-03-09');
INSERT INTO Verify VALUES(27,113,'2021-03-10'),(28,114,'2021-03-11'),(29,115,'2021-03-12'),(30,116,'2021-03-13'),(31,117,'2021-03-14');
INSERT INTO Verify VALUES(32,118,'2021-03-15'),(34,119,'2021-03-16'),(18,120,'2021-03-17'),(33,102,'2021-03-12');

insert into Official_Has_Vaccine values (4,1,200),(4,2,200),(5,2,300),(5,4,460),(6,3,400),(7,4,560),(8,1,600),(9,1,650),(10,2,700),(11,2,720);
insert into Official_Has_Vaccine values(12,3,800),(13,4,840),(14,1,900),(15,2,950),(16,3,360),(17,4,420),(18,1,550),(19,2,300),(20,3,400);
insert into Official_Has_Vaccine values(21,4,340),(22,1,230),(23,2,170),(24,3,760),(25,3,540),(26,4,980),(27,1,190),(28,2,650),(29,3,510);
insert into Official_Has_Vaccine values(30,4,450),(31,1,340),(32,2,650),(33,3,760),(34,4,300);	

insert into cs_distribution values(1, 4, 9, 1, 100, '2021-01-16');
insert into cs_distribution values(2, 5, 8, 2, 200, '2021-01-17');
insert into cs_distribution values(3, 6, 11, 3, 300, '2021-01-18');
insert into cs_distribution values(4, 7, 15, 4, 350, '2021-01-17');
insert into cs_distribution values(5, 4, 13, 1, 450, '2021-01-20');
insert into cs_distribution values(6, 5, 16, 2, 460, '2021-01-19');
insert into cs_distribution values(7, 6, 10, 3, 350, '2021-01-21');
insert into cs_distribution values(8, 7, 12, 4, 250, '2021-01-22');
insert into cs_distribution values(9, 4, 14, 1, 550, '2021-01-17');
insert into cs_distribution values(10, 5, 8, 2, 360, '2021-01-23');
insert into cs_distribution values(11, 6, 10, 3, 380, '2021-01-22');
insert into cs_distribution values(12, 7, 11, 4, 450, '2021-01-24');
insert into cs_distribution values(13, 4, 9, 1, 350, '2021-01-19');
insert into cs_distribution values(14, 5, 16, 2, 650, '2021-01-20');
insert into cs_distribution values(15, 6, 13, 3, 660, '2021-01-16');

insert into sd_distribution values(1, 8, 17, 1, 150, '2021-01-18');
insert into sd_distribution values(2, 9, 19, 1, 250, '2021-01-16');
insert into sd_distribution values(3, 10, 21, 2, 100, '2021-01-22');
insert into sd_distribution values(4, 11, 23, 2, 50, '2021-01-24');
insert into sd_distribution values(5, 12, 25, 3, 225, '2021-01-22');
insert into sd_distribution values(6, 13, 27, 4, 125, '2021-01-21');
insert into sd_distribution values(7, 14, 29, 1, 175, '2021-01-18');
insert into sd_distribution values(8, 15, 31, 2, 275, '2021-01-17');
insert into sd_distribution values(9, 16, 32, 3, 75, '2021-01-20');
insert into sd_distribution values(10, 8, 18, 1, 120, '2021-01-18');
insert into sd_distribution values(11, 9, 20, 1, 240, '2021-01-16');
insert into sd_distribution values(12, 10, 22, 2, 135, '2021-01-21');
insert into sd_distribution values(13, 11, 24, 2, 90, '2021-01-18');
insert into sd_distribution values(14, 13, 28, 4, 85, '2021-01-21');
insert into sd_distribution values(15, 12, 26, 3, 220, '2021-01-22');

insert into Vaccination values (102,81,4,'2021-03-02'),(102,82,4,'2021-04-02'),(103,51,1,'2021-03-03'),(103,52,1,'2021-04-03'),(104,53,2,'2021-04-04'),(106,58,4,'2021-03-06'),(106,58,4,'2021-04-06');
insert into Vaccination values (107,59,1,'2021-03-07'),(107,60,1,'2021-04-07'),(108,61,2,'2021-04-08'),(110,65,4,'2021-03-10'),(110,66,4,'2021-04-10'),(111,67,1,'2021-04-11'),(112,69,2,'2021-03-12'),(112,70,2,'2021-04-12');
insert into Vaccination values (113,71,3,'2021-04-11'),(114,73,4,'2021-03-10'),(114,74,4,'2021-04-09'),(115,75,1,'2021-04-09'),(116,77,2,'2021-04-08'),(118,81,4,'2021-03-06'),(118,82,4,'2021-04-08');

insert into generates_medical_record values(33, 102, '2021-03-02', '2021-04-02', 'Completed', 'Completed');
insert into generates_medical_record values(17, 103, '2021-03-03', '2021-04-03', 'Completed', 'Completed');
insert into generates_medical_record values(18, 104, '2021-04-04', '2021-05-04', 'Completed', 'Pending');
insert into generates_medical_record values(19, 105, '2021-04-22', '2021-05-05', 'Pending', 'Pending');
insert into generates_medical_record values(20, 106, '2021-03-06', '2021-04-06', 'Completed', 'Completed');
insert into generates_medical_record values(21, 107, '2021-03-07', '2021-04-07', 'Completed', 'Completed');
insert into generates_medical_record values(22, 108, '2021-04-08', '2021-05-08', 'Completed', 'Pending');
insert into generates_medical_record values(23, 109, '2021-04-23', '2021-05-09', 'Pending', 'Pending');
insert into generates_medical_record values(24, 110, '2021-03-10', '2021-04-10', 'Completed', 'Completed');
insert into generates_medical_record values(25,111, '2021-04-11', '2021-05-11', 'Completed', 'Pending');
insert into generates_medical_record values(26, 112, '2021-03-12', '2021-04-12', 'Completed', 'Completed');
insert into generates_medical_record values(27, 113, '2021-04-11', '2021-05-13', 'Completed', 'Pending');
insert into generates_medical_record values(28, 114, '2021-03-10', '2021-04-09', 'Completed', 'Completed');
insert into generates_medical_record values(29, 115, '2021-04-09', '2021-05-15', 'Completed', 'Pending');
insert into generates_medical_record values(30, 116, '2021-04-08', '2021-05-16', 'Completed', 'Pending');
insert into generates_medical_record values(31, 117, '2021-04-30', '2021-05-17', 'Pending', 'Pending');
insert into generates_medical_record values(32, 118, '2021-03-06', '2021-04-08', 'Completed', 'Completed');
insert into generates_medical_record values(34, 119, '2021-04-23', '2021-05-19', 'Pending', 'Pending');
insert into generates_medical_record values(18, 120, '2021-04-25', '2021-05-19', 'Pending', 'Pending');

insert into dh_distribution values(1, 17, 1, 4, 100, '2021-01-19');
insert into dh_distribution values(2, 19, 2, 2, 150, '2021-02-18');
insert into dh_distribution values(3, 21, 3, 4, 75, '2021-02-23');
insert into dh_distribution values(4, 23, 4, 2, 15, '2021-02-25');
insert into dh_distribution values(5, 25, 5, 3, 200, '2021-02-24');
insert into dh_distribution values(6, 27, 6, 1, 110, '2021-02-22');
insert into dh_distribution values(7, 29, 7, 3, 120, '2021-02-20');
insert into dh_distribution values(8, 31, 8, 1, 210, '2021-02-19');
insert into dh_distribution values(9, 32, 8, 2, 50, '2021-02-21');
insert into dh_distribution values(10, 18, 1, 1, 105, '2021-02-19');
insert into dh_distribution values(11, 20, 2, 3, 190, '2021-02-17');
insert into dh_distribution values(12, 22, 3, 1, 90, '2021-02-22');
insert into dh_distribution values(13, 24, 4, 3, 50, '2021-02-21');
insert into dh_distribution values(14, 28, 6, 2, 40, '2021-02-23');
insert into dh_distribution values(15, 28, 6, 2, 40, '2021-02-23');
insert into dh_distribution values(16, 28, 6, 2, 200, '2021-02-24');

use cowinnew;
drop user 'Vaccine_Supplier2'@'localhost';
CREATE USER 'Vaccine_Supplier2'@'localhost' IDENTIFIED BY 'A';
CREATE VIEW v_1 as SELECT  Users.First_Name , Users.Last_name, Users.District_ID from Users, Vaccine_Supplier where Users.User_ID=Vaccine_Supplier.Supplier_ID;
CREATE VIEW v_2 as SELECT * from Vaccine;
CREATE VIEW v_3 as SELECT * from Supply_Vaccine ;
GRANT SELECT on v_1 to Vaccine_Supplier2@localhost;
GRANT SELECT on v_2 to Vaccine_Supplier2@localhost;
GRANT SELECT, INSERT, DELETE, UPDATE on v_3 to Vaccine_Supplier2@localhost;

drop user 'General_Population1'@'localhost';
CREATE USER 'General_Population1'@'localhost' identified by 'B';
create view v_4 as select First_Name, Last_Name, District_ID from Users U, General_Population P where U.User_ID=P.General_Population_ID;
create view v_5 as select * from Application_Form;
create view v20 as select * from generates_medical_record;
create view v_7 as select * from Hospital;
GRANT SELECT on v_4 to General_Population1@localhost;
GRANT SELECT, INSERT on v_5 to General_Population1@localhost;
GRANT SELECT on v20 to General_Population1@localhost;
GRANT SELECT on v_7 to General_Population1@localhost;

drop user 'HealthCare_Worker1'@'localhost';
create user 'HealthCare_Worker1'@'localhost' identified by 'C';
create view v_6 as select First_Name, Last_Name, District_ID, Hospital_ID from Users U, HealthCare_Worker H where H.HCW_ID=U.User_ID;
create view v_8 as select * from Vaccination;
grant select, insert on v_5 to HealthCare_Worker1@localhost;
grant select on v_6 to HealthCare_Worker1@localhost;
grant select on v_7 to HealthCare_Worker1@localhost;
grant select, insert on v_8 to HealthCare_Worker1@localhost;

drop user 'FrontLine_Worker1'@'localhost';
create user 'FrontLine_Worker1'@'localhost' identified by 'D';
create view v_9 as select First_Name, Last_Name, District_ID from Users U, FrontLine_Worker F
where U.User_ID=F.FLW_ID;
create view v_10 as select * from Department;
grant select, insert on v_5 to FrontLine_Worker1@localhost;
grant select on v_7 to FrontLine_Worker1@localhost;
grant select on v_9 to FrontLine_Worker1@localhost;
grant select on v_10 to FrontLine_Worker1@localhost;


drop user 'Central_Official1'@'localhost';
create user 'Central_Official1'@'localhost' identified by 'E';
create view v_11 as select First_Name, Last_Name, District_ID from Users U, Central_Official C
where U.User_ID=C.Central_Official_ID;
create view v_12 as select * from Official_Has_Vaccine;
create view v_13 as select * from Supply_Vaccine;
create view v_14 as select * from CS_Distribution;
grant select on v_11 to Central_Official1@localhost;
grant select on v_13 to Central_Official1@localhost;
grant select, insert, update, delete on v_12 to Central_Official1@localhost;
grant select, insert on v_14 to Central_Official1@localhost;

drop user 'State_Official1'@'localhost';
create user 'State_Official1'@'localhost' identified by 'F';
create view v_15 as select First_Name, Last_Name, District_ID from Users U, State_Official S
where U.User_ID=S.State_Official_ID;
create view v_16 as select * from SD_Distribution;
grant select on v_15 to State_Official1@localhost;
grant select, insert on v_16 to State_Official1@localhost;
grant select, insert, update, delete on v_12 to State_Official1@localhost;
grant select on v_14 to State_Official1@localhost;

drop user 'District_Official1'@'localhost';
create user 'District_Official1'@'localhost' identified by 'G';
create view v_17 as select First_Name, Last_Name, District_ID from Users U, District_Official D
where U.User_ID=D.District_Official_ID;
create view v_18 as select * from DH_Distribution;
grant select on v_17 to District_Official1@localhost;
grant select, insert on v_18 to District_Official1@localhost;
grant select, insert, update, delete on v_12 to District_Official1@localhost;
grant select on v_16 to District_Official1@localhost;

drop user 'Administer'@'localhost';
Create user 'Administer'@'localhost' identified by 'H';
Create view v_23 as select * from Hospital_Has_Vaccine;
Grant select , insert, update, delete on v_23 to Administer@localhost;
grant select, insert on v_5 to Administer@localhost;
grant select on v_6 to Administer@localhost;
grant select on v_7 to Administer@localhost;
grant select, insert on v_8 to Administer@localhost;

show tables;

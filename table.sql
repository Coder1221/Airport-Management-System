

CREATE USER 'Air_admin'@'localhost' IDENTIFIED BY 'toor'
GRANT ALL PRIVILEGES ON *.* TO 'Air_admin'@'localhost'
-- flush privileges





CREATE TABLE PERSON(
Name varchar(225),
Cnic BIGINT not null check (Cnic between 1000000000000 and 9999999999999),
Adress varchar(225),
Phone BIGINT not null check(Phone between 1000000000 and 9999999999),
Nationality varchar(10),
primary key(Cnic));


CREATE TABLE AIRPORT(
Name_of_airport varchar(225),
IATA  varchar(3),
primary key(IATA)
);

CREATE TABLE Flight(
Flight_id varchar(10),
Departure varchar(3) not null,
Arrival  varchar(3) not null, 
Departure_t varchar(5) not null,
Arrival_t varchar(5) not null,
airplane varchar(20),
fare int not null,
primary KEY(Flight_id),
FOREIGN KEY (Departure) REFERENCES AIRPORT(IATA),
FOREIGN KEY (Arrival) REFERENCES AIRPORT(IATA)
);

CREATE  TABLE PASSENGER(
    Flight_id varchar(10),
    Cnic BIGINT not null ,
    day_of DATETIME,
    FOREIGN KEY (Flight_id)  REFERENCES Flight(Flight_id),
    FOREIGN KEY (Cnic) REFERENCES PERSON(Cnic)
);

INSERT INTO PERSON VALUES ('ABDURE REHMAN' , 3510258004795 ,'lUMS' ,03009999999 , 'PAKI');
INSERT INTO PERSON VALUES ('ABDURE REHMAN' , 3510258004795 ,'lUMS' ,03009999999 , 'PAKI');
INSERT INTO PERSON VALUES ('ABDURE REHMAN' , 3510258004793 ,'lUMS' ,03054658422, 'PAKI');
INSERT INTO PERSON VALUES ('asif' , 3510258004794 ,'lUMS4' ,03253658452, 'Siri');
INSERT INTO PERSON VALUES ('Bilal' , 3510258004795 ,'lUMS5' ,03253658452, 'ind');
INSERT INTO PERSON VALUES ('abdulla' , 3510258004796 ,'lUMS6' ,06253658452, 'Afghani');
INSERT INTO PERSON VALUES ('azka' , 3510258004797 ,'lUMS7' ,06253658452, 'Afghani');
INSERT INTO PERSON VALUES ('suman' , 3510258004798 ,'lUMS8' ,06253658452, 'Pakii');
INSERT INTO PERSON VALUES ('izza' , 3510258004799 ,'lUMS9' ,06253658452, 'Paki');
INSERT INTO PERSON VALUES ('Manahil' , 3510258004790 ,'lUMS0' ,06253658452, 'Afghani');


INSERT INTO AIRPORT VALUES ('LAHORE' , 'LHR');
INSERT INTO AIRPORT VALUES ('KASUR'  , 'KSR');
INSERT INTO AIRPORT VALUES ('PINDI'  , 'PND');
INSERT INTO AIRPORT VALUES ('KARACHI' ,'KRC');
INSERT INTO AIRPORT VALUES ('BAWALPOR', 'BWL');


INSERT INTO Flight VALUES ('Pk301' , 'LHR' , 'KSR' ,'10:00' , '13:00' ,'JF Thunder' , 200);
INSERT INTO Flight VALUES ('Pk302' , 'LHR' , 'BWL' ,'12:00' , '19:00' ,'PIA_101'    , 1500);
INSERT INTO Flight VALUES ('Pk303' , 'KRC' , 'PND' ,'04:00' , '22:00' ,'PIA_102'    , 1300);
INSERT INTO Flight VALUES ('Pk304' , 'KSR' , 'KRC' ,'04:00' , '22:00' ,'PIA_103'    , 1200);
INSERT INTO Flight VALUES ('Pk305' , 'PND' , 'BWL' ,'02:00' , '23:00' ,'PIA_103'    , 1200);



INSERT INTO PASSENGER VALUES ('Pk301' ,3510258004795 , '2018-11-06 00:00:00');
INSERT INTO PASSENGER VALUES ('Pk302' ,3510258004792 , '2018-11-06 00:00:00');
INSERT INTO PASSENGER VALUES ('Pk305' ,3510258004791 , '2018-11-07 00:00:00');

-- SELECT Flight_id from  Flight ,  PASSENGER  where   

SELECT c.Flight_id  from PASSENGER as c  where c.Flight_id IN (SELECT * from (SELECT * from Flight where ) where Arrival = 'LHR' or Departure ='LHR')




-- View all flights landing and taking off for a particular airport on that day
-- day and then airport


-- CREATE TABLE Flight 





CREATE TABLE IATA(
  P_id INT NOT NULL AUTO_INCREMENT,
  IATA_code VARCHAR(5) UNIQUE ,
  PRIMARY KEY(P_id)
);


INSERT INTO IATA VALUES (0,'PK2');
INSERT INTO IATA VALUES (0,'PK1');
INSERT INTO IATA VALUES (0,'LHR');
INSERT INTO IATA VALUES (0,'KSR');
INSERT INTO IATA VALUES (0,'GWN');
INSERT INTO IATA VALUES (0,'SAI');
INSERT INTO IATA VALUES (0,'NEW');
INSERT INTO IATA VALUES (0,'ENG');
INSERT INTO IATA VALUES (0,'Gie');
INSERT INTO IATA VALUES (0,'OPE');



CREATE TABLE FLIGHT_ID(
id VARCHAR(5),
d_A VARCHAR(5),
a_A VARCHAR(5),
FOREIGN KEY(a_A) REFERENCES IATA(IATA_code),
FOREIGN KEY(d_A) REFERENCES IATA(IATA_code),
primary key(id)
);

INSERT INTO FLIGHT_ID VALUES ('PK301' ,  'LHR' , 'SAI');
INSERT INTO FLIGHT_ID VALUES ('PK302' ,  'PK1' , 'PK2');
INSERT INTO FLIGHT_ID VALUES ('PK303' ,  'LHR' , 'GWN');
INSERT INTO FLIGHT_ID VALUES ('PK304' ,  'SAI' , 'KSR');
INSERT INTO FLIGHT_ID VALUES ('PK305' ,  'LHR' , 'KSR');
INSERT INTO FLIGHT_ID VALUES ('PK306' ,  'ENG' , 'KSR');
INSERT INTO FLIGHT_ID VALUES ('PK307' ,  'LHR' , 'KSR');
INSERT INTO FLIGHT_ID VALUES ('PK308' ,  'OPE' , 'KSR');





CREATE TABLE flights_in_process(
flight_number INT NOT NULL AUTO_INCREMENT,
flight_id_t varchar(5),
d_t varchar(5),
a_t varchar(5),
date_f DATETIME,
airplane varchar(10),
fare INT, 
FOREIGN KEY (flight_id_t) REFERENCES Flight_id(id),
PRIMARY key(flight_number)
);


INSERT INTO flights_in_process VALUES (0, 'PK301' ,'1:00','5:00','2018-11-07 00:00:00'  ,'Thunder' , 1300 );
INSERT INTO flights_in_process VALUES (0, 'PK301' ,'1:00','5:00','2018-11-07 00:00:00'  ,'1-Thunder' , 1200 );
INSERT INTO flights_in_process VALUES (0, 'PK302' ,'1:00','5:00','2018-11-08 00:00:00'  ,'2-Thunder' , 1500 );
INSERT INTO flights_in_process VALUES (0, 'PK303' ,'1:00','5:00','2018-11-09 00:00:00'  ,'3-Thunder' , 1600 );
INSERT INTO flights_in_process VALUES (0, 'PK304' ,'1:00','5:00','2018-11-10 00:00:00'  ,'4-Thunder' , 1700 );



CREATE TABLE passenger_in_flight(
total INT NOT NULL AUTO_INCREMENT,
flight_details INT NOT NULL ,
P_CNIC  BIGINT not null check (P_CNIC between 1000000000000 and 9999999999999),
FOREIGN KEY (flight_details) REFERENCES flights_in_process(flight_number),
FOREIGN KEY (P_CNIC) REFERENCES PERSON(Cnic),
primary key(total)  
);


INSERT INTO passenger_in_flight VALUES (0 ,1 ,3510258004798 );  
INSERT INTO passenger_in_flight VALUES (0 ,2 ,3510258004795 );
INSERT INTO passenger_in_flight VALUES (0 ,3 ,3510258004790 );
INSERT INTO passenger_in_flight VALUES (0 ,4 ,3510258004795 );  
INSERT INTO passenger_in_flight VALUES (0 ,5 ,3510258004794 );  
INSERT INTO passenger_in_flight VALUES (0 ,6 ,3510258004799 );  
INSERT INTO passenger_in_flight VALUES (0 ,2 ,3510258004795 );  



-- SELECT * FROM flights_in_process where flight_number IN (SELECT flight_details from passenger_in_flight where P_CNIC=3510258004795);   

SELECT * from passenger_in_flight where P_CNIC=3510258004795 and flight_details in (SELECT * FROM flights_in_process INNER JOIN FLIGHT_ID ON flight_id_t=FLIGHT_ID.id);

-- SELECT * from flights_in_process where 
-- (SELECT * from passenger_in_flight where P_CNIC=3510258004795) as temp



SELECT  C.COMMUNITY_AREA_NAME, C.PER_CAPITA_INCOME  FROM
SCHOOLS AS S  LEFT JOIN census_data as C ON S.COMMUNITY_AREA_NAME= C.COMMUNITY_AREA_NAME WHERE S.SAFETY_SCORE=1 GROUP BY S.COMMUNITY_AREA_NAME;

--  multiple quries

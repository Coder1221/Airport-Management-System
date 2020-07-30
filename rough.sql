

-- CREATE USER 'Air_admin'@'localhost' IDENTIFIED BY 'toor'
-- GRANT ALL PRIVILEGES ON *.* TO 'Air_admin'@'localhost'
-- flush privileges

CREATE TABLE PERSON(
Name varchar(225),
Cnic BIGINT not null check (Cnic between 1000000000000 and 9999999999999),
Adress varchar(225),
Phone BIGINT not null check(Phone between 1000000000 and 9999999999),
Nationality varchar(10),
primary key(Cnic));

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



CREATE TABLE passenger_in_flight(
coustmer_id INT NOT NULL AUTO_INCREMENT,
flight_details INT NOT NULL ,
P_CNIC  BIGINT not null check (P_CNIC between 1000000000000 and 9999999999999),
FOREIGN KEY (flight_details) REFERENCES flights_in_process(flight_number) ON DELETE CASCADE,
FOREIGN KEY (P_CNIC) REFERENCES PERSON(Cnic),
CONSTRAINT passenger_in_flight UNIQUE(flight_details,P_CNIC) ,
primary key(coustmer_id)  
);


INSERT INTO passenger_in_flight VALUES (0 ,1 ,3510258114798);       
INSERT INTO passenger_in_flight VALUES (0 ,1 ,3510258004798);  
INSERT INTO passenger_in_flight VALUES (0 ,2 ,3510258004795);
INSERT INTO passenger_in_flight VALUES (0 ,3 ,3510258004790);
INSERT INTO passenger_in_flight VALUES (0 ,4 ,3510258004795);
INSERT INTO passenger_in_flight VALUES (0 ,5 ,3510258004794);  
INSERT INTO passenger_in_flight VALUES (0 ,6 ,3510258004799);  
INSERT INTO passenger_in_flight VALUES (0 ,9 ,3510258004795);

INSERT INTO passenger_in_flight VALUES (0 ,6 ,3510258004794);  
INSERT INTO passenger_in_flight VALUES (0 ,7 ,3510258004794);  
INSERT INTO passenger_in_flight VALUES (0 ,8 ,3510258004794);  




-- SELECT * FROM flights_in_process where flight_number IN (SELECT flight_details from passenger_in_flight where P_CNIC=3510258004795);   

SELECT * from passenger_in_flight where P_CNIC=3510258004795 and flight_details in (SELECT * FROM flights_in_process INNER JOIN FLIGHT_ID ON flight_id_t=FLIGHT_ID.id);

-- SELECT * from flights_in_process where 
-- (SELECT * from passenger_in_flight where P_CNIC=3510258004795) as temp



SELECT  C.COMMUNITY_AREA_NAME, C.PER_CAPITA_INCOME  FROM
SCHOOLS AS S  LEFT JOIN census_data as C ON S.COMMUNITY_AREA_NAME= C.COMMUNITY_AREA_NAME WHERE S.SAFETY_SCORE=1 GROUP BY S.COMMUNITY_AREA_NAME;

--  multiple quries


SELECT *  from passenger_in_flight as t 
INNER JOIN  flights_in_process f ON f.flight_number = t.flight_details 
JOIN FLIGHT_ID h ON h.id=f.flight_id_t;

drop table passenger_in_flight;
drop TABLE flights_in_process;






CREATE TABLE flights_in_process(    
flight_number INT NOT NULL AUTO_INCREMENT,
flight_id_t varchar(5),
d_t time ,
a_t time,
date_f DATETIME,
airplane varchar(10),
fare INT, 
FOREIGN KEY (flight_id_t) REFERENCES Flight_id(id) ,
CONSTRAINT flights_in_process UNIQUE(flight_id_t  , d_t ,a_t ,date_f),
PRIMARY key(flight_number)
);


INSERT INTO flights_in_process VALUES (0, 'PK301' ,'01:00:00','05:00:00','2018-11-07 00:00:00'  ,'Thunder' , 1300 );
INSERT INTO flights_in_process VALUES (0, 'PK301' ,'03:00:00','04:00:00','2018-11-10 00:00:00'  ,'1-Thunder' , 1200 );
INSERT INTO flights_in_process VALUES (0, 'PK302' ,'10:00:00','05:30:00','2018-11-08 00:00:00'  ,'2-Thunder' , 1500 );
INSERT INTO flights_in_process VALUES (0, 'PK303' ,'01:20:00','10:20:00','2018-11-09 00:00:00'  ,'3-Thunder' , 1600 );

INSERT INTO flights_in_process VALUES (0, 'PK304' ,'06:20:00','10:20:00','2018-12-09 00:00:00'  ,'JFthunder' , 2600 );
INSERT INTO flights_in_process VALUES (0, 'PK305' ,'05:20:00','11:20:00','2018-12-19 00:00:00'  ,'F-Thunder' , 3600 );
INSERT INTO flights_in_process VALUES (0, 'PK306' ,'04:20:00','12:20:00','2018-12-29 00:00:00'  ,'G-Thunder' , 4600 );
INSERT INTO flights_in_process VALUES (0, 'PK307' ,'03:20:00','13:20:00','2018-12-19 00:00:00'  ,'H-Thunder' , 5600 );
INSERT INTO flights_in_process VALUES (0, 'PK308' ,'02:20:00','14:20:00','2018-11-09 00:00:00'  ,'3-Thunder' , 1600 );


SELECT d_t FROM flights_in_process where  d_t between '00:00:00' AND '01:40:00';
SELECT * from flights_in_process where date_f = "10:20:00";

    
SELECT * from flights_in_process as f,
(SELECT * from passenger_in_flight WHERE P_CNIC=3510258004798)as temp 
join  FLIGHT_ID on FLIGHT_ID.id=flights_in_process.flight_id_t 
where temp.flight_details = f.flight_number



SELECT * from flights_in_process as f,
(SELECT * from passenger_in_flight WHERE P_CNIC=3510258004798)as temp , FLIGHT_ID as x
where temp.flight_details = f.flight_number and x.id = f.flight_id_t;



SELECT  temp.P_CNIC, f.flight_number ,f.a_t ,f.d_t , f.date_f ,f.flight_id_t , x.d_A, x.a_A    from flights_in_process as f,
(SELECT * from passenger_in_flight WHERE P_CNIC=3510258004798)as temp , FLIGHT_ID as x
where temp.flight_details = f.flight_number and x.id = f.flight_id_t;



CREATE VIEW FLIGHT_DETAILS_F as
SELECT f.flight_number, f.flight_id_t, x.a_A, x.d_A ,f.a_t ,f.d_t , f.date_f ,f.fare from flights_in_process as f , FLIGHT_ID as x
where f.flight_id_t =x.id;



SELECT * from FLIGHT_DETAILS_F where fare in (
SELECT mix(xx.fare) from
(SELECT * from FLIGHT_DETAILS_F where a_a='KSR' and d_A ='LHR') as xx );


SELECT * from
(SELECT * FROM FLIGHT_DETAILS_F where a_A ='KSR' and d_a='LHR') as temp
where temp.date_f BETWEEN    "2018-11-07" AND "2018-12-19";
CREATE TABLE EliteSternritters(
    name varchar(20),
    schrift varchar(5),
    rank numeric(4,1),
    FOREIGN KEY (name) references sternritters
);

INSERT INTO EliteSternritters(name,schrift,rank)
VALUES ('Gerard Valkyrie','M',3.9),
       ('Pernida Parnkjas','C',3.6),
       ('Uruy','A',3.5),
       ('Lille Barro','X',3.9),
       ('Askin','D',3.7)
       ('Giselle','Z',2.8);

INSERT INTO Sternritters(name,schrift,rank)
VALUES ('Gerard Valkyrie','M',3.9),
       ('Pernida Parnkjas','C',3.6),
       ('Uruy','A',3.5),
       ('Lille Barro','X',3.9),
       ('Askin','D',3.7);

CREATE TABLE VsGotei(
    name varchar(20),
    fought varchar(20),
    stolen varchar(20),
    foreign key (name) references sternritters
);

INSERT INTO VsGotei(name,fought,stolen)
VALUES('Askin','Kisuke',NULL),
       ('Lille Barro','Shunsui',NULL),
       ('Jugram','Bazz-b',NULL),
       ('Bazz-B','Hitsugaya','Daiguren Hyorunmaru');

SELECT *
FROM sternritters,captains
WHERE sternritters.rank> captains.rank;



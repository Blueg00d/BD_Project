Pragma Foreign_Keys = on;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Actor;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Security;
DROP TABLE IF EXISTS Cleaner;
DROP TABLE IF EXISTS Cashier;
DROP TABLE IF EXISTS Exhibition;
DROP TABLE IF EXISTS Play;
DROP TABLE IF EXISTS Movie;



-- nao percebo muito bem quando por not null
CREATE TABLE Person (
    personID NUMERIC(8,0) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    birthdate DATE NOT NULL, 
    TAXnumber NUMERIC(9,0) NOT NULL UNIQUE, 
    address VARCHAR(50) NOT NULL, 
    zipcode NUMERIC(7,0) NOT NULL
);

create table Customer (
    customerID NUMERIC(8,0),
    personID NUMERIC(8,0),

    PRIMARY KEY(customerID, personID), 
    FOREIGN KEY (personID) REFERENCES Person(personID)
);

create table Actor (
    personID NUMERIC(8,0), 
    actorID NUMERIC(8,0),
    trophynumber NUMERIC(2,0) NOT NULL, 
    CV TEXT NOT NULL,


    PRIMARY KEY(personID, actorID),
    FOREIGN KEY (personID) REFERENCES Person(personID),
    CONSTRAINT trophyNonNegative CHECK (trophynumber >= 0)
);

create table Employee (
    personID NUMERIC(8,0),
    employeeID NUMERIC(8,0),
    CV TEXT NOT NULL,

    PRIMARY KEY(personID, employeeID),
    FOREIGN KEY (personID) REFERENCES Person(personID)
);


create table Security (
    employeeID NUMERIC(8,0) PRIMARY KEY,
    uniformNumber NUMERIC(2,0) NOT NULL,
    weaponLicense VARCHAR(50) NOT NULL, 
    trainingLevel VARCHAR(50) NOT NULL,

    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
    CONSTRAINT number_of_securities CHECK (uniformNumber BETWEEN 1 AND 15)
);


create table Cleaner (
    employeeID NUMERIC(8,0) PRIMARY KEY,
    areaAssigned VARCHAR(50) NOT NULL,
    equipmentUsed VARCHAR(100) NOT NULL,
    cleaningProduct VARCHAR(100) NOT NULL,

    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
);

create table Cashier (
    employeeID NUMERIC(8,0) PRIMARY KEY,
    registerNumber NUMERIC(1,0) NOT NULL,
    experienceLevel NUMERIC(1,0) NOT NULL,

    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
    CONSTRAINT number_of_registers CHECK (registerNumber BETWEEN 0 AND 10),
    CONSTRAINT level_of_experience CHECK (experienceLevel BETWEEN 1 AND 5)
);

create table Exhibition (
    exhibitionID NUMERIC(8,0) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL,
    releaseYear NUMERIC(4,0) NOT NULL,
    length TIME NOT NULL,
    genre VARCHAR(20) NOT NULL,
    ageRestriction NUMERIC(2,0),

    CONSTRAINT max_release CHECK (releaseYear <= 2025)
);

create table Play (
    exhibitionID NUMERIC(8,0) PRIMARY KEY,
    theatreCompany VARCHAR(30) NOT NULL,
    numberActs NUMERIC(1,0) NOT NULL,
    scenery VARCHAR(200) NOT NULL, 

    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID),
    CONSTRAINT number_of_acts CHECK (numberActs BETWEEN 1 AND 5)
);

create table Movie (
    exhibitionID NUMERIC(8,0) PRIMARY KEY,
    rating DECIMAL(2,1) NOT NULL,
    studioName VARCHAR(30) NOT NULL,

    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID),
    CONSTRAINT ratingbounds CHECK (rating BETWEEN 0 AND 5)
);

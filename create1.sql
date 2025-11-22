PRAGMA foreign_keys=ON;

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
DROP TABLE IF EXISTS Consume;
DROP TABLE IF EXISTS Food;
DROP TABLE IF EXISTS Drink;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Bill;
DROP TABLE IF EXISTS VIPSubscription;
DROP TABLE IF EXISTS CVInfo;
DROP TABLE IF EXISTS ThemeInfo;
DROP TABLE IF EXISTS Salary;
DROP TABLE IF EXISTS WorkSchedule;
DROP TABLE IF EXISTS ConsumeQ;
DROP TABLE IF EXISTS ReservationSchedule;
DROP TABLE IF EXISTS RoomSchedule;
DROP TABLE IF EXISTS AgeRestriction;
DROP TABLE IF EXISTS RoomSecurity;
DROP TABLE IF EXISTS RoomCleaner;
DROP TABLE IF EXISTS ActorPlay;


-- nao percebo muito bem quando por not null / sara D:
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
    CV TEXT NOT NULL,

    PRIMARY KEY(personID, actorID),
    FOREIGN KEY (personID) REFERENCES Person(personID),
    FOREIGN KEY (CV) REFERENCES CVInfo(CV)
    
);
CREATE TABLE CVInfo(
    CV TEXT PRIMARY KEY,
    trophyNumber NUMERIC(3, 0) NOT NULL,

    CONSTRAINT trophyNonNegative CHECK (trophynumber >= 0)
);

create table Employee (
    personID NUMERIC(8,0),
    employeeID NUMERIC(8,0),
    employeeCV TEXT NOT NULL,

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


CREATE TABLE Consume(
    consumeID NUMERIC(8,0) PRIMARY KEY,
    price NUMBER NOT NULL
);

CREATE TABLE Food(
    consumeID NUMERIC(8,0) PRIMARY KEY,
    size TEXT NOT NULL,
    option TEXT NOT NULL,

    FOREIGN KEY (consumeID) REFERENCES Consume(consumeID),
    CONSTRAINT size_options CHECK (size IN ('small','medium','large')),
    CONSTRAINT options CHECK (option IN ('popcorn','nachos'))
);

CREATE TABLE Drink(
    consumeID NUMERIC(8,0) PRIMARY KEY,
    size TEXT NOT NULL,
    option TEXT NOT NULL,

    FOREIGN KEY (consumeID) REFERENCES Consume(consumeID),
    CONSTRAINT size_options CHECK (size IN ('small','medium','large')),
    CONSTRAINT options CHECK (option IN ('Peach Fuzetea','Lemon Fuzetea','Coca-Cola','Sprite','Compal','Pleno'))
);

CREATE TABLE Menu(
    consumeID NUMERIC(8,0) PRIMARY KEY,
    type TEXT NOT NULL,

    FOREIGN KEY (consumeID) REFERENCES Consume(consumeID),
    CONSTRAINT types CHECK (type IN ('kids', 'double', 'maxi'))
);

CREATE TABLE Room(
    roomID NUMERIC(8,0) PRIMARY KEY,
    numbersSeats NUMBER NOT NULL,
    is_3D BOOLEAN NOT NULL,

    CONSTRAINT number_of_rooms CHECK (roomID > 0 AND roomID <= 10),
    CONSTRAINT number_of_seats CHECK (numbersSeats > 0 AND numbersSeats <= 463)
);

CREATE TABLE Bill(
    -- TODO: Union timeofday with date using DATETIME TYPE
    billID NUMERIC(8,0) PRIMARY KEY,
    amount NUMBER NOT NULL,
    date DATE NOT NULL,
    timeOfDay TIME NOT NULL,
    employeeID NUMERIC(8,0) NOT NULL,
    paymentID NUMERIC(8,0) NOT NULL,
    customerID NUMERIC(8,0) NOT NULL,

    FOREIGN KEY (employeeID) REFERENCES Cashier(employeeID),
    FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    CONSTRAINT amount_nonNegative CHECK (amount >= 0)
);

CREATE TABLE Reservation(
    reservationID NUMERIC(8,0) PRIMARY KEY,
    billID NUMERIC(8,0) NOT NULL,
    theme TEXT NOT NULL,
    
    FOREIGN KEY (billID) REFERENCES Bill(billID),
    FOREIGN KEY (theme) REFERENCES ThemeInfo(theme)
);
CREATE TABLE ThemeInfo(
    theme TEXT PRIMARY KEY,
    pricePerHour NUMERIC (2,0) NOT NULL,

    CONSTRAINT pricePerHour_nonNegative CHECK (pricePerHour >= 0)
);

CREATE TABLE Ticket(
    -- TODO: Union session with date using DATETIME TYPE
    ticketID NUMERIC(8,0) PRIMARY KEY,
    billID NUMERIC(8,0) NOT NULL,
    exhibitionID NUMERIC(8,0) NOT NULL,
    session TIME NOT NULL,
    seatNumber NUMBER NOT NULL,
    rowLetter CHAR NOT NULL,
    date DATE NOT NULL,
    price NUMBER NOT NULL,

    FOREIGN KEY (billID) REFERENCES Bill(billID),
    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID),
    CONSTRAINT number_of_seat CHECK (seatNumber > 0 AND seatNumber <= 33),
    CONSTRAINT letter_of_row CHECK (rowLetter >= 'A' AND rowLetter <= 'M'),
    CONSTRAINT ticketPrice_nonNegative CHECK (price >= 0)
);

CREATE TABLE VIPSubscription(
    appliedDiscountID NUMERIC(8,0) PRIMARY KEY,
    subRank TEXT NOT NULL,
    discountPercent NUMERIC(3,2) NOT NULL, --Percetange is in [0.00, 1.00].
    isActive BOOLEAN NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    customerID NUMERIC(8,0) NOT NULL,
    
    FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    CONSTRAINT subRank_categories CHECK (subRank in ('Bronze', 'Silver', 'Gold', 'Diamond')),
    CONSTRAINT correct_percentage CHECK (discountPercent >= 0 AND discountPercent <= 1)
);

CREATE TABLE Payment(
    -- TODO
    paymentID NUMERIC(8,0) PRIMARY KEY,
    method TEXT NOT NULL,
    totalAmount NUMBER NOT NULL
);
CREATE TABLE Salary(
    salaryID NUMERIC(8,0) PRIMARY KEY,
    employeeID NUMERIC(8,0) NOT NULL,
    ammount NUMERIC (6, 2) NOT NULL,

    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
    CONSTRAINT fair_salary CHECK (ammount>=870)
);
CREATE TABLE WorkSchedule(
    workScheduleID NUMERIC(8, 0) PRIMARY KEY,
    employeeID NUMERIC (8,0) NOT NULL,
    startShift TIME NOT NULL, --!!!
    endShift TIME NULL,       --!!!
    date DATE NOT NULL,

    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
);
CREATE TABLE ConsumeQ(
    consumeID NUMERIC(8,0) PRIMARY KEY,
    quantity NUMERIC(2, 0) NOT NULL,

    FOREIGN KEY (consumeID) REFERENCES Consume(consumeID),
    CONSTRAINT correct_quantity CHECK (quantity>=0)
);
CREATE TABLE ReservationSchedule(
    roomID NUMERIC(8,0) PRIMARY KEY,
    startHour TIME NOT NULL, --!!!
    endHour TIME NOT NULL,  --!!!
    date DATE NOT NULL,
    reservationID NUMERIC(8,0) NOT NULL,

    FOREIGN KEY (roomID) REFERENCES Room(roomID),
    FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID)
);
CREATE TABLE RoomSchedule(
    roomID NUMERIC(8,0),
    exhibitionID NUMERIC(8,0),
    startHour TIME NOT NULL,    ---!!!
    endHour TIME NOT NULL,      --!!!
    date DATE NOT NULL,

    PRIMARY KEY(roomID, exhibitionID),
    FOREIGN KEY (roomID) REFERENCES Room(roomID),
    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID)
);
CREATE TABLE AgeRestriction(
    exhibitionID NUMERIC(8,0) PRIMARY KEY,
    canWatch BOOLEAN NOT NULL,
    customerID NUMERIC (8,0) NOT NULL,

    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);
CREATE TABLE RoomSecurity(
    roomID NUMERIC (8,0),
    employeeID NUMERIC (8,0),

    PRIMARY KEY (roomID, employeeID),
    FOREIGN KEY (roomID) REFERENCES Room(roomID),
    FOREIGN KEY (employeeID) REFERENCES Security(employeeID)
);
CREATE TABLE RoomCleaner(
    roomID NUMERIC (8,0),
    employeeID NUMERIC (8,0),

    PRIMARY KEY (roomID, employeeID),
    FOREIGN KEY (roomID) REFERENCES Room(roomID),
    FOREIGN KEY (employeeID) REFERENCES Cleaner(employeeID)
);
CREATE TABLE ActorPlay(
    actorID NUMERIC (8,0),
    exhibitionID NUMERIC (8,0),

    PRIMARY KEY (actorID, exhibitionID),
    FOREIGN KEY (actorID) REFERENCES Actor(actorID),
    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID)
);






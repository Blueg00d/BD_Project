PRAGMA foreign_keys=ON;

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Cashier;
DROP TABLE IF EXISTS Play;
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS Food;
DROP TABLE IF EXISTS Drink;
DROP TABLE IF EXISTS Menu;
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
DROP TABLE IF EXISTS Actor;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Cleaner;
DROP TABLE IF EXISTS Consume;
DROP TABLE IF EXISTS Security;
DROP TABLE IF EXISTS Exhibition;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Person;


CREATE TABLE Person (
    personID NUMERIC(8,0) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    birthdate DATE NOT NULL, 
    TAXnumber NUMERIC(9,0) NOT NULL UNIQUE, 
    address VARCHAR(50) NOT NULL, 
    zipcode NUMERIC(7,0) NOT NULL
);
create table Customer (
    personID NUMERIC(8,0) PRIMARY KEY,

    FOREIGN KEY (personID) REFERENCES Person(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
create table Actor (
    personID NUMERIC(8,0) PRIMARY KEY, 
    CV TEXT NOT NULL,

    FOREIGN KEY (personID) REFERENCES Person(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (CV) REFERENCES CVInfo(CV)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
CREATE TABLE CVInfo(
    CV TEXT PRIMARY KEY,
    trophyNumber NUMERIC(3, 0) NOT NULL,

    CONSTRAINT trophyNonNegative CHECK (trophynumber >= 0)
);
create table Employee (
    personID NUMERIC(8,0) PRIMARY KEY,
    employeeCV TEXT NOT NULL,

    FOREIGN KEY (personID) REFERENCES Person(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
create table Security (
    personID NUMERIC(8,0) PRIMARY KEY,
    uniformNumber NUMERIC(2,0) NOT NULL,
    weaponLicense VARCHAR(50) NOT NULL, 
    trainingLevel VARCHAR(50) NOT NULL,

    FOREIGN KEY (personID) REFERENCES Employee(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT number_of_securities CHECK (uniformNumber BETWEEN 1 AND 15)
);
create table Cleaner (
    personID NUMERIC(8,0) PRIMARY KEY,
    areaAssigned VARCHAR(50) NOT NULL,
    equipmentUsed VARCHAR(100) NOT NULL,
    cleaningProduct VARCHAR(100) NOT NULL,

    FOREIGN KEY (personID) REFERENCES Employee(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
create table Cashier (
    personID NUMERIC(8,0) PRIMARY KEY,
    registerNumber NUMERIC(1,0) NOT NULL,
    experienceLevel NUMERIC(1,0) NOT NULL,

    FOREIGN KEY (personID) REFERENCES Employee(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT number_of_registers CHECK (registerNumber BETWEEN 0 AND 10),
    CONSTRAINT level_of_experience CHECK (experienceLevel BETWEEN 1 AND 5)
);
create table Exhibition (
    exhibitionID NUMERIC(8,0) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL,
    releaseYear NUMERIC(4,0) NOT NULL,
    length NUMERIC(3,0) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    ageRestriction NUMERIC(2,0),

    CONSTRAINT max_release CHECK (releaseYear <= 2025),
    CONSTRAINT max_length CHECK (length BETWEEN 0 AND 360)
);
create table Play (
    exhibitionID NUMERIC(8,0) PRIMARY KEY,
    theatreCompany VARCHAR(30) NOT NULL,
    numberActs NUMERIC(1,0) NOT NULL,
    scenery VARCHAR(200) NOT NULL, 

    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT number_of_acts CHECK (numberActs BETWEEN 1 AND 5)
);
create table Movie (
    exhibitionID NUMERIC(8,0) PRIMARY KEY,
    rating DECIMAL(2,1) NOT NULL,
    studioName VARCHAR(30) NOT NULL,

    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID)    
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT ratingbounds CHECK (rating BETWEEN 0 AND 5)
);
CREATE TABLE Consume(
    consumeID NUMERIC(8,0) PRIMARY KEY,
    price NUMBER NOT NULL,

    CONSTRAINT price_nonNegative CHECK (price >= 0)
);
CREATE TABLE Food(
    consumeID NUMERIC(8,0) PRIMARY KEY,
    size TEXT NOT NULL,
    option TEXT NOT NULL,

    FOREIGN KEY (consumeID) REFERENCES Consume(consumeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT size_options CHECK (size IN ('small','medium','large')),
    CONSTRAINT options CHECK (option IN ('popcorn','nachos'))
);
CREATE TABLE Drink(
    consumeID NUMERIC(8,0) PRIMARY KEY,
    size TEXT NOT NULL,
    option TEXT NOT NULL,

    FOREIGN KEY (consumeID) REFERENCES Consume(consumeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT size_options CHECK (size IN ('small','medium','large')),
    CONSTRAINT options CHECK (option IN ('Peach Fuzetea','Lemon Fuzetea','Coca-Cola','Sprite','Compal','Pleno'))
);
CREATE TABLE Menu(
    consumeID NUMERIC(8,0) PRIMARY KEY,
    type TEXT NOT NULL,

    FOREIGN KEY (consumeID) REFERENCES Consume(consumeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT types CHECK (type IN ('kids', 'double', 'maxi'))
);

CREATE TABLE Room(
    roomID NUMERIC(8,0) PRIMARY KEY,
    numberSeats NUMBER NOT NULL,
    is_3D BOOLEAN NOT NULL,

    CONSTRAINT number_of_rooms CHECK (roomID BETWEEN 1 AND 10),
    CONSTRAINT number_of_seats CHECK (numberSeats BETWEEN 1 AND 463)
);
CREATE TABLE Bill(
    billID NUMERIC(8,0) PRIMARY KEY,
    amount NUMBERIC(6,2) NOT NULL,
    date DATE NOT NULL,
    timeOfDay TIME NOT NULL,
    cashierID NUMERIC(8,0),
    paymentID NUMERIC(8,0),
    customerID NUMERIC(8,0),

    FOREIGN KEY (cashierID) REFERENCES Cashier(personID)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    FOREIGN KEY (paymentID) REFERENCES Payment(paymentID)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    FOREIGN KEY (customerID) REFERENCES Customer(personID)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT amount_nonNegative CHECK (amount >= 0),
    CONSTRAINT valid_date CHECK (DATE(date) IS NOT NULL),
    CONSTRAINT valid_timeOfDay CHECK (TIME(timeOfDay) IS NOT NULL)
);
CREATE TABLE Reservation(
    reservationID NUMERIC(8,0) PRIMARY KEY,
    billID NUMERIC(8,0) NOT NULL,
    theme TEXT NOT NULL,
    
    FOREIGN KEY (billID) REFERENCES Bill(billID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (theme) REFERENCES ThemeInfo(theme)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
CREATE TABLE ThemeInfo(
    theme TEXT PRIMARY KEY,
    pricePerHour NUMERIC (2,0) NOT NULL,

    CONSTRAINT pricePerHour_nonNegative CHECK (pricePerHour >= 0)
);
CREATE TABLE Ticket(
    ticketID NUMERIC(8,0) PRIMARY KEY,
    billID NUMERIC(8,0) NOT NULL,
    exhibitionID NUMERIC(8,0) NOT NULL,
    session TIME NOT NULL,
    seatNumber NUMBER NOT NULL,
    rowLetter CHAR NOT NULL,
    date DATE NOT NULL,
    price NUMBER NOT NULL,

    FOREIGN KEY (billID) REFERENCES Bill(billID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,  
    CONSTRAINT number_of_seat CHECK (seatNumber BETWEEN 1 AND 33),
    CONSTRAINT letter_of_row CHECK (rowLetter BETWEEN 'A' AND 'M'),
    CONSTRAINT ticketPrice_nonNegative CHECK (price >= 0),
    CONSTRAINT valid_session CHECK (TIME(session) IS NOT NULL),
    CONSTRAINT valid_date CHECK (DATE(date) IS NOT NULL) 
);
CREATE TABLE VIPSubscription(
    appliedDiscountID NUMERIC(8,0) PRIMARY KEY,
    subRank TEXT NOT NULL,
    discountPercent NUMERIC(3,2) NOT NULL, --Percetange is in [0.00, 1.00].
    isActive BOOLEAN NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    personID NUMERIC(8,0) NOT NULL,
    
    FOREIGN KEY (personID) REFERENCES Customer(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT subRank_categories CHECK (subRank in ('Bronze', 'Silver', 'Gold', 'Diamond')),
    CONSTRAINT correct_percentage CHECK (discountPercent BETWEEN 0 AND 1)
);
CREATE TABLE Payment(
    paymentID NUMERIC(8,0) PRIMARY KEY,
    method TEXT NOT NULL,
    totalAmount NUMBERIC(6,2) NOT NULL,

    CONSTRAINT methods_available CHECK (method IN ('card', 'cash')),
    CONSTRAINT totalAmount_nonNegative CHECK (totalAmount >= 0)
);
CREATE TABLE Salary(
    salaryID NUMERIC(8,0) PRIMARY KEY,
    personID NUMERIC(8,0) NOT NULL,
    ammount NUMERIC (6,2) NOT NULL,

    FOREIGN KEY (personID) REFERENCES Employee(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fair_salary CHECK (ammount>=870)
);
CREATE TABLE WorkSchedule(
    workScheduleID NUMERIC(8, 0) PRIMARY KEY,
    personID NUMERIC (8,0) NOT NULL,
    startShift TIME NOT NULL, --!!!
    endShift TIME NOT NULL,   --!!!
    date DATE NOT NULL,

    FOREIGN KEY (personID) REFERENCES Employee(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT valid_startShift CHECK (TIME(startShift) IS NOT NULL),
    CONSTRAINT valid_endShift CHECK (TIME(endShift) IS NOT NULL),
    CONSTRAINT valid_date CHECK (DATE(date) IS NOT NULL)
);
CREATE TABLE ConsumeQ(
    consumeID NUMERIC(8,0),
    billID NUMERIC(8,0), 
    quantity NUMERIC(2, 0) NOT NULL,

    PRIMARY KEY (consumeID, billID),
    FOREIGN KEY (billID) REFERENCES Bill(billID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (consumeID) REFERENCES Consume(consumeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT correct_quantity CHECK (quantity>=0)
);
CREATE TABLE ReservationSchedule(
    roomID NUMERIC(8,0),
    startHour TIME NOT NULL, 
    endHour TIME,  
    date DATE,
    reservationID NUMERIC(8,0) NOT NULL,
    PRIMARY KEY (roomID, startHour, date),
    FOREIGN KEY (roomID) REFERENCES Room(roomID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT valid_startHour CHECK (TIME(startHour) IS NOT NULL),
    CONSTRAINT valid_endHour CHECK (TIME(endHour) IS NOT NULL)
);
CREATE TABLE RoomSchedule(
    roomID NUMERIC(8,0),
    exhibitionID NUMERIC(8,0),
    startHour TIME NOT NULL,   
    endHour TIME NOT NULL,     
    date DATE NOT NULL,

    PRIMARY KEY(roomID, date, startHour),
    FOREIGN KEY (roomID) REFERENCES Room(roomID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT valid_startHour CHECK (TIME(startHour) IS NOT NULL),
    CONSTRAINT valid_endHour CHECK (TIME(endHour) IS NOT NULL)
);
CREATE TABLE AgeRestriction(
    exhibitionID NUMERIC(8,0),
    canWatch BOOLEAN NOT NULL,
    personID NUMERIC (8,0),
    PRIMARY KEY (exhibitionID, personID),
    FOREIGN KEY (exhibitionID) REFERENCES Exhibition(exhibitionID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (personID) REFERENCES Customer(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
CREATE TABLE RoomSecurity(
    roomID NUMERIC (8,0),
    personID NUMERIC (8,0),

    PRIMARY KEY (roomID, personID),
    FOREIGN KEY (roomID) REFERENCES Room(roomID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (personID) REFERENCES Security(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
CREATE TABLE RoomCleaner(
    roomID NUMERIC (8,0),
    personID NUMERIC (8,0),

    PRIMARY KEY (roomID, personID),
    FOREIGN KEY (roomID) REFERENCES Room(roomID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (personID) REFERENCES Cleaner(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
CREATE TABLE ActorPlay(
    personID NUMERIC (8,0),
    exhibitionID NUMERIC (8,0),

    PRIMARY KEY (personID, exhibitionID),
    FOREIGN KEY (personID) REFERENCES Actor(personID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (exhibitionID) REFERENCES Play(exhibitionID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
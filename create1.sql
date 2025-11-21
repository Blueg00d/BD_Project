PRAGMA foreign_keys=ON;

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
    pricePerHour NUMBER NOT NULL,

    FOREIGN KEY (billID) REFERENCES Bill(billID),
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
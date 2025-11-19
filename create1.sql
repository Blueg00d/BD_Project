Pragma Foreign_Keys = on;

create table Person (
    personID INT, 
    name VARCHAR(50), 
    birthdate DATE, 
    TAXnumber NUMERIC(9,0), 
    address VARCHAR(50), 
    zipcode NUMERIC(7,0)
);
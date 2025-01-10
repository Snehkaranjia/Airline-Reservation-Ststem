CREATE DATABASE IF NOT EXISTS Airline_reservation_system;

USE Airline_reservation_system;

CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    date_of_birth DATE,
    username VARCHAR(50) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE aircraft (
    aircraft_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE flights (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_number VARCHAR(10) NOT NULL,
    airline VARCHAR(100) NOT NULL,
    departure VARCHAR(100) NOT NULL,
    arrival VARCHAR(100) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    duration VARCHAR(50) NOT NULL,
    stops INT NOT NULL,
    aircraft_id INT,
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id)
);

CREATE TABLE IF NOT EXISTS passengers (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    flight_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    date_of_birth DATE NOT NULL,
    passport_number VARCHAR(20) NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    card_number VARCHAR(16) NOT NULL,
    expiry_date DATE NOT NULL,
    cvv CHAR(3) NOT NULL,
    card_holder_name VARCHAR(100) NOT NULL,
    user_id INT,
    booking_id INT,
    amount_paid DECIMAL(10, 2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (booking_id) REFERENCES passengers(booking_id)
);

-- Insert sample data into Users table
INSERT INTO Users (first_name, last_name, email, password, phone, address, date_of_birth, username) 
VALUES 
('John', 'Doe', 'john.doe@example.com', 'password123', '1234567890', '123 Main St, City, Country', '1990-01-01', 'johndoe'),
('Jane', 'Smith', 'jane.smith@example.com', 'password456', '9876543210', '456 Elm St, City, Country', '1992-02-02', 'janesmith'),
('Alice', 'Brown', 'alice.brown@example.com', 'password789', '5555555555', '789 Oak St, City, Country', '1985-03-15', 'alicebrown'),
('Bob', 'Johnson', 'bob.johnson@example.com', 'password101', '6666666666', '101 Pine St, City, Country', '1980-06-20', 'bobjohnson'),
('Charlie', 'Williams', 'charlie.williams@example.com', 'password202', '7777777777', '202 Maple St, City, Country', '1995-07-30', 'charliewilliams'),
('Emma', 'Davis', 'emma.davis@example.com', 'password303', '8888888888', '303 Birch St, City, Country', '1998-11-10', 'emmadavis'),
('Liam', 'Miller', 'liam.miller@example.com', 'password404', '9999999999', '404 Cedar St, City, Country', '2000-05-05', 'liammiller');

-- Insert sample data into aircraft table
INSERT INTO aircraft (model_name, manufacturer, capacity) 
VALUES 
('Boeing 737', 'Boeing', 180),
('Airbus A320', 'Airbus', 200),
('Embraer 190', 'Embraer', 100),
('Boeing 747', 'Boeing', 416),
('Airbus A380', 'Airbus', 853),
('Cessna 172', 'Cessna', 4),
('Bombardier CRJ900', 'Bombardier', 90);

-- Insert sample data into flights table
INSERT INTO flights (flight_number, airline, departure, arrival, departure_time, arrival_time, price, duration, stops, aircraft_id) 
VALUES 
('AA123', 'American Airlines', 'New York', 'Los Angeles', '2024-12-01 08:00:00', '2024-12-01 11:00:00', 300.00, '6h', 0, 1),
('DL456', 'Delta Airlines', 'Chicago', 'Atlanta', '2024-12-02 09:00:00', '2024-12-02 12:30:00', 200.00, '3h 30m', 1, 2),
('UA789', 'United Airlines', 'San Francisco', 'Denver', '2024-12-03 15:00:00', '2024-12-03 17:30:00', 150.00, '2h 30m', 3, 2),
('BA101', 'British Airways', 'London', 'New York', '2024-12-04 10:00:00', '2024-12-04 16:00:00', 600.00, '6h', 0, 4),
('AF202', 'Air France', 'Paris', 'Dubai', '2024-12-05 23:00:00', '2024-12-06 07:00:00', 800.00, '8h', 0, 5),
('EK303', 'Emirates', 'Dubai', 'Sydney', '2024-12-06 21:00:00', '2024-12-07 09:00:00', 1200.00, '12h', 0, 5),
('QF404', 'Qantas', 'Sydney', 'Melbourne', '2024-12-07 08:00:00', '2024-12-07 09:30:00', 100.00, '1h 30m', 0, 6);

-- Insert sample data into passengers table
INSERT INTO passengers (user_id, flight_id, first_name, last_name, email, phone, date_of_birth, passport_number) 
VALUES 
(1, 1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '1990-01-01', 'A1234567'),
(2, 2, 'Jane', 'Smith', 'jane.smith@example.com', '9876543210', '1992-02-02', 'B7654321'),
(3, 3, 'Alice', 'Brown', 'alice.brown@example.com', '5555555555', '1985-03-15', 'C0987654'),
(4, 4, 'Bob', 'Johnson', 'bob.johnson@example.com', '6666666666', '1980-06-20', 'D5678901'),
(5, 5, 'Charlie', 'Williams', 'charlie.williams@example.com', '7777777777', '1995-07-30', 'E3456789'),
(6, 6, 'Emma', 'Davis', 'emma.davis@example.com', '8888888888', '1998-11-10', 'F2345678'),
(7, 7, 'Liam', 'Miller', 'liam.miller@example.com', '9999999999', '2000-05-05', 'G1234567');

-- Insert sample data into payments table
INSERT INTO payments (card_number, expiry_date, cvv, card_holder_name, user_id, booking_id, amount_paid) 
VALUES 
('4111111111111111', '2025-12-31', '123', 'John Doe', 1, 8, 300.00),
('5555666677778888', '2026-06-30', '234', 'Jane Smith', 2, 9, 200.00),
('4012888888881881', '2024-11-30', '345', 'Alice Brown', 3, 10, 150.00),
('5105105105105100', '2025-05-31', '456', 'Bob Johnson', 4,11, 600.00),
('4222222222222222', '2026-03-31', '567', 'Charlie Williams', 5, 12, 800.00),
('3782822463100050', '2027-07-31', '678', 'Emma Davis', 6, 13, 1200.00),
('6011000990139424', '2028-08-31', '789', 'Liam Miller', 7, 14, 100.00);

CREATE VIEW FlightDetails AS
SELECT 
    f.flight_id,
    f.flight_number,
    f.airline,
    f.departure,
    f.arrival,
    f.departure_time,
    f.arrival_time,
    f.price,
    f.duration,
    f.stops,
    a.model_name AS aircraft_model
FROM flights f
JOIN aircraft a ON f.aircraft_id = a.aircraft_id;

CREATE VIEW PassengerDetails AS
SELECT 
    p.booking_id,
    p.first_name,
    p.last_name,
    p.email,
    p.phone,
    p.passport_number,
    p.booking_date,
    f.flight_number,
    f.departure,
    f.arrival,
    f.departure_time
FROM passengers p
JOIN flights f ON p.flight_id = f.flight_id;

DELIMITER //
CREATE PROCEDURE BookFlight(
    IN userId INT,
    IN flightId INT,
    IN firstName VARCHAR(50),
    IN lastName VARCHAR(50),
    IN email VARCHAR(100),
    IN phone VARCHAR(15),
    IN dateOfBirth DATE,
    IN passportNo VARCHAR(20)
)
BEGIN
    INSERT INTO passengers (
        user_id, flight_id, first_name, last_name, email, phone, date_of_birth, passport_number
    )
    VALUES (
        userId, flightId, firstName, lastName, email, phone, dateOfBirth, passportNo
    );
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE DeleteBooking(IN bookingId INT)
BEGIN
    DECLARE payment_count INT;

    -- Check if there are payments associated with the booking
    SELECT COUNT(*) INTO payment_count
    FROM payments
    WHERE booking_id = bookingId;

    -- If a payment exists, prevent deletion
    IF payment_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete booking: Payment already made.';
    ELSE
        -- If no payment, proceed with deleting the booking
        DELETE FROM passengers WHERE booking_id = bookingId;
        -- Optionally, you can also delete the corresponding records from the payments table if needed:
        -- DELETE FROM payments WHERE booking_id = bookingId;
    END IF;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateFlightPrice(
    IN flightId INT,
    IN newPrice DECIMAL(10, 2)
)
BEGIN
    UPDATE flights
    SET price = newPrice
    WHERE flight_id = flightId;
END //
DELIMITER ;

DELIMITER //

CREATE TRIGGER CheckFullFlight
BEFORE INSERT ON passengers
FOR EACH ROW
BEGIN
    DECLARE current_capacity INT;
    DECLARE max_capacity INT;

    -- Get the number of passengers already booked on the flight
    SELECT COUNT(*) INTO current_capacity
    FROM passengers
    WHERE flight_id = NEW.flight_id;
    
    -- Get the maximum capacity of the aircraft for this flight
    SELECT a.capacity INTO max_capacity
    FROM flights f
    JOIN aircraft a ON f.aircraft_id = a.aircraft_id
    WHERE f.flight_id = NEW.flight_id;
    
    -- Check if the flight is already full
    IF current_capacity >= max_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This flight is already full. Cannot book more passengers.';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER UpdatePaymentAmount
AFTER UPDATE ON flights
FOR EACH ROW
BEGIN
    -- Check if the flight price has changed
    IF OLD.price != NEW.price THEN
        -- Update the payment amount in the payments table if the flight price changes
        UPDATE payments
        SET amount_paid = NEW.price
        WHERE booking_id IN (SELECT booking_id FROM passengers WHERE flight_id = NEW.flight_id);
    END IF;
END //

DELIMITER ;


-- Insert sample data into Users table
INSERT INTO Users (first_name, last_name, email, password, phone, address, date_of_birth, username) 
VALUES 
('John', 'Doe', 'john.doe@example.com', 'password123', '1234567890', '123 Main St, City, Country', '1990-01-01', 'johndoe'),
('Jane', 'Smith', 'jane.smith@example.com', 'password456', '9876543210', '456 Elm St, City, Country', '1992-02-02', 'janesmith'),
('Alice', 'Brown', 'alice.brown@example.com', 'password789', '5555555555', '789 Oak St, City, Country', '1985-03-15', 'alicebrown'),
('Bob', 'Johnson', 'bob.johnson@example.com', 'password101', '6666666666', '101 Pine St, City, Country', '1980-06-20', 'bobjohnson'),
('Charlie', 'Williams', 'charlie.williams@example.com', 'password202', '7777777777', '202 Maple St, City, Country', '1995-07-30', 'charliewilliams'),
('Emma', 'Davis', 'emma.davis@example.com', 'password303', '8888888888', '303 Birch St, City, Country', '1998-11-10', 'emmadavis'),
('Liam', 'Miller', 'liam.miller@example.com', 'password404', '9999999999', '404 Cedar St, City, Country', '2000-05-05', 'liammiller');

-- Insert sample data into aircraft table
INSERT INTO aircraft (model_name, manufacturer, capacity) 
VALUES 
('Boeing 737', 'Boeing', 180),
('Airbus A320', 'Airbus', 200),
('Embraer 190', 'Embraer', 100),
('Boeing 747', 'Boeing', 416),
('Airbus A380', 'Airbus', 853),
('Cessna 172', 'Cessna', 4),
('Bombardier CRJ900', 'Bombardier', 90);

-- Insert sample data into flights table
INSERT INTO flights (flight_number, airline, departure, arrival, departure_time, arrival_time, price, duration, stops, aircraft_id) 
VALUES 
('AA123', 'American Airlines', 'New York', 'Los Angeles', '2024-12-01 08:00:00', '2024-12-01 11:00:00', 300.00, '6h', 0, 1),
('DL456', 'Delta Airlines', 'Chicago', 'Atlanta', '2024-12-02 09:00:00', '2024-12-02 12:30:00', 200.00, '3h 30m', 1, 2),
('UA789', 'United Airlines', 'San Francisco', 'Denver', '2024-12-03 15:00:00', '2024-12-03 17:30:00', 150.00, '2h 30m', 3, 2),
('BA101', 'British Airways', 'London', 'New York', '2024-12-04 10:00:00', '2024-12-04 16:00:00', 600.00, '6h', 0, 4),
('AF202', 'Air France', 'Paris', 'Dubai', '2024-12-05 23:00:00', '2024-12-06 07:00:00', 800.00, '8h', 0, 5),
('EK303', 'Emirates', 'Dubai', 'Sydney', '2024-12-06 21:00:00', '2024-12-07 09:00:00', 1200.00, '12h', 0, 5),
('QF404', 'Qantas', 'Sydney', 'Melbourne', '2024-12-07 08:00:00', '2024-12-07 09:30:00', 100.00, '1h 30m', 0, 6);

-- Insert sample data into passengers table
INSERT INTO passengers (user_id, flight_id, first_name, last_name, email, phone, date_of_birth, passport_number) 
VALUES 
(1, 1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '1990-01-01', 'A1234567'),
(2, 2, 'Jane', 'Smith', 'jane.smith@example.com', '9876543210', '1992-02-02', 'B7654321'),
(3, 3, 'Alice', 'Brown', 'alice.brown@example.com', '5555555555', '1985-03-15', 'C0987654'),
(4, 4, 'Bob', 'Johnson', 'bob.johnson@example.com', '6666666666', '1980-06-20', 'D5678901'),
(5, 5, 'Charlie', 'Williams', 'charlie.williams@example.com', '7777777777', '1995-07-30', 'E3456789'),
(6, 6, 'Emma', 'Davis', 'emma.davis@example.com', '8888888888', '1998-11-10', 'F2345678'),
(7, 7, 'Liam', 'Miller', 'liam.miller@example.com', '9999999999', '2000-05-05', 'G1234567');

-- Insert sample data into payments table
INSERT INTO payments (card_number, expiry_date, cvv, card_holder_name, user_id, booking_id, amount_paid) 
VALUES 
('4111111111111111', '2025-12-31', '123', 'John Doe', 1, 8, 300.00),
('5555666677778888', '2026-06-30', '234', 'Jane Smith', 2, 9, 200.00),
('4012888888881881', '2024-11-30', '345', 'Alice Brown', 3, 10, 150.00),
('5105105105105100', '2025-05-31', '456', 'Bob Johnson', 4,11, 600.00),
('4222222222222222', '2026-03-31', '567', 'Charlie Williams', 5, 12, 800.00),
('3782822463100050', '2027-07-31', '678', 'Emma Davis', 6, 13, 1200.00),
('6011000990139424', '2028-08-31', '789', 'Liam Miller', 7, 14, 100.00);


SELECT * FROM users; 
SELECT * FROM aircraft;
SELECT * FROM flights;
select * from passengers;
select * from payments;








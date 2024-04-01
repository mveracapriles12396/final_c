use week10ConnectedDatabase;
BEGIN TRANSACTION;

-- Drop tables 

DROP TABLE IF EXISTS TicketPrice;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Show;
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS Theatre;
DROP TABLE IF EXISTS UserProfile;
DROP TABLE IF EXISTS UserType;

-- Create UserType table 
CREATE TABLE UserType (
  user_type_id INT PRIMARY KEY IDENTITY,
  user_type_name VARCHAR(50) NOT NULL
);

-- Create UserProfile table
CREATE TABLE UserProfile (
  user_id INT PRIMARY KEY IDENTITY,
  [password] VARCHAR(255) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  user_type_id INT NOT NULL,
  date_of_birth DATE NOT NULL,
  is_student BIT NOT NULL,
  FOREIGN KEY (user_type_id) REFERENCES UserType(user_type_id)
);

-- Create Theatre table
CREATE TABLE Theatre (
  location_id INT PRIMARY KEY IDENTITY,
  location_name VARCHAR(100) NOT NULL,
  location_address VARCHAR(255) NOT NULL,
  location_phone VARCHAR(20) NOT NULL,
  location_photo VARCHAR(255) NOT NULL,
  business_hours VARCHAR(255) NOT NULL
);

-- Create Movie table
CREATE TABLE Movie (
  movie_id INT PRIMARY KEY IDENTITY,
  movie_title VARCHAR(100) NOT NULL,
  duration INT NOT NULL,
  director_name VARCHAR(100) NOT NULL,
  photo_url VARCHAR(255) NOT NULL
);

-- Create Show table
CREATE TABLE Show (
  show_id INT PRIMARY KEY IDENTITY,
  location_id INT NOT NULL,
  movie_id INT NOT NULL,
  available_seats INT NOT NULL CHECK (available_seats >= 0),
  date_time DATETIME NOT NULL,
  FOREIGN KEY (location_id) REFERENCES Theatre(location_id),
  FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

-- Create Ticket table
CREATE TABLE Ticket (
  ticket_id INT PRIMARY KEY IDENTITY,
  user_id INT NOT NULL,
  show_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  price DECIMAL(10,2) NOT NULL,
  order_date DATETIME NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES UserProfile(user_id),
  FOREIGN KEY (show_id) REFERENCES Show(show_id)
);

-- Create TicketPrice table 
CREATE TABLE TicketPrice (
  location_id INT PRIMARY KEY,
  regular_price DECIMAL(10,2) NOT NULL, 
  senior_discount DECIMAL(10,2)  NOT NULL,
  student_discount DECIMAL(10,2)  NOT NULL,
  member_discount DECIMAL(10,2)  NOT NULL,
  admin_discount DECIMAL(10,2)  NOT NULL,
  tuesday_discount DECIMAL(10,2)  NOT NULL,
  FOREIGN KEY (location_id) REFERENCES Theatre(location_id)
);

-- UserType table
INSERT INTO UserType (user_type_name) VALUES
('Admin'),
('User'),
('Member');

-- UserProfile table
INSERT INTO UserProfile ([password], email, user_type_id, date_of_birth, is_student) VALUES
('password123', 'admin@example.com', 1, '1990-01-01', 0),
('userpassword', 'user@example.com', 2, '1995-05-15', 1),
('memberpass', 'member@example.com', 3, '1988-12-10', 0),
('studentpass', 'student@example.com', 2, '2000-09-20', 1);

-- Theatre table
INSERT INTO Theatre (location_name, location_address, location_phone, location_photo, business_hours) VALUES
('CinemaCity', '123 Main St, Anytown', '555-123-4567', 'ms-appx:///Assets/filmca-cinemas.jpg', 'Monday-Sunday: 9am-11pm'),
('StarTheatre', '456 Broadway, Othertown', '555-987-6543', 'ms-appx:///Assets/Haunted-Theater.jpg', 'Monday-Friday: 10am-10pm; Saturday-Sunday: 11am-11pm');

-- Movie table
INSERT INTO Movie (movie_title, duration, director_name, photo_url) VALUES
('The Avengers', 180, 'Joss Whedon', 'ms-appx:///Assets/avengers.jpg'),
('Inception', 148, 'Christopher Nolan', 'ms-appx:///Assets/inception.jpg'),
('The Lion King', 118, 'Jon Favreau', 'ms-appx:///Assets/lion.png');

-- Show table
INSERT INTO Show (location_id, movie_id, available_seats, date_time) VALUES
(1, 1, 150, '2024-04-01 19:00:00'),
(1, 2, 100, '2024-04-02 15:30:00'),
(2, 3, 200, '2024-04-03 20:00:00');

-- Ticket table
INSERT INTO Ticket (user_id, show_id, quantity, price, order_date, amount) VALUES
(2, 1, 2, 15.00, '2024-03-28 10:30:00', 30.00),
(3, 2, 1, 10.00, '2024-03-29 14:45:00', 10.00),
(4, 3, 3, 8.00, '2024-03-30 18:00:00', 24.00);

-- TicketPrice table
INSERT INTO TicketPrice (location_id, regular_price, senior_discount, student_discount, member_discount, admin_discount, tuesday_discount) VALUES
(1, 20.00, 5.00, 3.00, 2.00, 1.00, 10.00),
(2, 18.00, 4.00, 2.50, 1.50, 1.50, 8.00);


-- UserType table
SELECT * FROM UserType;

-- UserProfile table
SELECT * FROM UserProfile;

-- Theatre table
SELECT * FROM Theatre;

-- Movie table
SELECT * FROM Movie;

-- Show table
SELECT * FROM Show;

-- Ticket table
SELECT * FROM Ticket;

-- TicketPrice table
SELECT * FROM TicketPrice;

COMMIT TRANSACTION; 

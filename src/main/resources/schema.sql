-- Drop tables if they exist
DROP TABLE IF EXISTS complaints;
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address TEXT,
    driving_license VARCHAR(50) NOT NULL UNIQUE,
    role ENUM('USER', 'ADMIN') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create vehicles table
CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_number VARCHAR(20) NOT NULL UNIQUE,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    type ENUM('CAR', 'BIKE', 'SCOOTER', 'SUV', 'TRUCK') NOT NULL,
    year INT NOT NULL,
    color VARCHAR(30) NOT NULL,
    seating_capacity INT NOT NULL,
    fuel_type ENUM('PETROL', 'DIESEL', 'ELECTRIC', 'HYBRID', 'CNG') NOT NULL,
    mileage DECIMAL(10, 2),
    price_per_day DECIMAL(10, 2) NOT NULL,
    availability BOOLEAN DEFAULT TRUE,
    image_url VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create bookings table
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED') DEFAULT 'PENDING',
    payment_status ENUM('PENDING', 'PAID', 'REFUNDED') DEFAULT 'PENDING',
    payment_method VARCHAR(50),
    transaction_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

-- Create videos table
CREATE TABLE videos (
    video_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    video_type ENUM('PICKUP', 'RETURN') NOT NULL,
    video_url VARCHAR(255) NOT NULL,
    upload_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Create complaints table
CREATE TABLE complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    booking_id INT,
    subject VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED') DEFAULT 'OPEN',
    admin_response TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Insert admin user
INSERT INTO users (username, password, first_name, last_name, email, phone, address, driving_license, role)
VALUES ('admin', '$2a$10$XptfskLsT1l/bRTLRiiCgejHqOpgXFreUnNUa35gJdCr2v2QbVFzu', 'Admin', 'User', 'admin@vehicle.com', '1234567890', 'Admin Address', 'ADMIN123456', 'ADMIN');

-- Insert sample vehicles
INSERT INTO vehicles (registration_number, brand, model, type, year, color, seating_capacity, fuel_type, mileage, price_per_day, availability, description)
VALUES 
('ABC123', 'Toyota', 'Camry', 'CAR', 2022, 'Black', 5, 'PETROL', 15.5, 1500.00, TRUE, 'Comfortable sedan with excellent fuel efficiency'),
('XYZ456', 'Honda', 'CR-V', 'SUV', 2021, 'White', 7, 'PETROL', 12.8, 1750.00, TRUE, 'Spacious SUV perfect for family trips'),
('DEF789', 'Ford', 'Mustang', 'CAR', 2023, 'Red', 2, 'PETROL', 9.5, 1950.00, TRUE, 'Powerful sports car with iconic design'),
('GHI101', 'Hyundai', 'i20', 'CAR', 2022, 'Blue', 5, 'PETROL', 18.2, 1200.00, TRUE, 'Compact hatchback ideal for city driving'),
('JKL202', 'Maruti', 'Swift', 'CAR', 2021, 'Silver', 5, 'PETROL', 19.5, 1000.00, TRUE, 'Fuel-efficient hatchback with modern features'),
('MNO303', 'Mahindra', 'Scorpio', 'SUV', 2022, 'Black', 7, 'DIESEL', 14.2, 1650.00, TRUE, 'Rugged SUV with powerful performance');
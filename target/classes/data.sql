-- Insert sample users (password is 'password123' encrypted with BCrypt)
-- Set auto_increment to start from 1
ALTER TABLE users AUTO_INCREMENT = 1;
INSERT INTO users (user_id, username, password, first_name, last_name, email, phone, address, driving_license, role)
VALUES 
(1, 'user1', '$2a$10$XptfskLsT1l/bRTLRiiCgejHqOpgXFreUnNUa35gJdCr2v2QbVFzu', 'Rahul', 'Sharma', 'rahul@example.com', '9876543210', '123 MG Road, Bangalore', 'DL12345678', 'USER'),
(2, 'user2', '$2a$10$XptfskLsT1l/bRTLRiiCgejHqOpgXFreUnNUa35gJdCr2v2QbVFzu', 'Priya', 'Patel', 'priya@example.com', '8765432109', '456 Anna Salai, Chennai', 'DL87654321', 'USER'),
(3, 'testuser', '$2a$10$XptfskLsT1l/bRTLRiiCgejHqOpgXFreUnNUa35gJdCr2v2QbVFzu', 'Test', 'User', 'test@example.com', '7654321098', 'NIET, Greater Noida', 'DL98765432', 'USER');

-- Insert sample vehicles (Indian cars with prices in INR)
-- Set auto_increment to start from 1
ALTER TABLE vehicles AUTO_INCREMENT = 1;
INSERT INTO vehicles (vehicle_id, registration_number, brand, model, type, year, color, seating_capacity, fuel_type, mileage, price_per_day, availability, image_url, description)
VALUES 
(1, 'KA01MH1234', 'Maruti Suzuki', 'Swift', 'CAR', 2023, 'Red', 5, 'PETROL', 23.20, 1000.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Maruti/Swift/10406/1697698080681/front-left-side-47.jpg', 'The Maruti Suzuki Swift is a popular hatchback known for its sporty design, excellent fuel efficiency, and fun-to-drive nature. Perfect for city commuting and weekend getaways.'),

(2, 'TN02AB5678', 'Hyundai', 'Creta', 'SUV', 2022, 'White', 5, 'DIESEL', 21.40, 1500.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Hyundai/Creta/10544/1697696202593/front-left-side-47.jpg', 'The Hyundai Creta is a feature-packed compact SUV with a comfortable cabin, powerful engine options, and advanced technology features. Ideal for family trips and long journeys.'),

(3, 'MH03CD9012', 'Tata', 'Nexon', 'SUV', 2023, 'Blue', 5, 'PETROL', 17.50, 1800.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Tata/Nexon/10710/1697696172313/front-left-side-47.jpg', 'The Tata Nexon is a stylish compact SUV with a 5-star safety rating, responsive handling, and a feature-rich interior. Perfect for urban adventures and weekend escapes.'),

(4, 'DL04EF3456', 'Mahindra', 'Thar', 'SUV', 2022, 'Black', 4, 'DIESEL', 15.20, 1950.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Mahindra/Thar/10585/1697696417376/front-left-side-47.jpg', 'The Mahindra Thar is an iconic off-road SUV with rugged styling, powerful 4x4 capabilities, and a comfortable interior. Ideal for adventure enthusiasts and off-road exploration.'),

(5, 'GJ05GH7890', 'Toyota', 'Innova Crysta', 'SUV', 2022, 'Silver', 7, 'DIESEL', 14.30, 1999.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Toyota/Innova-Crysta/9612/1675663238438/front-left-side-47.jpg', 'The Toyota Innova Crysta is a premium MPV with spacious seating for seven, refined ride quality, and reliable performance. Perfect for family outings and business travel.'),

(6, 'KL06IJ1234', 'Honda', 'City', 'CAR', 2023, 'Grey', 5, 'PETROL', 19.50, 1750.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Honda/City/9710/1677914238296/front-left-side-47.jpg', 'The Honda City is an elegant sedan with a spacious cabin, refined engine, and premium features. Ideal for business professionals and small families.'),

(7, 'UP07KL5678', 'Kia', 'Seltos', 'SUV', 2023, 'Red', 5, 'PETROL', 16.80, 1850.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Kia/Seltos/10741/1697695409257/front-left-side-47.jpg', 'The Kia Seltos is a feature-loaded compact SUV with striking design, advanced technology, and multiple powertrain options. Perfect for tech-savvy drivers and urban explorers.'),

(8, 'RJ08MN9012', 'MG', 'Hector', 'SUV', 2022, 'Burgundy', 5, 'DIESEL', 16.60, 1900.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/MG/Hector/10245/1690544151440/front-left-side-47.jpg', 'The MG Hector is a tech-forward SUV with a spacious cabin, panoramic sunroof, and connected car features. Ideal for tech enthusiasts and comfort-seeking families.'),

(9, 'AP09OP3456', 'Maruti Suzuki', 'Baleno', 'CAR', 2023, 'Blue', 5, 'PETROL', 22.35, 1200.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Maruti/Baleno/10482/1697696417376/front-left-side-47.jpg', 'The Maruti Suzuki Baleno is a premium hatchback with a spacious interior, smooth ride quality, and excellent fuel efficiency. Perfect for daily commuting and weekend trips.'),

(10, 'TN10QR7890', 'Hyundai', 'Venue', 'SUV', 2023, 'White', 5, 'PETROL', 18.15, 1600.00, TRUE, 'https://stimg.cardekho.com/images/carexteriorimages/930x620/Hyundai/Venue/10187/1690192564375/front-left-side-47.jpg', 'The Hyundai Venue is a compact SUV with modern styling, feature-rich interior, and peppy performance. Ideal for young professionals and small families.');

-- Insert sample bookings (with prices in INR)
-- Set auto_increment to start from 1
ALTER TABLE bookings AUTO_INCREMENT = 1;
INSERT INTO bookings (booking_id, user_id, vehicle_id, start_date, end_date, total_amount, status, payment_status)
VALUES 
(1, 1, 1, '2025-05-20', '2025-05-25', 5000.00, 'CONFIRMED', 'PAID'),
(2, 1, 3, '2025-06-10', '2025-06-15', 9000.00, 'PENDING', 'PENDING');

-- Insert sample complaints
-- Set auto_increment to start from 1
ALTER TABLE complaints AUTO_INCREMENT = 1;
INSERT INTO complaints (complaint_id, user_id, booking_id, subject, description, status)
VALUES 
(1, 1, 1, 'AC not working properly', 'The air conditioning in the Maruti Suzuki Swift was not cooling effectively during my rental period.', 'OPEN');

-- Insert sample videos
-- Set auto_increment to start from 1
ALTER TABLE videos AUTO_INCREMENT = 1;
INSERT INTO videos (video_id, booking_id, video_type, video_url, notes)
VALUES 
(1, 1, 'PICKUP', '/uploads/videos/sample_pickup.mp4', 'Vehicle condition at pickup - minor scratch on rear bumper noted'),
(2, 1, 'RETURN', '/uploads/videos/sample_return.mp4', 'Vehicle returned in same condition as pickup');
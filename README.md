# Vehicle Rental and Management System

A comprehensive full-stack web application for vehicle rental and management using Java, Spring Boot, JSP, JDBC, and MySQL.

## Features

### User Features
- User Registration and Login with session handling
- Browse Vehicles with filters (type, price, brand, availability)
- Book a Vehicle by selecting desired dates and vehicle
- Upload Condition Videos during pickup and return
- View Booking History and download invoices
- Submit Complaints or Issues

### Admin Features
- Admin Authentication and secure dashboard
- Vehicle Management (add, update, remove vehicles)
- Booking Oversight (view all bookings and statuses)
- Condition Video Review
- Complaint Management
- Reports and Analytics

## Technologies Used

- **Backend**: Java, Spring Boot, Spring MVC, JDBC
- **Frontend**: JSP, HTML, CSS, Bootstrap 5
- **Database**: MySQL
- **Tools**: Eclipse IDE, Apache Tomcat, MySQL Workbench

## Prerequisites

- Java 11 or higher
- Maven
- MySQL Server
- IDE (Eclipse, IntelliJ, etc.)

## Setup and Installation

1. **Clone the repository**
   ```
   git clone https://github.com/yourusername/vehicle-rental-system.git
   cd vehicle-rental-system
   ```

2. **Configure MySQL Database**
   - Create a database named `std`
   - Update database credentials in `src/main/resources/application.properties` if needed
   - Default credentials:
     - Username: root
     - Password: Ashborn7

3. **Build and Run the Application**
   ```
   mvn clean install
   mvn spring-boot:run
   ```

4. **Access the Application**
   - Open a web browser and navigate to `http://localhost:8080`
   - Admin credentials:
     - Username: admin
     - Password: admin123

## Project Structure

- `src/main/java/com/vehicle/rental`: Java source files
  - `controller`: MVC controllers
  - `model`: Entity classes
  - `dao`: Data Access Objects
  - `service`: Service layer
  - `config`: Configuration classes
- `src/main/resources`: Application resources
  - `application.properties`: Application configuration
  - `schema.sql`: Database schema
- `src/main/webapp/WEB-INF/views`: JSP views
  - `admin`: Admin dashboard views
  - `user`: User-related views
  - `vehicles`: Vehicle-related views
  - `bookings`: Booking-related views
  - `complaints`: Complaint-related views
  - `common`: Common layout files

## Database Schema

- `users`: Stores customer login and personal details
- `vehicles`: Contains vehicle records and availability
- `bookings`: Tracks booking details
- `videos`: Stores URLs/paths to condition videos
- `complaints`: Stores issue reports with resolution status

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Bootstrap for the responsive UI
- Spring Boot for the backend framework
- MySQL for the database
  ![Screenshot 2025-05-22 002539](https://github.com/user-attachments/assets/5613e1f8-cd56-449e-ba5c-5eee07a2906e)
![Screenshot 2025-05-22 002526](https://github.com/user-attachments/assets/482930b2-3db6-43d5-b9c4-d758af5a12f6)
![Screenshot 2025-05-22 002509](https://github.com/user-attachments/assets/4899b112-68c8-4944-97c0-de24098af70f)
![Screenshot 2025-05-22 002333](https://github.com/user-attachments/assets/582f6522-725b-4f02-a2d0-5f234f953fec)
![Screenshot 2025-05-22 002321](https://github.com/user-attachments/assets/d841c651-e9bd-4791-bb20-027131abdd9b)
![Screenshot 2025-05-22 002305](https://github.com/user-attachments/assets/f5d72acf-8828-4400-b2b3-e92d060d4308)
![Screenshot 2025-05-22 002402](https://github.com/user-attachments/assets/ea8d2ef7-3611-4af4-8533-0aa65920fd13)
![Screenshot 2025-05-22 002342](https://github.com/user-attachments/assets/8f29ed8b-4934-49ac-888f-12b7d96b4c0b)

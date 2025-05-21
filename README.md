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
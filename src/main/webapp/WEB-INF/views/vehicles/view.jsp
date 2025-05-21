<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${vehicle.brand} ${vehicle.model} - Vehicle Rental System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .vehicle-image {
            max-height: 400px;
            object-fit: cover;
        }
        .feature-icon {
            font-size: 1.5rem;
            margin-right: 10px;
            color: #0d6efd;
        }
        .booking-form {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
        }
        .footer {
            background-color: #343a40;
            color: white;
            padding: 40px 0;
            margin-top: 60px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/' />">Vehicle Rental System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/' />">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="<c:url value='/vehicles' />">Vehicles</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/about' />">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/contact' />">Contact</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.userId != null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    ${sessionScope.username}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="<c:url value='/bookings' />">My Bookings</a></li>
                                    <li><a class="dropdown-item" href="<c:url value='/user/profile' />">My Profile</a></li>
                                    <c:if test="${sessionScope.role == 'ADMIN'}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="<c:url value='/admin/dashboard' />">Admin Dashboard</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="<c:url value='/user/logout' />">Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/user/login' />">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/user/register' />">Register</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value='/' />">Home</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/vehicles' />">Vehicles</a></li>
                <li class="breadcrumb-item active">${vehicle.brand} ${vehicle.model}</li>
            </ol>
        </nav>
        
        <div class="row">
            <!-- Vehicle Details -->
            <div class="col-md-8">
                <div class="card mb-4">
                    <c:choose>
                        <c:when test="${not empty vehicle.imageUrl}">
                            <img src="${vehicle.imageUrl}" class="card-img-top vehicle-image" alt="${vehicle.brand} ${vehicle.model}">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/800x400?text=${vehicle.brand}+${vehicle.model}" class="card-img-top vehicle-image" alt="${vehicle.brand} ${vehicle.model}">
                        </c:otherwise>
                    </c:choose>
                    <div class="card-body">
                        <h2 class="card-title">${vehicle.brand} ${vehicle.model}</h2>
                        <div class="mb-3">
                            <span class="badge bg-info">${vehicle.type}</span>
                            <span class="badge bg-secondary">${vehicle.year}</span>
                            <span class="badge bg-success">₹${vehicle.pricePerDay}/day</span>
                            <c:if test="${vehicle.availability}">
                                <span class="badge bg-primary">Available</span>
                            </c:if>
                            <c:if test="${!vehicle.availability}">
                                <span class="badge bg-danger">Not Available</span>
                            </c:if>
                        </div>
                        <p class="card-text">${vehicle.description}</p>
                    </div>
                </div>
                
                <!-- Vehicle Specifications -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h4>Vehicle Specifications</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item d-flex align-items-center">
                                        <span class="feature-icon">🚗</span>
                                        <div>
                                            <strong>Registration Number:</strong>
                                            <p class="mb-0">${vehicle.registrationNumber}</p>
                                        </div>
                                    </li>
                                    <li class="list-group-item d-flex align-items-center">
                                        <span class="feature-icon">🎨</span>
                                        <div>
                                            <strong>Color:</strong>
                                            <p class="mb-0">${vehicle.color}</p>
                                        </div>
                                    </li>
                                    <li class="list-group-item d-flex align-items-center">
                                        <span class="feature-icon">⛽</span>
                                        <div>
                                            <strong>Fuel Type:</strong>
                                            <p class="mb-0">${vehicle.fuelType}</p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item d-flex align-items-center">
                                        <span class="feature-icon">👥</span>
                                        <div>
                                            <strong>Seating Capacity:</strong>
                                            <p class="mb-0">${vehicle.seatingCapacity} persons</p>
                                        </div>
                                    </li>
                                    <li class="list-group-item d-flex align-items-center">
                                        <span class="feature-icon">🛣️</span>
                                        <div>
                                            <strong>Mileage:</strong>
                                            <p class="mb-0">${vehicle.mileage} km/l</p>
                                        </div>
                                    </li>
                                    <li class="list-group-item d-flex align-items-center">
                                        <span class="feature-icon">📅</span>
                                        <div>
                                            <strong>Year:</strong>
                                            <p class="mb-0">${vehicle.year}</p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Booking Form -->
            <div class="col-md-4">
                <div class="card booking-form">
                    <div class="card-header">
                        <h4>Book This Vehicle</h4>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <c:choose>
                                    <c:when test="${vehicle.availability}">
                                        <form action="<c:url value='/bookings/create/${vehicle.vehicleId}' />" method="get">
                                            <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
                                            
                                            <div class="mb-3">
                                                <label for="startDate" class="form-label">Start Date</label>
                                                <input type="date" class="form-control" id="startDate" name="startDate" required min="${java.time.LocalDate.now()}">
                                            </div>
                                            
                                            <div class="mb-3">
                                                <label for="endDate" class="form-label">End Date</label>
                                                <input type="date" class="form-control" id="endDate" name="endDate" required min="${java.time.LocalDate.now()}">
                                            </div>
                                            
                                            <div class="mb-3">
                                                <p><strong>Price per day:</strong> ₹${vehicle.pricePerDay}</p>
                                                <p><strong>Total Price:</strong> <span id="totalPrice">₹0.00</span></p>
                                                <input type="hidden" id="totalAmount" name="totalAmount" value="0">
                                            </div>
                                            
                                            <button type="submit" class="btn btn-primary w-100">Continue to Booking</button>
                                        </form>
                                        
                                        <script>
                                            document.addEventListener('DOMContentLoaded', function() {
                                                const startDateInput = document.getElementById('startDate');
                                                const endDateInput = document.getElementById('endDate');
                                                const totalPriceSpan = document.getElementById('totalPrice');
                                                const totalAmountInput = document.getElementById('totalAmount');
                                                const pricePerDay = ${vehicle.pricePerDay};
                                                
                                                function calculateTotal() {
                                                    if (startDateInput.value && endDateInput.value) {
                                                        const startDate = new Date(startDateInput.value);
                                                        const endDate = new Date(endDateInput.value);
                                                        
                                                        if (endDate >= startDate) {
                                                            const diffTime = Math.abs(endDate - startDate);
                                                            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
                                                            const totalPrice = diffDays * pricePerDay;
                                                            
                                                            totalPriceSpan.textContent = '₹' + totalPrice.toFixed(2);
                                                            totalAmountInput.value = totalPrice.toFixed(2);
                                                        } else {
                                                            totalPriceSpan.textContent = 'End date must be after start date';
                                                            totalAmountInput.value = 0;
                                                        }
                                                    }
                                                }
                                                
                                                startDateInput.addEventListener('change', calculateTotal);
                                                endDateInput.addEventListener('change', calculateTotal);
                                            });
                                        </script>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-danger">
                                            <h5>Not Available</h5>
                                            <p>This vehicle is currently not available for booking. Please check back later or choose another vehicle.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info">
                                    <h5>Login Required</h5>
                                    <p>Please login to book this vehicle.</p>
                                    <a href="<c:url value='/user/login' />" class="btn btn-primary">Login</a>
                                    <a href="<c:url value='/user/register' />" class="btn btn-outline-primary">Register</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5>Vehicle Rental System</h5>
                    <p>Your trusted partner for all your vehicle rental needs. We provide quality vehicles at affordable prices.</p>
                </div>
                <div class="col-md-2 mb-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="<c:url value='/' />" class="text-white">Home</a></li>
                        <li><a href="<c:url value='/vehicles' />" class="text-white">Vehicles</a></li>
                        <li><a href="<c:url value='/about' />" class="text-white">About Us</a></li>
                        <li><a href="<c:url value='/contact' />" class="text-white">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-3 mb-4">
                    <h5>Legal</h5>
                    <ul class="list-unstyled">
                        <li><a href="<c:url value='/terms' />" class="text-white">Terms of Service</a></li>
                        <li><a href="<c:url value='/privacy' />" class="text-white">Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="col-md-3 mb-4">
                    <h5>Contact Us</h5>
                    <address>
                        <p>123 Rental Street<br>City, State 12345</p>
                        <p>Email: info@vehiclerental.com<br>Phone: (123) 456-7890</p>
                    </address>
                </div>
            </div>
            <hr class="bg-light">
            <div class="text-center">
                <p>&copy; 2025 Vehicle Rental System. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
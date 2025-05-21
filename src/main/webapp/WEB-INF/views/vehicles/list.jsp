<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Vehicles - Vehicle Rental System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .vehicle-card {
            margin-bottom: 30px;
            transition: transform 0.3s;
        }
        .vehicle-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            margin-bottom: 30px;
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
        <h1 class="mb-4">Available Vehicles</h1>
        
        <!-- Search Bar -->
        <div class="row mb-4">
            <div class="col-md-6 offset-md-3">
                <form action="<c:url value='/vehicles/search' />" method="get" class="d-flex">
                    <input type="text" name="query" class="form-control me-2" placeholder="Search vehicles..." value="${searchQuery}">
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <h4 class="mb-3">Filter Vehicles</h4>
            <form action="<c:url value='/vehicles/filter' />" method="get">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label for="type" class="form-label">Vehicle Type</label>
                        <select name="type" id="type" class="form-select">
                            <option value="">All Types</option>
                            <c:forEach items="${vehicleTypes}" var="type">
                                <option value="${type}" ${type eq selectedType ? 'selected' : ''}>${type}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="brand" class="form-label">Brand</label>
                        <select name="brand" id="brand" class="form-select">
                            <option value="">All Brands</option>
                            <c:forEach items="${vehicleBrands}" var="brand">
                                <option value="${brand}" ${brand eq selectedBrand ? 'selected' : ''}>${brand}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="minPrice" class="form-label">Min Price</label>
                        <input type="number" name="minPrice" id="minPrice" class="form-control" value="${minPrice}">
                    </div>
                    <div class="col-md-2">
                        <label for="maxPrice" class="form-label">Max Price</label>
                        <input type="number" name="maxPrice" id="maxPrice" class="form-control" value="${maxPrice}">
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">Apply Filters</button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Vehicles List -->
        <div class="row">
            <c:choose>
                <c:when test="${empty vehicles}">
                    <div class="col-12 text-center">
                        <div class="alert alert-info">
                            <h4>No vehicles found</h4>
                            <p>Try adjusting your search criteria or check back later for new vehicles.</p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${vehicles}" var="vehicle">
                        <div class="col-md-4">
                            <div class="card vehicle-card">
                                <c:choose>
                                    <c:when test="${not empty vehicle.imageUrl}">
                                        <img src="${vehicle.imageUrl}" class="card-img-top" alt="${vehicle.brand} ${vehicle.model}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/300x200?text=${vehicle.brand}+${vehicle.model}" class="card-img-top" alt="${vehicle.brand} ${vehicle.model}">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body">
                                    <h5 class="card-title">${vehicle.brand} ${vehicle.model}</h5>
                                    <p class="card-text">
                                        <span class="badge bg-info">${vehicle.type}</span>
                                        <span class="badge bg-secondary">${vehicle.year}</span>
                                        <span class="badge bg-success">₹${vehicle.pricePerDay}/day</span>
                                    </p>
                                    <p class="card-text small">
                                        <strong>Color:</strong> ${vehicle.color}<br>
                                        <strong>Fuel:</strong> ${vehicle.fuelType}<br>
                                        <strong>Seating:</strong> ${vehicle.seatingCapacity} persons
                                    </p>
                                    <a href="<c:url value='/vehicles/${vehicle.vehicleId}' />" class="btn btn-primary">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
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
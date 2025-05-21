<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />

<div class="container py-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/' />">Home</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/bookings' />">My Bookings</a></li>
            <li class="breadcrumb-item active">Booking #${booking.bookingId}</li>
        </ol>
    </nav>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success" role="alert">
            ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            ${error}
        </div>
    </c:if>
    
    <div class="row">
        <div class="col-md-8">
            <!-- Booking Details -->
            <div class="card shadow mb-4">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Booking Details</h5>
                    <span class="badge bg-light text-dark">Booking #${booking.bookingId}</span>
                </div>
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h6>Booking Status</h6>
                            <c:choose>
                                <c:when test="${booking.status eq 'PENDING'}">
                                    <span class="badge bg-warning">Pending</span>
                                </c:when>
                                <c:when test="${booking.status eq 'CONFIRMED'}">
                                    <span class="badge bg-success">Confirmed</span>
                                </c:when>
                                <c:when test="${booking.status eq 'CANCELLED'}">
                                    <span class="badge bg-danger">Cancelled</span>
                                </c:when>
                                <c:when test="${booking.status eq 'COMPLETED'}">
                                    <span class="badge bg-info">Completed</span>
                                </c:when>
                            </c:choose>
                        </div>
                        <div class="col-md-6">
                            <h6>Payment Status</h6>
                            <c:choose>
                                <c:when test="${booking.paymentStatus eq 'PENDING'}">
                                    <span class="badge bg-warning">Pending</span>
                                </c:when>
                                <c:when test="${booking.paymentStatus eq 'PAID'}">
                                    <span class="badge bg-success">Paid</span>
                                    <c:if test="${not empty booking.paymentMethod}">
                                        <small class="text-muted ms-2">via ${booking.paymentMethod}</small>
                                    </c:if>
                                </c:when>
                                <c:when test="${booking.paymentStatus eq 'REFUNDED'}">
                                    <span class="badge bg-info">Refunded</span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h6>Booking Dates</h6>
                            <p>
                                <fmt:parseDate value="${booking.startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" type="date" />
                                <fmt:parseDate value="${booking.endDate}" pattern="yyyy-MM-dd" var="parsedEndDate" type="date" />
                                <strong>From:</strong> <fmt:formatDate value="${parsedStartDate}" pattern="MMMM dd, yyyy" /><br>
                                <strong>To:</strong> <fmt:formatDate value="${parsedEndDate}" pattern="MMMM dd, yyyy" />
                            </p>
                        </div>
                        <div class="col-md-6">
                            <h6>Total Amount</h6>
                            <p class="text-primary fw-bold">₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></p>
                        </div>
                    </div>
                    
                    <c:if test="${not empty booking.vehicle}">
                        <h6>Vehicle Details</h6>
                        <div class="card mb-3">
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <c:choose>
                                        <c:when test="${not empty booking.vehicle.imageUrl}">
                                            <img src="${booking.vehicle.imageUrl}" class="img-fluid rounded-start" alt="${booking.vehicle.brand} ${booking.vehicle.model}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://via.placeholder.com/300x200?text=${booking.vehicle.brand}+${booking.vehicle.model}" class="img-fluid rounded-start" alt="${booking.vehicle.brand} ${booking.vehicle.model}">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">${booking.vehicle.brand} ${booking.vehicle.model}</h5>
                                        <p class="card-text">
                                            <span class="badge bg-info">${booking.vehicle.type}</span>
                                            <span class="badge bg-secondary">${booking.vehicle.year}</span>
                                            <span class="badge bg-success">₹${booking.vehicle.pricePerDay}/day</span>
                                        </p>
                                        <p class="card-text">
                                            <small class="text-muted">
                                                <strong>Registration:</strong> ${booking.vehicle.registrationNumber}<br>
                                                <strong>Color:</strong> ${booking.vehicle.color}<br>
                                                <strong>Fuel Type:</strong> ${booking.vehicle.fuelType}
                                            </small>
                                        </p>
                                        <a href="<c:url value='/vehicles/${booking.vehicle.vehicleId}' />" class="btn btn-sm btn-outline-primary">View Vehicle</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- Videos Section -->
                    <h6>Condition Videos</h6>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card mb-3">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0">Pickup Videos</h6>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty pickupVideos}">
                                            <p class="text-muted">No pickup videos uploaded yet.</p>
                                            <a href="<c:url value='/bookings/${booking.bookingId}/upload-video' />" class="btn btn-sm btn-primary">
                                                <i class="fas fa-upload"></i> Upload Pickup Video
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="list-group">
                                                <c:forEach items="${pickupVideos}" var="video">
                                                    <div class="list-group-item">
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <div>
                                                                <h6 class="mb-1">Pickup Video</h6>
                                                                <small class="text-muted">
                                                                    ${video.uploadTime.toLocalDate()} ${video.uploadTime.toLocalTime().toString().substring(0, 5)}
                                                                </small>
                                                            </div>
                                                            <a href="${video.videoUrl}" class="btn btn-sm btn-outline-primary" target="_blank">
                                                                <i class="fas fa-play"></i> Play
                                                            </a>
                                                        </div>
                                                        <c:if test="${not empty video.notes}">
                                                            <p class="mb-1 mt-2"><strong>Notes:</strong> ${video.notes}</p>
                                                        </c:if>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card mb-3">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0">Return Videos</h6>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty returnVideos}">
                                            <p class="text-muted">No return videos uploaded yet.</p>
                                            <a href="<c:url value='/bookings/${booking.bookingId}/upload-video' />" class="btn btn-sm btn-primary">
                                                <i class="fas fa-upload"></i> Upload Return Video
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="list-group">
                                                <c:forEach items="${returnVideos}" var="video">
                                                    <div class="list-group-item">
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <div>
                                                                <h6 class="mb-1">Return Video</h6>
                                                                <small class="text-muted">
                                                                    ${video.uploadTime.toLocalDate()} ${video.uploadTime.toLocalTime().toString().substring(0, 5)}
                                                                </small>
                                                            </div>
                                                            <a href="${video.videoUrl}" class="btn btn-sm btn-outline-primary" target="_blank">
                                                                <i class="fas fa-play"></i> Play
                                                            </a>
                                                        </div>
                                                        <c:if test="${not empty video.notes}">
                                                            <p class="mb-1 mt-2"><strong>Notes:</strong> ${video.notes}</p>
                                                        </c:if>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <!-- Actions Panel -->
            <div class="card shadow mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Actions</h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <c:if test="${booking.status eq 'PENDING' || booking.status eq 'CONFIRMED'}">
                            <c:if test="${booking.paymentStatus eq 'PENDING'}">
                                <a href="<c:url value='/bookings/${booking.bookingId}/payment' />" class="btn btn-success">
                                    <i class="fas fa-credit-card"></i> Make Payment
                                </a>
                            </c:if>
                            <a href="<c:url value='/bookings/${booking.bookingId}/upload-video' />" class="btn btn-primary">
                                <i class="fas fa-video"></i> Upload Video
                            </a>
                            <a href="<c:url value='/bookings/${booking.bookingId}/cancel' />" class="btn btn-danger" 
                               onclick="return confirm('Are you sure you want to cancel this booking?');">
                                <i class="fas fa-times"></i> Cancel Booking
                            </a>
                        </c:if>
                        <c:if test="${booking.paymentStatus eq 'PAID'}">
                            <a href="<c:url value='/bookings/${booking.bookingId}/invoice' />" class="btn btn-info">
                                <i class="fas fa-file-invoice"></i> View Invoice
                            </a>
                        </c:if>
                        <a href="<c:url value='/complaints/create?bookingId=${booking.bookingId}' />" class="btn btn-outline-secondary">
                            <i class="fas fa-comment-alt"></i> Submit Complaint
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Booking Timeline -->
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Booking Timeline</h5>
                </div>
                <div class="card-body">
                    <ul class="timeline">
                        <li class="timeline-item">
                            <div class="timeline-marker"></div>
                            <div class="timeline-content">
                                <h6 class="timeline-title">Booking Created</h6>
                                <p class="timeline-date">
                                    ${booking.createdAt.toLocalDate()} ${booking.createdAt.toLocalTime().toString().substring(0, 5)}
                                </p>
                            </div>
                        </li>
                        <c:if test="${booking.paymentStatus eq 'PAID'}">
                            <li class="timeline-item">
                                <div class="timeline-marker bg-success"></div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Payment Completed</h6>
                                    <p class="timeline-text">
                                        Payment method: ${booking.paymentMethod}<br>
                                        Transaction ID: ${booking.transactionId}
                                    </p>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${booking.status eq 'CONFIRMED'}">
                            <li class="timeline-item">
                                <div class="timeline-marker bg-success"></div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Booking Confirmed</h6>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${booking.status eq 'CANCELLED'}">
                            <li class="timeline-item">
                                <div class="timeline-marker bg-danger"></div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Booking Cancelled</h6>
                                </div>
                            </li>
                        </c:if>
                        <c:if test="${booking.status eq 'COMPLETED'}">
                            <li class="timeline-item">
                                <div class="timeline-marker bg-info"></div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Booking Completed</h6>
                                </div>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .timeline {
        position: relative;
        padding-left: 30px;
        list-style: none;
    }
    .timeline-item {
        position: relative;
        padding-bottom: 20px;
    }
    .timeline-item:last-child {
        padding-bottom: 0;
    }
    .timeline-marker {
        position: absolute;
        width: 15px;
        height: 15px;
        left: -30px;
        background-color: #0d6efd;
        border-radius: 50%;
    }
    .timeline-item:not(:last-child) .timeline-marker:before {
        content: '';
        position: absolute;
        left: 7px;
        top: 15px;
        height: calc(100% + 5px);
        width: 1px;
        background-color: #dee2e6;
    }
    .timeline-content {
        padding-bottom: 10px;
    }
    .timeline-title {
        margin-bottom: 5px;
    }
    .timeline-date {
        color: #6c757d;
        font-size: 0.875rem;
        margin-bottom: 5px;
    }
</style>

<jsp:include page="../common/footer.jsp" />
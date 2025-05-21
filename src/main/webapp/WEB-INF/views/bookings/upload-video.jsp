<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />

<div class="container py-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/' />">Home</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/bookings' />">My Bookings</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/bookings/${booking.bookingId}' />">Booking #${booking.bookingId}</a></li>
            <li class="breadcrumb-item active">Upload Video</li>
        </ol>
    </nav>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            ${error}
        </div>
    </c:if>
    
    <div class="row">
        <div class="col-md-8">
            <div class="card shadow mb-4">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Upload Condition Video</h4>
                </div>
                <div class="card-body">
                    <p class="mb-4">
                        Please upload a video showing the condition of the vehicle. This helps document the state of the vehicle
                        at pickup and return, protecting both you and the rental company.
                    </p>
                    
                    <form action="<c:url value='/bookings/${booking.bookingId}/upload-video' />" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="videoType" class="form-label">Video Type*</label>
                            <select class="form-select" id="videoType" name="videoType" required>
                                <option value="">Select video type</option>
                                <option value="PICKUP">Pickup Video (before starting your trip)</option>
                                <option value="RETURN">Return Video (when returning the vehicle)</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="videoFile" class="form-label">Video File*</label>
                            <input type="file" class="form-control" id="videoFile" name="videoFile" accept="video/*" required>
                            <div class="form-text">
                                Accepted formats: MP4, MOV, AVI. Maximum file size: 100MB.
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="notes" class="form-label">Notes</label>
                            <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Add any notes about the vehicle condition or issues you want to document"></textarea>
                        </div>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="<c:url value='/bookings/${booking.bookingId}' />" class="btn btn-outline-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Upload Video</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card shadow mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Video Guidelines</h5>
                </div>
                <div class="card-body">
                    <h6>What to Include in Your Video</h6>
                    <ul>
                        <li>Walk around the entire vehicle</li>
                        <li>Show all sides of the vehicle (front, back, left, right)</li>
                        <li>Document any existing damage or scratches</li>
                        <li>Show the odometer reading</li>
                        <li>Show the fuel gauge level</li>
                        <li>Check that all lights and signals are working</li>
                        <li>Check the interior condition</li>
                    </ul>
                    
                    <h6>Tips for Good Quality Video</h6>
                    <ul>
                        <li>Record in good lighting conditions</li>
                        <li>Hold the camera steady</li>
                        <li>Speak clearly if you're narrating</li>
                        <li>Make sure the video is in focus</li>
                        <li>Keep the video under 5 minutes if possible</li>
                    </ul>
                </div>
            </div>
            
            <div class="card shadow">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0">Booking Details</h5>
                </div>
                <div class="card-body">
                    <p><strong>Vehicle:</strong> ${booking.vehicle.brand} ${booking.vehicle.model}</p>
                    <p>
                        <strong>Booking Period:</strong><br>
                        <fmt:parseDate value="${booking.startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" type="date" />
                        <fmt:parseDate value="${booking.endDate}" pattern="yyyy-MM-dd" var="parsedEndDate" type="date" />
                        <fmt:formatDate value="${parsedStartDate}" pattern="MMM dd, yyyy" /> - 
                        <fmt:formatDate value="${parsedEndDate}" pattern="MMM dd, yyyy" />
                    </p>
                    <p>
                        <strong>Status:</strong> 
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
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
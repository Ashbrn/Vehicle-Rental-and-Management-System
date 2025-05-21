<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />

<div class="container py-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/' />">Home</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/vehicles' />">Vehicles</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/vehicles/${vehicle.vehicleId}' />">${vehicle.brand} ${vehicle.model}</a></li>
            <li class="breadcrumb-item active">Book Vehicle</li>
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
                    <h4 class="mb-0">Book Vehicle</h4>
                </div>
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-md-4">
                            <c:choose>
                                <c:when test="${not empty vehicle.imageUrl}">
                                    <img src="${vehicle.imageUrl}" class="img-fluid rounded" alt="${vehicle.brand} ${vehicle.model}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/300x200?text=${vehicle.brand}+${vehicle.model}" class="img-fluid rounded" alt="${vehicle.brand} ${vehicle.model}">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-8">
                            <h4>${vehicle.brand} ${vehicle.model}</h4>
                            <p>
                                <span class="badge bg-info">${vehicle.type}</span>
                                <span class="badge bg-secondary">${vehicle.year}</span>
                                <span class="badge bg-success">₹${vehicle.pricePerDay}/day</span>
                            </p>
                            <p><strong>Registration:</strong> ${vehicle.registrationNumber}</p>
                            <p><strong>Color:</strong> ${vehicle.color}</p>
                            <p><strong>Fuel Type:</strong> ${vehicle.fuelType}</p>
                            <p><strong>Seating Capacity:</strong> ${vehicle.seatingCapacity} persons</p>
                        </div>
                    </div>
                    
                    <form action="<c:url value='/bookings/create/${vehicle.vehicleId}' />" method="post">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="startDate" class="form-label">Start Date</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" required min="${minDate}" max="${maxDate}" value="${selectedStartDate}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="endDate" class="form-label">End Date</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" required min="${minDate}" max="${maxDate}" value="${selectedEndDate}">
                            </div>
                        </div>
                        
                        <div class="alert alert-info mb-4 booking-summary">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-0"><strong>Price per day:</strong> ₹<fmt:formatNumber value="${vehicle.pricePerDay}" pattern="#,##0.00" /></p>
                                    <p class="mb-0"><strong>Total Price:</strong> <span id="totalPrice">₹0.00</span></p>
                                </div>
                                <div>
                                    <span class="badge bg-primary fs-6 p-2">Days: <span id="totalDays">0</span></span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" id="termsCheck" required>
                            <label class="form-check-label" for="termsCheck">
                                I agree to the <a href="<c:url value='/terms' />" target="_blank">Terms and Conditions</a> and <a href="<c:url value='/privacy' />" target="_blank">Privacy Policy</a>
                            </label>
                        </div>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="<c:url value='/vehicles/${vehicle.vehicleId}' />" class="btn btn-outline-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Confirm Booking</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card shadow mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Booking Information</h5>
                </div>
                <div class="card-body">
                    <h6>Important Notes</h6>
                    <ul>
                        <li>A valid driver's license is required at the time of pickup.</li>
                        <li>A security deposit may be required at the time of pickup.</li>
                        <li>The vehicle must be returned with the same fuel level as at pickup.</li>
                        <li>Late returns will incur additional charges.</li>
                    </ul>
                    
                    <h6>Cancellation Policy</h6>
                    <p>Free cancellation up to 24 hours before pickup. After that, a cancellation fee of 50% of the total booking amount will apply.</p>
                    
                    <h6>Video Verification</h6>
                    <p>You will be required to record a video of the vehicle at pickup and return to document its condition.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        const totalPriceSpan = document.getElementById('totalPrice');
        const totalDaysSpan = document.getElementById('totalDays');
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
                    totalDaysSpan.textContent = diffDays;
                } else {
                    totalPriceSpan.textContent = 'End date must be after start date';
                    totalDaysSpan.textContent = '0';
                }
            }
        }
        
        startDateInput.addEventListener('change', calculateTotal);
        endDateInput.addEventListener('change', calculateTotal);
        
        // Calculate total on page load if dates are already set
        if (startDateInput.value && endDateInput.value) {
            calculateTotal();
        }
    });
</script>

<jsp:include page="../common/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp" />

<div class="container py-5">
    <h1 class="mb-4">My Bookings</h1>
    
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
    
    <div class="card shadow mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Booking History</h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="text-center py-5">
                        <i class="fas fa-calendar-times fa-4x text-muted mb-3"></i>
                        <h4>No Bookings Found</h4>
                        <p>You haven't made any bookings yet.</p>
                        <a href="<c:url value='/vehicles' />" class="btn btn-primary mt-3">Browse Vehicles</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Vehicle</th>
                                    <th>Dates</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th>Payment</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${bookings}" var="booking">
                                    <tr>
                                        <td>${booking.bookingId}</td>
                                        <td>
                                            <c:if test="${not empty booking.vehicle}">
                                                ${booking.vehicle.brand} ${booking.vehicle.model}
                                            </c:if>
                                        </td>
                                        <td>
                                            <fmt:parseDate value="${booking.startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" type="date" />
                                            <fmt:parseDate value="${booking.endDate}" pattern="yyyy-MM-dd" var="parsedEndDate" type="date" />
                                            <fmt:formatDate value="${parsedStartDate}" pattern="MMM dd, yyyy" /> - 
                                            <fmt:formatDate value="${parsedEndDate}" pattern="MMM dd, yyyy" />
                                        </td>
                                        <td>₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></td>
                                        <td>
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
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${booking.paymentStatus eq 'PENDING'}">
                                                    <span class="badge bg-warning">Pending</span>
                                                </c:when>
                                                <c:when test="${booking.paymentStatus eq 'PAID'}">
                                                    <span class="badge bg-success">Paid</span>
                                                </c:when>
                                                <c:when test="${booking.paymentStatus eq 'REFUNDED'}">
                                                    <span class="badge bg-info">Refunded</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="<c:url value='/bookings/${booking.bookingId}' />" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye"></i> View
                                                </a>
                                                <button type="button" class="btn btn-sm btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown">
                                                    <span class="visually-hidden">Toggle Dropdown</span>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <c:if test="${booking.status eq 'PENDING' || booking.status eq 'CONFIRMED'}">
                                                        <c:if test="${booking.paymentStatus eq 'PENDING'}">
                                                            <li>
                                                                <a class="dropdown-item" href="<c:url value='/bookings/${booking.bookingId}/payment' />">
                                                                    <i class="fas fa-credit-card"></i> Make Payment
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                        <li>
                                                            <a class="dropdown-item" href="<c:url value='/bookings/${booking.bookingId}/upload-video' />">
                                                                <i class="fas fa-video"></i> Upload Video
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a class="dropdown-item" href="<c:url value='/bookings/${booking.bookingId}/cancel' />" 
                                                               onclick="return confirm('Are you sure you want to cancel this booking?');">
                                                                <i class="fas fa-times"></i> Cancel Booking
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${booking.paymentStatus eq 'PAID'}">
                                                        <li>
                                                            <a class="dropdown-item" href="<c:url value='/bookings/${booking.bookingId}/invoice' />">
                                                                <i class="fas fa-file-invoice"></i> View Invoice
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
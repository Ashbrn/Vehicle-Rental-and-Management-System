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
            <li class="breadcrumb-item active">Invoice</li>
        </ol>
    </nav>
    
    <div class="card shadow mb-4">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">Invoice</h4>
            <button class="btn btn-light btn-sm" onclick="window.print()">
                <i class="fas fa-print"></i> Print Invoice
            </button>
        </div>
        <div class="card-body p-4">
            <div class="row mb-4">
                <div class="col-md-6">
                    <h5 class="mb-3">Vehicle Rental System</h5>
                    <p>
                        123 Rental Street<br>
                        City, State 12345<br>
                        Phone: (123) 456-7890<br>
                        Email: info@vehiclerental.com
                    </p>
                </div>
                <div class="col-md-6 text-md-end">
                    <h5 class="mb-3">Invoice #INV-${booking.bookingId}</h5>
                    <p>
                        <strong>Date:</strong> ${booking.createdAt.toLocalDate()}<br>
                        <strong>Status:</strong> 
                        <c:choose>
                            <c:when test="${booking.paymentStatus eq 'PAID'}">
                                <span class="badge bg-success">Paid</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-warning">Pending</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
            
            <hr>
            
            <div class="row mb-4">
                <div class="col-md-6">
                    <h5 class="mb-3">Billed To</h5>
                    <p>
                        ${sessionScope.fullName}<br>
                        <c:if test="${not empty booking.user.address}">
                            ${booking.user.address}<br>
                        </c:if>
                        <c:if test="${not empty booking.user.email}">
                            Email: ${booking.user.email}<br>
                        </c:if>
                        <c:if test="${not empty booking.user.phone}">
                            Phone: ${booking.user.phone}
                        </c:if>
                    </p>
                </div>
                <div class="col-md-6 text-md-end">
                    <h5 class="mb-3">Booking Details</h5>
                    <p>
                        <strong>Booking ID:</strong> ${booking.bookingId}<br>
                        <strong>Booking Date:</strong> ${booking.createdAt.toLocalDate()}<br>
                        <fmt:parseDate value="${booking.startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" type="date" />
                        <fmt:parseDate value="${booking.endDate}" pattern="yyyy-MM-dd" var="parsedEndDate" type="date" />
                        <strong>Rental Period:</strong> <fmt:formatDate value="${parsedStartDate}" pattern="MMM dd, yyyy" /> - <fmt:formatDate value="${parsedEndDate}" pattern="MMM dd, yyyy" />
                    </p>
                </div>
            </div>
            
            <div class="table-responsive mb-4">
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Description</th>
                            <th>Vehicle</th>
                            <th>Days</th>
                            <th>Rate</th>
                            <th class="text-end">Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Vehicle Rental</td>
                            <td>${booking.vehicle.brand} ${booking.vehicle.model} (${booking.vehicle.registrationNumber})</td>
                            <td>
                                <c:set var="daysBetween" value="${(parsedEndDate.time - parsedStartDate.time) / (1000*60*60*24) + 1}" />
                                <fmt:formatNumber value="${daysBetween}" pattern="#,##0" />
                            </td>
                            <td>₹<fmt:formatNumber value="${booking.vehicle.pricePerDay}" pattern="#,##0.00" />/day</td>
                            <td class="text-end">₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4" class="text-end"><strong>Subtotal</strong></td>
                            <td class="text-end">$<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-end"><strong>Tax (0%)</strong></td>
                            <td class="text-end">$0.00</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-end"><strong>Total</strong></td>
                            <td class="text-end"><strong>$<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></strong></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            
            <c:if test="${booking.paymentStatus eq 'PAID'}">
                <div class="alert alert-success mb-4">
                    <div class="row">
                        <div class="col-md-6">
                            <h5 class="mb-2">Payment Information</h5>
                            <p class="mb-0">
                                <strong>Payment Method:</strong> ${booking.paymentMethod}<br>
                                <strong>Transaction ID:</strong> ${booking.transactionId}<br>
                                <strong>Payment Date:</strong> ${booking.createdAt.toLocalDate()}
                            </p>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <h3 class="text-success mb-0">PAID</h3>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <div class="mb-4">
                <h5 class="mb-3">Terms & Conditions</h5>
                <ul>
                    <li>Payment is due upon vehicle pickup.</li>
                    <li>A security deposit may be required at the time of pickup.</li>
                    <li>The vehicle must be returned with the same fuel level as at pickup.</li>
                    <li>Late returns will incur additional charges.</li>
                    <li>The renter is responsible for any traffic violations or fines incurred during the rental period.</li>
                </ul>
            </div>
            
            <div class="text-center">
                <p class="mb-0">Thank you for choosing Vehicle Rental System!</p>
                <p class="mb-0">For any questions, please contact our customer support at (123) 456-7890 or support@vehiclerental.com</p>
            </div>
        </div>
    </div>
</div>

<style>
    @media print {
        .navbar, .breadcrumb, .footer, .btn {
            display: none !important;
        }
        .card {
            border: none !important;
            box-shadow: none !important;
        }
        .card-header {
            background-color: #f8f9fa !important;
            color: #000 !important;
        }
        body {
            padding: 0 !important;
            margin: 0 !important;
        }
        .container {
            max-width: 100% !important;
            padding: 0 !important;
        }
    }
</style>

<jsp:include page="../common/footer.jsp" />
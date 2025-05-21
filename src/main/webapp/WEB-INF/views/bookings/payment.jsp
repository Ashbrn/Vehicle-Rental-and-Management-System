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
            <li class="breadcrumb-item active">Payment</li>
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
                    <h4 class="mb-0">Payment Details</h4>
                </div>
                <div class="card-body">
                    <div class="alert alert-info mb-4">
                        <h5>Booking Summary</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Vehicle:</strong> ${booking.vehicle.brand} ${booking.vehicle.model}</p>
                                <p>
                                    <strong>Booking Period:</strong><br>
                                    <fmt:parseDate value="${booking.startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" type="date" />
                                    <fmt:parseDate value="${booking.endDate}" pattern="yyyy-MM-dd" var="parsedEndDate" type="date" />
                                    <fmt:formatDate value="${parsedStartDate}" pattern="MMM dd, yyyy" /> - 
                                    <fmt:formatDate value="${parsedEndDate}" pattern="MMM dd, yyyy" />
                                </p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Total Amount:</strong> ₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></p>
                                <p><strong>Payment Status:</strong> <span class="badge bg-warning">Pending</span></p>
                            </div>
                        </div>
                    </div>
                    
                    <form action="<c:url value='/bookings/${booking.bookingId}/payment' />" method="post">
                        <h5 class="mb-3">Payment Method</h5>
                        <div class="mb-4">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="Credit Card" checked>
                                <label class="form-check-label" for="creditCard">
                                    Credit Card
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="debitCard" value="Debit Card">
                                <label class="form-check-label" for="debitCard">
                                    Debit Card
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="paypal" value="PayPal">
                                <label class="form-check-label" for="paypal">
                                    PayPal
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer" value="Bank Transfer">
                                <label class="form-check-label" for="bankTransfer">
                                    Bank Transfer
                                </label>
                            </div>
                        </div>
                        
                        <div id="creditCardForm">
                            <h5 class="mb-3">Card Details</h5>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="cardName" class="form-label">Name on Card</label>
                                    <input type="text" class="form-control" id="cardName" placeholder="John Doe">
                                </div>
                                <div class="col-md-6">
                                    <label for="cardNumber" class="form-label">Card Number</label>
                                    <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="expiryMonth" class="form-label">Expiry Month</label>
                                    <select class="form-select" id="expiryMonth">
                                        <option value="">Month</option>
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="expiryYear" class="form-label">Expiry Year</label>
                                    <select class="form-select" id="expiryYear">
                                        <option value="">Year</option>
                                        <option value="2025">2025</option>
                                        <option value="2026">2026</option>
                                        <option value="2027">2027</option>
                                        <option value="2028">2028</option>
                                        <option value="2029">2029</option>
                                        <option value="2030">2030</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="cvv" class="form-label">CVV</label>
                                    <input type="text" class="form-control" id="cvv" placeholder="123">
                                </div>
                            </div>
                        </div>
                        
                        <!-- This is a hidden field that would normally be populated by a payment gateway -->
                        <input type="hidden" name="transactionId" value="TXN-${System.currentTimeMillis()}">
                        
                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" id="termsCheck" required>
                            <label class="form-check-label" for="termsCheck">
                                I agree to the <a href="<c:url value='/terms' />" target="_blank">Terms and Conditions</a> and <a href="<c:url value='/privacy' />" target="_blank">Privacy Policy</a>
                            </label>
                        </div>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="<c:url value='/bookings/${booking.bookingId}' />" class="btn btn-outline-secondary">Cancel</a>
                            <button type="submit" class="btn btn-success">Pay Now ₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card shadow mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Payment Information</h5>
                </div>
                <div class="card-body">
                    <h6>Secure Payment</h6>
                    <p>All payments are processed securely. Your card details are encrypted and never stored on our servers.</p>
                    
                    <h6>Cancellation Policy</h6>
                    <p>Free cancellation up to 24 hours before pickup. After that, a cancellation fee of 50% of the total booking amount will apply.</p>
                    
                    <h6>Refund Policy</h6>
                    <p>Refunds are processed within 7-10 business days, depending on your payment method and financial institution.</p>
                </div>
            </div>
            
            <div class="card shadow">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Need Help?</h5>
                </div>
                <div class="card-body">
                    <p>If you have any questions or issues with payment, please contact our customer support:</p>
                    <p><i class="fas fa-phone"></i> +1-234-567-8900</p>
                    <p><i class="fas fa-envelope"></i> support@vehiclerental.com</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const paymentMethods = document.querySelectorAll('input[name="paymentMethod"]');
        const creditCardForm = document.getElementById('creditCardForm');
        
        function toggleCreditCardForm() {
            const selectedMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            if (selectedMethod === 'Credit Card' || selectedMethod === 'Debit Card') {
                creditCardForm.style.display = 'block';
            } else {
                creditCardForm.style.display = 'none';
            }
        }
        
        paymentMethods.forEach(method => {
            method.addEventListener('change', toggleCreditCardForm);
        });
        
        // Initial toggle
        toggleCreditCardForm();
    });
</script>

<jsp:include page="../common/footer.jsp" />
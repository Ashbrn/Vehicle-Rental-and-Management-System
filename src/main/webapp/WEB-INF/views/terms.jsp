<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="common/header.jsp" />

<div class="container py-5">
    <h1 class="mb-4">Terms of Service</h1>
    
    <div class="card mb-4">
        <div class="card-body">
            <h3>1. Introduction</h3>
            <p>
                Welcome to Vehicle Rental System. These Terms of Service govern your use of our website and services. 
                By accessing or using our services, you agree to be bound by these Terms. If you disagree with any part of the terms, 
                you may not access the service.
            </p>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-body">
            <h3>2. Rental Agreement</h3>
            <p>
                When you book a vehicle through our platform, you enter into a rental agreement with Vehicle Rental System. 
                This agreement is subject to the terms and conditions specified at the time of booking, including but not limited to 
                rental duration, pricing, and vehicle specifications.
            </p>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-body">
            <h3>3. User Accounts</h3>
            <p>
                To access certain features of our service, you may be required to register for an account. You are responsible for 
                maintaining the confidentiality of your account information, including your password, and for all activities that occur under your account.
            </p>
            <p>
                You agree to notify us immediately of any unauthorized use of your account or any other breach of security. 
                We cannot and will not be liable for any loss or damage arising from your failure to comply with this provision.
            </p>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-body">
            <h3>4. Booking and Cancellation</h3>
            <p>
                <strong>4.1 Booking:</strong> All bookings are subject to vehicle availability. A booking is only confirmed after payment is processed 
                and you receive a confirmation email.
            </p>
            <p>
                <strong>4.2 Cancellation:</strong> Cancellation policies vary depending on the vehicle and rental duration. 
                Specific cancellation terms will be provided at the time of booking.
            </p>
            <p>
                <strong>4.3 Modifications:</strong> Modifications to bookings are subject to availability and may incur additional charges.
            </p>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-body">
            <h3>5. Vehicle Use</h3>
            <p>
                <strong>5.1 Authorized Drivers:</strong> Only the person who made the booking and additional drivers listed in the rental agreement 
                are authorized to drive the rented vehicle.
            </p>
            <p>
                <strong>5.2 Prohibited Uses:</strong> Vehicles may not be used for:
            </p>
            <ul>
                <li>Illegal activities</li>
                <li>Racing or speed testing</li>
                <li>Transporting goods for commercial purposes unless specifically authorized</li>
                <li>Towing another vehicle unless the rented vehicle is equipped for towing and it is authorized</li>
                <li>Driving under the influence of alcohol, drugs, or any other substance that impairs driving ability</li>
            </ul>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-body">
            <h3>6. Fees and Payments</h3>
            <p>
                <strong>6.1 Rental Fees:</strong> The total rental fee will be disclosed at the time of booking and may include base rental rate, 
                insurance, taxes, and any additional services requested.
            </p>
            <p>
                <strong>6.2 Additional Charges:</strong> You may incur additional charges for:
            </p>
            <ul>
                <li>Late returns</li>
                <li>Fuel (if the vehicle is not returned with the same fuel level as at pickup)</li>
                <li>Traffic violations or parking tickets incurred during the rental period</li>
                <li>Damage to the vehicle beyond normal wear and tear</li>
                <li>Cleaning fees (if the vehicle is returned excessively dirty)</li>
            </ul>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-body">
            <h3>7. Insurance and Liability</h3>
            <p>
                <strong>7.1 Insurance Coverage:</strong> Basic insurance coverage is included in the rental fee. Additional coverage options 
                may be available at an extra cost.
            </p>
            <p>
                <strong>7.2 Liability:</strong> You are responsible for any damage to the vehicle during the rental period not covered by insurance.
            </p>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-body">
            <h3>8. Privacy Policy</h3>
            <p>
                Your use of our service is also governed by our Privacy Policy, which can be found <a href="<c:url value='/privacy' />">here</a>.
            </p>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-body">
            <h3>9. Changes to Terms</h3>
            <p>
                We reserve the right to modify these terms at any time. We will provide notice of significant changes by updating the date at the top of these terms 
                and by maintaining a current version of the terms at <a href="<c:url value='/terms' />">this link</a>.
            </p>
        </div>
    </div>
    
    <div class="card">
        <div class="card-body">
            <h3>10. Contact Us</h3>
            <p>
                If you have any questions about these Terms, please contact us at:
            </p>
            <p>
                Email: legal@vehiclerental.com<br>
                Phone: +1 (123) 456-7890<br>
                Address: 123 Rental Street, City, State 12345
            </p>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
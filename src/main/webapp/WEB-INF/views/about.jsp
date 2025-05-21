<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="common/header.jsp" />

<div class="container py-5">
    <h1 class="mb-4">About Us</h1>
    
    <div class="row">
        <div class="col-md-6">
            <h3>Our Story</h3>
            <p>
                Founded in 2020, Vehicle Rental System has quickly established itself as a leading provider of vehicle rental services. 
                Our journey began with a simple mission: to make vehicle rentals accessible, affordable, and hassle-free for everyone.
            </p>
            <p>
                What started as a small fleet of just 10 vehicles has now grown to over 100 vehicles of various types, 
                from economy cars to luxury SUVs, catering to diverse customer needs and preferences.
            </p>
        </div>
        <div class="col-md-6">
            <img src="https://via.placeholder.com/600x400" alt="About Us" class="img-fluid rounded">
        </div>
    </div>
    
    <div class="row mt-5">
        <div class="col-md-12">
            <h3>Our Mission</h3>
            <p>
                At Vehicle Rental System, our mission is to provide high-quality vehicles at competitive prices, 
                backed by exceptional customer service. We strive to make the rental process as smooth and transparent as possible, 
                ensuring our customers have a pleasant experience from booking to return.
            </p>
        </div>
    </div>
    
    <div class="row mt-5">
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body text-center">
                    <i class="fas fa-car-side fa-3x text-primary mb-3"></i>
                    <h4>Quality Vehicles</h4>
                    <p>
                        We maintain a fleet of well-serviced vehicles that undergo regular maintenance and thorough cleaning 
                        to ensure they are in perfect condition for our customers.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body text-center">
                    <i class="fas fa-hand-holding-usd fa-3x text-primary mb-3"></i>
                    <h4>Competitive Pricing</h4>
                    <p>
                        We offer transparent pricing with no hidden fees. Our competitive rates ensure you get the best value 
                        for your money without compromising on quality.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body text-center">
                    <i class="fas fa-headset fa-3x text-primary mb-3"></i>
                    <h4>Customer Support</h4>
                    <p>
                        Our dedicated customer support team is available to assist you with any queries or concerns, 
                        ensuring a smooth and hassle-free rental experience.
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-5">
        <div class="col-md-12">
            <h3>Our Team</h3>
            <p>
                Behind Vehicle Rental System is a team of passionate professionals committed to providing the best rental experience. 
                From our customer service representatives to our maintenance staff, everyone plays a crucial role in ensuring 
                our customers receive top-notch service.
            </p>
        </div>
    </div>
    
    <div class="row mt-5">
        <div class="col-md-12 text-center">
            <h3>Ready to Experience Our Service?</h3>
            <p>Browse our selection of vehicles and book your rental today!</p>
            <a href="<c:url value='/vehicles' />" class="btn btn-primary btn-lg mt-3">Browse Vehicles</a>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
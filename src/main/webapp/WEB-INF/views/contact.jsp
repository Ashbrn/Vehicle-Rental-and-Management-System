<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="common/header.jsp" />

<div class="container py-5">
    <h1 class="mb-4">Contact Us</h1>
    
    <div class="row">
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-body">
                    <h3 class="card-title">Get in Touch</h3>
                    <p class="card-text">
                        Have questions or feedback? We'd love to hear from you. Fill out the form below, and our team will get back to you as soon as possible.
                    </p>
                    
                    <form action="#" method="post">
                        <div class="mb-3">
                            <label for="name" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="subject" class="form-label">Subject</label>
                            <input type="text" class="form-control" id="subject" name="subject" required>
                        </div>
                        <div class="mb-3">
                            <label for="message" class="form-label">Message</label>
                            <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-body">
                    <h3 class="card-title">Contact Information</h3>
                    <p class="card-text">
                        You can also reach us through the following channels:
                    </p>
                    
                    <ul class="list-unstyled">
                        <li class="mb-3">
                            <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                            <strong>Address:</strong><br>
                            NIET, Plot 19, Knowledge Park 2, Greater Noida 201310, Uttar Pradesh
                        </li>
                        <li class="mb-3">
                            <i class="fas fa-phone me-2 text-primary"></i>
                            <strong>Phone:</strong><br>
                            +91 98765 43210
                        </li>
                        <li class="mb-3">
                            <i class="fas fa-envelope me-2 text-primary"></i>
                            <strong>Email:</strong><br>
                            info@indianvehiclerental.com
                        </li>
                        <li class="mb-3">
                            <i class="fas fa-clock me-2 text-primary"></i>
                            <strong>Business Hours:</strong><br>
                            Monday - Friday: 9:00 AM - 6:00 PM<br>
                            Saturday: 10:00 AM - 4:00 PM<br>
                            Sunday: Closed
                        </li>
                    </ul>
                </div>
            </div>
            
            <div class="card">
                <div class="card-body">
                    <h3 class="card-title">Follow Us</h3>
                    <p class="card-text">
                        Stay connected with us on social media for updates, promotions, and more.
                    </p>
                    
                    <div class="d-flex gap-3">
                        <a href="#" class="text-decoration-none">
                            <i class="fab fa-facebook fa-2x text-primary"></i>
                        </a>
                        <a href="#" class="text-decoration-none">
                            <i class="fab fa-twitter fa-2x text-info"></i>
                        </a>
                        <a href="#" class="text-decoration-none">
                            <i class="fab fa-instagram fa-2x text-danger"></i>
                        </a>
                        <a href="#" class="text-decoration-none">
                            <i class="fab fa-linkedin fa-2x text-primary"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-5">
        <div class="col-md-12">
            <h3>Location</h3>
            <div class="ratio ratio-16x9">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3507.2052421096147!2d77.49978207549395!3d28.470297175733946!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390cea7e051fd949%3A0xefccd5003c9032b6!2sNoida%20Institute%20of%20Engineering%20and%20Technology!5e0!3m2!1sen!2sin!4v1715708988000!5m2!1sen!2sin" 
                        width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
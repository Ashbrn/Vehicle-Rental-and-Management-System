<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="common/header.jsp" />

<!-- Hero Section -->
<section class="hero-section text-center">
    <div class="container">
        <h1 class="display-4 fw-bold mb-4">Rent Your Dream Vehicle Today</h1>
        <p class="lead mb-5">Choose from our wide range of vehicles at affordable prices. Easy booking, transparent pricing, and excellent customer service.</p>
        <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
            <a href="<c:url value='/vehicles' />" class="btn btn-primary btn-lg px-4 gap-3">Browse Vehicles</a>
            <a href="<c:url value='/about' />" class="btn btn-outline-light btn-lg px-4">Learn More</a>
        </div>
    </div>
</section>

<!-- Search Section -->
<section class="bg-light py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4">Find Your Perfect Vehicle</h3>
                        <form action="<c:url value='/vehicles/filter' />" method="get" class="row g-3">
                            <div class="col-md-4">
                                <label for="type" class="form-label">Vehicle Type</label>
                                <select class="form-select" id="type" name="type">
                                    <option value="">All Types</option>
                                    <c:forEach items="${vehicleTypes}" var="type">
                                        <option value="${type}">${type}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="brand" class="form-label">Brand</label>
                                <select class="form-select" id="brand" name="brand">
                                    <option value="">All Brands</option>
                                    <c:forEach items="${vehicleBrands}" var="brand">
                                        <option value="${brand}">${brand}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="priceRange" class="form-label">Price Range</label>
                                <select class="form-select" id="priceRange" onchange="setPriceRange(this.value)">
                                    <option value="">Any Price</option>
                                    <option value="1000-1200">₹1,000 - ₹1,200/day</option>
                                    <option value="1200-1500">₹1,200 - ₹1,500/day</option>
                                    <option value="1500-1800">₹1,500 - ₹1,800/day</option>
                                    <option value="1800-2000">₹1,800 - ₹2,000/day</option>
                                </select>
                                <input type="hidden" id="minPrice" name="minPrice">
                                <input type="hidden" id="maxPrice" name="maxPrice">
                            </div>
                            <div class="col-12 text-center mt-4">
                                <button type="submit" class="btn btn-primary px-4 py-2">Search Vehicles</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Featured Vehicles Section -->
<section class="py-5">
    <div class="container">
        <h2 class="text-center mb-5">Featured Vehicles</h2>
        <div class="row">
            <c:forEach items="${featuredVehicles}" var="vehicle" begin="0" end="5">
                <div class="col-md-4 mb-4">
                    <div class="card vehicle-card h-100">
                        <img src="${empty vehicle.imageUrl ? '/uploads/vehicles/default.jpg' : vehicle.imageUrl}" 
                             class="card-img-top vehicle-img" alt="${vehicle.brand} ${vehicle.model}">
                        <div class="card-body">
                            <h5 class="card-title">${vehicle.brand} ${vehicle.model} (${vehicle.year})</h5>
                            <p class="card-text text-muted">${vehicle.type} • ${vehicle.fuelType} • ${vehicle.seatingCapacity} Seats</p>
                            <p class="card-text fw-bold text-primary">₹<fmt:formatNumber value="${vehicle.pricePerDay}" pattern="#,##0.00" />/day</p>
                        </div>
                        <div class="card-footer bg-white border-top-0">
                            <a href="<c:url value='/vehicles/${vehicle.vehicleId}' />" class="btn btn-outline-primary w-100">View Details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="text-center mt-4">
            <a href="<c:url value='/vehicles' />" class="btn btn-outline-dark px-4 py-2">View All Vehicles</a>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="bg-light py-5">
    <div class="container">
        <h2 class="text-center mb-5">Why Choose Us</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="fas fa-car-side fa-3x text-primary"></i>
                        </div>
                        <h4 class="card-title">Wide Selection</h4>
                        <p class="card-text">Choose from our extensive fleet of vehicles ranging from economy cars to luxury SUVs.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="fas fa-money-bill-wave fa-3x text-primary"></i>
                        </div>
                        <h4 class="card-title">Transparent Pricing</h4>
                        <p class="card-text">No hidden fees or charges. What you see is what you pay.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="fas fa-video fa-3x text-primary"></i>
                        </div>
                        <h4 class="card-title">Video Verification</h4>
                        <p class="card-text">Our unique video verification system ensures transparency and prevents disputes.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="py-5">
    <div class="container">
        <h2 class="text-center mb-5">What Our Customers Say</h2>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="mb-3 text-warning">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p class="card-text">"Great service! The booking process was smooth, and the vehicle was in excellent condition. Will definitely use again."</p>
                    </div>
                    <div class="card-footer bg-white">
                        <div class="d-flex align-items-center">
                            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                <span>JD</span>
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">John Doe</h6>
                                <small class="text-muted">Regular Customer</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="mb-3 text-warning">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p class="card-text">"I love the video verification feature. It gives me peace of mind knowing there won't be any disputes about damages."</p>
                    </div>
                    <div class="card-footer bg-white">
                        <div class="d-flex align-items-center">
                            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                <span>JS</span>
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Jane Smith</h6>
                                <small class="text-muted">Business Traveler</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="mb-3 text-warning">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </div>
                        <p class="card-text">"Affordable prices and excellent customer service. The staff was very helpful when I needed to extend my rental period."</p>
                    </div>
                    <div class="card-footer bg-white">
                        <div class="d-flex align-items-center">
                            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                <span>RJ</span>
                            </div>
                            <div class="ms-3">
                                <h6 class="mb-0">Robert Johnson</h6>
                                <small class="text-muted">Tourist</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Special Offer Section -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <img src="https://stimg.cardekho.com/images/carexteriorimages/930x620/Maruti/Swift/10406/1697698080681/front-left-side-47.jpg" class="img-fluid rounded shadow" alt="Special Offer">
            </div>
            <div class="col-md-6">
                <div class="p-4">
                    <span class="badge bg-danger mb-2">Limited Time Offer</span>
                    <h2 class="mb-3">Rent for Just ₹1000/Day</h2>
                    <p class="lead mb-4">Experience the thrill of driving a brand new Maruti Suzuki Swift at an unbeatable price. All our vehicles are priced between ₹1000 and ₹2000 per day!</p>
                    <ul class="list-unstyled mb-4">
                        <li><i class="fas fa-check-circle text-success me-2"></i> Free cancellation up to 24 hours</li>
                        <li><i class="fas fa-check-circle text-success me-2"></i> Unlimited kilometers</li>
                        <li><i class="fas fa-check-circle text-success me-2"></i> 24/7 roadside assistance</li>
                        <li><i class="fas fa-check-circle text-success me-2"></i> Comprehensive insurance included</li>
                    </ul>
                    <a href="<c:url value='/vehicles/1' />" class="btn btn-primary btn-lg">Book Now</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action -->
<section class="bg-primary text-white py-5">
    <div class="container text-center">
        <h2 class="mb-4">Ready to Rent Your Vehicle?</h2>
        <p class="lead mb-4">Join thousands of satisfied customers who trust our service.</p>
        <a href="<c:url value='/vehicles' />" class="btn btn-light btn-lg px-4 me-md-2">Browse Vehicles</a>
        <a href="<c:url value='/user/register' />" class="btn btn-outline-light btn-lg px-4">Register Now</a>
    </div>
</section>

<script>
    function setPriceRange(range) {
        if (range) {
            const [min, max] = range.split('-');
            document.getElementById('minPrice').value = min;
            document.getElementById('maxPrice').value = max;
        } else {
            document.getElementById('minPrice').value = '';
            document.getElementById('maxPrice').value = '';
        }
    }
</script>

<jsp:include page="common/footer.jsp" />
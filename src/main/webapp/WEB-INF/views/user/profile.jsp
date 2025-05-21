<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../common/header.jsp" />

<div class="container py-5">
    <div class="row">
        <!-- Profile Sidebar -->
        <div class="col-md-4 mb-4">
            <div class="card shadow">
                <div class="card-body text-center">
                    <div class="mb-3">
                        <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center mx-auto" style="width: 100px; height: 100px; font-size: 40px;">
                            ${user.firstName.charAt(0)}${user.lastName.charAt(0)}
                        </div>
                    </div>
                    <h4>${user.firstName} ${user.lastName}</h4>
                    <p class="text-muted">${user.email}</p>
                    <p class="text-muted">${user.phone}</p>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                        <a href="<c:url value='/bookings' />" class="text-decoration-none d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-calendar-alt me-2"></i> My Bookings</span>
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="<c:url value='/complaints' />" class="text-decoration-none d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-comment-alt me-2"></i> My Complaints</span>
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="<c:url value='/user/logout' />" class="text-decoration-none text-danger d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-sign-out-alt me-2"></i> Logout</span>
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        
        <!-- Profile Form -->
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Edit Profile</h4>
                </div>
                <div class="card-body">
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
                    
                    <form:form action="${pageContext.request.contextPath}/user/profile/update" method="post" modelAttribute="user" class="row g-3">
                        <div class="col-md-6">
                            <label for="firstName" class="form-label">First Name*</label>
                            <form:input path="firstName" id="firstName" class="form-control" required="true" />
                        </div>
                        <div class="col-md-6">
                            <label for="lastName" class="form-label">Last Name*</label>
                            <form:input path="lastName" id="lastName" class="form-control" required="true" />
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email*</label>
                            <form:input path="email" id="email" type="email" class="form-control" required="true" />
                        </div>
                        <div class="col-md-6">
                            <label for="phone" class="form-label">Phone Number*</label>
                            <form:input path="phone" id="phone" class="form-control" required="true" />
                        </div>
                        <div class="col-12">
                            <label for="address" class="form-label">Address</label>
                            <form:textarea path="address" id="address" class="form-control" rows="3" />
                        </div>
                        <div class="col-md-6">
                            <label for="drivingLicense" class="form-label">Driving License Number*</label>
                            <form:input path="drivingLicense" id="drivingLicense" class="form-control" required="true" readonly="true" />
                            <small class="text-muted">Driving license cannot be changed</small>
                        </div>
                        <div class="col-md-6">
                            <label for="username" class="form-label">Username*</label>
                            <form:input path="username" id="username" class="form-control" required="true" readonly="true" />
                            <small class="text-muted">Username cannot be changed</small>
                        </div>
                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-primary px-4 py-2">Update Profile</button>
                        </div>
                    </form:form>
                </div>
            </div>
            
            <!-- Change Password Section -->
            <div class="card shadow mt-4">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Change Password</h4>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/user/password/change" method="post" class="row g-3">
                        <div class="col-md-6">
                            <label for="currentPassword" class="form-label">Current Password*</label>
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                        </div>
                        <div class="col-md-6">
                            <label for="newPassword" class="form-label">New Password*</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="col-md-6">
                            <label for="confirmPassword" class="form-label">Confirm New Password*</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        </div>
                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-primary px-4 py-2">Change Password</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
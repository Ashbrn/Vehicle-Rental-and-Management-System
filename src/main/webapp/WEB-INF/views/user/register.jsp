<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../common/header.jsp" />

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Create an Account</h4>
                </div>
                <div class="card-body">
                    <form:form action="${pageContext.request.contextPath}/user/register" method="post" modelAttribute="user" class="row g-3">
                        <div class="col-md-6">
                            <label for="username" class="form-label">Username*</label>
                            <form:input path="username" id="username" class="form-control" required="true" />
                        </div>
                        <div class="col-md-6">
                            <label for="password" class="form-label">Password*</label>
                            <form:password path="password" id="password" class="form-control" required="true" />
                        </div>
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
                            <form:input path="drivingLicense" id="drivingLicense" class="form-control" required="true" />
                        </div>
                        <div class="col-12 mt-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                <label class="form-check-label" for="termsCheck">
                                    I agree to the <a href="<c:url value='/terms' />" target="_blank">Terms and Conditions</a> and <a href="<c:url value='/privacy' />" target="_blank">Privacy Policy</a>
                                </label>
                            </div>
                        </div>
                        <div class="col-12 mt-4 text-center">
                            <button type="submit" class="btn btn-primary px-4 py-2">Register</button>
                        </div>
                    </form:form>
                    <div class="mt-4 text-center">
                        <p>Already have an account? <a href="<c:url value='/user/login' />">Login here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
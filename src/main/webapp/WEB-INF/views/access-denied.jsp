<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="common/header.jsp" />

<div class="container py-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-body p-5">
                    <i class="fas fa-exclamation-triangle text-danger fa-5x mb-4"></i>
                    <h1 class="display-4 mb-4">Access Denied</h1>
                    <p class="lead mb-4">
                        Sorry, you don't have permission to access this page.
                    </p>
                    <p class="mb-4">
                        If you believe this is an error, please contact our support team for assistance.
                    </p>
                    <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                        <a href="<c:url value='/' />" class="btn btn-primary btn-lg px-4 gap-3">
                            <i class="fas fa-home me-2"></i>Return to Home
                        </a>
                        <a href="<c:url value='/contact' />" class="btn btn-outline-secondary btn-lg px-4">
                            <i class="fas fa-envelope me-2"></i>Contact Support
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
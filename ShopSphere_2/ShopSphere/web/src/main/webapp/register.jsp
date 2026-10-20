<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Create Account | ShopSphere" scope="request"/>
<%@ include file="fragments/header.jsp" %>
<%@ include file="fragments/navbar.jsp" %>

<main class="auth-container py-5">
    <div class="container">
        <div class="auth-card">
            <div class="auth-header text-center mb-4">
                <span class="auth-icon">✨</span>
                <h2 class="auth-title">Create Account</h2>
                <p class="text-muted">Join ShopSphere for seamless shopping</p>
            </div>

            <c:if test="${not empty param.error}">
                <div class="alert alert-danger custom-alert mb-3" role="alert">
                    ⚠️ <c:out value="${param.error}"/>
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/register" class="auth-form">
                <div class="mb-3">
                    <label class="form-label" for="regName">Full Name</label>
                    <input class="form-control auth-input" id="regName" name="name" placeholder="John Doe" required>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="regEmail">Email Address</label>
                    <input class="form-control auth-input" id="regEmail" name="email" type="email" placeholder="john@example.com" required>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="regMobile">Mobile Number</label>
                    <input class="form-control auth-input" id="regMobile" name="mobile" placeholder="+91 98765 43210">
                </div>

                <div class="mb-4">
                    <label class="form-label" for="regPassword">Password</label>
                    <input class="form-control auth-input" id="regPassword" name="password" type="password" placeholder="Create a strong password" required>
                </div>

                <button class="btn btn-auth-submit w-100" type="submit">Create Account</button>
            </form>

            <div class="auth-footer text-center mt-4">
                <p class="mb-0 text-muted">
                    Already have an account? <a href="${pageContext.request.contextPath}/login.jsp" class="auth-link">Sign in here</a>
                </p>
            </div>
        </div>
    </div>
</main>

<%@ include file="fragments/footer.jsp" %>
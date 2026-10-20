<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Sign In | ShopSphere" scope="request"/>
<%@ include file="fragments/header.jsp" %>
<%@ include file="fragments/navbar.jsp" %>

<main class="auth-container py-5">
    <div class="container">
        <div class="auth-card">
            <div class="auth-header text-center mb-4">
                <span class="auth-icon">🔐</span>
                <h2 class="auth-title">Welcome Back</h2>
                <p class="text-muted">Sign in to your ShopSphere account</p>
            </div>

            <c:if test="${not empty param.error}">
                <div class="alert alert-danger custom-alert mb-3" role="alert">
                    ⚠️ <c:out value="${param.error}"/>
                </div>
            </c:if>

            <c:if test="${not empty param.registered}">
                <div class="alert alert-success custom-alert mb-3" role="alert">
                    ✅ Account created successfully! Please log in.
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/login" class="auth-form">
                <div class="mb-3">
                    <label class="form-label" for="loginEmail">Email Address</label>
                    <input class="form-control auth-input" id="loginEmail" name="email" type="email" placeholder="name@domain.com" required>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="loginPassword">Password</label>
                    <input class="form-control auth-input" id="loginPassword" name="password" type="password" placeholder="••••••••" required>
                </div>

                <div class="mb-4">
                    <label class="form-label" for="loginRole">Account Role</label>
                    <select class="form-select auth-input" id="loginRole" name="role">
                        <option value="CUSTOMER" selected>Customer Portal</option>
                        <option value="ADMIN">Administrator Portal</option>
                    </select>
                </div>

                <button class="btn btn-auth-submit w-100" type="submit">Sign In</button>
            </form>

            <div class="demo-hints mt-4 p-3 rounded-3">
                <small class="d-block fw-bold text-muted mb-2">⚡ Quick Demo Credentials:</small>
                <div class="d-flex flex-wrap gap-2">
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="fillCreds('admin@shopsphere.com', 'admin123', 'ADMIN')">
                        Demo Admin
                    </button>
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="fillCreds('user@shopsphere.com', 'user123', 'CUSTOMER')">
                        Demo Customer
                    </button>
                </div>
            </div>

            <div class="auth-footer text-center mt-4">
                <p class="mb-0 text-muted">
                    Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp" class="auth-link">Register here</a>
                </p>
            </div>
        </div>
    </div>
</main>

<script>
function fillCreds(email, pass, role) {
    document.getElementById('loginEmail').value = email;
    document.getElementById('loginPassword').value = pass;
    document.getElementById('loginRole').value = role;
}
</script>

<%@ include file="fragments/footer.jsp" %>

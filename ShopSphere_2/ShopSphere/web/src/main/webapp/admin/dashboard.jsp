<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Admin Portal | ShopSphere" scope="request"/>
<%@ include file="../fragments/header.jsp" %>
<%@ include file="../fragments/navbar.jsp" %>

<main class="admin-dashboard-container py-5">
    <div class="container">
        <div class="admin-header-strip p-4 rounded-4 mb-4">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
                <div>
                    <span class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-bold">ADMINISTRATIVE CONSOLE</span>
                    <h1 class="text-white mt-2 mb-1">ShopSphere Control Center</h1>
                    <p class="text-white-50 mb-0">Logged in as: <strong><c:out value="${sessionScope.user.name}"/></strong> (<c:out value="${sessionScope.user.email}"/>)</p>
                </div>
                <div class="d-flex gap-2">
                    <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/products">View Storefront</a>
                    <a class="btn btn-danger" href="${pageContext.request.contextPath}/logout">Log Out</a>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon">📦</div>
                    <div class="stat-val">18</div>
                    <div class="stat-lbl">Active Products</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon">👥</div>
                    <div class="stat-val">2</div>
                    <div class="stat-lbl">Registered Accounts</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon">🗂️</div>
                    <div class="stat-val">3</div>
                    <div class="stat-lbl">Store Categories</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon">⚡</div>
                    <div class="stat-val">Online</div>
                    <div class="stat-lbl">RMI / Sockets Status</div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="admin-module-card h-100">
                    <div class="card-icon">🛠️</div>
                    <h4>Product Management</h4>
                    <p class="text-muted">Create, update, discount, and manage inventory listings stored in MySQL.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark w-100 mt-auto">Browse Items</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="admin-module-card h-100">
                    <div class="card-icon">📦</div>
                    <h4>Order Operations</h4>
                    <p class="text-muted">Track customer orders, payment statuses, and shipment fulfillments.</p>
                    <button class="btn btn-outline-dark w-100 mt-auto" onclick="alert('Order processing subsystem active.')">View Orders</button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="admin-module-card h-100">
                    <div class="card-icon">📊</div>
                    <h4>Distributed Inventory</h4>
                    <p class="text-muted">Real-time socket-based inventory feed and RMI service monitoring.</p>
                    <button class="btn btn-outline-dark w-100 mt-auto" onclick="alert('Socket inventory listener ready.')">Inventory Monitor</button>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="../fragments/footer.jsp" %>

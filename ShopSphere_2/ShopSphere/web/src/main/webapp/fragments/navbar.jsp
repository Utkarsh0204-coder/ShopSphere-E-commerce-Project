<%@ page import="com.shopsphere.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
%>
<header class="site-header sticky-top">
    <nav class="navbar navbar-expand-lg navbar-dark main-navbar">
        <div class="container header-inner">
            <a class="navbar-brand brand-mark" href="${pageContext.request.contextPath}/">
                <span class="brand-icon">&#128722;</span>
                <span class="brand-text">Shop<strong>Sphere</strong></span>
            </a>
            
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navContent" aria-controls="navContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 nav-links">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active-indicator" href="${pageContext.request.contextPath}/products">
                            <span>Browse Products</span>
                        </a>
                    </li>
                    <% if (currentUser != null && "ADMIN".equalsIgnoreCase(currentUser.getRole())) { %>
                    <li class="nav-item">
                        <a class="nav-link admin-pill" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                           &#9881; Admin Portal
                        </a>
                    </li>
                    <% } %>
                </ul>

                <div class="nav-auth-actions d-flex align-items-center gap-2">
                    <% if (currentUser != null) { %>
                        <a class="btn btn-nav-ghost" href="${pageContext.request.contextPath}/cart">&#128722; Cart</a>
                        <a class="btn btn-nav-ghost" href="${pageContext.request.contextPath}/orders">&#128188; Orders</a>
                        <span class="user-pill">
                           &#128075; Hi, <strong><%= currentUser.getName() %></strong>
                        </span>
                        <a class="btn btn-nav-ghost" href="${pageContext.request.contextPath}/logout">Logout</a>
                    <% } else { %>
                        <a class="btn btn-nav-ghost" href="${pageContext.request.contextPath}/login.jsp">Sign In</a>
                        <a class="btn btn-nav-primary" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                    <% } %>
                </div>
            </div>
        </div>
    </nav>
</header>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="ShopSphere — Next-Gen Java E-Commerce" scope="request"/>
<%@ include file="fragments/header.jsp" %>
<%@ include file="fragments/navbar.jsp" %>

<main class="home-container">
    <div class="container py-5">
        <!-- Hero Section -->
        <section class="landing-hero rounded-4 p-5 mb-5">
            <div class="row align-items-center">
                <div class="col-lg-7">
                    <div class="badge-pill mb-3">
                        <span class="badge-dot"></span> RTU Advanced Java E-Commerce
                    </div>
                    <h1 class="landing-title">Empowering Modern Commerce with High-Performance Java</h1>
                    <p class="landing-subtitle">
                        Experience lightning-fast browsing, dynamic filtering, enterprise MVC architecture, and seamless multi-module integration.
                    </p>
                    <div class="landing-cta-group d-flex flex-wrap gap-3">
                        <a class="btn btn-hero-primary" href="${pageContext.request.contextPath}/products">
                            <span>Browse Catalogue</span>
                            <span class="arrow" aria-hidden="true">→</span>
                        </a>
                        <a class="btn btn-hero-secondary" href="${pageContext.request.contextPath}/login.jsp">
                            Admin &amp; Customer Portal
                        </a>
                    </div>
                </div>
                <div class="col-lg-5 text-center mt-4 mt-lg-0">
                    <div class="hero-visual-card">
                        <div class="visual-badge">⚡ Enterprise Stack</div>
                        <div class="visual-stat-number">100%</div>
                        <div class="visual-stat-label">Native Jakarta EE Architecture</div>
                        <div class="stat-pills mt-3">
                            <span class="stat-tag">Jakarta Servlet 6.1</span>
                            <span class="stat-tag">MySQL 8.0</span>
                            <span class="stat-tag">Tomcat 11</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Tech Highlights -->
        <div class="section-heading mb-4">
            <h2>Architectural Highlights</h2>
            <p class="text-muted">Demonstrating core paradigms of the RTU Advanced Java Curriculum</p>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="feature-card h-100">
                    <div class="feature-icon-wrap">🌐</div>
                    <h3>Servlet + JSP + JSTL</h3>
                    <p>Clean MVC separation with front-controller servlets, JSTL tag libraries, and responsive view rendering.</p>
                    <span class="feature-link-hint">Presentation Layer →</span>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card h-100">
                    <div class="feature-icon-wrap">🗄️</div>
                    <h3>JDBC + MySQL + DAO</h3>
                    <p>Robust persistence layer with prepared statements, connection pooling compatibility, and relational schema.</p>
                    <span class="feature-link-hint">Data Layer →</span>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card h-100">
                    <div class="feature-icon-wrap">⚡</div>
                    <h3>RMI + Socket + Swing</h3>
                    <p>Distributed computing with Java RMI registry, TCP socket serialization, and Swing desktop admin client.</p>
                    <span class="feature-link-hint">Distributed Layer →</span>
                </div>
            </div>
        </div>

        <!-- Quick Categories -->
        <section class="quick-category-strip p-4 rounded-4">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
                <div>
                    <h4 class="mb-1 text-white">Popular Departments</h4>
                    <p class="mb-0 text-white-50">Filter seamlessly by high-demand product lines</p>
                </div>
                <div class="d-flex flex-wrap gap-2">
                    <a class="btn btn-outline-light rounded-pill px-4" href="${pageContext.request.contextPath}/products?q=Electronics">Electronics</a>
                    <a class="btn btn-outline-light rounded-pill px-4" href="${pageContext.request.contextPath}/products?q=Fashion">Fashion</a>
                    <a class="btn btn-outline-light rounded-pill px-4" href="${pageContext.request.contextPath}/products?q=Home">Home &amp; Living</a>
                </div>
            </div>
        </section>
    </div>
</main>

<%@ include file="fragments/footer.jsp" %>
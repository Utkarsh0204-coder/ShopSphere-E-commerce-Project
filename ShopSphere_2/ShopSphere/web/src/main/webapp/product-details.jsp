<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="${product.name} | ShopSphere" scope="request"/>
<%@ include file="fragments/header.jsp" %>
<%@ include file="fragments/navbar.jsp" %>

<main class="product-details-container">
    <div class="container py-4">
        
        <nav class="breadcrumb-nav mb-4" aria-label="Breadcrumb">
            <a href="${pageContext.request.contextPath}/products" class="back-link">
                <span>←</span> Back to All Products
            </a>
            <span class="crumb-separator">/</span>
            <span class="crumb-current"><c:out value="${product.name}"/></span>
        </nav>

        <c:choose>
            <c:when test="${not empty product}">
                <div class="product-detail-card">
                    <div class="row g-4 align-items-center">
                        <div class="col-lg-6">
                            <div class="detail-gallery-wrap">
                                <c:if test="${product.discount gt 0}">
                                    <span class="detail-discount-pill">
                                        <c:out value="${product.discount}"/>% OFF
                                    </span>
                                </c:if>

                                <c:choose>
                                    <c:when test="${not empty product.imageUrl}">
                                        <img class="detail-main-img"
                                             src="<c:out value='${product.imageUrl}'/>"
                                             alt="<c:out value='${product.name}'/>"
                                             onerror="this.style.display='none';this.nextElementSibling.style.display='flex';">
                                        <div class="detail-fallback" style="display:none">
                                            <span class="fallback-sparkle">✦</span>
                                            <span>ShopSphere Premium</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="detail-fallback">
                                            <span class="fallback-sparkle">✦</span>
                                            <span>ShopSphere Premium</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="detail-content">
                                <div class="detail-header-meta">
                                    <span class="detail-brand-badge"><c:out value="${product.brand}"/></span>
                                    <c:choose>
                                        <c:when test="${product.stock gt 0}">
                                            <span class="detail-stock-badge in-stock">
                                                <span class="stock-dot"></span> In Stock (<c:out value="${product.stock}"/> units available)
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="detail-stock-badge out-stock">
                                                <span class="stock-dot"></span> Out of Stock
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <h1 class="detail-title"><c:out value="${product.name}"/></h1>

                                <p class="detail-description"><c:out value="${product.description}"/></p>

                                <div class="detail-pricing-box">
                                    <div class="detail-price-main">
                                        <span class="detail-currency">₹</span>
                                        <span class="detail-amount"><c:out value="${product.finalPrice}"/></span>
                                    </div>
                                    <c:if test="${product.discount gt 0}">
                                        <div class="detail-price-original">
                                            <del>₹<c:out value="${product.price}"/></del>
                                            <span class="detail-savings">Save <c:out value="${product.discount}"/>%</span>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="detail-perks">
                                    <div class="perk-item">
                                        <span class="perk-icon">⚡</span>
                                        <div>
                                            <strong>Fast Dispatch</strong>
                                            <p>Ships within 24 hours</p>
                                        </div>
                                    </div>
                                    <div class="perk-item">
                                        <span class="perk-icon">🛡️</span>
                                        <div>
                                            <strong>Genuine Quality</strong>
                                            <p>100% verified hardware</p>
                                        </div>
                                    </div>
                                </div>

                                <section class="product-extra-details" aria-labelledby="highlights-heading">
                                    <h2 id="highlights-heading">Product highlights</h2>
                                    <ul class="product-highlight-list">
                                        <c:forEach var="highlight" items="${product.highlights}">
                                            <li><span class="highlight-check">✓</span><c:out value="${highlight}"/></li>
                                        </c:forEach>
                                    </ul>
                                </section>

                                <section class="product-specifications" aria-labelledby="specifications-heading">
                                    <h2 id="specifications-heading">Product specifications</h2>
                                    <div class="specification-table-wrap">
                                        <table class="specification-table">
                                            <tbody>
                                                <c:forEach var="spec" items="${product.specifications}">
                                                    <tr>
                                                        <th scope="row"><c:out value="${spec.key}"/></th>
                                                        <td><c:out value="${spec.value}"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </section>

                                <section class="product-service-info" aria-label="Shopping information">
                                    <div class="service-info-card">
                                        <span class="service-info-icon">🚚</span>
                                        <div><strong>Delivery</strong><p>Delivery options and estimated arrival are confirmed during checkout.</p></div>
                                    </div>
                                    <div class="service-info-card">
                                        <span class="service-info-icon">↩</span>
                                        <div><strong>Returns and support</strong><p>Check the store's applicable return terms before placing your order.</p></div>
                                    </div>
                                </section>

                                <div class="detail-cta-row">
                                    <c:choose>
                                        <c:when test="${sessionScope.user != null}">
                                            <form method="post" action="${pageContext.request.contextPath}/cart" class="add-cart-form">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="productId" value="${product.productId}">
                                                <label class="visually-hidden" for="quantity">Quantity</label>
                                                <input id="quantity" class="form-control quantity-input" type="number" name="quantity" value="1" min="1" max="${product.stock}" required>
                                                <button class="btn btn-purchase" type="submit" ${product.stock le 0 ? 'disabled' : ''}>🛒 Add to Cart</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="btn btn-purchase" href="${pageContext.request.contextPath}/login.jsp">
                                                🔒 Login to Add to Cart
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <a class="btn btn-browse-more" href="${pageContext.request.contextPath}/products">
                                        Continue Shopping
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <div class="no-products text-center p-5">
                    <h3>Product Not Found</h3>
                    <p class="muted">The product you are looking for might have been removed or is unavailable.</p>
                    <a class="btn btn-primary mt-3" href="${pageContext.request.contextPath}/products">
                        Return to Catalogue
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</main>

<%@ include file="fragments/footer.jsp" %>

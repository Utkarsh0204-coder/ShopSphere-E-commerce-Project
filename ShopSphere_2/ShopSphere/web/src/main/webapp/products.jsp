
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Explore Products | ShopSphere" scope="request"/>
<%@ include file="fragments/header.jsp" %>
<%@ include file="fragments/navbar.jsp" %>

<main class="products-container">

    <section class="catalog-hero">
        <div class="hero-content">
            <span class="eyebrow">THE SHOPSPHERE COLLECTION</span>
            <h1>Find your next favourite.</h1>
            <p>Explore electronics, everyday essentials, premium fashion and more.</p>
        </div>
        <div class="hero-decoration" aria-hidden="true">
            <div class="hero-glow"></div>
            <span>✦</span>
        </div>
    </section>

    <section class="catalog-toolbar">
        <div class="toolbar-title">
            <h2>Explore Products</h2>
            <p class="muted">Curated essentials tailored for performance and lifestyle.</p>
        </div>

        <form class="product-search"
              action="${pageContext.request.contextPath}/products"
              method="get">
            <label class="search-box">
                <span class="search-icon" aria-hidden="true">🔍</span>
                <input type="search"
                       class="search-input"
                       name="q"
                       placeholder="Search products or brands..."
                       value="<c:out value='${param.q}'/>"
                       aria-label="Search products">
            </label>
            <button type="submit" class="btn btn-search">Search</button>
        </form>
    </section>

    <section class="catalog-controls">
        <div class="category-filters" aria-label="Filter by category">
            <button type="button" class="filter-btn active"
                    data-category="all">All Products</button>
            <button type="button" class="filter-btn"
                    data-category="1">Electronics</button>
            <button type="button" class="filter-btn"
                    data-category="2">Fashion</button>
            <button type="button" class="filter-btn"
                    data-category="3">Home &amp; Living</button>
        </div>

        <label class="sort-control">
            <span class="sort-label">Sort by:</span>
            <select id="productSort" class="sort-select">
                <option value="default">Recommended</option>
                <option value="price-low">Price: Low to High</option>
                <option value="price-high">Price: High to Low</option>
                <option value="name">Name: A to Z</option>
            </select>
        </label>
    </section>

    <div class="results-bar">
        <p class="product-count"><strong id="productCount">0</strong> products available</p>
        <button type="button" id="resetFilters" class="reset-btn">
            ↺ Reset filters
        </button>
    </div>

    <c:choose>
        <c:when test="${not empty products}">

            <section class="product-grid" id="productGrid"
                     aria-label="Product catalogue">

                <c:forEach var="p" items="${products}">
                    <article class="product-card"
                             data-category="<c:out value='${p.categoryId}'/>"
                             data-price="<c:out value='${p.finalPrice}'/>"
                             data-name="<c:out value='${p.name}'/>">

                        <div class="product-image-wrap">
                            <c:if test="${p.discount gt 0}">
                                <span class="discount-badge">
                                    <c:out value="${p.discount}"/>% OFF
                                </span>
                            </c:if>

                            <c:choose>
                                <c:when test="${not empty p.imageUrl}">
                                    <img
                                        src="<c:out value='${p.imageUrl}'/>"
                                        alt="<c:out value='${p.name}'/>"
                                        class="product-image"
                                        loading="lazy"
                                        onerror="this.style.display='none';this.nextElementSibling.style.display='grid';">
                                    <div class="image-fallback" style="display:none">
                                        <span class="fallback-icon">✦</span>
                                        <small>ShopSphere</small>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="image-fallback">
                                        <span class="fallback-icon">✦</span>
                                        <small>ShopSphere</small>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <span class="image-caption">SHOPSPHERE PICK</span>
                        </div>

                        <div class="product-info">
                            <p class="product-brand">
                                <c:out value="${p.brand}"/>
                            </p>

                            <h3 class="product-name">
                                <c:out value="${p.name}"/>
                            </h3>

                            <p class="product-description">
                                <c:out value="${p.description}"/>
                            </p>

                            <div class="price-row">
                                <span class="product-price">
                                    &#8377;<c:out value="${p.finalPrice}"/>
                                </span>

                                <c:if test="${p.discount gt 0}">
                                    <del class="original-price">
                                        &#8377;<c:out value="${p.price}"/>
                                    </del>
                                </c:if>
                            </div>

                            <c:choose>
                                <c:when test="${p.stock gt 0}">
                                    <p class="stock-status in-stock">
                                        <span class="stock-dot"></span> In stock (<c:out value="${p.stock}"/>)
                                    </p>
                                </c:when>
                                <c:otherwise>
                                    <p class="stock-status out-stock">
                                        <span class="stock-dot"></span> Out of stock
                                    </p>
                                </c:otherwise>
                            </c:choose>

                            <a class="product-details"
                               href="${pageContext.request.contextPath}/product?id=${p.productId}">
                                <span>View Details</span>
                                <span class="arrow-icon" aria-hidden="true">→</span>
                            </a>
                        </div>
                    </article>
                </c:forEach>

            </section>

            <div id="emptyFilterMessage" class="no-products" hidden>
                <div class="empty-icon">🔍</div>
                <h3>No matching products</h3>
                <p>Try selecting another category or resetting your search filters.</p>
                <button type="button" class="btn btn-primary"
                        id="emptyReset">Show all products</button>
            </div>

        </c:when>

        <c:otherwise>
            <div class="no-products">
                <div class="empty-icon">🛍️</div>
                <h3>No products found</h3>
                <p>We couldn't find any products matching your criteria.</p>
                <a class="btn btn-primary"
                   href="${pageContext.request.contextPath}/products">
                    Browse all products
                </a>
            </div>
        </c:otherwise>
    </c:choose>

</main>

<script>
(function () {
    const grid = document.getElementById("productGrid");
    if (!grid) return;

    const count = document.getElementById("productCount");
    const sort = document.getElementById("productSort");
    const cards = Array.from(grid.querySelectorAll(".product-card"));
    const emptyMessage = document.getElementById("emptyFilterMessage");
    const filterButtons = document.querySelectorAll(".filter-btn");
    let selectedCategory = "all";

    function updateProducts() {
        const query = new URLSearchParams(window.location.search)
            .get("q") || "";
        const search = query.trim().toLowerCase();
        const visibleCards = [];

        cards.forEach(function (card) {
            const categoryMatch =
                selectedCategory === "all" ||
                card.dataset.category === selectedCategory;

            const searchText = (
                (card.dataset.name || "") + " " +
                (card.querySelector(".product-brand")?.textContent || "") + " " +
                (card.querySelector(".product-description")?.textContent || "")
            ).toLowerCase();

            const searchMatch = !search || searchText.includes(search);
            const visible = categoryMatch && searchMatch;

            card.hidden = !visible;
            if (visible) {
                card.style.display = "";
                visibleCards.push(card);
            } else {
                card.style.display = "none";
            }
        });

        visibleCards.sort(function (a, b) {
            const priceA = Number(a.dataset.price) || 0;
            const priceB = Number(b.dataset.price) || 0;
            const nameA = (a.dataset.name || "").toLowerCase();
            const nameB = (b.dataset.name || "").toLowerCase();

            switch (sort.value) {
                case "price-low": return priceA - priceB;
                case "price-high": return priceB - priceA;
                case "name": return nameA.localeCompare(nameB);
                default: return cards.indexOf(a) - cards.indexOf(b);
            }
        });

        visibleCards.forEach(function (card) {
            grid.appendChild(card);
        });

        if (count) {
            count.textContent = visibleCards.length;
        }
        if (emptyMessage) {
            emptyMessage.hidden = visibleCards.length !== 0;
            emptyMessage.style.display = visibleCards.length === 0 ? "block" : "none";
        }
        grid.hidden = visibleCards.length === 0;
        grid.style.display = visibleCards.length === 0 ? "none" : "grid";
    }

    filterButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            selectedCategory = button.dataset.category;

            filterButtons.forEach(function (item) {
                const active = item === button;
                item.classList.toggle("active", active);
                item.setAttribute("aria-pressed", String(active));
            });

            updateProducts();
        });
    });

    if (sort) {
        sort.addEventListener("change", updateProducts);
    }

    function resetFilters() {
        selectedCategory = "all";
        if (sort) sort.value = "default";

        filterButtons.forEach(function (button) {
            const active = button.dataset.category === "all";
            button.classList.toggle("active", active);
            button.setAttribute("aria-pressed", String(active));
        });

        updateProducts();
    }

    const resetBtn = document.getElementById("resetFilters");
    if (resetBtn) resetBtn.addEventListener("click", resetFilters);

    const emptyResetBtn = document.getElementById("emptyReset");
    if (emptyResetBtn) emptyResetBtn.addEventListener("click", resetFilters);

    filterButtons.forEach(function (button) {
        button.setAttribute(
            "aria-pressed",
            String(button.dataset.category === "all")
        );
    });

    updateProducts();
})();
</script>

<%@ include file="fragments/footer.jsp" %>
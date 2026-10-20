package com.shopsphere.controller;

import com.shopsphere.model.CartItem;
import com.shopsphere.model.Product;
import com.shopsphere.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private final ProductService products = new ProductService();
    @SuppressWarnings("unchecked")
    private Map<Integer, CartItem> cart(HttpSession session) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) { cart = new LinkedHashMap<>(); session.setAttribute("cart", cart); }
        return cart;
    }
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<Integer, CartItem> cart = cart(req.getSession());
        req.setAttribute("cartItems", cart.values());
        double total = cart.values().stream().mapToDouble(CartItem::getSubtotal).sum();
        req.setAttribute("cartTotal", total);
        req.setAttribute("cartCount", cart.values().stream().mapToInt(CartItem::getQuantity).sum());
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = cart(session);
        String action = req.getParameter("action");
        try {
            int id = Integer.parseInt(req.getParameter("productId"));
            if ("remove".equals(action)) { cart.remove(id); }
            else if ("update".equals(action)) {
                CartItem item = cart.get(id);
                if (item != null) { int q = Integer.parseInt(req.getParameter("quantity")); if (q <= 0) cart.remove(id); else if (q <= item.getProduct().getStock()) item.setQuantity(q); }
            } else {
                Product product = products.get(id);
                if (product == null || product.getStock() < 1) { resp.sendRedirect(req.getContextPath()+"/products?error=unavailable"); return; }
                int q = Math.max(1, Integer.parseInt(req.getParameter("quantity")));
                CartItem item = cart.get(id);
                int next = q + (item == null ? 0 : item.getQuantity());
                if (next > product.getStock()) next = product.getStock();
                if (item == null) { item = new CartItem(); item.setProductId(id); item.setProduct(product); cart.put(id, item); }
                item.setQuantity(next);
            }
            resp.sendRedirect(req.getContextPath()+"/cart");
        } catch (NumberFormatException ex) { resp.sendRedirect(req.getContextPath()+"/products"); }
        catch (Exception ex) { throw new ServletException("Unable to update cart", ex); }
    }
}

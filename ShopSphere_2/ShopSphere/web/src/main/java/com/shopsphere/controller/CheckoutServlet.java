package com.shopsphere.controller;

import com.shopsphere.model.CartItem;
import com.shopsphere.model.User;
import com.shopsphere.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");
        Map<Integer, CartItem> cart = session == null ? null : (Map<Integer, CartItem>) session.getAttribute("cart");
        if (user == null) { resp.sendRedirect(req.getContextPath()+"/login.jsp"); return; }
        if (cart == null || cart.isEmpty()) { resp.sendRedirect(req.getContextPath()+"/cart?error=empty"); return; }
        try (Connection c = DBConnection.getConnection()) {
            c.setAutoCommit(false);
            try {
                double total = 0;
                for (CartItem item : cart.values()) {
                    try (PreparedStatement ps = c.prepareStatement("SELECT stock, price, discount FROM products WHERE product_id=? AND status=1 FOR UPDATE")) {
                        ps.setInt(1, item.getProductId());
                        try (ResultSet rs = ps.executeQuery()) {
                            if (!rs.next() || rs.getInt("stock") < item.getQuantity()) throw new IllegalStateException("Stock changed for " + item.getProduct().getName());
                            double price = rs.getDouble("price");
                            double discount = rs.getDouble("discount");
                            total += (price - price * discount / 100.0) * item.getQuantity();
                        }
                    }
                }
                int orderId;
                try (PreparedStatement ps = c.prepareStatement("INSERT INTO orders(user_id,total_amount,discount,payment_method,payment_status,order_status) VALUES(?,?,0,'Cash on Delivery','Pending','Placed')", Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, user.getUserId()); ps.setDouble(2, total); ps.executeUpdate();
                    try (ResultSet keys = ps.getGeneratedKeys()) { if (!keys.next()) throw new IllegalStateException("Could not create order"); orderId = keys.getInt(1); }
                }
                for (CartItem item : cart.values()) {
                    double price = item.getProduct().getFinalPrice();
                    try (PreparedStatement ps = c.prepareStatement("INSERT INTO order_items(order_id,product_id,quantity,price) VALUES(?,?,?,?)")) {
                        ps.setInt(1, orderId); ps.setInt(2, item.getProductId()); ps.setInt(3, item.getQuantity()); ps.setDouble(4, price); ps.executeUpdate();
                    }
                    try (PreparedStatement ps = c.prepareStatement("UPDATE products SET stock=stock-? WHERE product_id=? AND stock>=?")) {
                        ps.setInt(1, item.getQuantity()); ps.setInt(2, item.getProductId()); ps.setInt(3, item.getQuantity());
                        if (ps.executeUpdate() != 1) throw new IllegalStateException("Stock changed during checkout");
                    }
                }
                c.commit();
                cart.clear();
                session.setAttribute("lastOrderId", orderId);
                resp.sendRedirect(req.getContextPath()+"/order-success.jsp");
            } catch (Exception ex) { c.rollback(); req.setAttribute("checkoutError", ex.getMessage()); req.setAttribute("cartItems", cart.values()); req.setAttribute("cartTotal", cart.values().stream().mapToDouble(CartItem::getSubtotal).sum()); req.getRequestDispatcher("/cart.jsp").forward(req, resp); }
            finally { c.setAutoCommit(true); }
        } catch (Exception ex) { throw new ServletException("Checkout failed. Check MySQL connection and database schema.", ex); }
    }
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException { resp.sendRedirect(req.getContextPath()+"/cart"); }
}

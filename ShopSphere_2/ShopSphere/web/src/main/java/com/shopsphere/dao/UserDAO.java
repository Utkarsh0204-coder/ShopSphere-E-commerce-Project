package com.shopsphere.dao;

import com.shopsphere.model.User;
import com.shopsphere.util.DBConnection;
import java.sql.*;

public class UserDAO {

    public User login(String email, String hashedPass, String plainPass, String role) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ? AND (password = ? OR password = ?) AND role = ? AND status = 1";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, email);
            p.setString(2, hashedPass);
            p.setString(3, plainPass);
            p.setString(4, role);
            try (ResultSet r = p.executeQuery()) {
                if (!r.next()) return null;
                User u = new User();
                u.setUserId(r.getInt("user_id"));
                u.setName(r.getString("name"));
                u.setEmail(r.getString("email"));
                u.setRole(r.getString("role"));
                return u;
            }
        }
    }

    public boolean exists(String email) throws SQLException {
        String sql = "SELECT user_id FROM users WHERE email = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, email);
            try (ResultSet r = p.executeQuery()) {
                return r.next();
            }
        }
    }

    public void save(User u) throws SQLException {
        String sql = "INSERT INTO users(name, email, password, mobile, role) VALUES(?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, u.getName());
            p.setString(2, u.getEmail());
            p.setString(3, u.getPassword());
            p.setString(4, u.getMobile());
            p.setString(5, u.getRole() != null ? u.getRole() : "CUSTOMER");
            p.executeUpdate();
        }
    }
}

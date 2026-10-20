package com.shopsphere.service;

import com.shopsphere.dao.UserDAO;
import com.shopsphere.model.User;
import java.security.MessageDigest;

public class UserService {
    private final UserDAO dao = new UserDAO();

    private String hash(String s) throws Exception {
        if (s == null) return "";
        byte[] b = MessageDigest.getInstance("SHA-256").digest(s.getBytes());
        StringBuilder x = new StringBuilder();
        for (byte v : b) x.append(String.format("%02x", v));
        return x.toString();
    }

    public User login(String email, String password, String role) throws Exception {
        return dao.login(email, hash(password), password, role);
    }

    public boolean register(User u) throws Exception {
        if (dao.exists(u.getEmail())) return false;
        u.setPassword(hash(u.getPassword()));
        dao.save(u);
        return true;
    }
}

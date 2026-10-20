package com.shopsphere.dao;
import com.shopsphere.model.Product;
import com.shopsphere.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class ProductDAO {
    private Product map(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("product_id"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setName(rs.getString("name"));
        product.setBrand(rs.getString("brand"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setDiscount(rs.getDouble("discount"));
        product.setStock(rs.getInt("stock"));
        product.setImageUrl(rs.getString("image_url"));
        return product;
    }
    public List<Product> findAll(String query) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql =
            "SELECT * FROM products " +
            "WHERE status = 1 " +
            "AND (? = '' OR name LIKE ? OR brand LIKE ? " +
            "OR description LIKE ?) " +
            "ORDER BY product_id DESC";
        String search = query == null ? "" : query.trim();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                 connection.prepareStatement(sql)) {
            String pattern = "%" + search + "%";
            statement.setString(1, search);
            statement.setString(2, pattern);
            statement.setString(3, pattern);
            statement.setString(4, pattern);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    products.add(map(rs));
                }
            }
        }
        return products;
    }
    public Product find(int id) throws SQLException {
        String sql =
            "SELECT * FROM products WHERE product_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                 connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }
}

package com.shopsphere.service;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;
import java.util.*;

public class ProductService {
    private final ProductDAO d = new ProductDAO();

    public List<Product> all(String q) throws Exception {
        return d.findAll(q);
    }

    public Product get(int id) throws Exception {
        return d.find(id);
    }
}

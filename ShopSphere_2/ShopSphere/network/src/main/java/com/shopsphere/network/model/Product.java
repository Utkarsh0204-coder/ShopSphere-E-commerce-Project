package com.shopsphere.network.model;
import java.io.Serializable;
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;
    public int id;
    public int stock;
    public String name;
    public double price;
    public Product() {
    }
    public Product(int id, String name, double price, int stock) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.stock = stock;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }
    @Override
    public String toString() {
        return id + " | " + name + " | ₹" + price + " | stock=" + stock;
    }
}

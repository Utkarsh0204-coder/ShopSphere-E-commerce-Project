package com.shopsphere.model;

import java.io.Serializable;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Product data used by the ShopSphere catalogue and product detail page.
 * The extra presentation details are derived from the product's name/category,
 * so they work for every item without requiring a database schema migration.
 */
public class Product implements Serializable {
    private int productId, categoryId, stock;
    private String name, brand, description, imageUrl;
    private double price, discount;

    public int getProductId() { return productId; }
    public void setProductId(int x) { productId = x; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int x) { categoryId = x; }
    public int getStock() { return stock; }
    public void setStock(int x) { stock = x; }
    public String getName() { return name; }
    public void setName(String x) { name = x; }
    public String getBrand() { return brand; }
    public void setBrand(String x) { brand = x; }
    public String getDescription() { return description; }
    public void setDescription(String x) { description = x; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String x) { imageUrl = x; }
    public double getPrice() { return price; }
    public void setPrice(double x) { price = x; }
    public double getDiscount() { return discount; }
    public void setDiscount(double x) { discount = x; }
    public double getFinalPrice() { return price - price * discount / 100.0; }

    public String getCategoryName() {
        switch (categoryId) {
            case 1: return "Electronics";
            case 2: return "Fashion";
            case 3: return "Home & Living";
            default: return "General";
        }
    }

    /** Highlights are tailored to the seeded catalogue; unknown products get safe defaults. */
    public List<String> getHighlights() {
        String key = name == null ? "" : name.toLowerCase();
        switch (key) {
            case "bluetooth speaker": return Arrays.asList("Portable audio for music, podcasts and videos", "Wireless listening without a wired audio connection", "Compact design for desk, room or travel use");
            case "gaming headset": return Arrays.asList("Over-ear style for extended gaming sessions", "Designed for gaming, voice chat and media", "Store in a dry place and avoid pulling the cable");
            case "laptop": return Arrays.asList("Suitable for study, office work and everyday productivity", "Portable computer for working at home or on the move", "Keep vents clear and use on a hard, flat surface");
            case "gaming controller": return Arrays.asList("Hands-on controls for compatible games", "Useful for racing, sports and action titles", "Check device compatibility before purchase");
            case "digital camera": return Arrays.asList("Made for travel, events and everyday photography", "Dedicated camera controls for taking photos", "Protect the lens and store away from moisture");
            case "smartphone": return Arrays.asList("Everyday device for communication and apps", "Suitable for browsing, photos and entertainment", "Use a compatible charger and protective case");
            case "classic t-shirt": return Arrays.asList("Easy everyday style for casual outfits", "Pairs with jeans, trousers and shorts", "Follow the garment care label when washing");
            case "casual sneakers": return Arrays.asList("Versatile footwear for everyday casual wear", "Pairs easily with jeans and daily outfits", "Choose your usual fit and keep away from excess moisture");
            case "backpack": return Arrays.asList("Useful for college, commuting and short trips", "Carry books, accessories and everyday essentials", "Distribute weight evenly and do not overfill");
            case "classic denim jacket": return Arrays.asList("Timeless outer layer for casual outfits", "Easy to pair with T-shirts and denim", "Check the garment label for washing instructions");
            case "aviator sunglasses": return Arrays.asList("Classic aviator-inspired everyday style", "Lightweight accessory for outdoor use", "Keep lenses in a protective case to reduce scratches");
            case "analog wristwatch": return Arrays.asList("Classic analogue look for casual or formal wear", "Easy accessory to pair with daily outfits", "Avoid water exposure unless the product is marked water-resistant");
            case "table lamp": return Arrays.asList("Adds focused light to a desk or bedside table", "Useful for reading, studying or ambient lighting", "Use a compatible bulb and keep away from wet surfaces");
            case "indoor plant pot": return Arrays.asList("Decorative container for indoor plants", "Fits desks, shelves and other home spaces", "Choose a plant and liner suitable for the pot");
            case "coffee maker": return Arrays.asList("Designed for preparing coffee at home", "Convenient for a morning or work-break routine", "Clean after use and follow the supplied instructions");
            case "decorative cushion": return Arrays.asList("Adds a soft decorative accent to sofas and beds", "Works with living-room and bedroom décor", "Check the care label before washing the cover");
            case "wall clock": return Arrays.asList("Helps keep time while decorating a room", "Suitable for living rooms, bedrooms or offices", "Use a secure wall fixing and compatible battery if required");
            case "desk organizer": return Arrays.asList("Keeps stationery and small desk items together", "Useful for study tables and home-office setups", "Sort items by size for a tidier workspace");
            default: return Arrays.asList(
                "Selected from the ShopSphere " + getCategoryName() + " collection",
                "Brand: " + safe(brand, "ShopSphere"),
                "Check the product description and compatibility before ordering");
        }
    }

    /** Transparent catalogue facts; avoids inventing exact measurements or warranties. */
    public Map<String, String> getSpecifications() {
        Map<String, String> specs = new LinkedHashMap<>();
        specs.put("Product ID", "SS-" + productId);
        specs.put("Brand", safe(brand, "Not specified"));
        specs.put("Category", getCategoryName());
        specs.put("Availability", stock > 0 ? "In stock" : "Currently out of stock");
        specs.put("Available quantity", String.valueOf(Math.max(stock, 0)) + " unit(s)");
        specs.put("Discount", String.format(java.util.Locale.ROOT, "%.1f%%", discount));
        specs.put("Price before discount", String.format(java.util.Locale.ROOT, "₹%.2f", price));
        specs.put("Current price", String.format(java.util.Locale.ROOT, "₹%.2f", getFinalPrice()));
        specs.put("Product description", safe(description, "See product details"));
        return specs;
    }

    private static String safe(String value, String fallback) {
        return value == null || value.trim().isEmpty() ? fallback : value.trim();
    }
}

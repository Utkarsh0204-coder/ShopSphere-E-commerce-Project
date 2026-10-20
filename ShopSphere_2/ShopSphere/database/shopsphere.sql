-- ShopSphere demo database. Safe to re-run: tables are not dropped.
-- For a completely fresh schema, use an empty shopsphere database.
CREATE DATABASE IF NOT EXISTS shopsphere CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; USE shopsphere;
CREATE TABLE IF NOT EXISTS users(user_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(100) NOT NULL,email VARCHAR(150) UNIQUE NOT NULL,password VARCHAR(255) NOT NULL,mobile VARCHAR(20),role ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',status BOOLEAN DEFAULT TRUE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS categories(category_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(100) NOT NULL UNIQUE,description VARCHAR(255),status BOOLEAN DEFAULT TRUE);
CREATE TABLE IF NOT EXISTS products(product_id INT PRIMARY KEY AUTO_INCREMENT,category_id INT,name VARCHAR(150) NOT NULL,brand VARCHAR(100),description TEXT,price DECIMAL(10,2) NOT NULL,discount DECIMAL(5,2) DEFAULT 0,stock INT DEFAULT 0,image_url VARCHAR(500),status BOOLEAN DEFAULT TRUE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,UNIQUE KEY uq_product_brand(name,brand),FOREIGN KEY(category_id) REFERENCES categories(category_id) ON DELETE SET NULL);
CREATE TABLE IF NOT EXISTS cart(cart_id INT PRIMARY KEY AUTO_INCREMENT,user_id INT NOT NULL,product_id INT NOT NULL,quantity INT NOT NULL,UNIQUE(user_id,product_id),FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE,FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE);
CREATE TABLE IF NOT EXISTS orders(order_id INT PRIMARY KEY AUTO_INCREMENT,user_id INT NOT NULL,total_amount DECIMAL(10,2) NOT NULL,discount DECIMAL(10,2) DEFAULT 0,payment_method VARCHAR(30),payment_status VARCHAR(30),order_status VARCHAR(30),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(user_id));
CREATE TABLE IF NOT EXISTS order_items(order_item_id INT PRIMARY KEY AUTO_INCREMENT,order_id INT NOT NULL,product_id INT NOT NULL,quantity INT NOT NULL,price DECIMAL(10,2) NOT NULL,FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE,FOREIGN KEY(product_id) REFERENCES products(product_id));
INSERT INTO users(name,email,password,mobile,role) VALUES('Admin','admin@shopsphere.com','admin123','9999999999','ADMIN'),('Demo User','user@shopsphere.com','user123','8888888888','CUSTOMER');
INSERT INTO categories(name,description) VALUES('Electronics','Gadgets'),('Fashion','Clothing'),('Home','Home products');
INSERT INTO products
(category_id, name, brand, description, price, discount, stock, image_url)
VALUES
(1, 'Bluetooth Speaker', 'SoundMax',
 'Portable speaker with rich stereo sound',
 1999.00, 10.00, 25,
 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1'),

(1, 'Gaming Headset', 'GamePro',
 'Over-ear gaming headset with a comfortable fit',
 2799.00, 15.00, 18,
 'https://images.unsplash.com/photo-1599669454699-248893623440'),

(1, 'Laptop', 'TechNova',
 'Lightweight laptop for study and productivity',
 54999.00, 5.00, 8,
 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853'),

(1, 'Gaming Controller', 'PlayCore',
 'Wireless controller for compatible gaming devices',
 2499.00, 12.00, 22,
 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3'),

(1, 'Digital Camera', 'PixelPro',
 'Digital camera for travel and everyday photography',
 32999.00, 8.00, 6,
 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32'),

(1, 'Smartphone', 'NovaMobile',
 'Modern smartphone with a high-resolution display',
 24999.00, 7.00, 15,
 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'),


(2, 'Classic T-Shirt', 'UrbanWear',
 'Comfortable everyday cotton T-shirt',
 699.00, 10.00, 50,
 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab'),

(2, 'Casual Sneakers', 'StreetStep',
 'Versatile sneakers for everyday wear',
 2499.00, 15.00, 24,
 'https://images.unsplash.com/photo-1542291026-7eec264c27ff'),

(2, 'Backpack', 'CarryPro',
 'Spacious backpack for college and travel',
 1599.00, 10.00, 30,
 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62'),

(2, 'Classic Denim Jacket', 'DenimWorks',
 'Everyday denim jacket with a timeless design',
 2299.00, 12.00, 16,
 'https://images.unsplash.com/photo-1543076447-215ad9ba6923'),

(2, 'Aviator Sunglasses', 'SunStyle',
 'Lightweight sunglasses for everyday outdoor use',
 999.00, 8.00, 35,
 'https://images.unsplash.com/photo-1511499767150-a48a237f0083'),

(2, 'Analog Wristwatch', 'TimeCraft',
 'Classic wristwatch for casual and formal outfits',
 1899.00, 10.00, 20,
 'https://images.unsplash.com/photo-1524592094714-0f0654e20314'),


(3, 'Table Lamp', 'GlowHome',
 'Modern table lamp for bedrooms and study desks',
 1299.00, 10.00, 20,
 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c'),

(3, 'Indoor Plant Pot', 'GreenNest',
 'Decorative planter for indoor spaces',
 499.00, 5.00, 40,
 'https://images.unsplash.com/photo-1485955900006-10f4d324d411'),

(3, 'Coffee Maker', 'BrewMate',
 'Compact coffee maker for home use',
 3499.00, 12.00, 12,
 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085'),

(3, 'Decorative Cushion', 'CozyLiving',
 'Soft decorative cushion for sofas and beds',
 599.00, 5.00, 30,
 'https://images.unsplash.com/photo-1584100936595-c0654b55a2e2'),

(3, 'Wall Clock', 'TimeHome',
 'Minimalist wall clock for modern interiors',
 899.00, 10.00, 18,
 'https://images.unsplash.com/photo-1563861826100-9cb868fdbe1c'),

(3, 'Desk Organizer', 'OrganizeIt',
 'Practical organizer for stationery and desk accessories',
 399.00, 5.00, 45,
 'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85');
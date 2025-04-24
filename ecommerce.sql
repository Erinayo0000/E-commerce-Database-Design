CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    logo_url VARCHAR(512)
);

CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10,2),
    description TEXT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(512) NOT NULL,
    alt_text VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE product_item (
    product_item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    sku VARCHAR(100) NOT NULL UNIQUE,
    stock_quantity INT DEFAULT 0,
    price_override DECIMAL(10,2),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hex_code VARCHAR(7)
);

CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT,
    value VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    name VARCHAR(100) NOT NULL,
    value VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);



-- Sample_data
-- Insert Brands
INSERT INTO brand (name, description, logo_url) VALUES
('Nike', 'Sportswear and accessories', 'https://example.com/nike-logo.png'),
('Apple', 'Electronics and software', 'https://example.com/apple-logo.png');

-- Insert Product Categories
INSERT INTO product_category (name, description) VALUES
('Clothing', 'All kinds of wearable items'),
('Electronics', 'Devices and gadgets');

-- Insert Products
INSERT INTO product (name, brand_id, category_id, base_price, description) VALUES
('Air Max Sneakers', 1, 1, 120.00, 'Comfortable running shoes'),
('iPhone 14', 2, 2, 999.99, 'Latest Apple smartphone');

-- Insert Product Images
INSERT INTO product_image (product_id, image_url, alt_text) VALUES
(1, 'https://example.com/air-max.jpg', 'Nike Air Max'),
(2, 'https://example.com/iphone14.jpg', 'iPhone 14');

-- Insert Product Items
INSERT INTO product_item (product_id, sku, stock_quantity, price_override, is_active) VALUES
(1, 'NK-AM-001', 50, NULL, TRUE),
(2, 'APL-IP14-001', 30, 950.00, TRUE);

-- Insert Colors
INSERT INTO color (name, hex_code) VALUES
('Red', '#FF0000'),
('Black', '#000000');

-- Insert Size Categories
INSERT INTO size_category (name) VALUES
('Clothing Sizes'),
('Phone Storage');

-- Insert Size Options
INSERT INTO size_option (size_category_id, value) VALUES
(1, 'M'), (1, 'L'),
(2, '128GB'), (2, '256GB');

-- Insert Product Variations
INSERT INTO product_variation (product_item_id, color_id, size_option_id) VALUES
(1, 1, 1),
(1, 2, 2),
(2, NULL, 3);

-- Insert Attribute Categories
INSERT INTO attribute_category (name) VALUES
('Physical'), ('Technical');

-- Insert Attribute Types
INSERT INTO attribute_type (name) VALUES
('Text'), ('Number'), ('Boolean');

-- Insert Product Attributes
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, name, value) VALUES
(1, 1, 1, 'Material', 'Leather'),
(1, 1, 2, 'Weight', '0.8'),
(2, 2, 1, 'Processor', 'A16 Bionic'),
(2, 2, 2, 'Battery Life', '20');


-- sample queries
-- Get all products with their brand and category
SELECT p.name, b.name AS brand, c.name AS category
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
JOIN product_category c ON p.category_id = c.category_id;

-- Get variations for a product
SELECT pi.sku, c.name AS color, s.value AS size
FROM product_variation pv
JOIN product_item pi ON pv.product_item_id = pi.product_item_id
LEFT JOIN color c ON pv.color_id = c.color_id
LEFT JOIN size_option s ON pv.size_option_id = s.size_option_id;

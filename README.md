#  E-Commerce Database Project

This project is a collaborative group effort to design and implement a fully functional **e-commerce relational database** using SQL and ER modeling.

##  Objective

To gain practical experience in database architecture by:
- Designing an ERD
- Building tables and relationships
- Populating sample data
- Understanding real-world data modeling

---

##  ERD

![ERD Diagram](<iframe width="560" height="315" src='https://dbdiagram.io/e/6809df2b1ca52373f52698a0/680a12191ca52373f52f0855'> </iframe>)

---

## Tables Overview

- `brand` – Stores brand details
- `product_category` – Categorizes products
- `product` – Main product details
- `product_image` – Image references
- `product_item` – Specific product stock items
- `color` – Color options
- `size_category` – Size groupings (e.g. clothing, tech)
- `size_option` – Actual sizes (e.g. M, 128GB)
- `product_variation` – Links to size/color variations
- `attribute_category`, `attribute_type`, `product_attribute` – Custom product attributes

---
## Group members
1. Olusanmi Pamilerin
2.Cherozade Bhayat

##  Setup Instructions

1. Clone this repository
2. Import the SQL file into your MySQL server
3. Explore the tables and run queries

##  Files
1.ecommerce.sql – SQL script for schema and sample data
2.README.md – This file
3.ERD image 

```bash
git clone https://github.com/Erinayo0000/E-commerce-Database-Design.git


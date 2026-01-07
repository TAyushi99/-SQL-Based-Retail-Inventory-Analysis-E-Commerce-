📌 Project Overview

This project demonstrates how SQL is used in real-world retail and e-commerce inventory analysis. The focus is on working with a messy, production-like dataset, performing data exploration and cleaning, and answering business-driven questions related to pricing, inventory, stock availability, and revenue insights.

The project simulates the type of backend analysis performed by data analysts in e-commerce companies to support pricing, merchandising, and inventory decisions.

🎯 Objectives

Work with raw, unstructured retail inventory data

Perform exploratory data analysis (EDA) using SQL

Clean and standardize pricing and inventory fields

Analyze product pricing, discounts, stock availability, and category performance

Derive actionable business insights using SQL queries

📁 Dataset Source

The dataset used in this project was sourced from Kaggle and represents an e-commerce inventory system similar to quick-commerce platforms.

The data was originally scraped from real product listings

Each row represents a unique SKU (Stock Keeping Unit)

Duplicate product names exist due to variations in:

Package size

Weight

Discount percentage

Category placement

This closely reflects how real-world retail catalog data is structured.

🧾 Dataset Schema

Key columns included in the dataset:

sku_id – Unique identifier for each SKU

name – Product name

category – Product category (Fruits, Snacks, Beverages, etc.)

mrp – Maximum Retail Price (converted from paise to ₹)

discount_percent – Discount applied on MRP

discounted_price – Final selling price

available_quantity – Units available in inventory

weight_in_gms – Product weight

out_of_stock – Stock availability indicator

quantity – Units per package

🗄️ Database Setup

A structured table was created in PostgreSQL to store and analyze the data:

CREATE TABLE zepto (
  sku_id SERIAL PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp NUMERIC(8,2),
  discount_percent NUMERIC(5,2),
  available_quantity INTEGER,
  discounted_price NUMERIC(8,2),
  weight_in_gms INTEGER,
  out_of_stock BOOLEAN,
  quantity INTEGER
);

📥 Data Loading

The dataset was imported into PostgreSQL using pgAdmin

Encoding issues were resolved by converting the CSV file to UTF-8 format

Data ingestion was validated using record counts and sample queries

🔍 Exploratory Data Analysis (EDA)

SQL queries were used to:

Count total SKUs and product categories

Identify missing and inconsistent values

Compare in-stock vs out-of-stock products

Detect duplicate product names representing multiple SKUs

Explore pricing and discount distributions

🧹 Data Cleaning & Standardization

Data cleaning steps included:

Removing rows with invalid pricing values (zero or null MRP / selling price)

Converting pricing fields from paise to rupees for consistency

Validating discount calculations and stock indicators

📊 Business Insights Using SQL

The analysis focused on answering practical business questions such as:

Which products offer the highest discount value?

Which high-MRP products are currently out of stock?

What is the estimated revenue potential by category?

Which expensive products offer minimal discounts?

Which categories provide the highest average discounts?

What products offer the best price-per-gram value?

How does inventory weight vary across categories?


🛠️ Tools Used

PostgreSQL

SQL

pgAdmin

CSV (Kaggle dataset)

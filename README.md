# 🍽️ Swiggy Customer Behavior & Sales Analysis

Analyzing customer ordering patterns, pricing behavior, and restaurant performance using SQL and Excel to generate actionable business insights.

---

## 📌 Table of Contents

* Overview
* Business Problem
* Dataset
* Tools & Technologies
* Project Structure
* Data Cleaning & Preparation
* Data Modeling
* Key Analysis Performed
* Key Insights
* Final Recommendations
* How to Run This Project
* Conclusion
* Author

---

## 📊 Overview

This project analyzes 197,000+ Swiggy food delivery transactions to understand customer behavior, sales performance, and demand patterns.
The goal is to extract actionable business insights that can help improve pricing strategy, customer targeting, and operational efficiency.

---

## Objective

Understand customer ordering behavior patterns
Identify peak demand hours and seasonal trends
Analyze top-performing cuisines, cities, and restaurants
Study pricing distribution and customer spending behavior
Generate insights for business decision-making

---
## 🎯 Business Problem

* Identify top-performing cities and restaurants
* Understand customer spending behavior
* Analyze demand across food categories
* Evaluate the impact of ratings on orders

---

## 📂 Dataset

Size: 197,431+ transaction records
Contains: Orders, customers, restaurants, pricing, ratings, timestamps
Type: Structured transactional data

---

## 🛠️ Tools & Technologies

* SQL → Data cleaning, transformation, and analysis
* Excel → Data validation and initial exploration

---

## 📁 Project Structure

swiggy-customer-behavior-analysis/
│
├── README.md
├── swiggy_analysis.sql
├── swiggy_data.csv (optional)
├── Swiggy_Report.docx

---

## 🧹 Data Cleaning & Preparation

* Removed null and missing values in key fields (city, restaurant, date)
*Eliminated duplicate records using SQL techniques
*Standardized categorical values (cuisine, location, category)
*Ensured data consistency for accurate analysis
---

## 🏗️ Data Modeling

* Implemented Star Schema
* Dimension Tables: Date, Location, Restaurant, Category, Dish
* Fact Table: Orders

---

## 📊 Key Analysis Performed

* Total Orders and Revenue
* Monthly, Quarterly, and Yearly Trends
* Top Cities and Restaurants
* Category and Dish Performance
* Price Range Distribution
* Ratings Analysis

---

## 📊 Key Insights

* Majority of orders fall in ₹100–₹300 range
* Orders are concentrated in a few major cities
* Popular categories dominate customer demand
* Higher-rated dishes tend to receive more orders
* Indian and Chinese cuisines dominate overall order volume

---

## 🎯 Final Recommendations

* Increase delivery workforce during peak hours (8–10 PM)
*Focus promotional offers on mid-range pricing segment (₹100–₹300)
*Strengthen partnerships with high-performing restaurants
*Optimize marketing strategies for top cuisines (Indian & Chinese)
*Improve supply chain efficiency during high-demand periods
---
## 🧱 SQL Concepts Used

*Joins
*GROUP BY
*Aggregations (SUM, COUNT, AVG)
*Filtering (WHERE conditions)
*Time-based analysis
*Data segmentation

---

## ⚙️ How to Run This Project

1. Load dataset into SQL database
2. Run `swiggy_analysis.sql` file
3. Analyze outputs using SQL queries
4. Use Excel for additional validation (optional)

---

## 📌 Key Takeaway

This project demonstrates how raw transactional data can be transformed into business intelligence insights that support decision-making in pricing, marketing, and operations.

## 📌 Conclusion

This project demonstrates how SQL and structured data modeling can be used to extract meaningful insights and support business decisions in the food delivery domain.

---

## 👩‍💻 Author

Shraddha
Aspiring Data Analyst

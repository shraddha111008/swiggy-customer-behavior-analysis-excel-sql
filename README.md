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

This project analyzes Swiggy food delivery data to understand customer behavior, pricing trends, and order patterns.

The goal is to identify key business drivers such as top-performing cities, popular food categories, and customer spending habits for better decision-making.

---

## 🎯 Business Problem

* Identify top-performing cities and restaurants
* Understand customer spending behavior
* Analyze demand across food categories
* Evaluate the impact of ratings on orders

---

## 📂 Dataset

* Dataset contains food delivery records including:

  * State, City, Restaurant, Category, Dish
  * Price, Ratings, and Order details
* Data was cleaned and transformed for analysis

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

* Removed null and blank values
* Eliminated duplicate records using SQL
* Ensured consistency across all fields

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

---

## 🎯 Final Recommendations

* Focus on mid-range pricing strategy
* Expand operations in high-demand cities
* Promote high-rated dishes
* Optimize top-performing categories

---

## ⚙️ How to Run This Project

1. Load dataset into SQL database
2. Run `swiggy_analysis.sql` file
3. Analyze outputs using SQL queries
4. Use Excel for additional validation (optional)

---
## 🎯 Final Recommendations

- Focus on mid-range pricing (₹100–₹300) as it drives the majority of orders  
- Strengthen operations and marketing in high-demand cities to maximize revenue  
- Promote high-rated dishes to improve customer trust and increase order volume  
- Expand popular food categories (e.g., Indian, Chinese) to match customer demand  
- Monitor and improve low-rated dishes to enhance overall customer satisfaction  
- Use customer spending patterns to design targeted offers and discounts
  
---

## 📌 Conclusion

This project demonstrates how SQL and structured data modeling can be used to extract meaningful insights and support business decisions in the food delivery domain.

---

## 👩‍💻 Author

Shraddha
Aspiring Data Analyst

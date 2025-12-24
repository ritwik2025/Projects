# 🛒 E-commerce Exploratory Analytics & Dashboard  
> Customer Behaviour, Sales Trends & Business Insights  

---

## 📌 Executive Summary  

This project analyses **e-commerce transaction data** from a UK-based online retailer to uncover **sales trends, customer behaviour, geographic patterns, and cancellation impacts**.

Using **R for exploratory data analysis** and **Tableau for interactive dashboarding**, the project provides **actionable insights** to support marketing strategy, customer segmentation, and revenue optimisation.

The dataset spans **December 2010 to December 2011** and includes over half a million transactions.

---

## 🔎 Business Context  

E-commerce businesses rely heavily on **data-driven decision-making** to:
- Identify top-selling products  
- Understand customer behaviour  
- Detect regional sales patterns  
- Reduce revenue loss from cancellations  

This project answers:

> **How can transactional data be used to improve sales strategy, customer targeting, and operational efficiency?**

---

## 🎯 Objectives  

- Identify **top-selling products and seasonal trends**  
- Segment customers based on **purchasing behaviour**  
- Analyse **sales by country**  
- Quantify the **impact of cancelled transactions**  
- Translate insights into a **Tableau dashboard for executives**

---

## 📂 Dataset  

Source: **UCI Machine Learning Repository – Online Retail Dataset**

Fields used:
- InvoiceNo  
- StockCode  
- Description  
- Quantity  
- InvoiceDate  
- UnitPrice  
- CustomerID  
- Country  

The data contains both **completed and cancelled transactions**.

---

## ⚙️ Analytical Workflow  

The project followed a structured pipeline:

1. Data import and cleaning  
2. Missing value diagnostics  
3. Time-series preparation  
4. Product-level sales analysis  
5. Customer segmentation using clustering  
6. Country-level sales analysis  
7. Cancellation impact analysis  
8. Dashboard design in Tableau  

---

## 📊 Key Insights  

### 1️⃣ Product Performance  

The most popular product by total quantity sold was:

**WORLD WAR 2 GLIDERS ASSTD DESIGNS**

Top-selling products were tracked over time to identify:
- Popularity trends  
- Seasonal patterns  
- Sales volatility  

These insights support **inventory planning and promotion strategy**.

---

### 2️⃣ Customer Segmentation  

Customers were segmented using:
- **Total number of purchases**
- **Total spending**

Hierarchical clustering grouped customers into **five distinct segments**, allowing the retailer to:
- Identify high-value customers  
- Detect infrequent buyers  
- Design targeted marketing campaigns  

---

### 3️⃣ Geographic Sales Patterns  

Sales were analysed across all countries in the dataset.

Key finding:
> **The UK contributes the majority of total sales**

This highlights:
- Strong domestic market dependence  
- Opportunities to grow internationally  
- The need for country-specific marketing strategies  

---

### 4️⃣ Impact of Cancellations  

Cancelled transactions (InvoiceNo starting with **“C”**) were isolated and analysed.

Results show:
- Cancellations reduce effective revenue  
- Some time periods experience higher cancellation activity  
- Tracking cancellations helps identify operational or customer-experience issues  

This enables better:
- Order management  
- Refund policies  
- Customer satisfaction strategies  

---

## 🧠 Business Value  

This project enables retailers to:

- Optimise **inventory and product promotion**  
- Improve **customer targeting**  
- Identify **high-value customers**  
- Reduce revenue loss from **cancellations**  
- Support **data-driven executive decisions**

---

## ⚠️ Limitations  

- External factors (economy, holidays, promotions) are not included  
- No marketing or website behaviour data  
- Customer demographics not available  

---

## 🔮 Future Enhancements  

- Predictive sales forecasting  
- Basket analysis for product bundling  
- Customer lifetime value modelling  
- Real-time dashboards  

---

## 🛠️ Tools & Technologies  

- **R (tidyverse, dplyr, ggplot2, lubridate)**  
- **Tableau Desktop**  
- Exploratory data analysis  
- Customer clustering  
- Interactive dashboarding  

---

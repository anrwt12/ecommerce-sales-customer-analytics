# ecommerce-sales-customer-analytics

## 📌 Project Overview

This project analyzes an Indian e-commerce business using SQL to understand sales performance, customer behavior, product performance, inventory risks, and regional trends.

The goal is to transform raw e-commerce data into meaningful business insights that can support better decisions related to revenue, customers, products, inventory, and operations.

---

## 🎯 Business Objectives

- Measure overall business performance
- Identify revenue and sales trends
- Analyze product and category performance
- Understand customer behavior
- Identify high-performing states and cities
- Detect potential overstock and stockout risks
- Analyze order cancellations and returns
- Understand payment preferences

---

## 📂 Dataset

**Dataset:** Indian E-Commerce Sales Analytics Dataset  
**Source:** Kaggle  
**Format:** CSV  
**Database:** PostgreSQL  

🔗 **[Download Dataset from Kaggle](https://www.kaggle.com/datasets/jatinkhandelwal112/indian-e-commerce-sales-analytics-dataset)**
### Dataset Files

| File | Rows | Description |
|---|---:|---|
| `customers.csv` | 40,000 | Customer information |
| `products.csv` | 2,000 | Product and inventory information |
| `sales.csv` | 250,000 | Order and transaction information |

### 🔗 Table Relationships

```text
customers
    │
    │ customer_id
    ↓
sales
    │
    │ product_id
    ↓
products

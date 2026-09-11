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



## 🗄️ PostgreSQL Data Usage

The raw e-commerce data is provided in CSV format and imported into PostgreSQL for analysis.

### Data Flow

```text
CSV Files
   │
   ├── customers.csv
   ├── products.csv
   └── sales.csv
          │
          ↓
   PostgreSQL Database
          │
          ├── customers table
          ├── products table
          └── sales table
          │
          ↓
     SQL Analysis
          │
          ↓
   Business Insights
```

### How PostgreSQL Uses the CSV Files

1. **CSV files** contain the raw customer, product, and sales data.
2. The files are **imported into PostgreSQL tables**.
3. Relationships are established using keys such as `customer_id` and `product_id`.
4. SQL queries are used to perform:

   * Data quality checks
   * Customer analysis
   * Product and category analysis
   * Revenue analysis
   * Inventory risk analysis
   * Regional analysis
   * Cancellation and return analysis
5. The results are converted into **business insights and recommendations**.

### Example

```sql
COPY customers
FROM '/path/customers.csv'
DELIMITER ','
CSV HEADER;
```

After importing the CSV, you query the PostgreSQL table:

```sql
SELECT state, SUM(total_amount) AS revenue
FROM sales
GROUP BY state
ORDER BY revenue DESC;
```

**In short:** CSV → PostgreSQL Tables → SQL Analysis → Business Insights

# 🛒 Olist E-Commerce SQL Analysis

A business intelligence analysis of 113,390 real e-commerce transactions 
from Olist, Brazil's largest online marketplace. This project answers 3 
critical business questions using advanced SQL techniques including CTEs, 
window functions, and aggregate analysis.

---

## 🎯 Business Questions Answered

| # | Question | Technique Used |
|---|----------|---------------|
| 1 | Which product categories drive the most revenue? | GROUP BY, Subqueries |
| 2 | Who are our most valuable vs at-risk customers? | CTEs, Window Functions, NTILE |
| 3 | Which states have the worst delivery performance? | DATEDIFF, CASE WHEN, CTEs |

---

## 📊 Dataset

- **Source:** Brazilian E-Commerce Public Dataset by Olist (Kaggle)
- **Size:** 113,390 orders — 2016 to 2018
- **Tables:** Single merged table with 39 columns covering orders, customers, products, sellers, payments and logistics
- **Null Values:** Zero — clean dataset ready for analysis

---

## 🔍 Key Findings

### 1. Revenue Analysis
- **Beauty & Health** is the #1 revenue category at R$1.27M — 9.33% of total platform revenue
- **Watches & Gifts** has the highest average order value at R$200 — premium, low-volume segment
- **November 2017** was the peak month at R$1.53M driven by Black Friday demand
- **Recommendation:** Prioritize Beauty & Health inventory ahead of Q4 and launch targeted Watch campaigns for high-value customers

### 2. RFM Customer Segmentation
| Segment | Customers | Avg Spend | Total Revenue |
|---------|-----------|-----------|---------------|
| Loyal Customers | 35,570 | R$340 | R$12.29M |
| At Risk | 44,361 | R$128 | R$5.68M |
| Champions | 1,938 | R$587 | R$1.13M |
| Lost Customers | 10,206 | R$59 | R$606K |

- **Biggest opportunity:** 44,361 At-Risk customers hold R$5.68M in recoverable revenue
- **Recommendation:** A targeted win-back campaign achieving just 10% recovery rate = R$568K additional revenue

### 3. Delivery & Logistics
- **Alagoas (AL)** has the worst late delivery rate at 21.3%
- **Maranhão (MA)** follows at 18.2% late rate
- Packages across all states arrive earlier than estimated on average — the platform is **over-estimating** delivery times
- **Recommendation:** Recalibrate delivery estimates for northeastern states to reduce perceived lateness without changing logistics operations

---

## 🛠️ Tools Used
- MySQL 8.0
- MySQL Workbench
- Dataset: Kaggle (CC0 Public Domain)

---

## 📁 Project Structure
olist-ecommerce-sql-analysis/
├── README.md
├── queries/
│ ├── 01_revenue_analysis.sql
│ ├── 02_rfm_segmentation.sql
│ └── 03_delivery_logistics.sql
└── insights/
└── key_findings.md

---

## 👤 Author
**Abdullah Nasir**  
Business Analytics Student @ FAST-NUCES Lahore  
abdullahnasir.anc@gmail.com  
[LinkedIn](www.linkedin.com/in/abdullah-nasir-analyst)

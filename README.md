# E-Commerce-Fraud-Analysis
### Tools: Excel, MySQL, Tableau
---
##  Table of Contents
- [Project Background](#project-background)
- [Business Objective](#business-objective)
- [Dataset Overview](#dataset-overview)
- [Initial Checks & Data Preparation](#initial-checks--data-preparation)
- [Executive Summary](#executive-summary)
- [Key Analysis & Insights](#key-analysis--insights)
- [High-Risk Customer Profile](#high-risk-customer-profile)
- [Recommendations](#recommendations)
- [KPIs to Track](#kpis-to-track)
- [Expected Impact](#expected-impact)
- [Caveats](#caveats)
---
<br/>

## **Project Background**

Souq Nest is a UAE-based e-commerce platform experiencing rapid growth driven by digital adoption, promotional campaigns and seasonal events such as New Year clearance sale, Ramadan, Eid. With increasing transaction volumes, the company observed a rising risk of fraudulent activities, prompting the need for a structured fraud detection analysis.

This fraud detection analysis conducted for Souq Nest, reporting to business and risk stakeholders, using 150,000+ transaction records of the company. The study evaluates fraud trends across signup behavior, purchase value, demographics, acquisition sources, and seasonal patterns. It identifies high-risk customer profiles and early fraud indicators that significantly exceed UAE benchmarks. The insights enable data-driven fraud prevention strategies to reduce losses while maintaining customer experience and revenue growth.

---
<br/>

## **Business Objective**

The primary objective of this analysis is to:

- Identify fraud patterns and high-risk segments.

- Quantify fraud impact across time, value, and customer dimensions.

- Support data-driven fraud prevention strategies.

- Balance fraud control with customer experience and revenue growth.

The insights generated are intended to help stakeholders:

- Improve fraud monitoring and early detection.

- Optimize risk rules and verification checks.

- Reduce financial losses without affecting genuine customers.

---
<br/>

## **Dataset Overview**

The dataset represents e-commerce transaction behavior and includes:

- 150,000+ records of trasaction in a year.

- Customer attributes (age group, gender).
- 
- Transaction details (purchase value, purchase time).

- Behavioral metrics (signup time, signup-to-purchase gap).

- Acquisition channels (Direct, Ads, SEO).

- Fraud labels (class) identifying legitimate vs fraudulent transactions.

---
<br/>

## **Initial Checks & Data Preparation**

The analysis began with preparing and validating a dataset of **150,000+** UAE e-commerce transaction records to ensure reliability for fraud detection.<br/>
The following initial data quality checks were performed to establish a clean and trustworthy analytical foundation:

- Verified overall data completeness and identified missing or inconsistent values using **Excel**.

- Detected and reviewed duplicate user IDs and device IDs to flag potential abuse or repeat fraud behavior.

- Validated timestamp consistency between signup and purchase events.

- Confirmed correct data types for date, time, and numeric fields using [sql](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/SQL/data_preparation.sql).

- Reviewed geographic attributes (shipping city, billing city, BIN country) for logical consistency within the UAE context.

Key baseline metrics were established to understand the overall transaction health and fraud exposure. These included total transactions, unique users and devices, overall fraudulent transaction percentage, average and median purchase value and distribution of transactions by acquisition source. Signup-to-purchase time gaps were calculated to assess early-purchase behavior, a known indicator of potential fraud.

Additional exploratory checks focused on risk segmentation across customer and transaction dimensions. Fraud rates were analyzed by age group, gender, purchase value ranges, acquisition source, and geographic mismatches between billing and shipping cities. These initial metrics provided a strong foundation for deeper fraud pattern analysis and informed the selection of high-impact dimensions for advanced fraud investigation. <br/>
The queries used for the exploratory checks can be found [here](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/SQL/kpi_queries.sql).

---
<br/>

## **Executive Summary**

The fraud analysis of 150,000+ UAE e-commerce transactions reveals a high overall fraud rate of **~9%**, significantly exceeding the typical UAE e-commerce benchmark of **2–3%**, indicating elevated risk exposure. Fraud activity is heavily concentrated immediately after user signup, with the highest incidence occurring within the first hour **(7,630 fraudulent vs 574 legitimate transactions)**. Fraud probability begins to decline from the second day onward with a noticeable drop within a 12-day window, highlighting early post-signup behavior as the most critical risk period. Seasonal analysis shows clear fraud spikes during New Year clearance sales, aligning with high-discount promotional periods.

Further segmentation identifies low-value transactions (below 50 AED) as the primary fraud vector, suggesting “testing” behavior rather than high-ticket abuse. The **31–35 age** group shows disproportionately **high fraud rates**, potentially driven by fake or poorly verified profiles, supporting the need for age-based verification controls. Among acquisition channels, paid ads contribute the highest fraud volume (5,513 cases) and show poor risk-to-revenue efficiency, indicating possible overspending on low-quality traffic, while SEO traffic exhibits faster signup-to-purchase fraud behavior than ads. Gender analysis shows higher absolute fraud volume among males, largely driven by transaction volume. Overall, the highest-risk profile emerges as male users around 30 years of age, acquired via ads, making low-value purchases immediately after signup, reinforcing the need for stricter early-stage controls such as dynamic transaction limits and enhanced identity verification.

---
<br/>

## **Key Analysis & Insights**

### **1. Fraud By Month Analysis**

The chart shows fraudulent transactions by month with a very sharp spike in **January (7000+ cases)** compared to all other months. After January, fraud volumes drop drastically and remain relatively low and stable throughout the rest of the year, fluctuating mostly between 200–900 cases per month.

From February onwards, fraud shows a mild rise during April–July, followed by a steady decline toward the end of the year, reaching the lowest levels in November and December. This indicates that fraud activity is highly seasonal and event-driven, rather than evenly distributed across months.

**Key Insights:**

- January is a clear outlier, contributing the majority of annual fraud cases.

- The spike strongly aligns with New Year clearance sales and heavy promotions.

- Mid-year months (Apr–Jul) show moderate fraud consistency, indicating baseline fraud levels during Ramadan, Eid al-Fitr, Eid al-Adha, Summer / End-of-Season Sales.

- Year-end months (Nov–Dec) show the lowest fraud activity, despite high shopping volume.

- Fraud prevention efforts should be intensified before and during January, especially for new users and promo-driven traffic.
  
![Fraud By Month](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_month.jpg)
--- 

### **2. Fraud Timing (Signup → Purchase)**

Fraudulent transactions by signup-to-purchase time (datediff in days) shows an overwhelming concentration at **Day 0** (same-day purchase). Fraud volume drops sharply after and remains very low across days 1–24, indicating that delayed purchases are far less risky.

This steep fall-off highlights that fraudsters act immediately after account creation, while genuine users tend to purchase after some delay. The distribution clearly separates high-risk instant conversions from lower-risk delayed behavior.

**Key Insights:**

- **~75–80%** of total fraud occurs on Day 0 (within the first 24 hours of signup)- Legit: 574 | Fraud: 7,630.

- Fraud drops by >90% from Day 1 onward, indicating a strong time-based risk signal.

- Days 1–12 collectively contribute <15% of fraud, forming a diminishing high-risk window.

- Beyond Day 12, fraud contribution is negligible (<5%).

- Implementing stricter checks for same-day purchases (rate limits, step-up verification) can address the majority of fraud with minimal impact on genuine users.

![Fraud Timing](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_datediff.jpg)
---

### **3. Fraud By Day**

With very high fraud volumes during the first half (Days 1–12), fraudulent signups by day of the month, peaks close to **~1,000** fraud cases per day. This indicates intense fraudulent account creation early in the signup cycle.

After Day 12, fraud drops sharply to nearly one-third of the earlier levels and then stabilizes between 150–250 cases per day toward the end of the month. The downward trend suggests that fraudsters are heavily concentrated in early-period signup activity.

**Key Insights:**

- Days 1–12 are the highest-risk signup period for fraud.

- A sharp structural drop after Day 12 indicates reduced fraud probability for later signups.

- Fraud activity stabilizes at lower levels from mid-month onward, forming a baseline risk.

- Early-month spikes likely align with promotions, campaigns, or billing-cycle abuse.

- Stricter signup verification and monitoring should be applied during the first 10–12 days of the month.

![Fraud By Day](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_day.jpg)
---

### **4. Purchase Value Analysis**

The relationship between purchase value and fraud rate, highlights a strong concentration of fraud in low-value transactions. Fraud rises sharply from very small amounts and peaks in the *AED 10–AED 40* range, after which it steadily declines as purchase value increases.

Beyond a purchase value of ~AED 50, fraud drops significantly, and transactions above AED 90– AED 100 show near-zero fraud activity. This pattern indicates that fraudsters primarily use low-value “testing” transactions rather than attempting high-value purchases.

**Key Insights:**

- **~65–70%** of total fraud occurs in purchases below AED 50, making this the highest-risk value band.

- Fraud peaks around the AED 20– AED 30 range, contributing roughly **25–30%** of overall fraud volume.

- Transactions above AED 70 account for <10% of fraud, despite contributing meaningful revenue.

- High-value purchases (>AED 100) show negligible fraud (<1–2%).

- Implementing stricter checks and limits for low-value, early-stage transactions can significantly reduce fraud without impacting genuine high-value customers.
  
![Purchase Value Analysis](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_pv.jpg)
---

### **5. Fraud By Source**

Monthly fraud trends by acquisition source (Ads, Direct, SEO) was conducted. Fraud from Ads and SEO dominates across all months, following a similar seasonal pattern with a steady rise from March, peaking between May and July, and then declining sharply toward the end of the year. Direct traffic consistently contributes the lowest fraud volume throughout the year.

While Ads and SEO track closely, SEO shows slightly higher fraud counts than Ads during peak months, indicating faster or riskier conversions from organic traffic. The sharp drop across all sources after August highlights the strong impact of seasonality and campaign-driven traffic on fraud activity.

**Key Insights:**

- Ads and SEO are the primary drivers of fraud volume across the year.

- SEO slightly exceeds Ads in peak fraud months, suggesting faster signup-to-purchase behavior.

- Direct traffic is the least risky source, with consistently lower fraud counts.

- Fraud peaks between May–July, aligning with heavy marketing activity.

- Stricter fraud checks should be applied to Ads and SEO traffic during high-campaign months.
  
![Fraud By Source](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_source.jpg)
---

### **6. Acquisition Source Analysis**

The graph shows signup-to-purchase time (datediff) aggregated by acquisition source, split into legitimate and fraudulent transactions. SEO and Ads dominate total signup-to-purchase duration, together accounting for the majority of overall customer activity, while Direct traffic shows significantly lower total datediff, reflecting fewer users and faster conversions.

In percentage terms, fraudulent activity is more concentrated in faster conversion sources. SEO contributes the highest share of fraud within short signup-to-purchase windows, followed closely by Ads, while Direct traffic contributes the smallest fraud share. This indicates that users acquired through SEO and Ads tend to convert faster and carry higher fraud risk.

**Key Insights:**

- SEO accounts for the highest fraud share **(~40–45%)** within signup-to-purchase activity.

- Ads contribute **~35–40%** of fraud, closely tracking SEO behavior.

- Direct traffic contributes **<20%** of fraud, making it the least risky source.

- Faster signup-to-purchase behavior correlates with higher fraud probability.

- Implement source-based risk rules with stricter checks for SEO and Ads during early conversion windows.

![Acquisition Source Analysis](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/datediff_by_source.jpg)
---

### **7. Age Group Analysis**

Transaction and fraud distribution across age groups shows the highest activity concentrated between ages **20–40**. Transaction volume peaks in the **26–30 age group (~29.4K transactions)**, followed by **31–35 (~25.5K)** and **21–25 (~26.7K)**, indicating that young-to-mid working-age users dominate platform usage.

Fraud volume follows a similar pattern but is disproportionately higher in the 31–35 age group, which records the highest fraud count (~3,113 cases). Beyond age 40, both transaction volume and fraud decline sharply, with users above 55 contributing less than ~2–3% of total transactions and negligible fraud.

**Key Insights:**

- 31–35 age group is the riskiest segment, contributing **~24–26%** of total fraud while accounting for **~20–22%** of transactions.

- 26–30 age group has the highest transaction share (~23–25%) but a relatively lower fraud share, making it less risky comparatively.

- Users aged **20–40** account for **~75–80%** of all fraud cases, making this the primary risk band.

- Fraud rate drops significantly after age 40, indicating lower risk among older customers.

- Age should be used as a weighted risk factor, especially when combined with source, purchase value (< AED 50), and fast signup-to-purchase behavior.
  
![Age Group Analysis](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_age.jpg)
---

### **8. Gender Analysis**

Conducting fraudulent vs legitimate transactions by gender shows male users account for a higher overall transaction volume compared to female users and therefore also show a higher absolute count of fraudulent transactions.

| Gender | Transactions | Fraud Cases |
| ------ | ------------ | ----------- |
| Female | 57,102       | 5,717       |
| Male   | 79,859       | 8,434       |

Fraud rates are fairly comparable across genders. Female users have a fraud rate of **~10.0%**(5,717 frauds out of 57,102 transactions) while male users show a slightly higher fraud rate of **~10.6%** (8,434 frauds out of 79,859 transactions). This indicates that fraud differences are driven more by volume than gender-specific behavior.

**Key Insights:**

- Male users contribute **~58%** of total transactions and **~60%** of total fraud volume.

- Fraud rate difference between genders is marginal **(~0.6%)**, not statistically extreme.

- Fraud risk becomes meaningful when gender is combined with age, source, and signup timing.

- Gender data should be treated as a supporting feature, not a primary fraud rule.

![Gender Analysis](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_gender.jpg) 
---

### **9. Fraud By Shipping City**

The chart compares legitimate vs fraudulent transactions by shipping city, showing that major metro and logistics hubs such as Dubai, Abu Dhabi, Sharjah, and Mumbai have the highest overall transaction volumes. Dubai stands out with the largest total volume, and consequently also records a higher absolute number of fraudulent transactions.

While fraud volumes generally follow transaction volume patterns, certain non-UAE cities (e.g., Mumbai, Karachi, Riyadh) display noticeable fraud presence relative to their total activity. This suggests that fraud risk is influenced not only by volume but also by cross-border shipping behavior.

**Key Insights:**

- **Dubai** is the highest-risk city in absolute terms, driven by very high transaction volume.

- UAE cities (Dubai, Abu Dhabi, Sharjah) dominate total activity but fraud largely scales with volume.

- Non-UAE shipping cities show elevated fraud risk, indicating potential cross-border misuse.

- Mismatch between shipping city and BIN country may be a strong fraud indicator.

- Geo-based risk rules and additional verification should be applied to cross-border or non-UAE shipments.
  
![Fraud By Shipping City](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_shipping_city.jpg)

---
<br/>

## **High-Risk Customer Profile**

Most Fraud-Prone Segment Identified:

- Month: January

- Source: Ads

- Gender: Male

- Age: 30–35

- Signup-to-purchase time: < 1 hour

- Purchase value: < AED 50

---
<br/>

## **Recommendations**

**Tools Used: SQL, Tableau**

Based on behavioral patterns across time, value, traffic source, demographics, geography, and signup-to-purchase intervals, the business should move away from broad, static fraud rules toward targeted, behavior-driven prevention. The analysis clearly shows that fraud is concentrated in specific lifecycle moments and channels rather than evenly distributed across users.

The strongest intervention point is the early customer lifecycle. Transactions occurring within the first 24 hours of signup—especially same-day purchases—drive the majority of fraud, making early-stage controls far more effective than post-purchase monitoring. Applying selective friction only during this high-risk window will significantly reduce fraud without degrading the experience for established users.

Finally, fraud mitigation should be risk-weighted, not demographic-blocked. Individual attributes (age, gender, city) become meaningful only when combined with behavioral signals such as rapid conversion, low purchase value, and traffic source. A composite risk approach allows the business to scale protection while preserving legitimate growth.

**Actionable Recommendations**

- Apply enhanced verification and monitoring for transactions occurring within 24 hours of signup, with the strictest controls on Day 0 purchases.

- Introduce dynamic transaction caps and order-rate limits immediately after signup, especially for low-value transactions.

- Deploy seasonal fraud rules (velocity checks, CAPTCHA, step-up authentication) during January and early-month sales periods.

- Re-optimize Ads and SEO channels by applying tighter audience targeting, excluding high-risk geographies and assigning source-specific risk weights.

- Trigger additional identity or device verification for high-risk behavioral combinations involving the 31–35 age segment.

- Build a composite fraud risk score combining signup timing, purchase value, traffic source, behavioral velocity and geo consistency.

- Route only high-risk transactions through friction (OTP, ID verification), keeping low-risk users frictionless.

---
<br/>

## **KPIs to Track**

- Fraudulent transaction percentage.

- Fraud within first 24 hours.

- Fraud by acquisition source.

- Fraud by purchase value band.

- Signup-to-purchase conversion risk.

- Revenue vs fraud loss by channel.

---
<br/>

## **Expected Impact**

* **2–4 weeks:** Immediate reduction in same-day and low-value fraud after enabling early-lifecycle rules and rate limits.
* **6–8 weeks:** Noticeable drop in overall fraud rate as Ads/SEO optimizations and source-based controls take effect.
* **3–4 months:** Stabilization of fraud closer to **UAE benchmarks (2–3%)**, with improved marketing ROI and cleaner acquisition traffic.
* **6–12 months:** Sustained improvement through seasonal playbooks and continuous risk-score tuning.

---
<br/>

## **Caveats**

* Over-restricting early purchases may **impact genuine first-time conversions** if friction is applied too broadly.
* Demographic signals (age/gender) should **never be used alone** to avoid bias; they must be combined with behavior.
* Fraud patterns evolve—rules must be **reviewed monthly**, especially around promotions.
* Data quality (age, gender, city accuracy) can affect decisions; **verification and monitoring** are essential.
* Marketing teams must align with risk controls to avoid **ROI loss from over-filtering traffic**.
---  

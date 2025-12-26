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
- [Business Recommendations](#business-recommendations)
- [KPIs to Track](#kpis-to-track)
- [Conclusion](#conclusion)
---
<br/>

## **Project Background**

Souq Nest is a UAE-based e-commerce platform experiencing rapid growth driven by digital adoption, promotional campaigns, and seasonal sales events such as New Year clearance sales. With increasing transaction volumes, the company observed a rising risk of fraudulent activities, prompting the need for a structured fraud detection analysis.

This fraud detection analysis conducted for Souq Nest, reporting to business and risk stakeholders, using 150,000+ transaction records of the company. The study evaluates fraud trends across signup behavior, purchase value, demographics, acquisition sources, and seasonal patterns. It identifies high-risk customer profiles and early fraud indicators that significantly exceed UAE benchmarks. The insights enable data-driven fraud prevention strategies to reduce losses while maintaining customer experience and revenue growth.

---
<br/>

## **Business Objective**

The primary objective of this analysis is to:

- Identify fraud patterns and high-risk segments

- Quantify fraud impact across time, value, and customer dimensions

- Support data-driven fraud prevention strategies

- Balance fraud control with customer experience and revenue growth

The insights generated are intended to help stakeholders:

- Improve fraud monitoring and early detection

- Optimize risk rules and verification checks

- Reduce financial losses without affecting genuine customers

---
<br/>

## **Dataset Overview**

The dataset represents e-commerce transaction behavior and includes:

- 150,000+ records of trasaction in a year

- Customer attributes (age group, gender)

- Transaction details (purchase value, purchase time)

- Behavioral metrics (signup time, signup-to-purchase gap)

- Acquisition channels (Direct, Ads, SEO)

- Fraud labels (class) identifying legitimate vs fraudulent transactions

---
<br/>

## **Initial Checks & Data Preparation**

The analysis began with validating and preparing a dataset of 150,000+ UAE e-commerce transaction records to ensure reliability for fraud detection. The following initial data quality checks were performed to establish a clean and trustworthy analytical foundation:

- Verified overall data completeness and identified missing or inconsistent values uaing **Excel**

- Detected and reviewed duplicate user IDs and device IDs to flag potential abuse or repeat fraud behavior

- Validated timestamp consistency between signup and purchase events

- Confirmed correct data types for date, time, and numeric fields

- Reviewed geographic attributes (shipping city, billing city, BIN country) for logical consistency within the UAE context

- Assessed device and browser fields to ensure alignment with realistic e-commerce usage patterns

Key baseline metrics were established to understand overall transaction health and fraud exposure. These included total transactions, unique users and devices, overall fraudulent transaction percentage, average and median purchase value, and distribution of transactions by acquisition source, device, and browser. Signup-to-purchase time gaps were calculated to assess early-purchase behavior, a known indicator of potential fraud.

Additional exploratory checks focused on risk segmentation across customer and transaction dimensions. Fraud rates were analyzed by age group, gender, purchase value ranges, acquisition source, and geographic mismatches between billing and shipping cities. These initial metrics provided a strong foundation for deeper fraud pattern analysis and informed the selection of high-impact dimensions for advanced fraud investigation.

---
<br/>

## **Executive Summary**

The fraud analysis of 150,000+ UAE e-commerce transactions reveals a high overall fraud rate of ~9%, significantly exceeding the typical UAE e-commerce benchmark of 2–3%, indicating elevated risk exposure. Fraud activity is heavily concentrated immediately after user signup, with the highest incidence occurring within the first hour (7,630 fraudulent vs 574 legitimate transactions). Fraud probability begins to decline from the second day onward, with a noticeable drop within a 12-day window, highlighting early post-signup behavior as the most critical risk period. Seasonal analysis shows clear fraud spikes during New Year clearance sales, aligning with high-discount promotional periods.

Further segmentation identifies low-value transactions (below 50) as the primary fraud vector, suggesting “testing” behavior rather than high-ticket abuse. The 31–35 age group shows disproportionately high fraud rates, potentially driven by fake or poorly verified profiles, supporting the need for age-based verification controls. Among acquisition channels, paid ads contribute the highest fraud volume (5,513 cases) and show poor risk-to-revenue efficiency, indicating possible overspending on low-quality traffic, while SEO traffic exhibits faster signup-to-purchase fraud behavior than ads. Gender analysis shows higher absolute fraud volume among males, largely driven by transaction volume rather than inherent risk. Overall, the highest-risk profile emerges as male users around 30 years of age, acquired via ads, making low-value purchases immediately after signup, reinforcing the need for stricter early-stage controls such as dynamic transaction limits and enhanced identity verification.

---
<br/>

## **Key Analysis & Insights**

**1. Fraud Timing (Signup → Purchase)**

- Highest fraud occurs within the first hour of signup

- Legit: 574 | Fraud: 7,630

- Fraud probability starts dropping from Day 2

- A 12-day high-risk window exists post-signup

- Fraud declines significantly after 4 months

Insight: Immediate post-signup activity is the strongest fraud indicator.

![Fraud Timing](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_datediff.jpg)

**2. Purchase Value Analysis**

Fraud is concentrated in low-value “testing” transactions

Fraud risk increases sharply for purchase values below 50

High-value transactions show comparatively lower fraud incidence
![Purchase Value Analysis](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_pv.jpg)

**3. Age Group Analysis**

31–35 age group shows disproportionately high fraud

Potential drivers include fake or manipulated profiles
![Age Group Analysis](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_age.jpg)

**4. Acquisition Source Analysis**

Ads channel has the highest fraud volume (5,513 cases)

SEO shows faster signup-to-purchase fraud behavior

Indicates overspending on low-quality acquisition traffic

![Acquisition Source Analysis](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/datediff_by_source.jpg)

**5. Gender Analysis**

| Gender | Transactions | Fraud Cases |
| ------ | ------------ | ----------- |
| Female | 57,102       | 5,717       |
| Male   | 79,859       | 8,434       |

Fraud differences are partly driven by volume; gender alone is not a primary fraud driver.

![Gender Analysis](https://github.com/swetasunilan/E-Commerce-Fraud-Analysis/blob/main/Data%20Visualization/fraud_by_gender.jpg)

**6. Seasonality**

Fraud spikes align with New Year clearance sales

Confirms correlation between high-discount events and fraud attempts

---
<br/>

## **High-Risk Customer Profile**

Most Fraud-Prone Segment Identified:

Month: January

Source: Ads

Gender: Male

Age: 30–35

Signup-to-purchase time: < 1 hour

Purchase value: < 50

## **Business Recommendations**

Tools Used: SQL, Tableau

- Apply stricter checks within the first 24 hours of signup

- Limit number of transactions immediately after signup

- Introduce ID verification for high-risk age segments

- Reduce or optimize paid ad spend on high-fraud channels

- Implement dynamic transaction limits based on signup age

- Develop a fraud risk score using behavioral signals

## **KPIs to Track**

- Fraudulent transaction percentage

- Fraud within first 24 hours

- Fraud by acquisition source

- Fraud by purchase value band

- Signup-to-purchase conversion risk

- Revenue vs fraud loss by channel

## **Conclusion**

This analysis demonstrates how early behavioral signals, low-value purchases, and acquisition sources drive fraud risk in UAE e-commerce. By implementing targeted controls and dynamic risk rules, the business can reduce fraud exposure while maintaining customer experience and revenue growth.


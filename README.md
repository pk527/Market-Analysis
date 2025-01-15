# Market Analysis in North America

## Introduction
The project involves analyzing data from Maven Market, a multi-national grocery chain operating in Canada, Mexico, and the United States. The objective is to demonstrate Power BI skills by completing the full business intelligence workflow, including data connection, shaping, relational modeling, calculated fields, and interactive reporting.

<img width="1280" alt="Screenshot 2025-01-15 112116"  src ="(https://github.com/user-attachments/assets/a0fe062f-4e73-4f45-833f-a92574f02d26)">


## Data Integration
### Data Sources
- **MavenMarket_Customers**
- **MavenMarket_Products**
- **MavenMarket_Stores**
- **MavenMarket_Regions**
- **MavenMarket_Calendar**
- **MavenMarket_Returns**
- **MavenMarket_Transactions** (1997-1998)

### Data Model
The data was unified using SQL:
```sql
SELECT
    C.customer_id,
    C.customer_acct_num,
    C.customer_postal_code,
    C.customer_address,
    C.customer_city,
    C.customer_state_province,
    C.customer_country,
    C.birthdate,
    C.marital_status,
    C.yearly_income,
    C.gender,
    C.total_children,
    C.num_children_at_home,
    C.education,
    C.acct_open_date,
    C.member_card,
    C.occupation,
    C.homeowner,
    C.full_name,
    C.birth_year,
    C.has_children,
    P.product_id,
    P.product_sku,
    P.product_name,
    P.product_brand,
    P.product_retail_price,
    P.discount_price,
    R.region_id,
    R.sales_district,
    R.sales_region,
    R.Region AS region_name,
    S.store_id,
    S.store_city,
    S.store_type,
    S.first_opened_date,
    S.last_remodel_date,
    S.total_sqft,
    S.grocery_sqft,
    S.store_state,
    S.store_country,
    S.full_address,
    S.area_code,
    Cal.date,
    Cal.start_of_week,
    Cal.day_name,
    Cal.start_of_month,
    Cal.month_name,
    Cal.quarter_of_year,
    Cal.calendar_year,
    Ret.quantity AS return_quantity,
    T.transaction_date,
    T.quantity AS transaction_quantity
FROM
    Transaction_Data T
    LEFT JOIN Customers C ON T.customer_id = C.customer_id
    LEFT JOIN Products P ON T.product_id = P.product_id
    LEFT JOIN Stores S ON T.store_id = S.store_id
    LEFT JOIN Regions R ON S.region_id = R.region_id
    LEFT JOIN Calendar Cal ON T.transaction_date = Cal.date
    LEFT JOIN Returns_Data Ret ON T.product_id = Ret.product_id AND T.store_id = Ret.store_id;
```

### Shaping the Data
- Applied transformations such as column merging, conditional columns, and null value replacements.
- Ensured proper data types for all fields.

---

## Features
- **Interactive Dashboard:** KPIs, charts, and maps for an intuitive experience.
- **Topline Performance Matrix:** Analysis of product brands based on profit, transactions, and return rates.
- **Geographical Analysis:** Insights into transactions by regions and store locations.
- **Trend Analysis:** Revenue trends by week with target comparisons.
- **KPI Metrics:** Monthly revenue, profit, and transaction analysis.
- **Customizable Filters:** Country filter and drill-down capabilities.

---

## Questions Addressed
1. What are the total transactions, revenue, and profit for the current month?
2. Which product brands perform the best in terms of transactions and profitability?
3. What is the return rate across product brands?
4. How do revenue trends compare week by week?
5. How does performance differ across regions and countries?
6. Are we meeting our monthly revenue targets?
7. What percentage of transactions occur on weekends?

---

## Analysis
### Data Connection and Shaping
- **Data Sources:** CSV files for Customers, Products, Stores, Regions, Calendar, Returns, and Transactions.
- **Unified SQL Structure:** Efficient query handling and analysis.
- **Data Preparation Steps:** Data cleaning, type formatting, calculated columns, and relationship creation.

### Key Metrics Created
#### Quantitative Metrics
- **Total Transactions, Revenue, Profit, and Cost**
- **Return Rate, Profit Margin, Weekend Transactions**
- **Year-to-Date (YTD) Revenue and 60-Day Rolling Revenue Average**

#### Calculated Columns
1. **Weekend Indicator:** `IF(WEEKDAY([Date],2)>=6, "Y", "N")`
2. **Customer Priority:** `IF([Homeowner]="Y" && [Membership Card]="Golden", "High", "Standard")`
3. **Price Tier:** `IF([Retail Price]>3, "High", IF([Retail Price]>1, "Mid", "Low"))`
4. **Years Since Remodel:** `DATEDIFF([Last Remodel Date], TODAY(), YEAR)`
5. **Short Country:** `UPPER(LEFT([Customer Country], 3))`

#### Measures
1. **Total Revenue:** `SUMX(Transactions, Transactions[Quantity] * Products[Retail Price])`
2. **Profit Margin:** `DIVIDE([Total Profit], [Total Revenue], 0)`
3. **Return Rate:** `DIVIDE([Quantity Returned], [Quantity Sold], 0)`
4. **YTD Revenue:** `TOTALYTD([Total Revenue], Calendar[Date])`
5. **Revenue Target:** `[Last Month Revenue] * 1.05`

---

## Data Visualizations
- **KPI Cards:** Showcasing current month transactions, revenue, and profit.
- **Map Visualization:** Transactions by store city and treemap for geographic drill-downs.
- **Weekly Revenue Trendline:** Visualizing revenue trends for 1998.
- **Gauge Chart:** Comparing revenue against targets.
- **Topline Performance Matrix:** Analyzing product brands by profit, transactions, and return rates.

---

## Insights
1. **Top Product Brands:** Brands like Cormorant, Carrington, and Best Choice lead in transactions and profitability.
2. **Geographical Trends:** U.S. stores outperform Canadian and Mexican counterparts in transactions and revenue.
3. **Revenue vs. Target:** Current month revenue exceeds the goal by 5.84%.
4. **Profitability:** Maintained a consistent 60% profit margin across categories.
5. **Return Rates:** Average return rate is 11%, with some brands higher than average.
6. **Weekend Transactions:** 28.4% of transactions occur on weekends, suggesting high-traffic periods.

---
##Dashboard Benefits
The Dashboard is a dynamic tool that brings data to life, transforming complex information into meaningful insights that drive smarter decisions. With its sleek, interactive design, the dashboard serves as a window into the heart of the business—revealing revenue patterns, transaction performance, and profitability metrics with remarkable clarity. It goes beyond numbers, offering an in-depth understanding of geographical trends, from the high-performing U.S. markets to opportunities in Canada and Mexico.

What truly sets this dashboard apart is its ability to tell a story. Each visualization, whether it's the KPIs, maps, or trendlines, paints a clear picture of where the business stands and where it’s headed. The customizable filters and drill-down features allow users to dive deep into specific product brands, customer segments, or regions, making analysis both efficient and personal. High-performing brands, like Cormorant and Carrington, shine through the data, offering inspiration for future strategies, while areas of improvement, such as return rates, are clearly highlighted for action.

By tracking progress against revenue goals and spotlighting high-traffic periods, such as weekends, the dashboard equips teams with the insights needed to act swiftly and strategically. Beyond just presenting data, it inspires forward-thinking by identifying patterns and opportunities that might otherwise go unnoticed. More than a reporting tool, the Maven Market dashboard is a strategic partner—empowering teams to focus on what matters most, streamline operations, and continuously adapt to meet the demands of an evolving market. With its blend of functionality and foresight, it’s not just a tool for today—it’s a foundation for tomorrow’s success.

---

## Conclusion
The Maven Market Power BI Dashboard demonstrates data-driven decision-making through advanced data modeling, DAX measures, and interactive visuals. It highlights:
- Areas to improve return rates.
- Revenue opportunities in underperforming regions.
- High-impact periods like weekends for focused marketing.

This project reinforces Power BI's effectiveness in handling complex workflows and delivering valuable insights for strategic planning.

---

## Files Included
1. **Power BI File:** `Marketprotfolioproj.pbix`
2. **Excel File:** `newmarketdata.xlsx`
3. **Dashboard Screenshot:** `Screenshot_2025-01-15.png`
4. **SQL Query:** Code for joining and shaping data.

### How to Use the Dashboard
1. Open the Power BI file and connect to the data sources.
2. Use slicers to filter by country, region, or product brand.
3. Analyze key KPIs, trends, and performance metrics using interactive visuals.
4. Drill down into specific product brands or geographic areas for detailed insights.

---

## Future Enhancements
1. Add predictive analytics for forecasting revenue and sales trends.
2. Include detailed demographic analysis for customer segmentation.
3. Enhance visualizations with additional interactivity and tooltips.
4. Implement advanced drill-through pages for deeper data analysis.


# Personal Subscription & Spend Tracker (SQL)

##  Project Overview
A relational database model created using SQL to track personal monthly subscriptions (Netflix, Spotify, Gym, etc.), analyze recurring spend, and identify churn metrics.

## Schema Structure
- **Users**: User identification and join dates.
- **Services**: Catalog of services, category, and monthly cost.
- **Subscriptions**: Junction table managing foreign keys, subscription status, and start/end dates.

## Key Insights & Analytics Solved
1. **User Spend Aggregation**: Calculated total active recurring spend per user using `JOIN` and `GROUP BY`.
2. **Churn Rate Analysis**: Evaluated service cancellation rates using conditional `CASE WHEN` aggregation.
3. **Ranked Monthly Expenses**: Applied `DENSE_RANK()` window function to identify top-paying users.

## How to Run
Open `schema_and_queries.sql` in any SQL Workbench (MySQL, PostgreSQL, SQLite) and execute the queries sequentially.

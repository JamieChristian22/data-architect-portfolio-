# Data Governance — Project 01 (Sales Data Warehouse)

## Data Classification
- **PII**: `dim_customer.email` (mask in non-prod; restrict in prod)
- **Non-PII**: product catalog, revenue metrics, date dimension

## Access Model (Example)
- **Analyst**: SELECT on `fact_sales`, `dim_product`, `dim_date`, masked `dim_customer.email`
- **Sales Ops**: SELECT on full `dim_customer` + row-level security by `region`
- **Admin**: Full privileges

## Data Quality Rules
1. `sale_id` unique and non-null
2. Revenue formula: `revenue = quantity * unit_price * (1 - discount_rate)` within $0.01
3. All facts resolve to `customer_sk`, `product_sk`, `date_id`
4. Allowed values:
   - `region` in {Northeast, Southeast, Midwest, Southwest, West}
   - `channel` in {Direct, Partner, Online}

## Change Management
- `region` and `segment` are tracked as **SCD Type 2** with `valid_from`/`valid_to`.

## Monitoring
- Example daily DQ output: `data_quality_results.csv`

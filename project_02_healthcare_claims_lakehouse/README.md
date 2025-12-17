# Project 02 — Healthcare Claims Lakehouse (Raw → Curated → Analytics)

## Business Problem
Claims cost analytics are slow and inconsistent because data lives in operational systems and flat files.  
Goal: build a **lakehouse** that is scalable, governed, and analytics-ready — while supporting **HIPAA-aware controls**.

## Architecture
- `architecture/lakehouse_architecture.png`
- `architecture/security_model.png`

## Data Zones
- `data_zones/raw/` — immutable landing (audit safe)
- `data_zones/curated/` — cleaned, standardized, tokenized
- `data_zones/analytics/` — marts for reporting

## Key Artifacts
- Governance controls: `governance/hipaa_controls.md`
- Data quality rules: `governance/data_quality_rules.md`
- Data dictionary: `governance/data_dictionary.xlsx`

## Analytics Evidence
- `analytics/paid_amount_by_claim_type.png`
- Marts:
  - `member_month_claim_cost_mart.csv`
  - `specialty_month_cost_mart.csv`

## Example Questions Answered
- Paid cost trend by claim type (Professional/Institutional/Pharmacy)
- Specialty cost by month (e.g., Cardiology vs Orthopedics)
- Denial rates by network status (In vs Out-of-network)

## What This Demonstrates
- Lakehouse layering (raw/curated/analytics)
- Security & governance patterns (masking, tokenization, RBAC concepts)
- Cost marts and business metric design

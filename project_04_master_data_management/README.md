# Project 04 — Master Data Management (MDM) Golden Record

## Business Problem
Customer identity is fragmented across CRM, Billing, and Support. This causes:
- Duplicate outreach and bad CX
- Inconsistent reporting of customer counts
- Broken downstream analytics joins

Goal: build an **MDM pipeline** that standardizes records, matches duplicates, applies survivorship rules, and produces a **Golden Customer** record with lineage.

## Architecture
- `architecture/mdm_architecture.png`
- `architecture/match_merge_flow.png`

## Data
- Raw multi-source input: `data/raw/customers_all_sources.csv`
- Standardized staging: `data/staging/stg_customers_standardized.csv`
- Matches: `data/mdm/customer_matches.csv`
- Golden output: `data/mdm/golden_customers.csv`
- Lineage: `data/mdm/xref_golden_to_source.csv`
- History snapshot: `data/mdm/golden_customers_history_snapshot.csv`

## Matching Rules (Implemented)
- Email exact match (confidence 0.98)
- Phone + last name (confidence 0.92)

## Survivorship Rules (Implemented)
- Names: prefer CRM for identity (or most recent if CRM not present)
- Contact/Address: most recent non-null
- Always keep xref for audit and traceability

## Governance
- `governance/mdm_policies.md`
- `governance/data_quality_rules.md`
- `governance/data_dictionary.xlsx`

## Evidence
- `analytics/duplicate_collapse_distribution.png`

## What This Demonstrates
- Real enterprise MDM patterns (match/merge + stewardship)
- Deterministic identity resolution rules
- Golden record design + lineage + auditability

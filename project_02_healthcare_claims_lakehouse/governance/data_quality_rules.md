# Data Quality Rules — Project 02

## Validations
1. `claim_number` unique per `claim_id`
2. `paid_amount <= allowed_amount <= billed_amount`
3. `status` in {Paid, Denied, Pending}
4. `claim_type` in {Professional, Institutional, Pharmacy}
5. Referential integrity:
   - claims.member_id exists in members
   - claims.provider_id exists in providers
6. Schema conformity:
   - dates parseable, amounts non-negative

## Reconciliation
- Total allowed/paid by month reconciled between header and line within tolerance.

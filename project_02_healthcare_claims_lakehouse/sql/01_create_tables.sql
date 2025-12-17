-- Project 02: Healthcare Claims Lakehouse (Raw/Curated/Analytics)
-- Tables can be created in a warehouse or lakehouse metastore.

-- RAW (immutable)
CREATE TABLE IF NOT EXISTS raw_members (
  member_id INTEGER,
  member_external_id VARCHAR(20),
  first_name VARCHAR(80),
  last_name VARCHAR(80),
  dob DATE,
  gender VARCHAR(1),
  state VARCHAR(2),
  ssn_masked VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS raw_providers (
  provider_id INTEGER,
  npi VARCHAR(20),
  provider_name VARCHAR(200),
  specialty VARCHAR(100),
  network_status VARCHAR(30),
  provider_type VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS raw_claims_header (
  claim_id INTEGER,
  claim_number VARCHAR(20),
  member_id INTEGER,
  provider_id INTEGER,
  service_date DATE,
  claim_type VARCHAR(30),
  status VARCHAR(20),
  billed_amount NUMERIC(14,2),
  allowed_amount NUMERIC(14,2),
  paid_amount NUMERIC(14,2)
);

CREATE TABLE IF NOT EXISTS raw_claims_line (
  claim_line_id INTEGER,
  claim_id INTEGER,
  cpt_code VARCHAR(10),
  icd10_code VARCHAR(10),
  units INTEGER,
  billed_amount NUMERIC(14,2),
  allowed_amount NUMERIC(14,2),
  paid_amount NUMERIC(14,2)
);

-- CURATED (clean + standardized + tokenized)
CREATE TABLE IF NOT EXISTS curated_members (
  member_id INTEGER,
  member_external_id VARCHAR(20),
  member_token VARCHAR(40),
  dob DATE,
  gender VARCHAR(1),
  state VARCHAR(2),
  ssn_masked VARCHAR(20),
  full_name VARCHAR(200)
);

-- ANALYTICS MARTS
CREATE TABLE IF NOT EXISTS mart_member_month_claim_cost (
  member_id INTEGER,
  service_month VARCHAR(7),
  status VARCHAR(20),
  claim_type VARCHAR(30),
  claims INTEGER,
  billed NUMERIC(18,2),
  allowed NUMERIC(18,2),
  paid NUMERIC(18,2)
);

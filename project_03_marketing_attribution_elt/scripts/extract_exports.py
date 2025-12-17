"""Project 03 — Extract step (demo)

In production this would call APIs (Google Ads, Meta) or ingest scheduled exports.
For this portfolio, raw files are already in `data/raw/`.

This script validates raw files exist and writes a run log.
"""

import os
from datetime import datetime

RAW_DIR = os.path.join(os.path.dirname(__file__), "..", "data", "raw")
required = ["google_ads.csv", "meta_ads.csv", "affiliate_ads.csv", "web_sessions.csv", "conversions.csv"]

missing = [f for f in required if not os.path.exists(os.path.join(RAW_DIR, f))]
if missing:
    raise FileNotFoundError(f"Missing raw exports: {missing}")

print("Extract OK:", required)
print("Run timestamp (UTC):", datetime.utcnow().isoformat())

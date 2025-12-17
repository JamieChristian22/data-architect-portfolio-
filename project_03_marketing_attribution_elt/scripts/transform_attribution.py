"""Project 03 — Transform step (demo)

Builds:
- dim_campaign
- fact_sessions
- fact_conversions
- mart_attribution_last_touch (30-day lookback)
- mart_marketing_roi

Local pandas implementation mirroring warehouse ELT logic.
"""

import os
import pandas as pd
import numpy as np
from datetime import timedelta

BASE = os.path.join(os.path.dirname(__file__), "..")
RAW = os.path.join(BASE, "data", "raw")
OUT = os.path.join(BASE, "data", "warehouse")
os.makedirs(OUT, exist_ok=True)

google = pd.read_csv(os.path.join(RAW, "google_ads.csv"))
meta = pd.read_csv(os.path.join(RAW, "meta_ads.csv"))
aff = pd.read_csv(os.path.join(RAW, "affiliate_ads.csv"))
sessions = pd.read_csv(os.path.join(RAW, "web_sessions.csv"))
conversions = pd.read_csv(os.path.join(RAW, "conversions.csv"))

# Dimension
dim_campaign = pd.concat([google[["campaign_id","campaign_name","channel"]],
                         meta[["campaign_id","campaign_name","channel"]],
                         aff[["campaign_id","campaign_name","channel"]]], ignore_index=True).drop_duplicates()
dim_campaign.to_csv(os.path.join(OUT, "dim_campaign.csv"), index=False)

# Facts
sessions["session_start_ts"] = pd.to_datetime(sessions["session_start_ts"])
sessions["session_month"] = sessions["session_start_ts"].dt.to_period("M").astype(str)
sessions.to_csv(os.path.join(OUT, "fact_sessions.csv"), index=False)

conversions["conversion_ts"] = pd.to_datetime(conversions["conversion_ts"])
conversions.to_csv(os.path.join(OUT, "fact_conversions.csv"), index=False)

# Last-touch attribution (30d)
sessions_sorted = sessions.sort_values(["user_id","session_start_ts"])
conv_sorted = conversions.sort_values(["user_id","conversion_ts"])
lookback = timedelta(days=30)

attrib = []
for user, convs in conv_sorted.groupby("user_id"):
    sess = sessions_sorted[sessions_sorted.user_id == user][["session_start_ts","channel","campaign_id"]]
    if sess.empty:
        continue
    for _, c in convs.iterrows():
        window = sess[(sess.session_start_ts <= c.conversion_ts) & (sess.session_start_ts >= c.conversion_ts - lookback)]
        if window.empty:
            attrib.append([c.conversion_id, user, c.conversion_ts, c.revenue, "Unattributed", None, "last_touch_30d"])
        else:
            last = window.sort_values("session_start_ts").iloc[-1]
            attrib.append([c.conversion_id, user, c.conversion_ts, c.revenue, last.channel, int(last.campaign_id) if pd.notna(last.campaign_id) else None, "last_touch_30d"])

attrib_df = pd.DataFrame(attrib, columns=["conversion_id","user_id","conversion_ts","revenue","attributed_channel","attributed_campaign_id","model"])
attrib_df.to_csv(os.path.join(OUT, "mart_attribution_last_touch.csv"), index=False)

# ROI mart
spend = pd.concat([google, meta, aff], ignore_index=True)
spend_month = spend.groupby(["month","channel"]).agg(spend=("spend","sum"), impressions=("impressions","sum"), clicks=("clicks","sum")).reset_index()

attrib_df["month"] = pd.to_datetime(attrib_df["conversion_ts"]).dt.to_period("M").astype(str)
rev_month = attrib_df.groupby(["month","attributed_channel"]).agg(attributed_revenue=("revenue","sum"), conversions=("conversion_id","count")).reset_index().rename(columns={"attributed_channel":"channel"})

roi = spend_month.merge(rev_month, on=["month","channel"], how="left").fillna({"attributed_revenue":0,"conversions":0})
roi["roi"] = np.where(roi["spend"] > 0, roi["attributed_revenue"] / roi["spend"], 0)
roi.to_csv(os.path.join(OUT, "mart_marketing_roi.csv"), index=False)

print("Transform complete. Outputs written to data/warehouse/")

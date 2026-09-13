-- Demo/placeholder tariff rates by vendor origin country.
-- NOTE: These are illustrative values only, not real customs/tariff data.
-- They exist to demonstrate how a natural-language BI agent (Databricks Genie)
-- can reason over sales + cost data together once a real tariff source is available.

CREATE OR REPLACE TABLE hd_supply_chain_databricks.sap_analytics.demo_tariff_rates (
  origin_country STRING,
  tariff_rate_pct DOUBLE,
  notes STRING
);

INSERT INTO hd_supply_chain_databricks.sap_analytics.demo_tariff_rates VALUES
('USA', 0.00, 'Demo placeholder'),
('Germany', 0.10, 'Demo placeholder'),
('Vietnam', 0.15, 'Demo placeholder'),
('India', 0.12, 'Demo placeholder');

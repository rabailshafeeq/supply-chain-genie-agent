-- Gold-layer view joining real purchase order / vendor / material data
-- with the demo tariff rate table, pre-aggregated by material, vendor,
-- and month. This is the single view exposed to the Genie agent so it
-- can answer "total sales + tariff impact" style questions accurately
-- with one well-described, pre-joined source instead of forcing the
-- LLM to reconstruct multi-table joins on the fly.

CREATE OR REPLACE VIEW hd_supply_chain_databricks.sap_analytics.out_sales_tariff_summary AS
SELECT
  po.material_id,
  m.material_desc,
  po.vendor_id,
  v.vendor_name,
  v.country AS origin_country,
  DATE_TRUNC('MONTH', po.order_date) AS order_month,
  SUM(po.quantity * po.unit_price) AS total_sales,
  MAX(t.tariff_rate_pct) AS tariff_rate_pct,
  SUM(po.quantity * po.unit_price) * MAX(t.tariff_rate_pct) AS estimated_tariff_impact
FROM hd_supply_chain_databricks.sap_raw.purchase_orders po
JOIN hd_supply_chain_databricks.sap_raw.material_master m
  ON po.material_id = m.material_id
JOIN hd_supply_chain_databricks.sap_raw.vendor_master v
  ON po.vendor_id = v.vendor_id
LEFT JOIN hd_supply_chain_databricks.sap_analytics.demo_tariff_rates t
  ON v.country = t.origin_country
GROUP BY
  po.material_id, m.material_desc, po.vendor_id, v.vendor_name,
  v.country, DATE_TRUNC('MONTH', po.order_date);

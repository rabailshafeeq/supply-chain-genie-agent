# Genie Agent — General Instructions

These are the natural-language instructions configured on the Genie Agent
so it interprets business terms and data limitations consistently, rather
than guessing per-question.

---

"Total sales" for a material means SUM(quantity * unit_price) from
purchase_orders, or the total_sales column in out_sales_tariff_summary.

"Tariff impact" means the estimated_tariff_impact column in
out_sales_tariff_summary, which is total_sales multiplied by a tariff
rate based on the vendor's origin country.

IMPORTANT: The tariff rates in demo_tariff_rates and
out_sales_tariff_summary are DEMO/PLACEHOLDER values only, not real
customs or tariff data. Always mention in your answer that tariff
figures are estimates based on demo data when a question involves
tariff impact.

The underlying order data (purchase_orders, out_sales_tariff_summary)
only covers order dates from January 2025 to October 2025. There is no
data for the current calendar month or "last month" relative to
today's real date. When a user asks about "last month" or "this
month", interpret it as the most recent complete month available in
the data, and state clearly in your answer which month you used.

When a user asks for "total sales and tariff impact" for a material,
query out_sales_tariff_summary filtered by material_id, and return
total_sales, tariff_rate_pct, and estimated_tariff_impact together,
summed or shown by month as appropriate.

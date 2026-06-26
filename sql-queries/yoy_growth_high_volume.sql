WITH yearly AS (
  SELECT
    Crime_Category,
    Year,
    SUM(Incidents) AS total
  FROM `sa-crime-portfolio.crime_data.crime_incidents`
  GROUP BY Crime_Category, Year
),
with_change AS (
  SELECT
    Crime_Category,
    Year,
    total,
    LAG(total) OVER (PARTITION BY Crime_Category ORDER BY Year) AS previous_year
  FROM yearly
)
SELECT
  Crime_Category,
  Year,
  total,
  previous_year,
  ROUND(SAFE_DIVIDE((total - previous_year), previous_year) * 100, 1) AS pct_change
FROM with_change
WHERE previous_year IS NOT NULL
  AND total > 5000
ORDER BY pct_change DESC
LIMIT 15;
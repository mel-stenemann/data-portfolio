WITH province_crime_totals AS (
  SELECT
    Province,
    Crime_Category,
    SUM(Incidents) AS total_incidents
  FROM `sa-crime-portfolio.crime_data.crime_incidents`
  GROUP BY Province, Crime_Category
)
SELECT
  Province,
  Crime_Category,
  total_incidents,
  RANK() OVER (PARTITION BY Province ORDER BY total_incidents DESC) AS rank_in_province
FROM province_crime_totals
QUALIFY rank_in_province <= 3
ORDER BY Province, rank_in_province;
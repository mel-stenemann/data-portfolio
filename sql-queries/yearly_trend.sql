SELECT
  Year,
  SUM(Incidents) AS total_incidents
FROM `sa-crime-portfolio.crime_data.crime_incidents`
GROUP BY Year
ORDER BY Year;
#X# Conversion failed: failed to parse YAML.  Check for pipes on newlines


view: sql_runner_query {
  derived_table: {
    sql: SELECT TOP (5000)
          CONVERT(VARCHAR(10), [Time], 120) AS [tabla_mutual.time_date],
          CASE WHEN MAX([pm2_5]) > 500 THEN 500 ELSE MAX([pm2_5]) END AS [tabla_mutual.max_pm2_5],
          MIN([pm2_5]) AS [tabla_mutual.min_pm2_5],
          AVG([pm2_5]) AS [tabla_mutual.avg_pm2_5]
      FROM
          [dbo].[BluesenseOfi] AS [tabla_mutual]
      WHERE
          [Time] >= CONVERT(DATETIME, '2023-07-10', 120) AND
          [Time] < CONVERT(DATETIME, '2023-07-13', 120)
      GROUP BY
          CONVERT(VARCHAR(10), [Time], 120)
      ORDER BY
          1 DESC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: tabla_mutual_time_date {
    type: string
    sql: ${TABLE}."tabla_mutual.time_date" ;;
  }

  dimension: tabla_mutual_max_pm2_5 {
    type: number
    sql: ${TABLE}."tabla_mutual.max_pm2_5" ;;
  }

  dimension: tabla_mutual_min_pm2_5 {
    type: number
    sql: ${TABLE}."tabla_mutual.min_pm2_5" ;;
  }

  dimension: tabla_mutual_avg_pm2_5 {
    type: number
    sql: ${TABLE}."tabla_mutual.avg_pm2_5" ;;
  }

  set: detail {
    fields: [
        tabla_mutual_time_date,
	tabla_mutual_max_pm2_5,
	tabla_mutual_min_pm2_5,
	tabla_mutual_avg_pm2_5
    ]
  }
}

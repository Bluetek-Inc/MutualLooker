#X# Conversion failed: failed to parse YAML.  Check for pipes on newlines


view: tabla_con_nombres {
  derived_table: {
    sql: SELECT * FROM (
          SELECT *, DENSE_RANK() OVER (ORDER BY z___min_rank) as z___pivot_row_rank, RANK() OVER (PARTITION BY z__pivot_col_rank ORDER BY z___min_rank) as z__pivot_col_ordering, CASE WHEN z___min_rank = z___rank THEN 1 ELSE 0 END AS z__is_highest_ranked_cell FROM (
              SELECT *, MIN(z___rank) OVER (PARTITION BY "mutualgeneral.id_1") as z___min_rank FROM (
                  SELECT *, RANK() OVER (ORDER BY "mutualgeneral.id_1" ASC, z__pivot_col_rank) AS z___rank FROM (
                      SELECT *, DENSE_RANK() OVER (ORDER BY CASE WHEN "mutualgeneral.estadodisp__sort__1" IS NULL THEN 1 ELSE 0 END, "mutualgeneral.estadodisp__sort__1", CASE WHEN "mutualgeneral.estadodisp_1" IS NULL THEN 1 ELSE 0 END, "mutualgeneral.estadodisp_1") AS z__pivot_col_rank FROM (
                          SELECT
                              CASE
                                  WHEN MutualGeneral.pm2_5 < 50 THEN 'Bueno'
                                  WHEN MutualGeneral.pm2_5 >= 50 AND MutualGeneral.pm2_5 < 80 THEN 'Regular'
                                  WHEN MutualGeneral.pm2_5 >= 80 AND MutualGeneral.pm2_5 < 110 THEN 'Alerta'
                                  WHEN MutualGeneral.pm2_5 >= 110 AND MutualGeneral.pm2_5 < 170 THEN 'Pre-Emergencia'
                                  WHEN MutualGeneral.pm2_5 >= 170 THEN 'Emergencia'
                              END AS [mutualgeneral.estadodisp_1],
                              CASE
                                  WHEN MutualGeneral.pm2_5 < 50 THEN '0'
                                  WHEN MutualGeneral.pm2_5 >= 50 AND MutualGeneral.pm2_5 < 80 THEN '1'
                                  WHEN MutualGeneral.pm2_5 >= 80 AND MutualGeneral.pm2_5 < 110 THEN '2'
                                  WHEN MutualGeneral.pm2_5 >= 110 AND MutualGeneral.pm2_5 < 170 THEN '3'
                                  WHEN MutualGeneral.pm2_5 >= 170 THEN '4'
                              END AS [mutualgeneral.estadodisp__sort__1],
                              CASE
                                  WHEN [id] = 'BS-001G-00003' THEN 'Oficina'
                                  WHEN [id] = 'BS-100L-00013' THEN 'Bulldozer 484'
                                  WHEN [id] = 'BS-100L-00014' THEN 'Motoniveladora 890'
                                  WHEN [id] = 'BS-100L-00017' THEN 'Excavadora 887'
                                  WHEN [id] = 'BS-100L-00018' THEN 'Retroexcavadora 171'
                                  WHEN [id] = 'BS-100L-00020' THEN 'Camión Articulado 741'
                                  WHEN [id] = 'BS-100L-00021' THEN 'Rodillo 518'
                                  WHEN [id] = 'BS-100L-00022' THEN 'Camión Aljibe 327'

                                  -- Agrega más casos aquí para asignar nombres personalizados a otros `id`
                              END AS [mutualgeneral.id_1],
                              COUNT(*) * 100 / 4320 AS [mutualgeneral.2semanas_1]
                          FROM
                              [dbo].[BluesenseOfi] AS [MutualGeneral]
                          WHERE
                              [id] IN ('BS-001G-00003', 'BS-100L-00013', 'BS-100L-00014', 'BS-100L-00017', 'BS-100L-00018', 'BS-100L-00020', 'BS-100L-00021', 'BS-100L-00022') AND
                              ((( [Time] ) >= (CONVERT(DATETIME, '2023-07-10', 120)) AND ( [Time] ) < (CONVERT(DATETIME, '2023-07-13', 120))))
                          GROUP BY
                              [id],
                              CASE
                                  WHEN MutualGeneral.pm2_5 < 50 THEN 'Bueno'
                                  WHEN MutualGeneral.pm2_5 >= 50 AND MutualGeneral.pm2_5 < 80 THEN 'Regular'
                                  WHEN MutualGeneral.pm2_5 >= 80 AND MutualGeneral.pm2_5 < 110 THEN 'Alerta'
                                  WHEN MutualGeneral.pm2_5 >= 110 AND MutualGeneral.pm2_5 < 170 THEN 'Pre-Emergencia'
                                  WHEN MutualGeneral.pm2_5 >= 170 THEN 'Emergencia'
                              END,
                              CASE
                                  WHEN MutualGeneral.pm2_5 < 50 THEN '0'
                                  WHEN MutualGeneral.pm2_5 >= 50 AND MutualGeneral.pm2_5 < 80 THEN '1'
                                  WHEN MutualGeneral.pm2_5 >= 80 AND MutualGeneral.pm2_5 < 110 THEN '2'
                                  WHEN MutualGeneral.pm2_5 >= 110 AND MutualGeneral.pm2_5 < 170 THEN '3'
                                  WHEN MutualGeneral.pm2_5 >= 170 THEN '4'
                              END
                      ) ww
                  ) bb WHERE z__pivot_col_rank <= 16384
              ) aa
          ) xx
      ) zz
      WHERE
          (z__pivot_col_rank <= 200 OR z__is_highest_ranked_cell = 1) AND
          (z___pivot_row_rank <= 5000 OR z__pivot_col_ordering = 1)
      ORDER BY z___pivot_row_rank ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: mutualgeneral_estadodisp_1 {
    type: string
    sql: ${TABLE}."mutualgeneral.estadodisp_1" ;;
  }

  dimension: mutualgeneral_estadodisp__sort__1 {
    type: string
    sql: ${TABLE}."mutualgeneral.estadodisp__sort__1" ;;
  }

  dimension: mutualgeneral_id_1 {
    type: string
    sql: ${TABLE}."mutualgeneral.id_1" ;;
  }

  dimension: mutualgeneral_2semanas_1 {
    type: number
    sql: ${TABLE}."mutualgeneral.2semanas_1" ;;
  }

  dimension: z__pivot_col_rank {
    type: number
    sql: ${TABLE}.z__pivot_col_rank ;;
  }

  dimension: z___rank {
    type: number
    sql: ${TABLE}.z___rank ;;
  }

  dimension: z___min_rank {
    type: number
    sql: ${TABLE}.z___min_rank ;;
  }

  dimension: z___pivot_row_rank {
    type: number
    sql: ${TABLE}.z___pivot_row_rank ;;
  }

  dimension: z__pivot_col_ordering {
    type: number
    sql: ${TABLE}.z__pivot_col_ordering ;;
  }

  dimension: z__is_highest_ranked_cell {
    type: number
    sql: ${TABLE}.z__is_highest_ranked_cell ;;
  }

  set: detail {
    fields: [
        mutualgeneral_estadodisp_1,
	mutualgeneral_estadodisp__sort__1,
	mutualgeneral_id_1,
	mutualgeneral_2semanas_1,
	z__pivot_col_rank,
	z___rank,
	z___min_rank,
	z___pivot_row_rank,
	z__pivot_col_ordering,
	z__is_highest_ranked_cell
    ]
  }
}

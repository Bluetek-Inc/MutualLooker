view: alertas_mutual {
  sql_table_name: dbo.AlertasMutual ;;

  dimension: aco2 {
    type: number
    sql: ${TABLE}.ACO2 ;;
  }

  dimension: apm1 {
    type: number
    sql: ${TABLE}.Apm1 ;;
  }

  dimension: apm10 {
    type: number
    sql: ${TABLE}.Apm10 ;;
  }

  dimension: apm2_5 {
    type: number
    sql: ${TABLE}.Apm2_5 ;;
  }

  dimension: arh {
    type: number
    sql: ${TABLE}.ARH ;;
  }

  dimension: at {
    type: number
    sql: ${TABLE}.AT ;;
  }

  dimension: atvoc {
    type: number
    sql: ${TABLE}.ATVOC ;;
  }

  dimension: id_disp {
    type: string
    sql: ${TABLE}.id_disp ;;
  }

  dimension: rh {
    type: number
    sql: ${TABLE}.RH ;;
  }

  dimension: t {
    type: number
    sql: ${TABLE}.T ;;
  }

  dimension_group: time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Time ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: roadmap_data_scl {
  sql_table_name: roadmap_xform_test.roadmap_data_scl ;;

  dimension: budget {
    type: number
    sql: ${TABLE}.budget ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: care_center {
    type: string
    sql: ${TABLE}.care_center ;;
  }

  dimension: cc_code {
    type: string
    sql: ${TABLE}.cc_code ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: client {
    type: string
    sql: ${TABLE}.client ;;
  }

  dimension_group: month {
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
    sql: CAST(${TABLE}.month AS TIMESTAMP) ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: region_code {
    type: string
    sql: ${TABLE}.region_code ;;
  }

  dimension: scenario {
    type: string
    sql: ${TABLE}.scenario ;;
  }

  dimension: service {
    type: string
    sql: ${TABLE}.service ;;
  }

  dimension: service_code {
    type: string
    sql: ${TABLE}.service_code ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

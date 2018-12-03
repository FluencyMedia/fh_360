view: list_services {
  sql_table_name: analytics.list_services ;;

  dimension: program {
    type: string
    sql: ${TABLE}.program ;;
  }

  dimension: service_line {
    type: string
    sql: ${TABLE}.service_line ;;
  }

  dimension: service_line_code {
    type: string
    sql: ${TABLE}.service_line_code ;;
  }
}

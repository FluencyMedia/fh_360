view: list_organizations {
  sql_table_name: analytics.list_organizations ;;

  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }

  dimension: organization {
    type: string
    sql: ${TABLE}.organization ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organization_id ;;
  }
}

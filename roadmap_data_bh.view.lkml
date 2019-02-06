view: roadmap_data_bh {
  sql_table_name: roadmap_xform_test.roadmap_data_bh ;;

  dimension: budget {
    type: number
    sql: ${TABLE}.budget ;;
  }

  measure: budget_total {
    view_label: "Main"
    label: "Budget"

    type: sum
    value_format_name: usd_0

    sql: ${budget} ;;
  }

  dimension: channel {
    view_label: "Main"
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: client {
    view_label: "Main"
    type: string

    hidden: yes

    sql: ${TABLE}.client ;;
  }

  dimension_group: month {
    view_label: "Main"
    type: time
    timeframes: [
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.month AS TIMESTAMP) ;;
  }

  dimension: program {
    view_label: "Main"
    type: string
    sql: ${TABLE}.program ;;
  }

  dimension: program_tier {
    view_label: "Main"
    type: string
    sql: ${TABLE}.program_tier ;;
  }

  dimension: scenario {
    view_label: "Main"
    type: string
    sql: ${TABLE}.scenario ;;
  }

  dimension: service {
    view_label: "Main"
    type: string
    sql: ${TABLE}.service ;;
  }

}

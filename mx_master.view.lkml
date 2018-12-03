view: mx_master {
  sql_table_name: analytics.mx_master ;;

  dimension: adgroup_id {
    group_label: "Z - Metadata"
    label: "Ad Group ID [MX_Master]"
    description: "Foreign Key from master metrics table"

    hidden: yes

    type: string

    sql: ${TABLE}.adgroup_id ;;
  }

  dimension_group: date {
    group_label: "Timeframes"
    label: "Timeframes"
    description: "Optional complex dimension for managing timeframes"

    type: time

    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]

    convert_tz: yes
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: device {
    group_label: "Program Dimensions"
    label: "Device"

    type: string

    sql: ${TABLE}.dimensions ->> 'device' ;;
  }

  measure: impressions {
    view_label: "Performance"
    group_label: "Performance Metrics"
    label: "# Impressions"

    type: sum
    value_format_name: decimal_0

    sql: CAST(${TABLE}.measures ->> 'impressions' AS integer);;
  }

}

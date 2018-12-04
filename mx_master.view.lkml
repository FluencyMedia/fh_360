view: mx_master {
  sql_table_name: analytics.mx_master  ;;


  ##########  METADATA  ##########

  dimension: adgroup_id {
    view_label: "Z - Metadata"
    label: "Ad Group ID [MX_Master]"
    description: "Foreign Key from master metrics table"

    hidden: yes

    type: string

    sql: ${TABLE}.adgroup_id ;;  }


  ##########  DIMENSIONS  ##########

  ##### Time Dimensions

  dimension_group: date {
    view_label: "Timeframes"
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
    sql: ${TABLE}.date ;;  }

  measure: date_start {
    view_label: "Timeframes"
    label: "Start Date"

    type: min

    sql: ${date_date} ;;  }

  ##### Channel Dimensions

  dimension: device {
    view_label: "Channel"
    label: "Device"

    type: string

    sql: ${TABLE}.dimensions ->> 'device' ;;  }

  dimension: mode {
    view_label: "Channel"
    group_label: "Display Mechanics"
    label: "Display Mode"

    type: string

    sql: ${TABLE}.dimensions ->> 'display_mode' ;;  }

  dimension: conversion_tracker_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Conversion Tracker ID"

    type: string

    sql: ${TABLE}.dimensions ->> 'conversion_tracker_id' ;;  }


  ##########  MEASURES  ##########

  ##### Base Measures

  measure: impr_sum {
    view_label: "Performance"
    group_label: "Performance Metrics"
    label: "# Impressions"

    type: sum
    value_format_name: decimal_0

    sql: CAST(${TABLE}.measures ->> 'impressions' AS integer);;  }

  measure: clicks_sum {
    view_label: "Performance"
    group_label: "Performance Metrics"
    label: "# Clicks"

    type: sum
    value_format_name: decimal_0

    sql: CAST(${TABLE}.measures ->> 'clicks' AS integer);;  }

  measure: cost_sum {
    view_label: "Performance"
    group_label: "Performance Metrics"
    label: "$ Cost"

    type: sum
    value_format_name: usd_0

    sql: CAST(${TABLE}.measures ->> 'cost' AS double precision);;  }

  measure: outcomes_sum {
    view_label: "Performance"
    group_label: "Outcome Metrics"
    label: "# Outcomes"

    type: sum
    value_format_name: decimal_0

    sql: CAST(${TABLE}.measures ->> 'outcomes' AS integer);;  }

  measure: outcomes_bulk_sum {
    view_label: "Performance"
    group_label: "Outcome Metrics"
    label: "# Outcomes (Bulk)"

    type: sum
    value_format_name: decimal_0

    sql: CAST(${TABLE}.measures ->> 'outcomes_bulk' AS integer);;  }

  ##### Calculated Measures

  measure: ctr {
    view_label: "Performance"
    group_label: "Performance Metrics"
    label: "% CTR"

    type: number
    value_format_name: percent_2

    sql: 1.0*(${clicks_sum}) / nullif(${impr_sum},0) ;;  }

  measure: cpc {
    view_label: "Performance"
    group_label: "Performance Metrics"
    label: "$ CPC"

    type: number
    value_format_name: usd

    sql: 1.0*(${cost_sum}) / nullif(${clicks_sum},0) ;;  }

  measure: cpo {
    view_label: "Performance"
    group_label: "Outcome Metrics"
    label: "$ CPO"
    description: "Cost / Outcome"

    type: number
    value_format_name: usd

    sql: 1.0*(${cost_sum}) / nullif(${outcomes_sum},0) ;;  }


  measure: otr {
    view_label: "Performance"
    group_label: "Outcome Metrics"
    label: "% OTR"
    description: "Outcomes / Clicks"

    type: number
    value_format_name: percent_2

    sql: 1.0*(${outcomes_sum}) / nullif(${clicks_sum},0) ;;  }

}

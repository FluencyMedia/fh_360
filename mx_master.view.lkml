view: mx_master {
  derived_table: {
    sql:
      SELECT
        *
      FROM analytics.mx_master
    ;;
  }

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

    type: date

    sql: MIN(${date_date}) ;;  }

  measure: date_end {
    view_label: "Timeframes"
    label: "End Date"

    type: date

    sql: MAX(${date_date}) ;;  }

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

  ##### Outcome Dimensions

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

  dimension: outcome_intent {
    view_label: "Outcomes"
    label: "Outcome Intent"

    type: string

    sql: ${TABLE}.dimensions ->> 'outcome_intent' ;; }

  dimension: outcome_mechanism {
    view_label: "Outcomes"
    label: "Outcome Mechanism"

    type: string
    sql: ${TABLE}.dimensions ->> 'outcome_mechanism' ;; }

  dimension: outcome_quality {
    view_label: "Outcomes"
    label: "Outcome Quality"

    type: string
    sql: ${TABLE}.dimensions ->> 'outcome_quality' ;; }

  dimension: outcome_score {
    view_label: "Outcomes"
    label: "Outcome Score"

    type: number
    sql: ${TABLE}.dimensions ->> 'outcome_score' ;; }

  dimension: outcome_type {
    view_label: "Outcomes"
    label: "Outcome Type"

    type: string
    sql: ${TABLE}.dimensions ->> 'outcome_type' ;; }

  dimension: outcome_type_name {
    view_label: "Outcomes"
    label: "Outcome Type Name"

    hidden: no

    type: string
    sql: ${TABLE}.dimensions ->> 'outcome_type_name' ;; }

  dimension: lead_qual {
    view_label: "Outcomes"
    label: "Lead Qualification"

    case: {
      when: {
        sql: ${outcome_quality} = "Referrals" ;;
        label: "Leads" }
      when: {
        sql: ${outcome_quality} = "Leads" ;;
        label: "Leads" }
      else: "Outcomes" } }

  measure: avg_conv_score {
    view_label: "Outcomes"
    label: "Avg. Outcome Score"

    type: average
    sql: ${outcome_score} ;;  }


}

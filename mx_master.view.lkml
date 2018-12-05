view: mx_master {
  sql_table_name: analytics.mx_master_material ;;

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
    view_label: "4. Timeframes"
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
    view_label: "4. Timeframes"
    label: "Start Date"

    type: date

    sql: MIN(${date_date}) ;;  }

  measure: date_end {
    view_label: "4. Timeframes"
    label: "End Date"

    type: date

    sql: MAX(${date_date}) ;;  }

  ##### Channel Dimensions

  dimension: device {
    view_label: "3. Channel"
    label: "Device"

    type: string

    sql: ${TABLE}.dimensions ->> 'device' ;;  }

  dimension: mode {
    view_label: "3. Channel"
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
    view_label: "5. Performance"
    label: "# Impressions"

    type: sum
    value_format_name: decimal_0

    sql: CAST(${TABLE}.measures ->> 'impressions' AS integer);;  }

  measure: clicks_sum {
    view_label: "5. Performance"
    label: "# Clicks"

    type: sum
    value_format_name: decimal_0

    sql: CAST(${TABLE}.measures ->> 'clicks' AS integer);;  }

  measure: cost_sum {
    view_label: "5. Performance"
    label: "$ Cost"

    type: sum
    value_format_name: usd_0

    sql: CAST(${TABLE}.measures ->> 'cost' AS double precision);;  }

  measure: outcomes_sum {
    view_label: "6. Outcomes"
    label: "# Outcomes"

    type: sum
    value_format_name: decimal_0

    sql: CAST(${TABLE}.measures ->> 'outcomes' AS integer);;  }

  measure: outcomes_bulk_sum {
    view_label: "6. Outcomes"
    label: "# Outcomes (Bulk)"

    type: sum
    value_format_name: decimal_0

    sql: CAST(${TABLE}.measures ->> 'outcomes_bulk' AS integer);;  }

  ##### Calculated Measures

  measure: ctr {
    view_label: "5. Performance"
    label: "% CTR"

    type: number
    value_format_name: percent_2

    sql: 1.0*(${clicks_sum}) / nullif(${impr_sum},0) ;;  }

  measure: cpc {
    view_label: "5. Performance"
    label: "$ CPC"

    type: number
    value_format_name: usd

    sql: 1.0*(${cost_sum}) / nullif(${clicks_sum},0) ;;  }

  measure: cpo {
    view_label: "6. Outcomes"
    label: "$ CPO"
    description: "Cost / Outcome"

    type: number
    value_format_name: usd

    sql: 1.0*(${cost_sum}) / nullif(${outcomes_sum},0) ;;  }


  measure: otr {
    view_label: "6. Outcomes"
    label: "% OTR"
    description: "Outcomes / Clicks"

    type: number
    value_format_name: percent_2

    sql: 1.0*(${outcomes_sum}) / nullif(${clicks_sum},0) ;;  }

  dimension: outcome_intent {
    view_label: "6. Outcomes"
    label: "Outcome Intent"

    type: string

    sql: ${TABLE}.dimensions ->> 'outcome_intent' ;; }

  dimension: outcome_mechanism {
    view_label: "6. Outcomes"
    label: "Outcome Mechanism"

    type: string
    sql: ${TABLE}.dimensions ->> 'outcome_mechanism' ;; }

  dimension: outcome_quality {
    view_label: "6. Outcomes"
    label: "Outcome Quality"

    type: string
    sql: ${TABLE}.dimensions ->> 'outcome_quality' ;; }

  dimension: outcome_score {
    view_label: "6. Outcomes"
    label: "Outcome Score"

    type: number
    sql: ${TABLE}.dimensions ->> 'outcome_score' ;; }

  dimension: outcome_type {
    view_label: "6. Outcomes"
    label: "Outcome Type"

    type: string
    sql: ${TABLE}.dimensions ->> 'outcome_type' ;; }

  dimension: outcome_type_name {
    view_label: "6. Outcomes"
    label: "Outcome Type Name"

    hidden: no

    type: string
    sql: ${TABLE}.dimensions ->> 'outcome_type_name' ;; }

  measure: o_referrals_num {
    view_label: "Z - Metadata"
    group_label: "Isolated Measures"
    label: "# Outcomes (Referrals)"
    description: "ISOLATED: Outcome Quality = 'Referrals'"

    type: sum
    sql: (${TABLE}.measures ->> 'outcomes')::integer ;;
    value_format_name: decimal_0

    filters: {
      field: outcome_quality
      value: "Referrals"  }  }

  measure: o_leads_num {
    view_label: "Z - Metadata"
    group_label: "Isolated Measures"
    label: "# Outcomes (Leads)"
    description: "ISOLATED: Outcome Quality = 'Leads'"

    type: sum
    sql: (${TABLE}.measures ->> 'outcomes')::integer ;;
    value_format_name: decimal_0

    filters: {
      field: outcome_quality
      value: "Leads"    }  }

  measure: o_outcomes_num {
    view_label: "Z - Metadata"
    group_label: "Isolated Measures"
    label: "# Outcomes (Outcomes)"
    description: "ISOLATED: Outcome Quality = 'Outcomes'"

    type: sum
    sql: (${TABLE}.measures ->> 'outcomes')::integer ;;
    value_format_name: decimal_0

    filters: {
      field: outcome_quality
      value: "Outcomes" }  }

  measure: leads_total {
    view_label: "6. Outcomes"
    label: "# Leads"
    description: "AGGREGATED: # Outcomes (Referrals) + # Outcomes (Leads)"

    type: number
    sql: ${o_referrals_num} + ${o_leads_num} ;;
    value_format_name: decimal_0
  }

  measure: cpl {
    view_label: "6. Outcomes"
    label: "$ CPL"
    description: "$ Cost / # Leads"

    type: number
    value_format_name: usd

    sql: 1.0*(${cost_sum}) / nullif(${leads_total},0) ;;  }

  measure: ltr {
    view_label: "6. Outcomes"
    label: "% LTR"
    description: "# Leads / # Clicks"

    type: number
    value_format_name: percent_2

    sql: 1.0*(${leads_total}) / nullif(${clicks_sum},0) ;;  }



  measure: avg_conv_score {
    view_label: "6. Outcomes"
    label: "Avg. Outcome Score"

    type: average
    value_format_name: decimal_1
    sql: ${outcome_score} ;;  }


}

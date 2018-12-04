view: arch_outcomes {
  sql_table_name: analytics.arch_outcomes ;;

  dimension: conversion_tracker_id {
    view_label: "Z - Metadata"
    label: "Conversion Tracker ID"

    hidden: no

    type: string
    sql: ${TABLE}.conversion_tracker_id ;;
  }

  dimension: conversion_intent {
    view_label: "Outcomes"
    label: "Outcome Intent"

    type: string

    sql: ${TABLE}.conversion_intent ;;
  }

  dimension: conversion_mechanism {
    view_label: "Outcomes"
    label: "Outcome Mechanism"

    type: string
    sql: ${TABLE}.conversion_mechanism ;;
  }

  dimension: conversion_quality {
    view_label: "Outcomes"
    label: "Outcome Quality"

    type: string
    sql: ${TABLE}.conversion_quality ;;
  }

  dimension: conversion_score {
    view_label: "Outcomes"
    label: "Outcome Score"

    type: number
    sql: ${TABLE}.conversion_score ;;
  }

  dimension: conversion_type {
    view_label: "Outcomes"
    label: "Outcome Type"

    type: string
    sql: ${TABLE}.conversion_type ;;
  }

  dimension: conversion_type_name {
    view_label: "Outcomes"
    label: "Outcome Type Name"

    hidden: no

    type: string
    sql: ${TABLE}.conversion_type_name ;;
  }

  dimension: lead_qual {
    view_label: "Outcomes"
    label: "Lead Qualification"

    case: {
      when: {
        sql: ${conversion_quality} = "Referrals" ;;
        label: "Leads"
      }
      when: {
        sql: ${conversion_quality} = "Leads" ;;
        label: "Leads"
      }
      else: "Outcomes"
    }
  }

  measure: avg_conv_score {
    view_label: "Outcomes"
    label: "Avg. Outcome Score"

    type: average
    sql: ${conversion_score} ;;
  }


}

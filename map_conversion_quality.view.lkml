view: map_conversion_quality {
  sql_table_name: analytics.map_conversion_quality ;;

  dimension: conversion_intent {
    type: string
    sql: ${TABLE}.conversion_intent ;;
  }

  dimension: conversion_quality {
    type: string
    sql: ${TABLE}.conversion_quality ;;
  }

  dimension: conversion_score {
    type: number
    sql: ${TABLE}.conversion_score ;;
  }
}

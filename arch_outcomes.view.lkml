view: arch_outcomes {
  sql_table_name: analytics.arch_outcomes ;;


  ##########  METADATA  ##########

  dimension: outcome_tracker_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Outcome Tracker ID [Arch_Outcomes]"
    type: string

    hidden: no

    sql: ${TABLE}.outcome_tracker_id ;;
  }


  ##########  DIMENSIONS  ##########

  dimension: outcome_intent {
    view_label: "6. Outcomes"
    label: "Outcome Intent"

    type: string
    sql: ${TABLE}.outcome_intent ;;
  }

  dimension: outcome_mechanism {
    view_label: "6. Outcomes"
    label: "Outcome Mechanism"

    type: string
    sql: ${TABLE}.outcome_mechanism ;;
  }

  dimension: outcome_quality {
    view_label: "6. Outcomes"
    label: "Outcome Quality"

    type: string
    sql: ${TABLE}.outcome_quality ;;
  }

  dimension: outcome_score {
    view_label: "6. Outcomes"
    label: "Outcome Score"

    type: number
    sql: ${TABLE}.outcome_score ;;
  }

  dimension: outcome_type {
    view_label: "6. Outcomes"
    label: "Outcome Type"

    type: string
    sql: ${TABLE}.outcome_type ;;
  }

  dimension: outcome_type_name {
    view_label: "6. Outcomes"
    label: "Outcome Type Name"

    type: string
    sql: ${TABLE}.outcome_type_name ;;
  }
}

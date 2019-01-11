connection: "fh_analytics"

datagroup: mp360_datagroup {
  sql_trigger:  SELECT
                  MAX(trg.last_updated)
                FROM (
                  SELECT mx.last_updated from analytics.mx_master mx
                  UNION ALL
                  SELECT ap.last_updated from analytics.arch_program ap
                  UNION ALL
                  SELECT ao.last_updated from analytics.arch_outcomes ao
                  UNION ALL
                  SELECT ac.last_updated from analytics.arch_clients ac
                ) trg ;;
  max_cache_age: "1 hour"
}

include: "*.view.lkml"                       # include all views in this project
include: "*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

access_grant: access_dev_fields {
  user_attribute: access_dev_fields
  allowed_values: ["yes"]
}

persist_with: mp360_datagroup


explore: mx_master {
  view_name: mx_master
  view_label: "Marketing - Daily (Master)"

  group_label: "MedPath360"
  label: "Marketing - Daily (Master)"

  join: arch_program {
    relationship: one_to_many
    type: full_outer
    sql_on: ${mx_master.adgroup_id} = ${arch_program.adgroup_id} ;;
  }

  join: arch_outcomes {
    relationship: one_to_many
    type: full_outer
    sql_on: ${mx_master.outcome_tracker_id} = ${arch_outcomes.outcome_tracker_id} ;; }

  join: arch_clients {
    relationship: one_to_many
    type: full_outer
    sql_on: ${arch_program.organization_id} = ${arch_clients.organization_id} ;;
  }

  join: subtotal_over {
    type: cross
    relationship: one_to_many
  }

  join: pref_styles {
    type: left_outer
    relationship: many_to_one

    sql_on: ${subtotal_over.row_type_description} = ${pref_styles.class} ;;
  }

}


explore: mx_master_month {
  group_label: "MedPath360"
  label: "Marketing - Monthly (Master)"

  join: arch_program {
    relationship: one_to_many
    type: full_outer
    sql_on: ${mx_master_month.adgroup_id} = ${arch_program.adgroup_id} ;;
  }

  join: arch_outcomes {
    relationship: one_to_many
    type: full_outer
    sql_on: ${mx_master_month.outcome_tracker_id} = ${arch_outcomes.outcome_tracker_id} ;; }

  join: arch_clients {
      relationship: one_to_many
    type: full_outer
    sql_on: ${arch_program.organization_id} = ${arch_clients.organization_id} ;;
  }

  join: subtotal_over {
    type: cross
    relationship: one_to_many
  }

  join: pref_styles {
    type: left_outer
    relationship: many_to_one

    sql_on: ${subtotal_over.row_type_description} = ${pref_styles.class} ;;
  }

}

explore: mx_core_month {
  group_label: "MedPath360"
  label: "Marketing - Monthly (Core)"

  join: arch_program {
    relationship: one_to_many
    type: full_outer
    sql_on: ${mx_core_month.adgroup_id} = ${arch_program.adgroup_id} ;;
  }

  join: arch_outcomes {
    relationship: one_to_many
    type: full_outer
    sql_on: ${mx_core_month.outcome_tracker_id} = ${arch_outcomes.outcome_tracker_id} ;; }

  join: arch_clients {
    relationship: one_to_many
    type: full_outer
    sql_on: ${arch_program.organization_id} = ${arch_clients.organization_id} ;;
  }

  join: subtotal_over {
    type: cross
    relationship: one_to_many
  }

  join: pref_styles {
    type: left_outer
    relationship: many_to_one

    sql_on: ${subtotal_over.row_type_description} = ${pref_styles.class} ;;
  }

}

explore: mx_core_day {
  group_label: "MedPath360"
  label: "Marketing - Monthly (Day)"

  join: arch_program {
    relationship: one_to_many
    type: full_outer
    sql_on: ${mx_core_day.adgroup_id} = ${arch_program.adgroup_id} ;;
  }

  join: arch_outcomes {
    relationship: one_to_many
    type: full_outer
    sql_on: ${mx_core_day.outcome_tracker_id} = ${arch_outcomes.outcome_tracker_id} ;; }

  join: arch_clients {
    relationship: one_to_many
    type: full_outer
    sql_on: ${arch_program.organization_id} = ${arch_clients.organization_id} ;;
  }

  join: subtotal_over {
    type: cross
    relationship: one_to_many
  }

  join: pref_styles {
    type: left_outer
    relationship: many_to_one

    sql_on: ${subtotal_over.row_type_description} = ${pref_styles.class} ;;
  }

}

explore: arch_program {
  group_label: "MedPath360"
  label: "MP360 - Marketing Insights"

  join: mx_master {
    relationship: one_to_many
    sql_on: ${arch_program.adgroup_id} = ${mx_master.adgroup_id} ;; }

  join: arch_outcomes {
    relationship: many_to_one
    sql_on: ${mx_master.outcome_tracker_id} = ${arch_outcomes.outcome_tracker_id} ;; }

  join: arch_clients {
    relationship: many_to_one
    sql_on: ${arch_program.organization_id} = ${arch_clients.organization_id} ;;
  }

  join: subtotal_over {
    type: cross
    relationship: one_to_many
  }

  join: pref_styles {
    type: left_outer
    relationship: many_to_one

    sql_on: ${subtotal_over.row_type_description} = ${pref_styles.class} ;;
  }

}

connection: "fh_analytics"

datagroup: mp360_datagroup {
  sql_trigger: SELECT MAX(mx.last_updated) FROM analytics.mx_master mx ;;
  max_cache_age: "24 hours"
}

include: "*.view.lkml"                       # include all views in this project
include: "*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

access_grant: access_dev_fields {
  user_attribute: access_dev_fields
  allowed_values: ["yes"]
}

explore: arch_program {
  group_label: "MedPath360"
  label: "MedPath360 - Marketing Insights"

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


}

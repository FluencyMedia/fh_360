connection: "fh_analytics"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


explore: arch_program {
  group_label: "MedPath360"
  label: "MedPath360 - Marketing Insights"

  join: mx_master {
    relationship: one_to_many
    sql_on: ${arch_program.adgroup_id} = ${mx_master.adgroup_id} ;; }

join: arch_outcomes {
  relationship: many_to_one
  sql_on: ${mx_master.outcome_tracker_id} = ${arch_outcomes.outcome_tracker_id} ;; }

}

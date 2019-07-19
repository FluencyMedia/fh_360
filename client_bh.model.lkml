label: "BH Dataset"

connection: "fh_analytics"

datagroup: dg_paid {
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
  max_cache_age: "24 hours"
}

include: "*.view.lkml"                       # include all views in this project
include: "*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

persist_with: dg_paid


explore: mx_core_month_bh {
  group_label: "Beaumont Health"
  label: "BH Marketing - Monthly (Core)"
  hidden: yes

  join: arch_program {
    relationship: one_to_many
    type: left_outer
    sql_on: ${mx_core_month_bh.adgroup_id} = ${arch_program.adgroup_id} ;;
  }

  join: arch_outcomes {
    relationship: one_to_many
    type: left_outer
    sql_on: ${mx_core_month_bh.outcome_tracker_id} = ${arch_outcomes.outcome_tracker_id} ;; }

  join: arch_clients_hidden {
    relationship: one_to_many
    type: left_outer
    sql_on: ${arch_program.organization_id} = ${arch_clients_hidden.organization_id} ;;
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

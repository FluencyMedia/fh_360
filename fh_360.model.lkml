connection: "fh_analytics"

label: "Marketing Data - ALL CLIENTS"

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

explore: list_phases {
  hidden: yes
  group_label: "Breadcrumb Marketing"
  label: "Marketing Phases"
}

explore: mx_master {
  view_name: mx_master
  view_label: "ALL CLIENTS - Daily (Master)"
  hidden: yes

  group_label: "All Clients"
  label: "ALL CLIENTS - Daily (Master)"

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
  group_label: "All Clients"
  label: "ALL CLIENTS - Monthly (Master)"
  hidden: yes

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
  group_label: "All Clients"
  label: "ALL CLIENTS - Monthly (Core)"
  hidden: yes

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
  group_label: "All Clients"
  label: "ALL CLIENTS - Daily (Core)"
  hidden: yes

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
  group_label: "All Clients"
  label: "ALL CLIENTS - Marketing Insights"
  hidden: yes

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

include: "mx_master.view.lkml"

view: mx_core_month_bh {
  extends: [mx_master]

  derived_table: {
    datagroup_trigger: dg_paid

    sql:  SELECT
            mxcm.row_id,
            mxcm.last_updated,
            mxcm.date,
            mxcm.adgroup_id,
            mxcm.outcome_tracker_id,
            mxcm.mode,
            mxcm.impressions,
            mxcm.clicks,
            mxcm.cost,
            mxcm.outcomes,
            mxcm.outcomes_bulk
          FROM analytics.mx_core_month mxcm
          LEFT JOIN analytics.arch_program ap ON mxcm.adgroup_id = ap.adgroup_id
          LEFT JOIN analytics.arch_clients ac ON ap.organization_id = ac.organization_id
          WHERE ac.client_id = 'CLIENT-00001';;

          indexes: ["row_id", "adgroup_id", "date", "outcome_tracker_id", "mode"]
  }

  dimension: row_id {
    hidden: yes
  }

  dimension: adgroup_id {
    hidden: yes
  }

  dimension: outcome_tracker_id {
    hidden: yes
  }

  dimension: client {
    hidden: yes
  }

}

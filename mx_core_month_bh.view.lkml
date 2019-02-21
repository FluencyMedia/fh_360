include: "mx_master.view.lkml"

view: mx_core_month_bh {
  extends: [mx_master]

  derived_table: {
    datagroup_trigger: dg_paid

    sql:  SELECT
            mxcm.*
          FROM analytics.mx_core_month mxcm
          LEFT JOIN analytics.arch_program ap ON ap.adgroup_id = mxcm.adgroup_id
          LEFT JOIN analytics.arch_clients ac ON ap.organization_id = ac.organization_id
          WHERE ac.client_id = 'CLIENT-00001';;

          indexes: ["adgroup_id"]
  }

}

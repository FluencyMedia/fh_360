include: "mx_master.view.lkml"

view: mx_master_month {
  extends: [mx_master]

  sql_table_name: analytics.mx_master_month ;;
}

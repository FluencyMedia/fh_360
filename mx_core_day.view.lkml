include: "mx_master.view.lkml"

view: mx_core_day {
  extends: [mx_master]

  sql_table_name: analytics.mx_core_day ;;
}

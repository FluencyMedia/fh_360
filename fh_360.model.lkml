connection: "fh_analytics"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }


explore: arch_program {
  label: "Program Architecture"

  join: mx_master {
    relationship: one_to_many
    sql_on: ${arch_program.adgroup_id} = ${mx_master.adgroup_id} ;;
  }
}

explore: mx_master {
  label: "MX Master"

}

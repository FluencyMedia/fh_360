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

explore: list_accounts {
  label: "FH 360 - Accounts"
  join: list_campaigns {
    relationship: one_to_many
    type: left_outer

    sql_on: ${list_accounts.account_id} = ${list_campaigns.account_id} ;;
  }
}

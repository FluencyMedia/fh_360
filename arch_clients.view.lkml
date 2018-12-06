view: arch_clients {
  view_label: "Client Architecture"
  sql_table_name: analytics.arch_clients ;;


  ##########  METADATA  ##########

  dimension: client_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Client ID"
    description: "ID for Primary MP360 Client Account"

    hidden: no

    type: string

    sql: ${TABLE}.client_id ;;
  }

  dimension: organization_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Organization ID [Arch_Clients]"
    description: "ID for Organization Within MP360 Client Account"

    hidden: no

    type: string

    sql: ${TABLE}.organization_id ;;
  }

  dimension: account_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Channel Account ID"
    description: "ID For Respective 'Channel' Account (Adwords, Display, etc.)"

    hidden: no

    type: string

    sql: ${TABLE}.account_id ;;
  }


  ##########  DIMENSIONS  ##########

  dimension: client {
    view_label: "1. Client/Account"
    label: "Client Account"
    description: "Primary MP360 Client Account"

    type: string
    sql: ${TABLE}.client ;;
  }

  dimension: organization {
    view_label: "1. Client/Account"
    label: "Client Organization"
    description: "Internal Organization Within MP360 Client Account"

    type: string
    sql: ${TABLE}.organization ;;
  }

  dimension: org_short {
    view_label: "1. Client/Account"
    label: "Client Org"
    description: "Short Name for Internal Organization"

    type: string
    sql: ${TABLE}.org_short ;;
  }

  dimension: account {
    view_label: "1. Client/Account"
    label: "Channel Account"
    description: "ID For Respective 'Channel' Account (Adwords, Display, etc.)"

    type: string
    sql: ${TABLE}.account ;;
  }

  ##########  MEASURES  ##########
  measure: num_clients {
    view_label: "Z - Metadata"
    group_label: "Category Counts"
    label: "# Clients"
    description: "Number of MP360 Client Accounts"
    type: count_distinct

    sql: ${client_id} ;;
  }

  measure: num_orgs {
    view_label: "Z - Metadata"
    group_label: "Category Counts"
    label: "# Organizations"
    description: "Number of MP360 Client Organizations"
    type: count_distinct

    sql: ${organization_id} ;;
  }

  measure: num_accounts {
    view_label: "Z - Metadata"
    group_label: "Category Counts"
    label: "# Accounts"
    description: "Number of Digital Channel Accounts"
    type: count_distinct

    sql: ${account_id} ;;
  }


  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: arch_clients {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }

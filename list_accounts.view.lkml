view: list_accounts {
  sql_table_name: analytics.list_accounts ;;

  ########## METADATA ##########

  dimension: account_id {
    view_label: "Z - Meta"
    group_label: "DB IDs"
    label: "Account ID [Account]"
    description: "Account ID from 'list_accounts'"
    hidden: no

    type: string

    sql: ${TABLE}.account_id ;;
  }


  ########## DIMENSIONS ##########

  dimension: account {
    view_label: "Clients"
    group_label: "Account Info"
    label: "Client Account"
    description: "Name of client"
    hidden: no

    type: string

    sql: ${TABLE}.account ;;
  }

}

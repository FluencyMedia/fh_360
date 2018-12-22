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


  ##########  DIMENSIONS  ##########

  set: drill_client {
    fields: [
      organization,
      arch_program.program
    ]
  }

  dimension: client {
    view_label: "1. Client/Account"
    label: "Client Account"
    description: "Primary MP360 Client Account"

    drill_fields: [
      drill_client*
    ]

    type: string
    sql: ${TABLE}.client ;;
  }

  dimension: client_html {
    view_label: "1. Client/Account"
    label: "Client [HTML]"

    type: string

    sql: ${TABLE}.client ;;

    html:
        <div>
        <p>{{rendered_value}}</p>
        </div>
         ;;
  }

  dimension: organization {
    view_label: "1. Client/Account"
    label: "Client Organization"
    description: "Internal Organization Within MP360 Client Account"

    drill_fields: [
      drill_client*,
      -client
    ]

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

  ##########  MEASURES  ##########
  measure: num_clients {
    view_label: "1. Client/Account"
    group_label: "Z - Category Counts"
    label: "# Clients"
    description: "Number of MP360 Client Accounts"
    type: count_distinct
    value_format_name: decimal_0

    sql: ${client_id} ;;
  }

  measure: num_orgs {
    view_label: "1. Client/Account"
    group_label: "Z - Category Counts"
    label: "# Organizations"
    description: "Number of MP360 Client Organizations"
    type: count_distinct
    value_format_name: decimal_0

    sql: ${organization_id} ;;
  }


}

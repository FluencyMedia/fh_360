view: arch_program {
  sql_table_name: analytics.arch_program ;;


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
    label: "Organization ID"
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

  dimension: campaign_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Campaign ID"
    description: "Campaign ID"

    hidden: no

    type: string

    sql: ${TABLE}.campaign_id ;;
  }

  dimension: adgroup_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Adgroup ID"
    description: "Ad Group ID"

    hidden: no

    type: string

    sql: ${TABLE}.adgroup_id ;;
  }


  ##########  DIMENSIONS  ##########

  dimension: client {
    view_label: "Client/Account Dimensions"
    label: "Client Account"
    description: "Primary MP360 Client Account"

    type: string
    sql: ${TABLE}.client ;;
  }

  dimension: organization {
    view_label: "Client/Account Dimensions"
    label: "Client Organization"
    description: "Internal Organization Within MP360 Client Account"

    type: string
    sql: ${TABLE}.organization ;;
  }

  dimension: account {
    view_label: "Client/Account Dimensions"
    label: "Channel Account"
    description: "ID For Respective 'Channel' Account (Adwords, Display, etc.)"

    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: medium {
    view_label: "Client/Account Dimensions"
    label: "Medium"
    description: "Digital Channel Used"

    type: string
    sql: ${TABLE}.medium ;;
}

  dimension: campaign {
    view_label: "Program Dimensions"
    group_label: "Campaign Architecture"
    label: "Campaign"
    description: "Campaign Within Digital Channel"

    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: adgroup {
    view_label: "Program Dimensions"
    group_label: "Campaign Architecture"
    label: "Ad Group"
    description: "Adgroup Within Digital Channel"

    type: string
    sql: ${TABLE}.adgroup ;;
  }

  dimension: service_line_code {
    view_label: "Program Dimensions"
    group_label: "Service Architecture"
    label: "Service Line Code"
    description: "Service Line Code"

    type: string
    sql: ${TABLE}.service_line_code ;;
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

  measure: num_campaigns {
    view_label: "Z - Metadata"
    group_label: "Category Counts"
    label: "# Campaigns"
    description: "Number of Digital Channel Campaigns"
    type: count_distinct

    sql: ${campaign_id} ;;
  }


  measure: num_adgroups {
    view_label: "Z - Metadata"
    group_label: "Category Counts"
    label: "# Ad Groups"
    description: "Number of Digital Channel Ad Groups"
    type: count_distinct

    sql: ${adgroup_id} ;;
  }
}

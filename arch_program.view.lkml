view: arch_program {
  sql_table_name: analytics.arch_program ;;


  ##########  METADATA  ##########

  dimension: client_id {
    group_label: "Z - Metadata"
    label: "Client ID"
    description: "ID for Primary MP360 Client Account"

    hidden: no

    type: string

    sql: ${TABLE}.client_id ;;
  }

  dimension: organization_id {
    group_label: "Z - Metadata"
    label: "Organization ID"
    description: "ID for Organization Within MP360 Client Account"

    hidden: no

    type: string

    sql: ${TABLE}.organization_id ;;
  }

  dimension: account_id {
    group_label: "Z - Metadata"
    label: "Channel Account ID"
    description: "ID For Respective 'Channel' Account (Adwords, Display, etc.)"

    hidden: no

    type: string

    sql: ${TABLE}.account_id ;;
  }

  dimension: campaign_id {
    group_label: "Z - Metadata"
    label: "Campaign ID"
    description: "Campaign ID"

    hidden: no

    type: string

    sql: ${TABLE}.campaign_id ;;
  }

  dimension: adgroup_id {
    group_label: "Z - Metadata"
    label: "Adgroup ID"
    description: "Ad Group ID"

    hidden: no

    type: string

    sql: ${TABLE}.adgroup_id ;;
  }


  ##########  DIMENSIONS  ##########

  dimension: client {
    group_label: "Client/Account Dimensions"
    label: "Client Account"
    description: "Primary MP360 Client Account"

    type: string
    sql: ${TABLE}.client ;;
  }

  dimension: organization {
    group_label: "Client/Account Dimensions"
    label: "Client Organization"
    description: "Internal Organization Within MP360 Client Account"

    type: string
    sql: ${TABLE}.organization ;;
  }

  dimension: account {
    group_label: "Client/Account Dimensions"
    label: "Channel Account"
    description: "ID For Respective 'Channel' Account (Adwords, Display, etc.)"

    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: medium {
    group_label: "Client/Account Dimensions"
    label: "Medium"
    description: "Digital Channel Used"

    type: string
  sql: ${TABLE}.medium ;;
}

  dimension: campaign {
    group_label: "Program Dimensions"
    label: "Campaign"
    description: "Campaign Within Digital Channel"

    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: adgroup {
    group_label: "Program Dimensions"
    label: "Ad Group"
    description: "Adgroup Within Digital Channel"

    type: string
    sql: ${TABLE}.adgroup ;;
  }

}

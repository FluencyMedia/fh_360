view: arch_program {
  sql_table_name: analytics.arch_program ;;


  ##########  METADATA  ##########

  dimension: organization_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Organization ID [Arch_Program]"
    description: "Organization ID [Arch_Program]"

    hidden: no

    type: string

    sql: ${TABLE}.organization_id ;;
  }

  dimension: campaign_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Campaign ID [Arch_Program]"
    description: "Campaign ID"

    hidden: no

    type: string

    sql: ${TABLE}.campaign_id ;;
  }

  dimension: adgroup_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Adgroup ID [Arch_Program]"
    description: "Ad Group ID"

    hidden: no

    type: string

    sql: ${TABLE}.adgroup_id ;;
  }


  ##########  DIMENSIONS  ##########

  dimension: medium {
    view_label: "3. Channel"
    label: "Medium"
    description: "Digital Channel Used"

    type: string
    sql: ${TABLE}.medium ;;
}

  dimension: campaign {
    view_label: "3. Channel"
    group_label: "Campaign Architecture"
    label: "Campaign"
    description: "Campaign Within Digital Channel"

    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: adgroup {
    view_label: "3. Channel"
    group_label: "Campaign Architecture"
    label: "Ad Group"
    description: "Adgroup Within Digital Channel"

    type: string
    sql: ${TABLE}.adgroup ;;
  }

  dimension: service_line {
    view_label: "2. Services"
    label: "Service Line"
    description: "Service Line"

    type: string
    sql: ${TABLE}.service_line ;;
  }

  dimension: program {
    view_label: "2. Services"
    label: "Program"
    description: "Service Line Program"

    type: string
    sql: ${TABLE}.program ;;
  }

  dimension: service_line_code {
    view_label: "2. Services"
    group_label: "Service Architecture"
    label: "Service Line Code"
    description: "Service Line Code"

    type: string
    sql: ${TABLE}.service_line_code ;;
  }

  dimension: agency {
    view_label: "1. Client/Account"
    label: "Agency"
    description: "Agency Managing Any Given Campaign"

    type: string
    sql: ${TABLE}.agency ;;
  }


  ##########  MEASURES  ##########

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

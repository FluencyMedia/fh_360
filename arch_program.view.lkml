view: arch_program {
  sql_table_name: analytics.arch_program ;;


  #>>>>>>>>>  METADATA  {

    dimension: organization_id {
      view_label: "Z - Metadata"
      group_label: "Database IDs"
      label: "Organization ID [Arch_Program]"
      description: "Organization ID [Arch_Program]"

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

    measure: num_accounts {
      view_label: "Z - Metadata"
      group_label: "Category Counts"
      label: "# Accounts"
      description: "Number of Digital Channel Accounts"
      type: count_distinct

      sql: ${account_id} ;;
    }

  #<<<<<<<<<  METADATA  }  <<<<<<<<<#



  ##########  DIMENSIONS  { ##########

      dimension: rel_client {
        view_label: "1. Client/Account"
        group_label: "Relative Dimensions"
        label: "Related Client"

        hidden: no

        type: string

        sql: ${arch_clients.client} ;;
      }



      dimension: rel_program_main {
        view_label: "2. Services"
        group_label: "Relative Dimensions"
        label: "{% if campaign._is_filtered %}
                [Ad Group]
              {% elsif campaign_group._is_filtered %}
                [Campaign]
              {% elsif service_line._is_filtered %}
                [Campaign Group]
              {% elsif program._is_filtered %}
                [Service]
              {% else %}
                [Program]
              {% endif %}"

        type: string

        sql:  {% if campaign._is_filtered %}
                ${adgroup}
              {% elsif campaign_group._is_filtered %}
                ${campaign}
              {% elsif service_line._is_filtered %}
                ${campaign_group}
              {% elsif program._is_filtered %}
                ${service_line}
              {% else %}
                ${program}
              {% endif %} ;;
      }

      dimension: rel_program_detail {
        view_label: "2. Services"
        group_label: "Relative Dimensions"
        label: "{% if service_line._is_filtered %}
                    [[Campaign]]
                  {% elsif program._is_filtered %}
                    [[Campaign Group]]
                  {% else %}
                    [[Agency]]
                  {% endif %}"

        type: string

        sql:  {% if service_line._is_filtered %}
                    ${campaign}
                  {% elsif program._is_filtered %}
                    ${campaign_group}
                  {% else %}
                    ${agency}
                  {% endif %} ;;
      }



      dimension: medium {
        view_label: "3. Channel"
        label: "Medium"
        description: "Digital Channel Used"

        type: string
        sql: ${TABLE}.medium ;;
      }

      dimension: account {
        view_label: "1. Client/Account"
        label: "Channel Account"
        description: "ID For Respective 'Channel' Account (Adwords, Display, etc.)"

        type: string
        sql: ${TABLE}.account ;;
      }

      dimension: campaign {
        view_label: "3. Channel"
        group_label: "Campaign Architecture"
        label: "Campaign"
        description: "Campaign Within Digital Channel"

        type: string
        sql: ${TABLE}.campaign ;;
      }

      dimension: campaign_group {
        view_label: "3. Channel"
        group_label: "Campaign Architecture"
        label: "Campaign Group"
        description: "Campaign Group Within Digital Channel"

        type: string
        sql: ${TABLE}.campaign_group ;;
      }

      dimension: campaign_region {
        view_label: "3. Channel"
        group_label: "Campaign Geography"
        label: "Region"

        type: string
        sql: ${TABLE}.campaign_region ;;
      }

      dimension: campaign_location {
        view_label: "3. Channel"
        group_label: "Campaign Geography"

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

  ##########  DIMENSIONS  }  ##########



  ##########  MEASURES  { ##########

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

  ##########  MEASURES } ##########


}

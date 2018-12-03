view: list_campaigns {
# Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
      SELECT
        *
      FROM analytics.list_campaigns_aw AS lc_aw
      UNION ALL
      SELECT
        *
      FROM analytics.list_campaigns_display AS lc_d
    ;;
  }


  ########## METADATA ##########

  dimension: account_id {
    view_label: "Z - Meta"
    group_label: "DB IDs"
    label: "Account ID [Campaign]"
    description: "Account ID from 'list_campaigns'"
    hidden: no

    type: string

    sql: ${TABLE}.account_id ;;
  }

  dimension: campaign_id {
    view_label: "Z - Meta"
    group_label: "DB IDs"
    label: "Campaign ID [Campaign]"
    description: "Campaign ID from 'list_campaigns'"
    hidden: no

    type: string

    sql: ${TABLE}.account_id ;;
  }


  ########## DIMENSIONS ##########

  dimension: campaign {
    view_label: "Campaigns"
    group_label: "Campaign Info"
    label: "Campaign"
    hidden: no

    type: string

    sql: ${TABLE}.campaign ;;
  }
}




##### SCROLL ANCHOR

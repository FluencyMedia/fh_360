view: map_campaign_architecture {
  derived_table: {
    sql:
      SELECT
        *
      FROM analytics.map_campaign_architecture_aw AS mca_aw
      UNION ALL
      SELECT
        *
      FROM analytics.map_campaign_architecture_display AS mca_d
    ;;
  }
}

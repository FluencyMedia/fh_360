view: list_adgroups {
# Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
      SELECT
        *
      FROM analytics.list_adgroups_aw AS lag_aw
      UNION ALL
      SELECT
        *
      FROM analytics.list_adgroups_display AS lag_d
    ;;
  }
}

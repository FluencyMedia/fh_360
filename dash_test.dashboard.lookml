- dashboard: test_dashboard
  title: Test Dashboard
  layout: newspaper
  elements:
  - title: Test Table
    name: Test Table
    model: fh_360
    explore: mx_master_month
    type: table
    fields:
    - mx_master_month.date_month
    - arch_program.program
    - mx_master_month.referrals_total
    - mx_master_month.cpr
    pivots:
    - arch_program.program
    fill_fields:
    - mx_master_month.date_month
    filters:
      arch_clients.client: Beaumont Health
      arch_program.medium: PPC
      arch_program.agency: Fluency
    sorts:
    - mx_master_month.date_month desc
    - arch_program.program
    limit: 500
    query_timezone: America/New_York
    row: 0
    col: 0
    width: 15
    height: 8

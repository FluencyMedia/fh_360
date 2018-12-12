- dashboard: dash_perf_test
  title: Performance Dashboard - Grid
  layout: grid
  rows:
  - elements: [display_flights]
  elements:
  - title: Display Flights
    name: display_flights
    model: fh_360
    explore: arch_program
    type: looker_timeline
    fields:
    - arch_program.rel_program_main
    - mx_master.date_start
    - mx_master.date_end
    - mx_master.ctr
    - mx_master.rel_medium_mode
    filters:
      mx_master.date_start: NOT NULL
    sorts:
    - arch_program.rel_program_main
    - mx_master.date_start
    limit: 500
    column_limit: 50
    total: true
    row_total: left
    query_timezone: America/New_York
    barColors:
    - "#025e0c"
    - "#79ff8b"
    color_application:
      collection_id: legacy
      palette_id: looker_classic
    groupBars: false
    labelSize: 10pt
    valueFormat: mmm-yy
    showLegend: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: White to Green
        colors:
        - "#FFFFFF"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
      - mx_master.ctr
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Custom
        colors:
        - "#FFFFFF"
        - "#5e82bc"
      bold: false
      italic: false
      strikethrough: false
      fields: []
    conditional_formatting_include_totals: true
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Client: arch_clients.client
      Timeframe: mx_master.date_date
      Program: arch_program.program
      Channel: arch_program.medium

  filters:
  - name: Client
    title: Client
    type: field_filter
    default_value: Beaumont Health
    allow_multiple_values: false
    required: true
    model: fh_360
    explore: arch_program
    listens_to_filters: []
    field: arch_clients.client
  - name: Timeframe
    title: Timeframe
    type: field_filter
    default_value: 2018/01/01 to 2018/12/10
    allow_multiple_values: true
    required: false
    model: fh_360
    explore: arch_program
    listens_to_filters: []
    field: mx_master.date_date
  - name: Program
    title: Program
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: fh_360
    explore: arch_program
    listens_to_filters: []
    field: arch_program.program
  - name: Channel
    title: Channel
    type: field_filter
    default_value: PPC,Display
    allow_multiple_values: true
    required: true
    model: fh_360
    explore: arch_program
    listens_to_filters: []
    field: arch_program.medium

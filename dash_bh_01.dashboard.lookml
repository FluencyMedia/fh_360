- dashboard: ppc__overall_dashboard
  title: PPC - Overall Dashboard
  layout: newspaper
  elements:
  - name: Monthly Referrals / CPR - By Program
    title: Monthly Referrals / CPR - By Program
    model: fh_360
    explore: mx_master_month
    type: looker_column
    fields:
    - mx_master_month.date_month
    - arch_program.program
    - mx_master_month.referrals_total
    - mx_master_month.cost_sum
    pivots:
    - arch_program.program
    fill_fields:
    - mx_master_month.date_month
    filters:
      arch_program.agency: Fluency
      arch_clients.client: Beaumont Health
      arch_program.medium: PPC
      mx_master_month.date_date: 2018/01/01 to 2018/12/31
    sorts:
    - mx_master_month.date_month
    - arch_program.program 0
    limit: 500
    row_total: left
    dynamic_fields:
    - table_calculation: cpr
      label: "@ CPR"
      expression: "${mx_master_month.cost_sum:row_total}/${mx_master_month.referrals_total:row_total}"
      value_format:
      value_format_name: usd
      _kind_hint: supermeasure
      _type_hint: number
    query_timezone: America/New_York
    trellis: ''
    stacking: normal
    show_value_labels: false
    label_density: 25
    font_size: 125%
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle_outline
    series_colors:
      cpr: "#72D16D"
    series_labels:
      Brand - mx_master_month.referrals_total: Brand
      Women & Babies - mx_master_month.referrals_total: Women & Babies
      Weight Loss & Bariatric - mx_master_month.referrals_total: Weight Loss & Bariatric
      Vein Centers - mx_master_month.referrals_total: Vein Centers
      Urgent Care - mx_master_month.referrals_total: Urgent Care
      Proton Therapy - mx_master_month.referrals_total: Proton Therapy
      Primary Care - mx_master_month.referrals_total: Primary Care
      Physical Therapy - mx_master_month.referrals_total: Physical Therapy
      Orthopedics - mx_master_month.referrals_total: Orthopedics
      Neurosciences - mx_master_month.referrals_total: Neurosciences
      Hyperbaric - mx_master_month.referrals_total: Hyperbaric
      Heart & Vascular - mx_master_month.referrals_total: Heart & Vascular
      Children's - mx_master_month.referrals_total: Children's
      Cancer - mx_master_month.referrals_total: Cancer
    series_types:
      cpr: area
    limit_displayed_rows: false
    y_axes:
    - label:
      orientation: left
      series:
      - id: Cancer - mx_master_month.referrals_total
        name: Cancer
        axisId: Cancer - mx_master_month.referrals_total
      - id: Children's - mx_master_month.referrals_total
        name: Children&#39;s
        axisId: Children's - mx_master_month.referrals_total
      - id: Heart & Vascular - mx_master_month.referrals_total
        name: Heart &amp; Vascular
        axisId: Heart & Vascular - mx_master_month.referrals_total
      - id: Hyperbaric - mx_master_month.referrals_total
        name: Hyperbaric
        axisId: Hyperbaric - mx_master_month.referrals_total
      - id: Neurosciences - mx_master_month.referrals_total
        name: Neurosciences
        axisId: Neurosciences - mx_master_month.referrals_total
      - id: Orthopedics - mx_master_month.referrals_total
        name: Orthopedics
        axisId: Orthopedics - mx_master_month.referrals_total
      - id: Physical Therapy - mx_master_month.referrals_total
        name: Physical Therapy
        axisId: Physical Therapy - mx_master_month.referrals_total
      - id: Primary Care - mx_master_month.referrals_total
        name: Primary Care
        axisId: Primary Care - mx_master_month.referrals_total
      - id: Proton Therapy - mx_master_month.referrals_total
        name: Proton Therapy
        axisId: Proton Therapy - mx_master_month.referrals_total
      - id: Urgent Care - mx_master_month.referrals_total
        name: Urgent Care
        axisId: Urgent Care - mx_master_month.referrals_total
      - id: Vein Centers - mx_master_month.referrals_total
        name: Vein Centers
        axisId: Vein Centers - mx_master_month.referrals_total
      - id: Weight Loss & Bariatric - mx_master_month.referrals_total
        name: Weight Loss &amp; Bariatric
        axisId: Weight Loss & Bariatric - mx_master_month.referrals_total
      - id: Women & Babies - mx_master_month.referrals_total
        name: Women &amp; Babies
        axisId: Women & Babies - mx_master_month.referrals_total
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    - label:
      orientation: right
      series:
      - id: cpr
        name: "@ CPR"
        axisId: cpr
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_datetime_label: "%b-%y"
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    column_group_spacing_ratio: 0
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - mx_master_month.cost_sum
    row: 8
    col: 0
    width: 24
    height: 7
  - name: Detailed Referrals / CPR - By Program [NAME]
    title: Detailed Referrals / CPR - By Program [TITLE]
    model: fh_360
    explore: mx_master_month
    type: table
    fields:
    - mx_master_month.date_month
    - arch_program.program
    - mx_master_month.referrals_total
    - mx_master_month.cpr
    pivots:
    - mx_master_month.date_month
    fill_fields:
    - mx_master_month.date_month
    filters:
      arch_program.agency: Fluency
      arch_clients.client: Beaumont Health
      arch_program.medium: PPC
      mx_master_month.date_date: 2018/01/01 to 2018/12/31
    sorts:
    - mx_master_month.date_month
    - arch_program.program 0
    limit: 500
    total: true
    row_total: left
    dynamic_fields:
    - table_calculation: cpr
      label: "@ CPR"
      expression: "${mx_master_month.cost_sum:row_total}/${mx_master_month.referrals_total:row_total}"
      value_format:
      value_format_name: usd
      _kind_hint: supermeasure
      _type_hint: number
      is_disabled: true
    query_timezone: America/New_York
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      Brand - mx_master_month.referrals_total: Brand
      Women & Babies - mx_master_month.referrals_total: Women & Babies
      Weight Loss & Bariatric - mx_master_month.referrals_total: Weight Loss & Bariatric
      Vein Centers - mx_master_month.referrals_total: Vein Centers
      Urgent Care - mx_master_month.referrals_total: Urgent Care
      Proton Therapy - mx_master_month.referrals_total: Proton Therapy
      Primary Care - mx_master_month.referrals_total: Primary Care
      Physical Therapy - mx_master_month.referrals_total: Physical Therapy
      Orthopedics - mx_master_month.referrals_total: Orthopedics
      Neurosciences - mx_master_month.referrals_total: Neurosciences
      Hyperbaric - mx_master_month.referrals_total: Hyperbaric
      Heart & Vascular - mx_master_month.referrals_total: Heart & Vascular
      Children's - mx_master_month.referrals_total: Children's
      Cancer - mx_master_month.referrals_total: Cancer
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: along a scale...
      value:
      background_color:
      font_color:
      color_application:
        collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
        palette_id: afd46b40-e939-4ace-bffd-69d1bb16ee05
        options:
          steps: 5
          constraints:
            mid:
              type: average
      bold: false
      italic: false
      strikethrough: false
      fields:
      - mx_master_month.referrals_total
    - type: along a scale...
      value:
      background_color:
      font_color:
      color_application:
        collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
        custom:
          id: 6b8cfcf3-cf05-9985-8262-764df3f9217d
          label: Custom
          type: continuous
          stops:
          - color: "#ffffff"
            offset: 0
          - color: "#e8967c"
            offset: 100
        options:
          steps: 5
          constraints:
            mid:
              type: average
      bold: false
      italic: false
      strikethrough: false
      fields:
      - mx_master_month.cpr
    conditional_formatting_include_totals: true
    conditional_formatting_include_nulls: false
    trellis: ''
    stacking: normal
    show_value_labels: false
    label_density: 25
    font_size: 125%
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: circle_outline
    series_colors:
      cpr: "#72D16D"
    series_types: {}
    y_axes:
    - label:
      orientation: left
      series:
      - id: Cancer - mx_master_month.referrals_total
        name: Cancer
        axisId: Cancer - mx_master_month.referrals_total
      - id: Children's - mx_master_month.referrals_total
        name: Children&#39;s
        axisId: Children's - mx_master_month.referrals_total
      - id: Heart & Vascular - mx_master_month.referrals_total
        name: Heart &amp; Vascular
        axisId: Heart & Vascular - mx_master_month.referrals_total
      - id: Hyperbaric - mx_master_month.referrals_total
        name: Hyperbaric
        axisId: Hyperbaric - mx_master_month.referrals_total
      - id: Neurosciences - mx_master_month.referrals_total
        name: Neurosciences
        axisId: Neurosciences - mx_master_month.referrals_total
      - id: Orthopedics - mx_master_month.referrals_total
        name: Orthopedics
        axisId: Orthopedics - mx_master_month.referrals_total
      - id: Physical Therapy - mx_master_month.referrals_total
        name: Physical Therapy
        axisId: Physical Therapy - mx_master_month.referrals_total
      - id: Primary Care - mx_master_month.referrals_total
        name: Primary Care
        axisId: Primary Care - mx_master_month.referrals_total
      - id: Proton Therapy - mx_master_month.referrals_total
        name: Proton Therapy
        axisId: Proton Therapy - mx_master_month.referrals_total
      - id: Urgent Care - mx_master_month.referrals_total
        name: Urgent Care
        axisId: Urgent Care - mx_master_month.referrals_total
      - id: Vein Centers - mx_master_month.referrals_total
        name: Vein Centers
        axisId: Vein Centers - mx_master_month.referrals_total
      - id: Weight Loss & Bariatric - mx_master_month.referrals_total
        name: Weight Loss &amp; Bariatric
        axisId: Weight Loss & Bariatric - mx_master_month.referrals_total
      - id: Women & Babies - mx_master_month.referrals_total
        name: Women &amp; Babies
        axisId: Women & Babies - mx_master_month.referrals_total
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    - label:
      orientation: right
      series:
      - id: cpr
        name: "@ CPR"
        axisId: cpr
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_datetime_label: "%b-%y"
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    column_group_spacing_ratio: 0
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    row: 15
    col: 0
    width: 24
    height: 11
  - name: Total Referrals - By Program
    title: Total Referrals - By Program
    model: fh_360
    explore: mx_core_month
    type: looker_pie
    fields:
    - mx_core_month.referrals_total
    - arch_program.program
    filters:
      arch_clients.client: Beaumont Health
      arch_program.agency: Fluency
      arch_program.medium: PPC
      mx_core_month.date_date: '2018'
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    color_range:
    - "#3EB0D5"
    - "#B1399E"
    - "#C2DD67"
    - "#592EC2"
    - "#4276BE"
    - "#72D16D"
    - "#FFD95F"
    - "#B32F37"
    - "#9174F0"
    - "#E57947"
    - "#75E2E2"
    - "#FBB555"
    show_view_names: 'true'
    series_types: {}
    row: 0
    col: 5
    width: 10
    height: 8
  - name: Referrals - YoY
    title: Referrals - YoY
    model: fh_360
    explore: mx_core_month
    type: single_value
    fields:
    - mx_core_month.referrals_total
    - mx_core_month.date_year
    pivots:
    - mx_core_month.date_year
    fill_fields:
    - mx_core_month.date_year
    filters:
      arch_program.agency: Fluency
      arch_clients.client: Beaumont Health
      arch_program.medium: PPC
      mx_core_month.date_date: 2017/01/01 to 2019/01/01
    sorts:
    - mx_core_month.date_year desc
    limit: 500
    column_limit: 50
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: "#5fa35f"
    show_single_value_title: true
    single_value_title: Total Referrals - 2018
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Total Referrals - 2017
    row: 0
    col: 0
    width: 5
    height: 4
  - name: CPR - YoY
    title: CPR - YoY
    model: fh_360
    explore: mx_core_month
    type: single_value
    fields:
    - mx_core_month.date_year
    - mx_core_month.cpr
    pivots:
    - mx_core_month.date_year
    fill_fields:
    - mx_core_month.date_year
    filters:
      arch_program.agency: Fluency
      arch_clients.client: Beaumont Health
      mx_core_month.date_date: 2017/01/01 to 2019/01/01
      arch_program.medium: PPC
    sorts:
    - mx_core_month.date_year desc
    limit: 500
    column_limit: 50
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: "#5fa35f"
    show_single_value_title: true
    single_value_title: Overall CPR - 2018
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: CPR - 2017
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 4
    col: 0
    width: 5
    height: 4

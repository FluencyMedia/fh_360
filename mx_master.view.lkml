view: mx_master {
  derived_table: {
    sql:
      SELECT
        mx.row_id,
        mx.adgroup_id,
        mx.outcome_tracker_id,
        mx.date,
        EXTRACT (year FROM mx.date) AS year,
        EXTRACT (month FROM mx.date) AS month,
        EXTRACT (day FROM mx.date) AS day,
        (mx.dim_channel ->> 'device')::TEXT AS device,
        (mx.dim_channel ->> 'mode')::TEXT AS mode,
        (mx.dim_channel ->> 'final_url')::TEXT AS final_url,
        (mx.dim_creative ->> 'creative')::TEXT AS creative,
        (mx.dim_creative ->> 'creative_format')::TEXT AS creative_format,
        (mx.measures ->> 'impressions')::INTEGER AS impressions,
        (mx.measures ->> 'clicks')::INTEGER AS clicks,
        (mx.measures ->> 'cost')::DOUBLE PRECISION AS cost,
        (mx.measures ->> 'outcomes')::INTEGER AS outcomes,
        (mx.measures ->> 'outcomes_bulk')::INTEGER AS outcomes_bulk
      FROM analytics.mx_master mx
    ;;

    datagroup_trigger: mp360_datagroup
    indexes: ["row_id"]
  }


  ##########  METADATA    {

    dimension: adgroup_id {
      view_label: "Z - Metadata"
      group_label: "Database IDs"
      label: "Ad Group ID [MX_Master]"
      description: "Foreign Key from master metrics table"

      required_access_grants: [access_dev_fields]

      type: string

      sql: ${TABLE}.adgroup_id ;;  }

    dimension: row_id {
      view_label: "Z - Metadata"
      group_label: "Database IDs"
      label: "Row ID [MX_Master]"
      description: "Unique row ID from master metrics table"
      primary_key: yes

      required_access_grants: [access_dev_fields]

      type: string

      sql: ${TABLE}.row_id ;;  }

    dimension: outcome_tracker_id {
      view_label: "Z - Metadata"
      group_label: "Database IDs"
      label: "Outcome Tracker ID [MX_Master]"
      description: "Outcome Tracker ID from master metrics table"

      required_access_grants: [access_dev_fields]

      type: string

      sql: ${TABLE}.outcome_tracker_id ;;  }

  ##########  METADATA  }  ##########



  ##########  DIMENSIONS  {

    ##### Field Sets {
      set: drill_outcomes {
        fields: [
          arch_programs.program,
          arch_programs.service,
          arch_outcomes.outcome_mechanism,
          arch_outcomes.outcome_type
        ]
      }

  set: drill_mx_outcomes {
    fields: [
      leads_total,
      cost_sum,
      cpl,
      ltr
    ]
  }



    # } #####

    ##### Time Dimensions {

      dimension_group: date {
        view_label: "4. Timeframes"
        label: "Timeframes"
        description: "Optional complex dimension for managing timeframes"

        type: time

        timeframes: [
          raw,
          date,
          day_of_week_index,
          day_of_week,
          week,
          month,
          quarter,
          year
        ]

        convert_tz: no
        datatype: date
        sql: ${TABLE}.date ;;  }

    measure: date_start {
      view_label: "4. Timeframes"
      label: "Start Date"

      type: date

      sql: MIN(${date_date})::DATE ;;  }

    measure: date_end {
      view_label: "4. Timeframes"
      label: "End Date"

      type: date

      sql: MAX(${date_date})::DATE ;;  }

    measure: date_diff {
      view_label: "4. Timeframes"
      label: "Duration - Days"

      type: number
      value_format_name: decimal_0

      sql: ${date_end} - ${date_start} ;;
    }

    measure: count_days {
      view_label: "Z - Metadata"
      group_label: "Category Counts"
      label: "# Days"

      type: count_distinct
      value_format_name: decimal_0

      sql: ${date_date} ;;
    }



    ##### Time Dimensions } #####

    ##### Creative Dimensions  {

      dimension: creative {
        view_label: "5. Creative"
        label: "Creative"

        type: string
        sql:  ${TABLE}.creative;;
      }


    ##### Creative Dimensions } #####

    ##### Channel Dimensions {

      dimension: device {
        view_label: "3. Channel"
        label: "Device"

        type: string

        sql: ${TABLE}.device ;;  }

      dimension: mode {
        view_label: "3. Channel"
        label: "Mode"

        type: string

        html: <font size="2">{{rendered_value}}</font> ;;

        sql: ${TABLE}.mode ;;  }

      dimension: final_url {
        view_label: "3. Channel"
        label: "Final URL"

        type: string

        sql: ${TABLE}.final_url ;;  }

    ##### Channel Dimensions } #####

    ##### Dynamic Dimensions  {

      dimension: rel_medium_mode {
        view_label: "3. Channel"
        group_label: "Relative Dimensions"
        label: "{% if ${arch_program.medium}._is_filtered %}
                  [Mode]
                {% else %}
                  [Medium]
                {% endif %}"

        type: string

        sql:  {% if ${arch_program.medium}._is_filtered %}
                ${mode}
              {% else %}
                ${arch_program.medium}
              {% endif %};;

      }

      parameter: font_size {
        view_label: "Z - Metadata"

        type: number
        allowed_value: {
          label: "Small"
          value: "1"
        }
        allowed_value: {
          label: "Medium"
          value: "2"
        }
        allowed_value: {
          label: "Large"
          value: "2"
        }
      }

    ##### Dynamic Dimensions } #####

  ##########  DIMENSIONS  }  ##########



  ##########  MEASURES   {

    ##### Base Measures {

      measure: impr_sum {
        view_label: "5. Performance"
        label: "# Impressions"

        type: sum
        value_format_name: decimal_0

        sql: ${TABLE}.impressions;;  }

      measure: impr_pct {
        view_label: "5. Performance"
        group_label: "Interim Measures"
        label: "% Impressions"

        hidden: yes

        type: percent_of_total
        direction: "column"
        value_format_name: decimal_1

        sql: ${impr_sum};;  }

      measure: clicks_sum {
        view_label: "5. Performance"
        label: "# Clicks"

        type: sum
        value_format_name: decimal_0

        sql: ${TABLE}.clicks;;

        html: {% if subtotal_over.row_type_description._value == 'SUBTOTAL' %}
                <div style="
                  background: rgba(70, 130, 180, 0.4);
                  width: 100%;
                  height: 20px;
                  padding: 3px 3px 1px;
                  border-bottom: 1px solid black;
                  margin:18px 0 0 0;
                  font-size: 110%;
                ">
                  <b><span>{{ rendered_value }}</span></b>
                </div>
              {% else %}
                <div style="
                  width: 100%;
                  padding: 3px 3px 1px;
                  font-size: 105%;
                ">
                  {{ rendered_value }}
                </div>
              {% endif %};;

        }

      measure: cost_sum {
        view_label: "5. Performance"
        label: "$ Cost"

        type: sum
        value_format_name: usd_0

        sql: ${TABLE}.cost;;  }

      measure: outcomes_sum {
        view_label: "6. Outcomes"
        label: "# Outcomes"

        type: sum
        value_format_name: decimal_0

        sql: ${TABLE}.outcomes;;  }

      measure: outcomes_bulk_sum {
        view_label: "6. Outcomes"
        group_label: "Z - Reference"
        label: "# Outcomes (Bulk)"

        hidden: no

        type: sum
        value_format_name: decimal_0

        sql: ${TABLE}.outcomes_bulk;;  }

    ##### }
    ##### End Base Measures

    ##### Calculated Measures {

      measure: ctr {
        view_label: "5. Performance"
        label: "% CTR"

        type: number
        value_format_name: percent_2

        sql: 1.0*(${clicks_sum}) / nullif(${impr_sum},0) ;;  }

      measure: ctr_bar {
        view_label: "5. Performance"
        label: "% CTR [BAR]"

        type: number
        value_format_name: percent_1

        html:
        <div style="float: left
        ; width:50%
        ; text-align:right
        ; margin-right: 4px"> <p>{{rendered_value}}</p>
        </div>
        <div style="float: left
        ; width:{{ value | times:50}}%
        ; background-color: rgba(0,180,0,{{ value | times:100 }})
        ; text-align:left
        ; color: #FFFFFF
        ; border-radius: 2px"> <p style="margin-bottom: 0; margin-left: 4px;"> &nbsp; </p>
        </div>
        ;;

        sql: 1.0*(${clicks_sum}) / nullif(${impr_sum},0) ;;  }

      measure: cpc {
        view_label: "5. Performance"
        label: "$ CPC"

        type: number
        value_format_name: usd

        sql: 1.0*(${cost_sum}) / nullif(${clicks_sum},0) ;;  }

      measure: cpo {
        view_label: "6. Outcomes"
        label: "$ CPO"
        description: "Cost / Outcome"

        type: number
        value_format_name: usd

        sql: 1.0*(${cost_sum}) / nullif(${outcomes_sum},0) ;;  }

      measure: otr {
        view_label: "6. Outcomes"
        label: "% OTR"
        description: "Outcomes / Clicks"

        type: number
        value_format_name: percent_2

        sql: 1.0*(${outcomes_sum}) / nullif(${clicks_sum},0) ;;  }

      measure: o_referrals_num {
        view_label: "Z - Metadata"
        group_label: "Isolated Measures"
        label: "# Outcomes (Referrals)"
        description: "ISOLATED: Outcome Quality = 'Referrals'"

        type: sum
        sql: ${TABLE}.outcomes ;;
        value_format_name: decimal_0

        filters: {
          field: arch_outcomes.outcome_quality
          value: "Referrals"  }  }

      measure: o_leads_num {
        view_label: "Z - Metadata"
        group_label: "Isolated Measures"
        label: "# Outcomes (Leads)"
        description: "ISOLATED: Outcome Quality = 'Leads'"

        type: sum
        sql: ${TABLE}.outcomes ;;
        value_format_name: decimal_0

        filters: {
          field: arch_outcomes.outcome_quality
          value: "Leads"    }  }

      measure: o_outcomes_num {
        view_label: "Z - Metadata"
        group_label: "Isolated Measures"
        label: "# Outcomes (Outcomes)"
        description: "ISOLATED: Outcome Quality = 'Outcomes'"

        type: sum
        sql: ${TABLE}.outcomes ;;
        value_format_name: decimal_0

        filters: {
          field: arch_outcomes.outcome_quality
          value: "Outcomes" }  }

      measure: leads_total {
        view_label: "6. Outcomes"
        label: "# Leads"
        description: "AGGREGATED: # Outcomes (Referrals) + # Outcomes (Leads)"

        drill_fields: [
          drill_outcomes*,
          drill_mx_outcomes*
        ]

        type: number
        sql: ${o_referrals_num} + ${o_leads_num} ;;
        value_format_name: decimal_0
      }

      measure: cpl {
        view_label: "6. Outcomes"
        label: "$ CPL"
        description: "$ Cost / # Leads"

        drill_fields: [
          drill_outcomes*
        ]

        type: number
        value_format_name: usd

        sql: 1.0*(${cost_sum}) / nullif(${leads_total},0) ;;  }

      measure: ltr {
        view_label: "6. Outcomes"
        label: "% LTR"
        description: "# Leads / # Clicks"

        type: number
        value_format_name: percent_2

        sql: 1.0*(${leads_total}) / nullif(${clicks_sum},0) ;;  }

      measure: avg_conv_score {
        view_label: "6. Outcomes"
        label: "Avg. Outcome Score"

        type: average
        value_format_name: decimal_1
        sql: ${arch_outcomes.outcome_score} ;;  }

    ##### }
    ##### Calculated Measures

  ##########  MEASURES  }  ##########

}

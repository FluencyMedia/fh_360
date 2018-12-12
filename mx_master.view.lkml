view: mx_master {
  sql_table_name: analytics.mx_master ;;


  ##########  METADATA    {

    dimension: adgroup_id {
      view_label: "3. Channel"
      group_label: "Z - Dev Fields"
      label: "Ad Group ID [MX_Master]"
      description: "Foreign Key from master metrics table"

      required_access_grants: [access_dev_fields]

      type: string

      sql: ${TABLE}.adgroup_id ;;  }

    dimension: row_id {
      view_label: "3. Channel"
      group_label: "Z - Dev Fields"
      label: "Row ID [MX_Master]"
      description: "Unique row ID from master metrics table"

      required_access_grants: [access_dev_fields]

      type: string

      sql: ${TABLE}.row_id ;;  }

    dimension: outcome_tracker_id {
      view_label: "7. Outcomes"
      group_label: "Z - Dev Fields"
      label: "Outcome Tracker ID [MX_Master]"
      description: "Outcome Tracker ID from master metrics table"

      required_access_grants: [access_dev_fields]

      type: string

      sql: ${TABLE}.outcome_tracker_id ;;  }

  ##########  METADATA  }  ##########



  ##########  DIMENSIONS  {

    ##### Time Dimensions {

      dimension_group: date {
        view_label: "4. Timeframes"
        label: "Timeframes"
        description: "Optional complex dimension for managing timeframes"

        type: time

        timeframes: [
          raw,
          date,
          week,
          month,
          quarter,
          year
        ]

        convert_tz: yes
        datatype: date
        sql: ${TABLE}.date ;;  }

      measure: date_start {
        view_label: "4. Timeframes"
        label: "Start Date"

        type: date

        sql: MIN(${date_date}) ;;  }

      measure: date_end {
        view_label: "4. Timeframes"
        label: "End Date"

        type: date
        value_format: ""

        sql: MAX(${date_date}) ;;  }

    ##### Time Dimension } #####

    ##### Channel Dimensions {

      dimension: device {
        view_label: "3. Channel"
        label: "Device"

        type: string

        sql: ${TABLE}.dim_channel ->> 'device' ;;  }

      dimension: mode {
        view_label: "3. Channel"
        label: "Display Mode"

        type: string

        html: <font size="2">{{rendered_value}}</font> ;;

        sql: ${TABLE}.dim_channel ->> 'mode' ;;  }

      dimension: final_url {
        view_label: "3. Channel"
        label: "Final URL"

        type: string

        sql: ${TABLE}.dim_channel ->> 'final_url' ;;  }

    ##### Channel Dimensions } #####

    ##### Dynamic Dimensions  {

      dimension: rel_medium {
        view_label: "3. Channel"
        group_label: "Relative Dimensions"
        label: "Related Medium"

        hidden: yes

        type: string

        sql:  ${arch_program.medium};;

      }

      dimension: rel_medium_mode {
        view_label: "3. Channel"
        group_label: "Relative Dimensions"
        label: "Medium | Mode"

        type: string

        sql:  {% if ${rel_medium}._is_filtered %}
                ${mode}
              {% else %}
                ${rel_medium}
              {% endif %};;

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

        sql: CAST(${TABLE}.measures ->> 'impressions' AS integer);;  }

      measure: impr_pct {
        view_label: "5. Performance"
        group_label: "Interim Measures"
        label: "% Impressions"

        hidden: no

        type: percent_of_total
        direction: "column"
        value_format_name: decimal_1

        sql: ${impr_sum};;  }

      measure: clicks_sum {
        view_label: "5. Performance"
        label: "# Clicks"

        type: sum
        value_format_name: decimal_0

        sql: CAST(${TABLE}.measures ->> 'clicks' AS integer);;  }

      measure: cost_sum {
        view_label: "6. Investment"
        label: "$ Cost"

        type: sum
        value_format_name: usd_0

        html: <font size="2">{{rendered_value}}</font> ;;

        sql: CAST(${TABLE}.measures ->> 'cost' AS double precision);;  }

      measure: outcomes_sum {
        view_label: "5. Performance"
        label: "# Outcomes"

        type: sum
        value_format_name: decimal_0

        sql: CAST(${TABLE}.measures ->> 'outcomes' AS integer);;  }

      measure: outcomes_bulk_sum {
        view_label: "7. Outcomes"
        label: "# Outcomes (Bulk)"

        type: sum
        value_format_name: decimal_0

        sql: CAST(${TABLE}.measures ->> 'outcomes_bulk' AS integer);;  }

    ##### }
    ##### End Base Measures

    ##### Calculated Measures {

      measure: ctr {
        view_label: "5. Performance"
        label: "% CTR"

        type: number
        value_format_name: percent_1

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
        view_label: "6. Investment"
        label: "$ CPC"

        type: number
        value_format_name: usd

        sql: 1.0*(${cost_sum}) / nullif(${clicks_sum},0) ;;  }

      measure: cpo {
        view_label: "6. Investment"
        label: "$ CPO"
        description: "Cost / Outcome"

        type: number
        value_format_name: usd

        sql: 1.0*(${cost_sum}) / nullif(${outcomes_sum},0) ;;  }

      measure: otr {
        view_label: "5. Performance"
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
        sql: (${TABLE}.measures ->> 'outcomes')::integer ;;
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
        sql: (${TABLE}.measures ->> 'outcomes')::integer ;;
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
        sql: (${TABLE}.measures ->> 'outcomes')::integer ;;
        value_format_name: decimal_0

        filters: {
          field: arch_outcomes.outcome_quality
          value: "Outcomes" }  }

      measure: leads_total {
        view_label: "7. Outcomes"
        label: "# Leads"
        description: "AGGREGATED: # Outcomes (Referrals) + # Outcomes (Leads)"

        type: number
        sql: ${o_referrals_num} + ${o_leads_num} ;;
        value_format_name: decimal_0
      }

      measure: cpl {
        view_label: "7. Outcomes"
        label: "$ CPL"
        description: "$ Cost / # Leads"

        type: number
        value_format_name: usd

        sql: 1.0*(${cost_sum}) / nullif(${leads_total},0) ;;  }

      measure: ltr {
        view_label: "7. Outcomes"
        label: "% LTR"
        description: "# Leads / # Clicks"

        type: number
        value_format_name: percent_2

        sql: 1.0*(${leads_total}) / nullif(${clicks_sum},0) ;;  }

      measure: avg_conv_score {
        view_label: "7. Outcomes"
        label: "Avg. Outcome Score"

        type: average
        value_format_name: decimal_1
        sql: ${arch_outcomes.outcome_score} ;;  }

    ##### }
    ##### Calculated Measures

  ##########  MEASURES  }  ##########

}

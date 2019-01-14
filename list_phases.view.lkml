view: list_phases {
  derived_table: {
    sql:
      SELECT
        (ARRAY_AGG(lp.id))[1] AS id,
        lp.process,
        ARRAY_AGG(phase) AS phases
      FROM analytics.list_phases lp
      GROUP BY lp.process    ;;
  }

  dimension: id {
    primary_key: yes
    type: number

    hidden: yes

    sql: ${TABLE}.id ;;
  }

  dimension: process {
    type: string
    sql: ${TABLE}.process ;;
  }

  dimension: phases {
    view_label: "Phases"
    group_label: "Z - Metadata"
    label: "Phases"

    type: string
    sql: ${TABLE}.phases ;;
  }

  dimension: phase_01 {
    view_label: "Phases"
    label: "Phase 01"

    type: string

    html: <div style="
                  background: rgba(127, 127, 127, 0.2);
                  width: 100%;
                  height: 100%;
                  padding: 24px 0px;
                  border: 3px solid rgba(0, 0, 0, 0.2);
                  border-radius: 3px;
                  margin:0px 0 0 0;
                  text-align: center;
                  font-face: bold;
                  font-size: 300%;
                  letter-spacing: 2px;
                ">
            {{rendered_value}}
          </div>;;

    sql: UPPER(${phases}[1]) ;;
  }

  dimension: phase_02 {
    view_label: "Phases"
    label: "Phase 02"

    type: string
    html: <div style="
            background: rgba(127, 127, 127, 0.2);
            width: 100%;
            height: 100%;
            padding: 24px 0px;
            border: 3px solid rgba(0, 0, 0, 0.5);
            border-radius: 3px;
            margin:0px 0 0 0;
            text-align: center;
            font-face: bold;
            font-size: 300%;
            letter-spacing: 2px;
            ">
            {{rendered_value}}
          </div>;;

    sql: UPPER(${phases}[2]) ;;
  }

  dimension: phase_03 {
    view_label: "Phases"
    label: "Phase 03"

    type: string
    html: <div style="
            background: rgba(127, 127, 127, 0.2);
            width: 100%;
            height: 100%;
            padding: 24px 0px;
            border: 3px solid rgba(0, 0, 0, 0.2);
            border-radius: 3px;
            margin:0px 0 0 0;
            text-align: center;
            font-face: bold;
            font-size: 300%;
            letter-spacing: 2px;
            ">
            {{rendered_value}}
          </div>;;


    sql: UPPER(${phases}[3]) ;;
  }

}

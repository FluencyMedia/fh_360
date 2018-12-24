view: pref_styles {
  derived_table: {
    sql:  SELECT
            c.id_class AS id_class,
            c.class AS class,
            array_to_string(array_agg(c.item_style), ';'||chr(10)) AS styles
              FROM (
                SELECT
                  ca.id_class,
                  ca.class,
                  ca.attr_key,
                  ca.attr_val,
                  '"'||ca.attr_key||'": "'||ca.attr_val||'"' AS item_style
                FROM (
                  SELECT
                    cls.id_class,
                    cls.class,
                    cls.attr_key,
                    cls.attr_val
                  FROM (
                    SELECT
                      attrs.id_class,
                      attrs.class,
                      attrs.attr_key,
                      attrs.attrs ->> attrs.attr_key AS attr_val
                    FROM (
                      SELECT
                        aps.id_class,
                        aps.class,
                        aps.attrs,
                        jsonb_object_keys(aps.attrs) as attr_key
                      FROM
                        analytics.pref_styles aps ) attrs
                  ) cls
                ) ca
              ) c
              GROUP BY c.id_class, c.class ;;
        datagroup_trigger: mp360_datagroup
        indexes: ["id_class"]
  }

  dimension: id_class {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id_class ;;
  }

  dimension: class {
    type: string
    sql: ${TABLE}.class ;;
  }

  dimension: styles {
    type: string
    sql: ${TABLE}.styles ;;
  }

}

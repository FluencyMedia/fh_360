include: "arch_clients.view.lkml"

view: arch_clients_hidden {
  extends: [arch_clients]

  dimension: client_id { hidden: yes}
  dimension: organization_id { hidden: yes }
  dimension: client { hidden: yes }
  dimension: client_html { hidden: yes }
  measure: num_clients { hidden: yes }
  measure: num_orgs { hidden: yes }
}

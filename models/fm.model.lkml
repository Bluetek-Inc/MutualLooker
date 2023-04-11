connection: "az-look"

# include all the views
include: "/views/**/*.view"

datagroup: fm_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: fm_default_datagroup

explore: alertas_mutual {}

explore: sysdiagrams {}

explore: tabla_mu {}

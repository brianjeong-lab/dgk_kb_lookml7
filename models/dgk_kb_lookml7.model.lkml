connection: "kb-daas-dev"

# include all the views
include: "/views/**/*.view"

datagroup: dgk_kb_lookml7_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: dgk_kb_lookml7_default_datagroup

explore: keyword_bank {}

explore: keyword_bank_result {
  join: keyword_bank_result__kpe {
    view_label: "Keyword Bank Result: Kpe"
    sql: CROSS JOIN UNNEST(${keyword_bank_result.kpe}) as keyword_bank_result__kpe ;;
    relationship: many_to_many
  }

  join: keyword_bank_result__d2_c {
    view_label: "Keyword Bank Result: D2c"
    sql: LEFT JOIN UNNEST(${keyword_bank_result.d2_c}) as keyword_bank_result__d2_c ;;
    relationship: one_to_many
  }

  join: keyword_bank_result__kse {
    view_label: "Keyword Bank Result: Kse"
    sql: LEFT JOIN UNNEST(${keyword_bank_result.kse}) as keyword_bank_result__kse ;;
    relationship: one_to_many
  }

  join: keyword_bank_result__response {
    view_label: "Keyword Bank Result: Response"
    sql: LEFT JOIN UNNEST([${keyword_bank_result.response}]) as keyword_bank_result__response ;;
    relationship: one_to_one
  }
}

explore: keyword_corona {}

explore: keyword_corona_result {
  join: keyword_corona_result__kpe {
    view_label: "Keyword Corona Result: Kpe"
    sql: LEFT JOIN UNNEST(${keyword_corona_result.kpe}) as keyword_corona_result__kpe ;;
    relationship: one_to_many
  }

  join: keyword_corona_result__d2_c {
    view_label: "Keyword Corona Result: D2c"
    sql: LEFT JOIN UNNEST(${keyword_corona_result.d2_c}) as keyword_corona_result__d2_c ;;
    relationship: one_to_many
  }

  join: keyword_corona_result__kse {
    view_label: "Keyword Corona Result: Kse"
    sql: LEFT JOIN UNNEST(${keyword_corona_result.kse}) as keyword_corona_result__kse ;;
    relationship: one_to_many
  }

  join: keyword_corona_result__response {
    view_label: "Keyword Corona Result: Response"
    sql: LEFT JOIN UNNEST([${keyword_corona_result.response}]) as keyword_corona_result__response ;;
    relationship: one_to_one
  }


}

explore: keword_bank_bypress {}

explore: keword_bank_bypress2 {}

explore: keword_bank_bypress3 {

  cancel_grouping_fields: []}

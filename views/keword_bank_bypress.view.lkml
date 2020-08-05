view: keword_bank_bypress {
  derived_table: {
    sql: SELECT
       S_NAME
       ,SB_NAME
       , CHANNEL
       , CRAWLSTAMP
       , DATE(CRAWLSTAMP) AS crawlstampDate
FROM `kb-daas-dev.master_200729.keyword_bank_result` as keywordBankResult
      , UNNEST(keywordBankResult.KPE) as keywordBankResultKpe
WHERE keywordBankResultKpe.keyword  LIKE {% parameter searchKeyword %}
and keywordBankResult.CHANNEL  = '뉴스'

 ;;
  }

  filter: searchKeyword {
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: s_name {
    type: string
    sql: ${TABLE}.S_NAME ;;
  }

  dimension: sb_name {
    type: string
    sql: ${TABLE}.SB_NAME ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.CHANNEL ;;
  }

  dimension_group: crawlstamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.CRAWLSTAMP ;;
  }

  dimension: crawlstampDate {
    type: date
    sql: ${TABLE}.crawlstampDate ;;
  }

  set: detail {
    fields: [s_name, channel, crawlstampDate]
  }
}

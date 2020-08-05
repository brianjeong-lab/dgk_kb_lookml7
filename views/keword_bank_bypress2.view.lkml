view: keword_bank_bypress2 {
  derived_table: {
    sql: WITH keyword_bank_bypress AS (SELECT
       S_NAME
       ,SB_NAME
       , CHANNEL
       , CRAWLSTAMP
       , DATE(CRAWLSTAMP) AS crawlstampDate
FROM `kb-daas-dev.master_200729.keyword_bank_result` as keywordBankResult
      , UNNEST(keywordBankResult.KPE) as keywordBankResultKpe
WHERE keywordBankResultKpe.keyword  LIKE '%서비스%'
and keywordBankResult.CHANNEL  = '뉴스'
and DATE(CRAWLSTAMP) >= '2020-06-01'
and DATE(CRAWLSTAMP) <= '2020-06-30'
)

SELECT
  case when keyword_bank_bypress.S_NAME in ('네이트', '네이버뉴스', '미디어다음', '뉴스줌') THEN  REGEXP_REPLACE(keyword_bank_bypress.SB_NAME, '[a-z]', '') ELSE
  keyword_bank_bypress.S_NAME
  end as press
  , keyword_bank_bypress.CRAWLSTAMP
  , keyword_bank_bypress.crawlstampDate as resultCrawlstampDate
FROM keyword_bank_bypress
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: press {
    type: string
    sql: ${TABLE}.press ;;
  }

  dimension_group: crawlstamp {
    type: time
    sql: ${TABLE}.CRAWLSTAMP ;;
  }

  dimension: result_crawlstamp_date {
    type: date
    sql: ${TABLE}.resultCrawlstampDate ;;
  }

  set: detail {
    fields: [press, crawlstamp_time, result_crawlstamp_date]
  }
}

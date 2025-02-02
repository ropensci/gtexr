test_that("`get_news_item()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_news_item()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c("title", "newsText", "rank", "dateCreated", "release", "id")
  )
})

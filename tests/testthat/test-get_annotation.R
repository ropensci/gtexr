test_that("`get_annotation()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_annotation()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c("entity", "values", "type", "annotation", "datasetId")
  )
})

test_that("`get_subject()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_subject(itemsPerPage = 1) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c("hardyScale", "ageBracket", "subjectId", "sex", "datasetId")
  )
})

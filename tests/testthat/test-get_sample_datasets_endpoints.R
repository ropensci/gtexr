test_that("`get_sample_datasets_endpoints()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_sample_datasets_endpoints(itemsPerPage = 1) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "ischemicTime",
      "aliquotId",
      "tissueSampleId",
      "tissueSiteDetail",
      "dataType",
      "ischemicTimeGroup",
      "freezeType",
      "sampleId",
      "sampleIdUpper",
      "ageBracket",
      "hardyScale",
      "tissueSiteDetailId",
      "subjectId",
      "uberonId",
      "sex",
      "datasetId"
    )
  )
})

test_that("`get_single_nucleus_gex_summary()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_single_nucleus_gex_summary(tissueSiteDetailIds = "Breast_Mammary_Tissue", itemsPerPage = 1) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "tissueSiteDetailId",
      "ontologyId",
      "datasetId",
      "cellType",
      "numCells"
    )
  )
})

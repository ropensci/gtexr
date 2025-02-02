test_that("`get_single_nucleus_gex()` returns tibble with expected colnames", {
  skip_if_offline()
  # `excludeDataArray = FALSE`
  result <- get_single_nucleus_gex(
    gencodeIds = "ENSG00000132693.12",
    excludeDataArray = FALSE,
    itemsPerPage = 1
  ) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "tissueSiteDetailId",
      "ontologyId",
      "datasetId",
      "gencodeId",
      "geneSymbol",
      "cellTypes",
      "unit"
    )
  )

  expect_identical(
    names(result$cellTypes[[1]]),
    c(
      "cellType",
      "count",
      "meanWithZeros",
      "meanWithoutZeros",
      "medianWithZeros",
      "medianWithoutZeros",
      "numZeros",
      "data"
    )
  )

  # `excludeDataArray = TRUE`
  result <- get_single_nucleus_gex(
    gencodeIds = "ENSG00000132693.12",
    excludeDataArray = TRUE,
    itemsPerPage = 1
  ) |>
    suppressWarnings()

  expect_identical(
    names(result$cellTypes[[1]]),
    c(
      "cellType",
      "count",
      "meanWithZeros",
      "meanWithoutZeros",
      "medianWithZeros",
      "medianWithoutZeros",
      "numZeros"
    )
  )
})

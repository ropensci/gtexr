test_that("`get_median_transcript_expression()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_median_transcript_expression(gencodeIds = "ENSG00000132693.12", itemsPerPage = 1) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "median",
      "transcriptId",
      "tissueSiteDetailId",
      "ontologyId",
      "datasetId",
      "gencodeId",
      "geneSymbol",
      "unit"
    )
  )
})

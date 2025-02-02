test_that("`get_median_exon_expression()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_median_exon_expression(gencodeIds = "ENSG00000132693.12", tissueSiteDetailIds = "Whole_Blood")

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "median",
      "exonId",
      "tissueSiteDetailId",
      "ontologyId",
      "datasetId",
      "gencodeId",
      "geneSymbol",
      "unit"
    )
  )
})

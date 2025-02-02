test_that("`get_top_expressed_genes()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_top_expressed_genes(tissueSiteDetailId = "Breast_Mammary_Tissue", itemsPerPage = 1) |>
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
      "median",
      "unit"
    )
  )
})

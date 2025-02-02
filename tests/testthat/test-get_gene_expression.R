test_that("`get_gene_expression()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_gene_expression(gencodeIds = "ENSG00000132693.12", tissueSiteDetailIds = "Whole_Blood")

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "data",
      "tissueSiteDetailId",
      "ontologyId",
      "datasetId",
      "gencodeId",
      "geneSymbol",
      "unit",
      "subsetGroup"
    )
  )
})

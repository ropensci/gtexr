test_that("`get_collapsed_gene_model_exon()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_collapsed_gene_model_exon(gencodeId = "ENSG00000132693.12")

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "featureType",
      "end",
      "genomeBuild",
      "chromosome",
      "exonNumber",
      "geneSymbolUpper",
      "exonId",
      "datasetId",
      "start",
      "dataSource",
      "gencodeId",
      "geneSymbol",
      "gencodeVersion",
      "strand"
    )
  )
})

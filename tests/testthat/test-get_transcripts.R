test_that("`get_gwas_catalog_by_location()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_transcripts(gencodeId = "ENSG00000203782.5")

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "start",
      "end",
      "featureType",
      "genomeBuild",
      "transcriptId",
      "source",
      "chromosome",
      "gencodeId",
      "geneSymbol",
      "gencodeVersion",
      "strand"
    )
  )
})

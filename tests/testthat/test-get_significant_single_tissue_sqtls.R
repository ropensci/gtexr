test_that("`get_significant_single_tissue_sqtls()` returns tibble with expected colnames", {
  skip_if_offline()
  result <-
    get_significant_single_tissue_sqtls(gencodeIds = "ENSG00000203782.5")

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "snpId",
      "pos",
      "snpIdUpper",
      "variantId",
      "geneSymbol",
      "pValue",
      "geneSymbolUpper",
      "datasetId",
      "tissueSiteDetailId",
      "ontologyId",
      "chromosome",
      "gencodeId",
      "nes",
      "phenotypeId"
    )
  )
})

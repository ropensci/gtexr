test_that("`get_significant_single_tissue_eqtls()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- suppressWarnings(
    get_significant_single_tissue_eqtls(gencodeIds = "ENSG00000132693.12", itemsPerPage = 1)
  )

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
      "nes"
    )
  )
})

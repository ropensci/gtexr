test_that("`get_significant_single_tissue_isqtls()` returns tibble with expected colnames", {
  skip_if_offline()
  result <-
    get_significant_single_tissue_isqtls(gencodeIds = "ENSG00000203782.5", itemsPerPage = 1) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "snpId",
      "bGISE",
      "pos",
      "snpIdUpper",
      "pValueG",
      "pValueGI",
      "geneSymbol",
      "geneSymbolUpper",
      "pValueI",
      "bGI",
      "tissueSiteDetailId",
      "ontologyId",
      "chromosome",
      "tissueCellType",
      "tssDistance",
      "bGSE",
      "variantId",
      "maf",
      "bISE",
      "datasetId",
      "bG",
      "pValueAdjustedBH",
      "bI",
      "gencodeId",
      "phenotypeId"
    )
  )
})

test_that("`get_independent_eqtl()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- suppressWarnings(get_independent_eqtl(gencodeIds = "ENSG00000203782.5", itemsPerPage = 1))

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "gencodeId",
      "geneSymbol",
      "variantId",
      "snpId",
      "tissueSiteDetailId",
      "ontologyId",
      "rank",
      "tssDistance",
      "maf",
      "pValue",
      "nes",
      "chromosome",
      "pos",
      "datasetId"
    )
  )
})

test_that("`get_multi_tissue_eqtls()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- suppressWarnings(get_multi_tissue_eqtls(gencodeId = "ENSG00000203782.5", itemsPerPage = 1))

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c("gencodeId", "datasetId", "metaP", "variantId", "tissues")
  )
})

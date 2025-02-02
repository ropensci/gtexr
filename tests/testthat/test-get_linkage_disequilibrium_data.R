test_that("`get_linkage_disequilibrium_data()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_linkage_disequilibrium_data(gencodeId = "ENSG00000132693.12", itemsPerPage = 1) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(names(result), c("variantId_1", "variantId_2", "ld"))
})

test_that("`get_gwas_catalog_by_location()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_gwas_catalog_by_location(
    start = 1,
    end = 10000000,
    chromosome = "chr1",
    itemsPerPage = 1
  ) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "chromosome",
      "start",
      "end",
      "phenotype",
      "pValue",
      "beta",
      "pubmedId",
      "snpId",
      "riskAllele",
      "genomeBuild"
    )
  )
})

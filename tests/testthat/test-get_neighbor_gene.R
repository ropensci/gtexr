test_that("`get_gwas_catalog_by_location()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_neighbor_gene(
    pos = 1000000,
    chromosome = "chr1",
    bp_window = 10000,
    itemsPerPage = 1
  ) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "chromosome",
      "dataSource",
      "description",
      "end",
      "gencodeId",
      "gencodeVersion",
      "geneStatus",
      "geneSymbol",
      "geneSymbolUpper",
      "geneType",
      "genomeBuild",
      "start",
      "strand",
      "tss"
    )
  )
})

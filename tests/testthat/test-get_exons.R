test_that("`get_exons()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_exons(gencodeIds = "ENSG00000203782.5", itemsPerPage = 1) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "featureType",
      "end",
      "genomeBuild",
      "start",
      "exonId",
      "source",
      "chromosome",
      "gencodeId",
      "transcriptId",
      "geneSymbol",
      "gencodeVersion",
      "strand",
      "exonNumber"
    )
  )
})

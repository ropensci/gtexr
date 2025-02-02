test_that("`get_tissue_site_detail()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_tissue_site_detail(itemsPerPage = 1) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "tissueSiteDetailId",
      "colorHex",
      "colorRgb",
      "datasetId",
      "eGeneCount",
      "expressedGeneCount",
      "hasEGenes",
      "hasSGenes",
      "mappedInHubmap",
      "eqtlSampleSummary",
      "rnaSeqSampleSummary",
      "sGeneCount",
      "samplingSite",
      "tissueSite",
      "tissueSiteDetail",
      "tissueSiteDetailAbbr",
      "ontologyId",
      "ontologyIri"
    )
  )
})

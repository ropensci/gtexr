test_that("`get_functional_annotation()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_functional_annotation(
    chromosome = "chr1",
    start = 192168000,
    end = 192169000
  )

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "variantId",
      "enhancer",
      "promoter",
      "openChromatinRegion",
      "promoterFlankingRegion",
      "ctcfBindingSite",
      "tfBindingSite",
      "3PrimeUtrVariant",
      "5PrimeUtrVariant",
      "frameshiftVariant",
      "intronVariant",
      "missenseVariant",
      "nonCodingTranscriptExonVariant",
      "spliceAcceptorVariant",
      "spliceDonorVariant",
      "spliceRegionVariant",
      "stopGained",
      "synonymousVariant",
      "chromosome",
      "pos",
      "ref",
      "alt",
      "datasetId"
    )
  )
})

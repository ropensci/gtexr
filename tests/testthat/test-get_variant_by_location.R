test_that("`get_variant_by_location()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_variant_by_location(
    start = 153209600,
    end = 153209700,
    chromosome = "chr1"
  )

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "snpId",
      "b37VariantId",
      "pos",
      "maf01",
      "variantId",
      "alt",
      "chromosome",
      "snpIdUpper",
      "datasetId",
      "ref"
    )
  )
})

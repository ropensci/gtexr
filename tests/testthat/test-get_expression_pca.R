test_that("`get_expression_pca()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_expression_pca(tissueSiteDetailIds = "Adipose_Subcutaneous", sampleId = "GTEX-1117F-0226-SM-5GZZ7")

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "pc1",
      "pc2",
      "pc3",
      "sampleId",
      "tissueSiteDetailId",
      "ontologyId",
      "datasetId"
    )
  )
})

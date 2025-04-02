test_that("`get_dataset_info()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_dataset_info()

  expect_s3_class(result, "tbl_df")

  expect_equal(names(result),
               c("datasetId",
                 "dbSnpBuild",
                 "dbgapId",
                 "description",
                 "displayName",
                 "eqtlSubjectCount",
                 "eqtlTissuesCount",
                 "gencodeVersion",
                 "genomeBuild",
                 "organization",
                 "rnaSeqAndGenotypeSampleCount",
                 "rnaSeqSampleCount",
                 "subjectCount",
                 "tissueCount"))
})

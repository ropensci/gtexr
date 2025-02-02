test_that(
  "`get_clustered_median_transcript_expression()` returns tibble with expected colnames",
  {
    skip_if_offline()
    result <- get_clustered_median_transcript_expression(c("ENSG00000203782.5", "ENSG00000132693.12"),
      tissueSiteDetailIds = "Bladder"
    )

    expect_s3_class(result, "tbl_df")

    expect_identical(
      names(result),
      c(
        "median",
        "transcriptId",
        "tissueSiteDetailId",
        "ontologyId",
        "datasetId",
        "gencodeId",
        "geneSymbol",
        "unit"
      )
    )
  }
)

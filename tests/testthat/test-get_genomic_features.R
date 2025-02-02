test_that("`validate_featureId()` detects invalid `.featureId` arguments", {
  # wrong class
  expect_error(validate_featureId(1L), "integer of length 1")

  # wrong length
  expect_error(validate_featureId(1:2), "integer of length 2")

  expect_error(validate_featureId(letters), "character of length 26")

  # invalid characters
  expect_error(validate_featureId("%"), "1 invalid character")

  expect_error(validate_featureId("% ,"), "3 invalid characters")

  expect_error(validate_featureId("%%  ,,"), "3 invalid characters")
})

test_that("`process_get_genomic_features_resp_json()` handles empty responses", {
  expect_equal(
    process_get_genomic_features_resp_json(list(
      features = list(), assembly = "HG38"
    )),
    tibble::tibble(assembly = "HG38")
  )
})

test_that("`process_get_genomic_features_resp_json()` handles non-empty responses", {
  expect_equal(
    process_get_genomic_features_resp_json(list(
      features = list(list(
        gencodeVersion = "v26", geneSymbol = "CRP"
      )), assembly = "HG38"
    )),
    tibble::tibble(
      gencodeVersion = "v26",
      geneSymbol = "CRP",
      assembly = "HG38"
    )
  )
})

test_that("`get_genomic_features()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_genomic_features("brca1")

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "gencodeVersion",
      "end",
      "description",
      "geneSymbolUpper",
      "genomeBuild",
      "geneStatus",
      "strand",
      "entrezGeneId",
      "geneType",
      "start",
      "dataSource",
      "gencodeId",
      "geneSymbol",
      "tss",
      "chromosome",
      "featureType",
      "assembly"
    )
  )
})

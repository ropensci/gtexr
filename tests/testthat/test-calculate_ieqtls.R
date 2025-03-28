test_that("`calculate_ieqtls()` returns tibble with expected colnames", {

  mocked_perform_gtex_request_json <- function(...) {
    list(
      cellType = "Adipocytes",
      data = list(0.2038),
      datasetId = "gtex_v8",
      enrichmentScores = list(0.6664),
      gencodeId = "ENSG00000203782.5",
      genotypes = list(0),
      regressionCoord = list(
        `0` = list(
          -3.042728,
          3.042728,-0.0232111413501241,-0.00245020517878138
        ),
        `1` = list(-3.042728, 3.042728, 0.21073213891777, -0.157052171868657),
        `2` = list(-3.042728, 3.042728, 0.444675419185664, -0.311654138558532)
      ),
      tissueSiteDetailId = "Adipose_Subcutaneous",
      variantId = "chr1_1099341_T_C_b38"
    )
  }

  testthat::with_mocked_bindings(
    code = {
      ieqtls <- calculate_ieqtls(
        cellType = "Adipocytes",
        tissueSiteDetailId = "Adipose_Subcutaneous",
        gencodeId = "ENSG00000203782.5",
        variantId = "chr1_1099341_T_C_b38"
      )
    },
    perform_gtex_request_json = mocked_perform_gtex_request_json
  )

  expect_identical(
    names(ieqtls),
    c(
      "cellType",
      "data",
      "datasetId",
      "enrichmentScores",
      "gencodeId",
      "genotypes",
      "regressionCoord",
      "tissueSiteDetailId",
      "variantId"
    )
  )

  expect_identical(
    ieqtls$data[[1]],
    0.2038
  )

  expect_identical(
    ieqtls$enrichmentScores[[1]],
    0.6664
  )

  expect_identical(
    ieqtls$genotypes[[1]],
    0
  )

  expect_identical(
    names(ieqtls$regressionCoord[[1]]),
    as.character(0:2)
  )

  skip_if_offline()

  result <-
    calculate_ieqtls(
      cellType = "Adipocytes",
      tissueSiteDetailId = "Adipose_Subcutaneous",
      gencodeId = "ENSG00000203782.5",
      variantId = "chr1_1099341_T_C_b38"
    )

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "cellType",
      "data",
      "datasetId",
      "enrichmentScores",
      "gencodeId",
      "genotypes",
      "regressionCoord",
      "tissueSiteDetailId",
      "variantId"
    )
  )
})

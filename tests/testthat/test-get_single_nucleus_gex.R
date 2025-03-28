test_that("`get_single_nucleus_gex()` returns tibble with expected colnames", {

  mocked_perform_gtex_request_json <- function(...) {
    list(
      data = list(
        list(
          tissueSiteDetailId = "Muscle_Skeletal",
          ontologyId = "UBERON:0011907",
          datasetId = "gtex_snrnaseq_pilot",
          gencodeId = "ENSG00000203782.5",
          geneSymbol = "LOR",
          cellTypes = list(
            list(
              cellType = "Immune (DC/macrophage)",
              count = 3,
              meanWithZeros = 0.0100524696772936,
              meanWithoutZeros = 2.41594354577622,
              medianWithZeros = 0,
              medianWithoutZeros = 2.72691867539705,
              numZeros = 718,
              data = NULL
            )
          ),
          unit = "log(CP10K)"
        )
      ),
      paging_info = list(
        numberOfPages = 1,
        page = 0,
        maxItemsPerPage = 250,
        totalNumberOfItems = 7
      )
    )
  }

  testthat::with_mocked_bindings(
    code = {
      single_nucleus_gex <- get_single_nucleus_gex(
        gencodeIds = "ENSG00000203782.5"
      )
    },
    perform_gtex_request_json = mocked_perform_gtex_request_json
  )

  expect_identical(
    names(single_nucleus_gex),
    c(
      "tissueSiteDetailId",
      "ontologyId",
      "datasetId",
      "gencodeId",
      "geneSymbol",
      "cellTypes",
      "unit"
    )
  )

  skip_if_offline()
  # `excludeDataArray = FALSE`
  result <- get_single_nucleus_gex(
    gencodeIds = "ENSG00000132693.12",
    excludeDataArray = FALSE,
    itemsPerPage = 1
  ) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "tissueSiteDetailId",
      "ontologyId",
      "datasetId",
      "gencodeId",
      "geneSymbol",
      "cellTypes",
      "unit"
    )
  )

  expect_identical(
    names(result$cellTypes[[1]]),
    c(
      "cellType",
      "count",
      "meanWithZeros",
      "meanWithoutZeros",
      "medianWithZeros",
      "medianWithoutZeros",
      "numZeros",
      "data"
    )
  )

  # `excludeDataArray = TRUE`
  result <- get_single_nucleus_gex(
    gencodeIds = "ENSG00000132693.12",
    excludeDataArray = TRUE,
    itemsPerPage = 1
  ) |>
    suppressWarnings()

  expect_identical(
    names(result$cellTypes[[1]]),
    c(
      "cellType",
      "count",
      "meanWithZeros",
      "meanWithoutZeros",
      "medianWithZeros",
      "medianWithoutZeros",
      "numZeros"
    )
  )
})

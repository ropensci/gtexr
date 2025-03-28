test_that("`get_annotation()` returns tibble with expected colnames", {

  mocked_perform_gtex_request_json <- function(...) {
    c(list(data = list(
      list(
        entity = "subject",
        values = list("male", "female"),
        type = "enum",
        annotation = "sex",
        datasetId = "gtex_v8"
      ),
      list(
        entity = "subject",
        values = list("20-29", "30-39", "40-49", "50-59", "60-69", "70-79"),
        type = "enum",
        annotation = "ageBracket",
        datasetId = "gtex_v8"
      )
    )), list(
      paging_info = list(
        numberOfPages = 1,
        page = 0,
        maxItemsPerPage = 250,
        totalNumberOfItems = 2
      )
    ))
  }

  testthat::with_mocked_bindings(
    code = {
      annotation <- get_annotation()
    },
    perform_gtex_request_json = mocked_perform_gtex_request_json
  )

  expect_identical(
    names(annotation),
    c("entity", "values", "type", "annotation", "datasetId")
  )

  expect_identical(
    annotation$values[[1]],
    c("male", "female")
  )

  expect_identical(annotation$values[[2]],
                   c("20-29", "30-39", "40-49", "50-59", "60-69", "70-79"))

  skip_if_offline()
  result <- get_annotation()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c("entity", "values", "type", "annotation", "datasetId")
  )
})

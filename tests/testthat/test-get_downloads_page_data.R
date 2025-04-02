test_that(
  "`get_downloads_page_data()` runs without error for `project_id` = 'gtex' (which returns no results)",
  {
    expect_equal(
      with_mocked_bindings(
        code = get_downloads_page_data("gtex"),
        perform_gtex_request_json = function(...) {
          list(data = list())
        }
      ),
      tibble::tibble()
    )
  }
)

test_that("`get_downloads_page_data()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_downloads_page_data("adult-gtex")

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "name",
      "displayName",
      "description",
      "order",
      "parent",
      "children"
    )
  )
})

with_mock_dir("gtex_query", {
  test_that("Call gtex_query() with no endpoint and no arguments", {
    expect_equal(nrow(get_service_info()), 1L)
  })

  test_that("Call gtex_query() with `.return_raw = TRUE`", {
    expect_equal(
      get_service_info(.return_raw = TRUE),
      list(
        id = "org.gtexportal.rest.v2",
        name = "GTEx Portal V2 API",
        version = "2.0.0",
        organization = list(name = "GTEx Project", url = "https://gtexportal.org"),
        description = "This service provides access to the data powering the GTEx portal.",
        contactUrl = "https://gtexportal.org/home/contact",
        documentationUrl = "https://gtexportal.org/api/v2/docs",
        environment = "prod"
      )
    )
  })

  test_that("Call gtex_query() with arguments", {
    expect_equal(nrow(suppressWarnings(get_gene_search("CRP", itemsPerPage = 1))), 1L)
  })

  test_that("gtex_query() prints paging info message when `.verbose = TRUE`", {
    expect_message(suppressWarnings(get_gene_search(
      "CRP", itemsPerPage = 1, .verbose = TRUE
    )))
  })

  test_that("gtex_query() raises a warning if total n items exceeds page size", {
    expect_warning(get_gene_search("CRP", itemsPerPage = 1),
                   "get_gene_search\\(<your_existing_parameters>, itemsPerPage = 100000\\)")
  })
})

test_that("`convert_null_to_na()` works", {
  expect_true(is.na(convert_null_to_na(NULL)))
})

test_that("`process_na_and_zero_char_query_params()` works", {
  expect_identical(
    purrr::map(list(NA, "", 1L), process_na_and_zero_char_query_params),
    list(NULL, NULL, 1L)
  )
})

test_that("`validate_verbose_arg` works", {
  withr::with_options(
    list(gtexr.verbose = c("invalid", "option")),
    expect_error(get_genes("CRP"), regexp = "You supplied: character of length 2")
  )
})

test_that("`.return_raw` argument works", {
  # check `validate_return_raw_arg()`
  gtex_query_wrapper_fn_with_no_return_raw_arg <- function() {
    gtex_query()
  }

  gtex_query_wrapper_fn_with_invalid_return_raw_arg <- function(.return_raw = "TRUE") {
    gtex_query()
  }

  expect_error(gtex_query_wrapper_fn_with_no_return_raw_arg(),
               regexp = "Missing argument: `.return_raw`")

  expect_error(gtex_query_wrapper_fn_with_invalid_return_raw_arg(),
               regexp = "You supplied: character of length 1")

})

test_that("Informative error raised if processed paginated response has differing n rows to expected n items", {
  mocked_perform_gtex_request_json <- function(...) {
    list(
      data = list(list(x = "some_data"), list(
        x = "some_more_data",
        y = list(a = "some_nested_data", b = "some_nested_data")
      )),
      paging_info = list(
        numberOfPages = 1,
        page = 0,
        maxItemsPerPage = 250,
        totalNumberOfItems = 2
      )
    )
  }

  testthat::with_mocked_bindings(
    code = {
      expect_error(get_eqtl_genes("Whole_Blood"),
                   regexp = "Mismatch: processed GTEx API response has 3 rows, but raw GTEx response has 2 elements.")
    },
    perform_gtex_request_json = mocked_perform_gtex_request_json
  )
})

with_mock_dir("gtex_query", {
  test_that("Call gtex_query() with no endpoint and no arguments", {
    expect_equal(nrow(get_service_info()), 1L)
  })

  test_that("Call gtex_query() with arguments", {
    expect_equal(nrow(suppressWarnings(get_gene_search("CRP", itemsPerPage = 1))), 1L)
  })

  test_that("gtex_query() raises a warning if total n items exceeds page size", {
    expect_warning(get_gene_search("CRP", itemsPerPage = 1))
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

test_that("`validate_verbose_arg()` works", {
  withr::with_options(
    list(gtexr.verbose = c("invalid", "option")),
    expect_error(get_genes("CRP"), regexp = "You supplied: character of length 2")
  )
})

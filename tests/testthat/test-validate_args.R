test_that("validate_args() raises error for invalid arguments", {
  # invalid arg length
  expect_error(
    validate_args(list(page = c(1, 0)),
      call = rlang::caller_env()
    ),
    class = "gtexr_arg_class_or_length"
  )

  # invalid class
  expect_error(
    validate_args(list(page = "invalid class"),
      call = rlang::caller_env()
    ),
    class = "gtexr_arg_class_or_length"
  )

  # invalid class
  expect_error(
    validate_args(list(geneIds = 1:2),
      call = rlang::caller_env()
    ),
    class = "gtexr_arg_class_or_length"
  )
})

test_that("validate_args() accepts integerish arguments", {
  expect_no_error(
    validate_args(list(page = 1.0),
      call = rlang::caller_env()
    ),
    class = "gtexr_arg_class_or_length"
  )
})

test_that("validate_args() removes 's$' from pluralised args", {
  expect_equal(
    validate_args(list(geneIds = "CRP"),
      call = rlang::caller_env()
    ),
    list(geneId = "CRP")
  )
})


test_that("validate_args() raises an error for arguments that are not listed by `gtexr_arguments()`", {
  expect_error(
    validate_args(list(unrecognised_arg = "x"), rlang::caller_env()),
    "Unrecognised argument: `unrecognised_arg`"
  )
})

test_that("`validate_args()` raises error if any query parameters are empty", {
  expect_error(
    get_neighbor_gene(),
    "Identified 3 missing arguments with no default values provided:"
  )
})

test_that(".onLoad sets default options correctly", {
  # Ensure the option is NOT set initially
  prev_option <- getOption("gtexr.verbose", NULL)
  if (!is.null(prev_option)) options(gtexr.verbose = NULL)

  # Simulate package loading
  gtexr:::.onLoad(libname = NULL, pkgname = "gtexr")

  # Check that the option is set
  expect_true(getOption("gtexr.verbose"))

  # Restore previous state
  options(gtexr.verbose = prev_option)
})

test_that(".onLoad does not overwrite existing options", {
  # Set a custom value
  options(gtexr.verbose = FALSE)

  # Simulate package loading
  gtexr:::.onLoad(libname = NULL, pkgname = "gtexr")

  # Ensure the value remains unchanged
  expect_false(getOption("gtexr.verbose"))

  # Cleanup
  options(gtexr.verbose = NULL)
})

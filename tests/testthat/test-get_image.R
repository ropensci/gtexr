test_that("`get_image()` returns tibble with expected colnames", {
  skip_if_offline()
  # no `pathologyNotesCategories` column
  result <- get_image(
    tissueSampleIds = "GTEX-1117F-0226",
    page = 0,
    itemsPerPage = 1
  ) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "ageBracket",
      "hardyScale",
      "hide",
      "histologyImageId",
      "pathologyNotes",
      "sampleId",
      "sex",
      "subjectId",
      "tissueSampleId",
      "tissueSiteDetail"
    )
  )

  # `pathologyNotesCategories` column present
  result <- get_image(
    tissueSampleIds = "GTEX-1117F-0526",
    page = 0,
    itemsPerPage = 1
  ) |>
    suppressWarnings()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "ageBracket",
      "hardyScale",
      "hide",
      "histologyImageId",
      "pathologyNotes",
      "pathologyNotesCategories",
      "sampleId",
      "sex",
      "subjectId",
      "tissueSampleId",
      "tissueSiteDetail"
    )
  )

  expect_identical(
    names(result$pathologyNotesCategories),
    c("monckeberg", "sclerotic")
  )
})

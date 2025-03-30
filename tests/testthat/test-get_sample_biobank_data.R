test_that("get_sample_biobank_data() runs without error", {
  skip_if_offline()
  expect_equal(
    get_sample_biobank_data(itemsPerPage = 1) |>
      suppressWarnings() |>
      nrow(),
    1
  )
})

test_that("process_get_sample_biobank_data_resp_json() prints expected message/warning and returns tibble", {
  # get_sample_biobank_data(tissueSiteDetailIds = "Whole_Blood", itemsPerPage =
  # 2)
  mocked_perform_gtex_request_json <- function(...) {
    list(
      page = 0,
      pageSize = 2,
      recordsTotal = 72513,
      recordsFiltered = 1329,
      numPages = 665,
      sample = list(
        list(
          materialType = "DNA:DNA Genomic",
          sampleId = "GTEX-1117F-0003-SM-4COJQ",
          sampleIdUpper = "GTEX-1117F-0003-SM-4COJQ",
          sex = "female",
          rin = NULL,
          hasGTExImage = FALSE,
          concentration = 189.67581,
          autolysisScore = NULL,
          analysisRelease = "gtex_v7",
          genotype = "",
          hardyScale = "Slow death",
          pathologyNotes = "",
          subjectId = "GTEX-1117F",
          tissueSiteDetailId = "Whole_Blood",
          hasGenotype = TRUE,
          originalMaterialType = "Whole Blood:Whole Blood",
          aliquotId = "SM-4COJQ",
          tissueSampleId = "GTEX-1117F-0003",
          ageBracket = "60-69",
          brainTissueDonor = TRUE,
          volume = 173.82494,
          hasExpressionData = FALSE,
          hasBRDImage = FALSE,
          tissueSiteDetail = "Whole Blood",
          pathologyNotesCategories = list(),
          amount = 32970.3862927014,
          mass = 0,
          tissueSite = "Blood",
          expression = NULL
        ),
        list(
          materialType = "RNA:Total RNA",
          sampleId = "GTEX-1117F-0005-SM-4COPU",
          sampleIdUpper = "GTEX-1117F-0005-SM-4COPU",
          sex = "female",
          rin = 8.257535,
          hasGTExImage = FALSE,
          concentration = 154,
          autolysisScore = NULL,
          analysisRelease = "gtex_v7",
          genotype = "",
          hardyScale = "Slow death",
          pathologyNotes = "",
          subjectId = "GTEX-1117F",
          tissueSiteDetailId = "Whole_Blood",
          hasGenotype = TRUE,
          originalMaterialType = "Whole Blood:PAXgene Preserved",
          aliquotId = "SM-4COPU",
          tissueSampleId = "GTEX-1117F-0005",
          ageBracket = "60-69",
          brainTissueDonor = TRUE,
          volume = 122.05195,
          hasExpressionData = FALSE,
          hasBRDImage = FALSE,
          tissueSiteDetail = "Whole Blood",
          pathologyNotesCategories = list(),
          amount = 18796.0003,
          mass = NULL,
          tissueSite = "Blood",
          expression = NULL
        )
      )
    )
  }

  testthat::with_mocked_bindings(code = {
    # expected message
    withr::with_options(
      list(gtexr.verbose = TRUE),
      expect_message(
        get_sample_biobank_data(tissueSiteDetailIds = "Whole_Blood", itemsPerPage = 2) |>
          suppressWarnings(),
        "Paging info"
      )
    )

    # expected warning
    expect_warning(
      get_sample_biobank_data(tissueSiteDetailIds = "Whole_Blood", itemsPerPage = 2),
      "get_sample_biobank_data\\(<your_existing_parameters>, itemsPerPage = 100000\\)"
    )

    # expected output
    expect_equal(
      get_sample_biobank_data(tissueSiteDetailIds = "Whole_Blood", itemsPerPage = 2) |>
        suppressWarnings() |>
        nrow(),
      2
    )
  }, perform_gtex_request_json = mocked_perform_gtex_request_json)
})

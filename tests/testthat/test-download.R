test_that("`download()` returns tibble with expected colnames", {
  skip_if_offline()
  result <-
    download(
      materialTypes = "RNA:Total RNA",
      tissueSiteDetailIds = "Prostate",
      pathCategory = "clean_specimens",
      sex = "male",
      ageBrackets = "50-59"
    )

  expect_s3_class(result, "tbl_df")

  expect_true(all(
    names(result) %in%
      c(
        "materialType",
        "sampleId",
        "sampleIdUpper",
        "sex",
        "rin",
        "hasGTExImage",
        "concentration",
        "autolysisScore",
        "analysisRelease",
        "genotype",
        "hardyScale",
        "pathologyNotes",
        "subjectId",
        "tissueSiteDetailId",
        "hasGenotype",
        "originalMaterialType",
        "aliquotId",
        "tissueSampleId",
        "ageBracket",
        "brainTissueDonor",
        "volume",
        "hasExpressionData",
        "hasBRDImage",
        "tissueSiteDetail",
        "pathologyNotesCategories",
        "amount",
        "mass",
        "tissueSite",
        "expression"
      )
  ))
})

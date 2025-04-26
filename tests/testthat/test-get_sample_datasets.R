test_that("`get_sample_datasets()` returns tibble with expected colnames",
          {
            skip_if_offline()
            result <- get_sample_datasets(itemsPerPage = 10) |>
              suppressWarnings()

            expect_s3_class(result, "tbl_df")

            expect_true(all(
              names(result) %in%
                c(
                  "ischemicTime",
                  "aliquotId",
                  "tissueSampleId",
                  "tissueSiteDetail",
                  "dataType",
                  "ischemicTimeGroup",
                  "freezeType",
                  "sampleId",
                  "sampleIdUpper",
                  "ageBracket",
                  "hardyScale",
                  "tissueSiteDetailId",
                  "subjectId",
                  "uberonId",
                  "sex",
                  "datasetId",
                  "rin",
                  "pathologyNotesCategories",
                  "pathologyNotes",
                  "autolysisScore"
                )
            ))
          })

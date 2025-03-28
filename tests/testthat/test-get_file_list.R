test_that("`get_file_list()` returns tibble with expected colnames", {
  skip_if_offline()
  result <- get_file_list()

  expect_s3_class(result, "tbl_df")

  expect_identical(
    names(result),
    c(
      "name",
      "subpath",
      "dbgapId",
      "dataset",
      "release",
      "order",
      "type",
      "id",
      "description",
      "filesets"
    )
  )
})


test_that("`get_file_list()` returns tibble with expected output under 'filesets' column", {

  mocked_perform_gtex_request_json <- function(...) {
    list(
      list(
        name = "GTEx Analysis Pilot V3",
        subpath = "gtex_analysis_pilot_v3",
        dbgapId = "phs000424.v3.p1",
        dataset = "GTEx",
        release = "v3",
        order = 10,
        type = "dataset_version",
        id = "gtex_analysis_pilot_v3",
        description = "",
        filesets = list(
          list(
            name = "RNA-Seq Data",
            subpath = "rna_seq_data",
            fileset = NULL,
            dataset = "GTEx",
            release = "v3",
            type = "fileset",
            order = 3,
            description = "",
            files = list(
              list(
                name = "GTEx_Analysis_RNA-seq_Flux1.2.3_intron_fractcovered__Pilot_V3.txt.gz",
                description = "Fraction of intron that is covered by reads.",
                fileset = "RNA-Seq Data",
                dataset = "GTEx",
                release = "v3",
                type = "file",
                order = 2,
                size = "50M"
              )
            )
          )
        )
      )
    )
  }

  testthat::with_mocked_bindings(
    code = {
      file_list <- get_file_list()
    },
    perform_gtex_request_json = mocked_perform_gtex_request_json
    )

  expect_identical(file_list$name, "GTEx Analysis Pilot V3")

  expect_identical(names(file_list$filesets[[1]]), "RNA-Seq Data")

  expect_identical(
    names(file_list$filesets[[1]]$`RNA-Seq Data`$files),
    "GTEx_Analysis_RNA-seq_Flux1.2.3_intron_fractcovered__Pilot_V3.txt.gz"
  )

})

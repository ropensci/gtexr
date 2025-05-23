#' Get Sample (Datasets)
#'
#' @description This service returns information of samples used in analyses
#' from all datasets. Results may be filtered by dataset ID, sample ID, subject
#' ID, sample metadata, or other provided parameters. By default, this service
#' queries the latest GTEx release.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_sample_api_v2_dataset_sample_get)
#'
#' @inheritParams gtexr_arguments
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examplesIf identical(Sys.getenv("IN_PKGDOWN"), "true")
#' get_sample_datasets()
get_sample_datasets <- function(datasetId = "gtex_v8",
                                          sampleIds = NULL,
                                          tissueSampleIds = NULL,
                                          subjectIds = NULL,
                                          ageBrackets = NULL,
                                          sex = NULL,
                                          pathCategory = NULL,
                                          tissueSiteDetailIds = NULL,
                                          aliquotIds = NULL,
                                          autolysisScores = NULL,
                                          hardyScales = NULL,
                                          ischemicTimes = NULL,
                                          ischemicTimeGroups = NULL,
                                          rins = NULL,
                                          uberonIds = NULL,
                                          dataTypes = NULL,
                                          sortBy = "sampleId",
                                          sortDirection = "asc",
                                          page = 0,
                                          itemsPerPage = getOption("gtexr.itemsPerPage"),
                                          .verbose = getOption("gtexr.verbose"),
                                          .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/sample", process_get_sample_datasets_resp_json)
}

process_get_sample_datasets_resp_json <- function(resp_json) {
  resp_json$data |>
    purrr::map(\(x) {
      if (!rlang::is_empty(x$pathologyNotesCategories)) {
        x$pathologyNotesCategories <- tibble::as_tibble(x$pathologyNotesCategories)
      }

      x |>
        purrr::compact() |>
        tibble::as_tibble()
    }, .progress = TRUE) |>
    dplyr::bind_rows()
}

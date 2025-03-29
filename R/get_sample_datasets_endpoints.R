#' Get Sample (Datasets Endpoints)
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
#' @return A tibble
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' \dontrun{
#' get_sample_datasets_endpoints()
#' }
get_sample_datasets_endpoints <- function(datasetId = "gtex_v8",
                                          sampleIds = NULL,
                                          tissueSampleIds = NULL,
                                          subjectIds = NULL,
                                          ageBrackets = NULL,
                                          sex = NULL,
                                          pathCategory = NULL,
                                          tissueSiteDetailId = NULL,
                                          aliquotIds = NULL,
                                          autolysisScores = NULL,
                                          hardyScales = NULL,
                                          ischemicTime = NULL,
                                          ischemicTimeGroups = NULL,
                                          rin = NULL,
                                          uberonIds = NULL,
                                          dataTypes = NULL,
                                          sortBy = NULL,
                                          sortDirection = NULL,
                                          page = NULL,
                                          itemsPerPage = NULL,
                                          .verbose = getOption("gtexr.verbose"),
                                          .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/sample")
}

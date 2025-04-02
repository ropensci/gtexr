#' Get Subject
#'
#' @description This service returns information of subjects used in analyses
#' from all datasets. Results may be filtered by dataset ID, subject ID, sex,
#' age bracket or Hardy Scale. By default, this service queries the latest GTEx
#' release.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_subject_api_v2_dataset_subject_get)
#'
#' @inheritParams gtexr_arguments
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' \dontrun{
#' get_subject()
#' }
get_subject <- function(datasetId = "gtex_v8",
                        sex = NULL,
                        ageBrackets = NULL,
                        hardyScale = NULL,
                        subjectIds = NULL,
                        page = 0,
                        itemsPerPage = getOption("gtexr.itemsPerPage"),
                        .verbose = getOption("gtexr.verbose"),
                        .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/subject")
}

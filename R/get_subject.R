#' Get Subject
#'
#' @description This service returns information of subjects used in analyses
#' from all datasets. Results may be filtered by dataset ID, subject ID, sex,
#' age bracket or Hardy Scale. By default, this service queries the latest GTEx
#' release.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_tissue_site_detail_api_v2_dataset_tissueSiteDetail_get)
#'
#' @inheritParams gtexr_arguments
#' @returns A Tibble
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
                        hardyScales = NULL,
                        subjectIds = NULL,
                        page = 0,
                        itemsPerPage = 250,
                        .verbose = getOption("gtexr.verbose"),
                        .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/subject")
}

#' Get Dataset Info
#'
#' @description [GTEx Portal API
#'   documentation](https://gtexportal.org/api/v2/redoc#tag/Metadata-Endpoints/operation/get_dataset_info_api_v2_metadata_dataset_get)
#'
#' @details Note: this currently only returns empty values.
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble.
#' @export
#' @family Metadata Endpoints
#'
#' @examples
#' \dontrun{
#' get_dataset_info()
#' }
get_dataset_info <- function(datasetId = "gtex_v8",
                             organizationName = "GTEx Consortium",
                             .return_raw = FALSE) {
  gtex_query(endpoint = "metadata/dataset")
}

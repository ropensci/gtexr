#' Get Dataset Info
#'
#' @description [GTEx Portal API
#'   documentation](https://gtexportal.org/api/v2/redoc#tag/Metadata-Endpoints/operation/get_dataset_info_api_v2_metadata_dataset_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Metadata Endpoints
#'
#' @examples
#' \dontrun{
#' get_dataset_info(datasetId = "gtex_v8", organizationName = "GTEx Consortium")
#' }
get_dataset_info <- function(datasetId = NULL,
                             organizationName = NULL,
                             .return_raw = FALSE) {
  gtex_query(endpoint = "metadata/dataset", process_get_dataset_info_resp_json)
}

process_get_dataset_info_resp_json <- function(resp_json) {
  resp_json |>
    purrr::map_df(\(x) x |>
                    purrr::map(\(y) ifelse(is.null(y), NA, y)) |>
                    tibble::as_tibble())
}

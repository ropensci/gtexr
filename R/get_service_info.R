#' Get Service Info
#'
#' @description General information about the GTEx service.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/GTEx-Portal-API-Info/operation/get_service_info_api_v2__get).
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family GTEx Portal API Info
#'
#' @examples
#' \dontrun{
#' get_service_info()
#' }
get_service_info <- function(.return_raw = FALSE) {
  gtex_query(endpoint = NULL, process_get_service_info_resp_json)
}

process_get_service_info_resp_json <- function(resp_json) {
  resp_json |>
    purrr::map_at("organization", tibble::as_tibble) |>
    tibble::as_tibble() |>
    tidyr::unnest(cols = "organization", names_sep = "_")
}

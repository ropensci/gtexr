#' Get Image
#'
#' @description [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Histology-Endpoints/operation/get_image_api_v2_histology_image_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Histology Endpoints
#'
#' @examples
#' \dontrun{
#' get_image()
#'
#' # filter by `tissueSampleId`
#' result <- get_image(tissueSampleIds = "GTEX-1117F-0526")
#' print(result)
#'
#' # note that `pathologyNotesCategories` (if present) is a list column
#' print(result$pathologyNotesCategories)
#' }
get_image <- function(tissueSampleIds = NULL,
                      page = 0,
                      itemsPerPage = getOption("gtexr.itemsPerPage"),
                      .verbose = getOption("gtexr.verbose"),
                      .return_raw = FALSE) {
  gtex_query(endpoint = "histology/image", process_get_image_resp_json)
}

process_get_image_resp_json <- function(resp_json) {
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

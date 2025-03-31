#' Get Annotation
#'
#' @description This service returns the list of annotations and allowed values
#'   by which a particular dataset can be subsetted. Results may be filtered by
#'   dataset.
#'
#'   [GTEx Portal API
#'   documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_annotation_api_v2_dataset_annotation_get)
#'
#' @details Note: the output for this function appears to be incomplete
#' currently.
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' \dontrun{
#' get_annotation()
#' }
get_annotation <- function(datasetId = "gtex_v8",
                           page = 0,
                           itemsPerPage = getOption("gtexr.itemsPerPage"),
                           .verbose = getOption("gtexr.verbose"),
                           .return_raw = FALSE) {

  gtex_query(endpoint = "dataset/annotation", process_get_annotation_resp_json)

}

process_get_annotation_resp_json <- function(resp_json) {
  resp_json$data |>
    purrr::map(
      \(x) x |>
        purrr::map_at("values", \(x) list(as.character(x))) |>
        tibble::as_tibble(),
      .progress = TRUE
    ) |>
    dplyr::bind_rows()
}

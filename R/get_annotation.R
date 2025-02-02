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
#' @return A tibble
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' \dontrun{
#' get_annotation()
#' }
get_annotation <- function(datasetId = "gtex_v8",
                           page = 0,
                           itemsPerPage = 250) {
  result <- gtex_query(
    endpoint = "dataset/annotation",
    return_raw = TRUE
  )

  paging_info_messages(gtex_response_body = result)

  result$data |>
    purrr::map(
      \(x) x |>
        purrr::map_at("values", \(x) list(as.character(x))) |>
        tibble::as_tibble(),
      .progress = TRUE
    ) |>
    dplyr::bind_rows()
}

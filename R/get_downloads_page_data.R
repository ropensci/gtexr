#' Get Downloads Page Data
#'
#' @description Retrieves all the files belonging to the given `project_id` for
#' display on the `Downloads Page`
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_downloads_page_data_api_v2_dataset_openAccessFilesMetadata_get)
#'
#' @details Note: The GTEx Portal API documentation states "GTEx currently has
#' one project available: gtex". However, `project_id` values "adult-gtex" and
#' "egtex" both return results, whereas "gtex" does not (see examples).
#'
#' @inheritParams gtexr_arguments
#'
#' @return A Tibble
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' \dontrun{
#' # "adult-gtex" (default `project_id` value) and "egtex" both return results
#' get_downloads_page_data()
#' egtex <- get_downloads_page_data("egtex")
#' egtex
#'
#' # ..."gtex" does not
#' get_downloads_page_data("gtex")
#'
#' # get details for whole blood methylation data, including download URL
#' purrr::pluck(
#'   egtex$children,
#'   1,
#'   "folders",
#'   "Methylation - EPIC Array",
#'   "children",
#'   "folders",
#'   "mQTLs",
#'   "children",
#'   "files",
#'   "WholeBlood.mQTLs.regular.txt.gz"
#' )
#' }
get_downloads_page_data <- function(project_id = "adult-gtex") {
  result <- gtex_query(
    endpoint = "dataset/openAccessFilesMetadata",
    return_raw = TRUE
  )

  result |>
    purrr::map(name_unnamed_items, name_item = "displayName") |>
    tibble::as_tibble() |>
    tidyr::unnest_wider("data") |>
    dplyr::arrange(dplyr::pick(dplyr::any_of("order")))
}

name_unnamed_items <- function(x, name_item) {
  if (inherits(x, "list")) {
    if (is.null(names(x))) {
      names(x) <- purrr::map_chr(x, \(item) item[[name_item]])
    }
    x <- purrr::map(x, name_unnamed_items, name_item = name_item)
  }

  return(x)
}

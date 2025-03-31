#' Get File List
#'
#' @description Get all the files in GTEx dataset for Download page
#'
#'   [GTEx Portal API
#'   documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_file_list_api_v2_dataset_fileList_get)
#'
#' @details The returned tibble includes a nested list column, "filesets". This
#'   details files, sub-categorised by fileset (see examples section).
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' \dontrun{
#' # Column "filesets" is a list column
#' get_file_list()
#'
#' # Get "GTEx Analysis V9" file list
#' gtex_v9_files <- get_file_list() |>
#'   dplyr::filter(name == "GTEx Analysis V9") |>
#'   dplyr::pull(filesets)
#'
#' # "GTEx Analysis V9" filesets
#' names(gtex_v9_files[[1]])
#'
#' # "GTEx Analysis V9", "snRNA-Seq Data" fileset files
#' names(gtex_v9_files[[1]][["snRNA-Seq Data"]]$files)
#' }
get_file_list <- function(.return_raw = FALSE) {
  gtex_query(endpoint = "dataset/fileList", process_get_file_list_resp_json)
}

process_get_file_list_resp_json <- function(resp_json) {
  resp_json |>
    purrr::map(
      \(x) x |>
        purrr::map_at("filesets", list) |>
        tibble::as_tibble(),
      .progress = TRUE
    ) |>
    dplyr::bind_rows() |>
    # add names to lists ('filesets' and 'files')
    dplyr::mutate("filesets" = purrr::map(.data[["filesets"]], \(x) {
      names(x) <- purrr::map_chr(x, \(y) y$name)
      x <- x |>
        purrr::map(\(x) x |>
                     purrr::map_at("files", \(y) {
                       names(y) <- purrr::map_chr(y, \(z) z$name)
                       y
                     }))
      x
    }))
}

#' Download
#'
#' @description
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Biobank-Data-Endpoints/operation/download_api_v2_biobank_download_get)
#'
#' @details
#' Note: running this request with no filters (i.e. `download()`) raises an error.
#'
#'
#' @inheritParams gtexr_arguments
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Biobank Data Endpoints
#'
#' @examples
#' \dontrun{
#' download(
#'   materialTypes = "RNA:Total RNA",
#'   tissueSiteDetailIds = "Thyroid",
#'   pathCategory = "clean_specimens",
#'   sex = "male",
#'   ageBrackets = "50-59"
#' )
#' }
download <- function(materialTypes = NULL,
                     tissueSiteDetailIds = NULL,
                     pathCategory = NULL,
                     tissueSampleIds = NULL,
                     sex = NULL,
                     sortBy = "sampleId",
                     sortDirection = "asc",
                     searchTerm = NULL,
                     sampleIds = NULL,
                     subjectIds = NULL,
                     ageBrackets = NULL,
                     hardyScales = NULL,
                     hasExpressionData = NULL,
                     hasGenotype = NULL,
                     .return_raw = FALSE) {
  gtex_query(endpoint = "biobank/download", process_download_resp_json)
}

process_download_resp_json <- function(resp_json) {
  resp_json |>
    purrr::map(
      \(x) x |>
        purrr::map_at("pathologyNotesCategories", tibble::as_tibble) |>
        purrr::compact() |>
        tibble::as_tibble(),
      .progress = TRUE
    ) |>
    dplyr::bind_rows()
}

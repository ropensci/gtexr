#' Get Sample (Biobank Data)
#'
#' @description
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Biobank-Data-Endpoints/operation/get_sample_api_v2_biobank_sample_get)
#'
#' @inheritParams gtexr_arguments
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Biobank Data Endpoints
#'
#' @examples
#' \dontrun{
#' get_sample_biobank_data(tissueSiteDetailIds = "Whole_Blood")
#' }
get_sample_biobank_data <- function(draw = NULL,
                                    materialTypes = NULL,
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
                                    page = 0,
                                    itemsPerPage = getOption("gtexr.itemsPerPage"),
                                    .verbose = getOption("gtexr.verbose"),
                                    .return_raw = FALSE) {
  gtex_query(endpoint = "biobank/sample", process_get_sample_biobank_data_resp_json)
}

process_get_sample_biobank_data_resp_json <- function(resp_json) {
  # warn user if not all available results fit on one page
  if ((resp_json$recordsFiltered > resp_json$pageSize)) {
    n_items_exceeds_page_size_warning(as.character(rlang::caller_call(2)[[1]]),
                                      resp_json$recordsFiltered,
                                      resp_json$pageSize)
  }

  # print paging info (retrieve `verbose` from caller function, `gtexr_query()`)
  verbose <- rlang::env_get(env = rlang::caller_env(), nm = "verbose")

  if (verbose) {
  cli::cli_h1("Paging info")
  resp_json |>
    purrr::discard_at("sample") |>
    tibble::as_tibble() |>
    dplyr::rename_with(
      \(x) dplyr::case_match(
        x,
        "numPages" ~ "numberOfPages",
        "pageSize" ~ "maxItemsPerPage",
        "recordsFiltered" ~ "totalNumberOfItems (recordsFiltered)",
        .default = x
      )
    ) |>
    dplyr::select(dplyr::all_of(
      c(
        "numberOfPages",
        "page",
        "maxItemsPerPage",
        "totalNumberOfItems (recordsFiltered)",
        "recordsTotal"
      )
    )) |>
    purrr::imap_chr(\(x, idx) paste(idx, x, sep = " = ")) |>
    purrr::set_names(nm = "*") |>
    cli::cli_bullets()
  }

  resp_json$sample |>
    purrr::map(\(x) x |>
      purrr::compact() |>
      tibble::as_tibble()) |>
    dplyr::bind_rows()
}

#' Get Genomic Features
#'
#' @description [GTEx API Portal
#'   documentation](https://gtexportal.org/api/v2/redoc#tag/Reference-Genome-Endpoints/operation/get_genomic_features_api_v2_reference_features__featureId__get)
#'
#' @details This endpoint takes a path parameter "featureId".
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Reference Genome Endpoints
#'
#' @examples
#' \dontrun{
#' # gene symbol
#' get_genomic_features("brca1")
#'
#' # GENCODE ID
#' get_genomic_features("ENSG00000132693.12")
#'
#' # RSID
#' get_genomic_features("rs1815739")
#'
#' # GTEx variant ID
#' get_genomic_features("chr11_66561023_G_GTTA_b38")
#' }
get_genomic_features <- function(.featureId,
                                 datasetId = "gtex_v8",
                                 .return_raw = FALSE) {
  # validate `.featureId`
  validate_featureId(.featureId)

  # perform query
  gtex_query(
    endpoint = paste0("reference/features/", .featureId),
    process_get_genomic_features_resp_json
  )
}

process_get_genomic_features_resp_json <- function(resp_json) {
  if (rlang::is_empty(resp_json$features)) {
    result <- tibble::tibble(assembly = resp_json$assembly)
  } else {
    result <- tibble::as_tibble(resp_json$features[[1]]) |>
      dplyr::mutate("assembly" = resp_json$assembly)
  }

  return(result)
}

validate_featureId <- function(.featureId) {
  if (!rlang::is_string(.featureId)) {
    cli::cli_abort(
      c(
        "!" = "Invalid `.featureId` input",
        "x" = cli::format_inline(
          "You supplied: {class(.featureId)} of length {length(.featureId)}"
        ),
        "i" = "`.featureId` must be a single string"
      )
    )
  }

  if (grepl("[^a-zA-Z0-9_.]", .featureId)) {
    invalid_characters <- gsub("[a-zA-Z0-9_.]", replacement = "", .featureId)
    invalid_characters <- strsplit(invalid_characters, "")[[1]] |>
      unique()

    error_message <-
      c(
        "!" = "Invalid `.featureId` input",
        "x" = cli::format_inline(
          "Found {length(invalid_characters)} invalid character{?s}: `{paste(invalid_characters, sep = '', collapse = '`, `')}`"
        ),
        "i" = cli::format_inline(
          "`.featureId` can only contain alphanumeric characters, underscores or period ('.') symbols."
        )
      )

    cli::cli_abort(error_message)
  }
}

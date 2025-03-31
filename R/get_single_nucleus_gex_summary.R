#' Get Single Nucleus Gex Summary
#'
#' @description Retrieve Summarized Single Nucleus Gene Expression Data.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Expression-Data-Endpoints/operation/get_single_nucleus_gex_summary_api_v2_expression_singleNucleusGeneExpressionSummary_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Expression Data Endpoints
#'
#' @examples
#' \dontrun{
#' # all tissues
#' get_single_nucleus_gex_summary()
#'
#' # filter for specific tissue
#' get_single_nucleus_gex_summary(tissueSiteDetailIds = c(
#'   "Breast_Mammary_Tissue",
#'   "Skin_Sun_Exposed_Lower_leg"
#' ))
#' }
get_single_nucleus_gex_summary <- function(datasetId = "gtex_snrnaseq_pilot",
                                           tissueSiteDetailIds = NULL,
                                           page = 0,
                                           itemsPerPage = getOption("gtexr.itemsPerPage"),
                                           .verbose = getOption("gtexr.verbose"),
                                           .return_raw = FALSE) {
  gtex_query(endpoint = "expression/singleNucleusGeneExpressionSummary")
}

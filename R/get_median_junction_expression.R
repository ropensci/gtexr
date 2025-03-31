#' Get Median Junction Expression
#'
#' @description Find junction gene expression data.
#'
#' - Returns median junction read counts in tissues of a given gene from all known transcripts.
#' - Results may be filtered by dataset or tissue.
#'
#' By default, this service queries the latest GTEx release.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Expression-Data-Endpoints/operation/get_median_junction_expression_api_v2_expression_medianJunctionExpression_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Expression Data Endpoints
#'
#' @examples
#' \dontrun{
#' get_median_junction_expression(gencodeIds = "ENSG00000132693.12")
#' }
get_median_junction_expression <- function(gencodeIds,
                                           datasetId = "gtex_v8",
                                           tissueSiteDetailIds = NULL,
                                           page = 0,
                                           itemsPerPage = getOption("gtexr.itemsPerPage"),
                                           .verbose = getOption("gtexr.verbose"),
                                           .return_raw = FALSE) {
  gtex_query(endpoint = "expression/medianJunctionExpression")
}

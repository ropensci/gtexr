#' Get Median Exon Expression
#'
#' @description Find median exon expression data.
#'
#' - Returns median exon read counts, in tissues, of a collapsed gene model.
#' - Results may be filtered by dataset, gene or tissue, but at least one gene must be provided
#'
#' By default, this service queries the latest GTEx release.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Expression-Data-Endpoints/operation/get_median_exon_expression_api_v2_expression_medianExonExpression_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Expression Data Endpoints
#'
#' @examples
#' \dontrun{
#' # median exon expression values for CRP, filtered for whole blood
#' get_median_exon_expression(
#'   gencodeIds = "ENSG00000132693.12",
#'   tissueSiteDetailIds = "Whole_Blood"
#' )
#' }
get_median_exon_expression <- function(gencodeIds,
                                       datasetId = "gtex_v8",
                                       tissueSiteDetailIds = NULL,
                                       page = 0,
                                       itemsPerPage = getOption("gtexr.itemsPerPage"),
                                       .verbose = getOption("gtexr.verbose"),
                                       .return_raw = FALSE) {
  gtex_query(endpoint = "expression/medianExonExpression")
}

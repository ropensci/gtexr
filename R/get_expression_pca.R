#' Get Expression Pca
#'
#' @description
#' Find gene expression PCA data.
#'
#' - Returns gene expression PCA (principal component analysis) in tissues.
#' - Results may be filtered by tissue, sample, or dataset.
#'
#' By default, the service queries the latest GTEx release.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Expression-Data-Endpoints/operation/get_expression_pca_api_v2_expression_expressionPca_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Expression Data Endpoints
#'
#' @examples
#' \dontrun{
#' get_expression_pca(tissueSiteDetailIds = c(
#'   "Adipose_Subcutaneous",
#'   "Whole_Blood"
#' ))
#'
#' get_expression_pca(
#'   tissueSiteDetailIds = "Adipose_Subcutaneous",
#'   sampleId = "GTEX-1117F-0226-SM-5GZZ7"
#' )
#' }
get_expression_pca <- function(tissueSiteDetailIds,
                               datasetId = "gtex_v8",
                               sampleId = NULL,
                               page = 0,
                               itemsPerPage = getOption("gtexr.itemsPerPage"),
                               .verbose = getOption("gtexr.verbose"),
                               .return_raw = FALSE) {
  gtex_query(endpoint = "expression/expressionPca")
}

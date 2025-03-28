#' Get Sqtl Genes
#'
#' @description Retrieve sGenes (sQTL Genes).
#'
#' - This service returns sGenes (sQTL Genes) from the specified dataset.
#' - Results may be filtered by tissue.
#' - By default, the service queries the latest GTEx release.
#'
#' The retrieved data is split into pages with `items_per_page` entries per page
#'
#' [GTEx Portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_sqtl_genes_api_v2_association_sgene_get).
#'
#' @inheritParams gtexr_arguments
#'
#' @return A tibble.
#' @export
#' @family Static Association Endpoints
#'
#' @examples
#' \dontrun{
#' get_sqtl_genes("Whole_Blood")
#' }
get_sqtl_genes <- function(tissueSiteDetailId,
                           datasetId = "gtex_v8",
                           page = 0,
                           itemsPerPage = 250,
                           .return_raw = FALSE) {
  gtex_query(endpoint = "association/sgene")
}

#' Get Significant Single Tissue Sqtls
#'
#' @description Retrieve Single Tissue sQTL Data.
#'
#' - This service returns single tissue sQTL
#' data for the given genes, from a specified dataset.
#' - Results may be filtered
#' by tissue
#' - By default, the service queries the latest GTEx release.
#'
#' The retrieved data is split into pages with `items_per_page` entries per page
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_significant_single_tissue_sqtls_api_v2_association_singleTissueSqtl_get).
#'
#' @inheritParams gtexr_arguments
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Static Association Endpoints
#'
#' @examples
#' \dontrun{
#' # search by gene
#' get_significant_single_tissue_sqtls(gencodeIds = c(
#'   "ENSG00000065613.9",
#'   "ENSG00000203782.5"
#' ))
#' }
get_significant_single_tissue_sqtls <- function(gencodeIds = NULL,
                                                variantIds = NULL,
                                                tissueSiteDetailIds = NULL,
                                                datasetId = "gtex_v8",
                                                page = 0,
                                                itemsPerPage = getOption("gtexr.itemsPerPage"),
                                                .verbose = getOption("gtexr.verbose"),
                                                .return_raw = FALSE) {
  gtex_query(endpoint = "association/singleTissueSqtl")
}

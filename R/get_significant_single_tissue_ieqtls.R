#' Get Significant Single Tissue Ieqtls
#'
#' @description Retrieve Interaction eQTL Data.
#'
#' - This service returns cell type interaction eQTLs (ieQTLs), from a specified dataset.
#' - Results may be filtered by tissue
#' - By default, the service queries the latest GTEx release.
#'
#' The retrieved data is split into pages with `items_per_page` entries per page
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_significant_single_tissue_ieqtls_api_v2_association_singleTissueIEqtl_get)
#'
#' @inheritParams gtexr_arguments
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Static Association Endpoints
#'
#' @examples
#' \dontrun{
#' get_significant_single_tissue_ieqtls(c(
#'   "ENSG00000132693.12",
#'   "ENSG00000203782.5"
#' ))
#' }
get_significant_single_tissue_ieqtls <- function(gencodeIds,
                                                 variantIds = NULL,
                                                 tissueSiteDetailIds = NULL,
                                                 datasetId = "gtex_v8",
                                                 page = 0,
                                                 itemsPerPage = getOption("gtexr.itemsPerPage"),
                                                 .verbose = getOption("gtexr.verbose"),
                                                 .return_raw = FALSE) {
  gtex_query(endpoint = "association/singleTissueIEqtl")
}

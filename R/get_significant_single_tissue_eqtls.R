#' Get Significant Single Tissue Eqtls
#'
#' @description Find significant single tissue
#' eQTLs.
#'
#' - This service returns precomputed significant single tissue eQTLs.
#' - Results may be filtered by tissue, gene, variant or dataset.
#' - To search by gene, use the versioned GENCODE ID.
#' - To search by variant, use the dbSNP rs ID (snpId).
#'
#' By default, the service queries the latest GTEx release and the retrieved data is split into pages with `items_per_page` entries per page
#'
#' [GTEx Portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_significant_single_tissue_eqtls_api_v2_association_singleTissueEqtl_get).
#'
#' @details
#' **Note:** although the GTEx Portal API documentation says to use the dbSNP rsID
#' when searching by variant, this returns no results. Instead use gtex variant
#' IDs e.g. use "chr1_153209640_C_A_b38" instead of "rs1410858".
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Static Association Endpoints
#'
#' @examples
#' \dontrun{
#' # search by gene
#' get_significant_single_tissue_eqtls(gencodeIds = c(
#'   "ENSG00000132693.12",
#'   "ENSG00000203782.5"
#' ))
#'
#' # search by variant - must be variantId (not rsid)
#' get_significant_single_tissue_eqtls(variantIds = "chr1_153209640_C_A_b38")
#'
#' # filter by gene/variant and tissue site - either `gencodeIds` or `variantIds`
#' # should be supplied as a minimum
#' get_significant_single_tissue_eqtls(
#'   gencodeIds = c(
#'     "ENSG00000132693.12",
#'     "ENSG00000203782.5"
#'   ),
#'   variantIds = "chr1_153209640_C_A_b38",
#'   tissueSiteDetailIds = "Whole_Blood"
#' )
#' }
get_significant_single_tissue_eqtls <- function(gencodeIds = NULL,
                                                variantIds = NULL,
                                                tissueSiteDetailIds = NULL,
                                                datasetId = "gtex_v8",
                                                page = 0,
                                                itemsPerPage = getOption("gtexr.itemsPerPage"),
                                                .verbose = getOption("gtexr.verbose"),
                                                .return_raw = FALSE) {
  gtex_query(endpoint = "association/singleTissueEqtl")
}

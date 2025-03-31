#' Get Independent Eqtl
#'
#' @description Retrieve Independent eQTL Data
#'
#' - Finds and returns `Independent eQTL Data` data for the provided list of genes
#' - By default, this endpoint fetches data from the latest `GTEx` version
#'
#' The retrieved data is split into pages with `items_per_page` entries per page
#'
#' [GTEx portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_independent_eqtl_api_v2_association_independentEqtl_get)
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
#' get_independent_eqtl(gencodeIds = c(
#'   "ENSG00000132693.12",
#'   "ENSG00000203782.5"
#' ))
#'
#' # optionally filter for a single variant and/or one or more tissues
#' get_independent_eqtl(
#'   gencodeIds = c(
#'     "ENSG00000132693.12",
#'     "ENSG00000203782.5"
#'   ),
#'   tissueSiteDetailIds = c(
#'     "Whole_Blood",
#'     "Thyroid"
#'   )
#' )
#' }
get_independent_eqtl <- function(gencodeIds,
                                 tissueSiteDetailIds = NULL,
                                 datasetId = "gtex_v8",
                                 page = 0,
                                 itemsPerPage = getOption("gtexr.itemsPerPage"),
                                 .verbose = getOption("gtexr.verbose"),
                                 .return_raw = FALSE) {
  gtex_query(endpoint = "association/independentEqtl")
}

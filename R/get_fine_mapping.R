#' Get Fine Mapping
#'
#' @description Retrieve Fine Mapping Data
#'
#' - Finds and returns `Fine Mapping` data for the provided list of genes
#' - By default, this endpoint fetches data from the latest `GTEx` version
#'
#' The retrieved data is split into pages with `items_per_page` entries per page
#'
#' [GTEx Portal API
#'  documentation](https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_fine_mapping_api_v2_association_fineMapping_get)
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
#' get_fine_mapping(gencodeIds = c(
#'   "ENSG00000132693.12",
#'   "ENSG00000203782.5"
#' ))
#'
#' # optionally filter for a single variant and/or one or more tissues
#' get_fine_mapping(
#'   gencodeIds = c(
#'     "ENSG00000132693.12",
#'     "ENSG00000203782.5"
#'   ),
#'   variantId = "chr1_153228363_A_G_b38",
#'   tissueSiteDetailIds = c(
#'     "Whole_Blood",
#'     "Thyroid"
#'   )
#' )
#' }
get_fine_mapping <- function(gencodeIds,
                             datasetId = "gtex_v8",
                             variantId = NULL,
                             tissueSiteDetailIds = NULL,
                             page = 0,
                             itemsPerPage = getOption("gtexr.itemsPerPage"),
                             .verbose = getOption("gtexr.verbose"),
                             .return_raw = FALSE) {
  gtex_query(endpoint = "association/fineMapping")
}

#' Get Gwas Catalog By Location
#'
#' @description Find the GWAS Catalog on a certain chromosome between start and
#' end locations.
#'
#' [GTEx API Portal
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Reference-Genome-Endpoints/operation/get_gwas_catalog_by_location_api_v2_reference_gwasCatalogByLocation_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Reference Genome Endpoints
#'
#' @examples
#' \dontrun{
#' get_gwas_catalog_by_location(start = 1, end = 10000000, chromosome = "chr1")
#' }
get_gwas_catalog_by_location <- function(start,
                                         end,
                                         chromosome,
                                         page = 0,
                                         itemsPerPage = getOption("gtexr.itemsPerPage"),
                                         .verbose = getOption("gtexr.verbose"),
                                         .return_raw = FALSE) {
  gtex_query(endpoint = "reference/gwasCatalogByLocation")
}

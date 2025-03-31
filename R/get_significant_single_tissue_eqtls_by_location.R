#' Get Significant Single Tissue eQTLs By Location
#'
#' @description
#' Find significant single tissue eQTLs using Chromosomal Locations.

#' - This service returns precomputed significant single tissue eQTLs.
#' - Results may be filtered by tissue, and/or dataset.
#'
#' By default, the service queries the latest GTEx release. Since this endpoint
#' is used to support a third party program on the portal, the return structure
#' is different from other endpoints and is not paginated.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_significant_single_tissue_eqtls_api_v2_association_singleTissueEqtl_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Static Association Endpoints
#'
#' @examples
#' \dontrun{
#' get_significant_single_tissue_eqtls_by_location(
#'   tissueSiteDetailId = "Artery_Aorta",
#'   start = 10000,
#'   end = 250000,
#'   chromosome = "chr11"
#' )
#' }
get_significant_single_tissue_eqtls_by_location <- function(tissueSiteDetailId,
                                                            start,
                                                            end,
                                                            chromosome,
                                                            datasetId = "gtex_v8",
                                                            .return_raw = FALSE) {
  gtex_query(
    endpoint = "association/singleTissueEqtlByLocation",
    process_get_significant_single_tissue_eqtls_by_location_resp_json
  )
}

process_get_significant_single_tissue_eqtls_by_location_resp_json <- function(resp_json) {
  resp_json$singleTissueEqtl |>
    purrr::map(tibble::as_tibble) |>
    dplyr::bind_rows()
}

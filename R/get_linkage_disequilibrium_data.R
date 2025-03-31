#' Get Linkage Disequilibrium Data
#'
#' @description Find linkage disequilibrium (LD) data for a given gene.
#'
#' This endpoint returns linkage disequilibrium data for the cis-eQTLs found
#' associated with the provided gene in a specified dataset. Results are queried
#' by gencode ID. By default, the service queries the latest GTEx release.
#' Specify a dataset ID to fetch results from a different dataset.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_variant_by_location_api_v2_dataset_variantByLocation_get)
#'
#' @inheritParams gtexr_arguments
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' get_linkage_disequilibrium_data(gencodeId = "ENSG00000132693.12")
get_linkage_disequilibrium_data <- function(gencodeId,
                                            datasetId = "gtex_v8",
                                            page = 0,
                                            itemsPerPage = getOption("gtexr.itemsPerPage"),
                                            .verbose = getOption("gtexr.verbose"),
                                            .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/ld", process_linkage_disequilibrium_resp_json)
}

#' Get Linkage Disequilibrium By Variant Data
#'
#' @description Find linkage disequilibrium (LD) data for a given variant
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_linkage_disequilibrium_by_variant_data_api_v2_dataset_ldByVariant_get)
#'
#' @inheritParams gtexr_arguments
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' get_linkage_disequilibrium_by_variant_data("chr1_159245536_C_T_b38")
get_linkage_disequilibrium_by_variant_data <- function(variantId,
                                                       page = 0,
                                                       itemsPerPage = getOption("gtexr.itemsPerPage"),
                                                       .verbose = getOption("gtexr.verbose"),
                                                       .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/ldByVariant", process_linkage_disequilibrium_resp_json)
}

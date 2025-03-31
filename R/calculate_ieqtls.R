#' Calculate Ieqtls
#'
#' @description Calculate your own Cell Specific eQTLs.
#'
#' - This service calculates the gene-variant association for any given pair of gene and variant, which may or may not be significant.
#' - This requires as input a GENCODE ID, GTEx variant ID, and tissue site detail ID.
#'
#' By default, the calculation is based on the latest GTEx release.
#'
#' [GTEx Portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Dynamic-Association-Endpoints/operation/calculate_ieqtls_api_v2_association_dynieqtl_get).
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Dynamic Association Endpoints
#'
#' @examples
#' \dontrun{
#' # perform request
#' calculate_ieqtls(
#'   cellType = "Adipocytes",
#'   tissueSiteDetailId = "Adipose_Subcutaneous",
#'   gencodeId = "ENSG00000203782.5",
#'   variantId = "chr1_1099341_T_C_b38"
#' )
#' }
calculate_ieqtls <-
  function(cellType,
           tissueSiteDetailId,
           gencodeId,
           variantId,
           datasetId = "gtex_v8",
           .return_raw = FALSE) {
    gtex_query(endpoint = "association/dynieqtl",
               process_calculate_ieqtls_resp_json)
  }

process_calculate_ieqtls_resp_json <- function(resp_json) {
  resp_json |>
    purrr::imap(\(x, idx) ifelse(is.list(x),
                                 tibble::tibble(
                                   data = purrr::map_depth(
                                     x,
                                     purrr::pluck_depth(x) - 2,
                                     unlist
                                   )
                                 ),
                                 x
    )) |>
    tibble::as_tibble()
}

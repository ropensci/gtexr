#' Calculate Splicing Quantitative Trait Loci
#'
#' @description
#' [GTEx Portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Dynamic-Association-Endpoints/operation/calculate_splicing_quantitative_trait_loci_api_v2_association_dynsqtl_get).
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Dynamic Association Endpoints
#'
#' @examples
#' \dontrun{
#' # perform request - returns a tibble with a single row
#' calculate_splicing_quantitative_trait_loci(
#'   tissueSiteDetailId = "Whole_Blood",
#'   phenotypeId = "chr1:15947:16607:clu_40980:ENSG00000227232.5",
#'   variantId = "chr1_14677_G_A_b38"
#' )
#' }
calculate_splicing_quantitative_trait_loci <- function(tissueSiteDetailId,
                                                       phenotypeId,
                                                       variantId,
                                                       datasetId = "gtex_v8",
                                                       .return_raw = FALSE) {
  gtex_query(
    "association/dynsqtl",
    process_calculate_splicing_quantitative_trait_loci_resp_json
  )
}

process_calculate_splicing_quantitative_trait_loci_resp_json <- function(resp_json) {
  resp_json$data <- list(tibble::tibble(data = as.numeric(resp_json$data)))
  resp_json$genotypes <- list(tibble::tibble(genotypes = as.integer(resp_json$genotypes)))

  return(tibble::as_tibble(resp_json))
}

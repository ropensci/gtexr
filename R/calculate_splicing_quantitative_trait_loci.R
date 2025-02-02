#' Calculate Splicing Quantitative Trait Loci
#'
#' @description
#' [GTEx Portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Dynamic-Association-Endpoints/operation/calculate_splicing_quantitative_trait_loci_api_v2_association_dynsqtl_get).
#'
#' @inheritParams gtexr_arguments
#'
#' @return A tibble.
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
                                                       datasetId = "gtex_v8") {
  result <- gtex_query("association/dynsqtl", return_raw = TRUE)
  result$data <- list(tibble::tibble(data = as.numeric(result$data)))
  result$genotypes <- list(tibble::tibble(genotypes = as.integer(result$genotypes)))

  result <- tibble::as_tibble(result)

  return(result)
}

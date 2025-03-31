#' Calculate Expression Quantitative Trait Loci
#'
#' @description Calculate your own eQTLs
#'
#' - This service calculates the gene-variant association for any given pair of gene and variant, which may or may not be significant.
#' - This requires as input a GENCODE ID, GTEx variant ID, and tissue site detail ID.
#'
#' By default, the calculation is based on the latest GTEx release.
#'
#' [GTEx Portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Dynamic-Association-Endpoints/operation/calculate_expression_quantitative_trait_loci_api_v2_association_dyneqtl_get).
#'
#' @details Notes on output:
#'
#' * Beta and standard error are recorded in columns `nes` and `error` respectively (see [GTEx FAQs](https://gtexportal.org/home/faq#nes_beta))
#' * `variantId` contains (in order) chromosome, position, reference allele, alternative allele and human genome build separated by underscores. The reference and alternative alleles for "chr1_13550_G_A_b38" for example are "G" and "A" respectively.
#' * See examples for how to calculate minor and alternative allele frequencies.
#'
#' Notes on input:
#'
#' * Argument `variantId` also accepts RSIDs.
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
#' calculate_expression_quantitative_trait_loci(
#'   tissueSiteDetailId = "Whole_Blood",
#'   gencodeId = "ENSG00000203782.5",
#'   variantId = "rs79641866"
#' )
#'
#' # unnest list columns with tidyr::unnest()
#' calculate_expression_quantitative_trait_loci(
#'   tissueSiteDetailId = "Whole_Blood",
#'   gencodeId = "ENSG00000203782.5",
#'   variantId = "rs79641866"
#' ) |>
#'   tidyr::unnest(c("data", "genotypes"))
#'
#' # to calculate minor and alternative allele frequencies
#' calculate_expression_quantitative_trait_loci(
#'   tissueSiteDetailId = "Liver",
#'   gencodeId = "ENSG00000237973.1",
#'   variantId = "rs12119111"
#' ) |>
#'   dplyr::bind_rows(.id = "rsid") |>
#'   tidyr::separate(
#'     col = "variantId",
#'     into = c(
#'       "chromosome",
#'       "position",
#'       "reference_allele",
#'       "alternative_allele",
#'       "genome_build"
#'     ),
#'     sep = "_"
#'   ) |>
#'   # ...then ascertain alternative_allele frequency
#'   dplyr::mutate(
#'     alt_allele_count = (2 * homoAltCount) + hetCount,
#'     total_allele_count = 2 * (homoAltCount + hetCount + homoRefCount),
#'     alternative_allele_frequency = alt_allele_count / total_allele_count
#'   ) |>
#'   dplyr::select(
#'     rsid,
#'     beta = nes,
#'     se = error,
#'     pValue,
#'     minor_allele_frequency = maf,
#'     alternative_allele_frequency,
#'     chromosome:genome_build,
#'     tissueSiteDetailId
#'   )
#' }
calculate_expression_quantitative_trait_loci <- function(tissueSiteDetailId,
                                                         gencodeId,
                                                         variantId,
                                                         datasetId = "gtex_v8",
                                                         .return_raw = FALSE) {
  gtex_query(
    "association/dyneqtl",
    process_calculate_expression_quantitative_trait_loci_resp_json
  )
}

process_calculate_expression_quantitative_trait_loci_resp_json <- function(resp_json) {
  resp_json$data <- list(tibble::tibble(data = as.numeric(resp_json$data)))
  resp_json$genotypes <- list(tibble::tibble(genotypes = as.integer(resp_json$genotypes)))

  return(tibble::as_tibble(resp_json))
}

#' Get Variant
#'
#' @description This service returns information about a variant, including
#'   position, dbSNP RS ID, the reference allele, the alternative allele, and
#'   whether the minor allele frequency is >= 1%. For GTEx v6p, there is also
#'   information about whether the whole exome sequence and chip sequencing data
#'   are available. Results may be queried by GTEx variant ID (variantId), dbSNP
#'   RS ID (snpId) or genomic location (chromosome and pos). Variants are
#'   identified based on the genotype data of each dataset cohort, namely, are
#'   dataset-dependent. Each variant is assigned a unique GTEx variant ID (i.e.
#'   the primary key). Not all variants have a mappable dbSNP RS ID. By default,
#'   this service queries the latest GTEx release.
#'
#'   [GTEx Portal API
#'   documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_variant_api_v2_dataset_variant_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' # search by rsid
#' get_variant(snpId = "rs1410858")
#'
#' # search by variantId
#' get_variant(variantId = "chr1_153209640_C_A_b38")
#'
#' # search by chromosome and position
#' get_variant(
#'   chromosome = "chr1",
#'   pos = 153209600:153209700
#' )
get_variant <- function(snpId = NULL,
                        variantId = NULL,
                        datasetId = "gtex_v8",
                        chromosome = NULL,
                        poss = NULL,
                        page = 0,
                        itemsPerPage = getOption("gtexr.itemsPerPage"),
                        .verbose = getOption("gtexr.verbose"),
                        .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/variant")
}

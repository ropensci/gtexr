#' Get Genes
#'
#' @description This service returns information about reference genes. A genome
#' build and GENCODE version must be provided.
#'
#' - Genes are searchable by gene symbol, GENCODE ID and versioned GENCODE ID.
#' - Versioned GENCODE ID is recommended to ensure unique ID matching.
#' - By default, this service queries the genome build and GENCODE version used by the latest GTEx release.
#'
#' [GTEx API Portal
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Reference-Genome-Endpoints/operation/get_genes_api_v2_reference_gene_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Reference Genome Endpoints
#'
#' @examples
#' \dontrun{
#' get_genes(c("CRP", "IL6R"))
#' }
get_genes <- function(geneIds,
                      gencodeVersion = "v26",
                      genomeBuild = "GRCh38/hg38",
                      page = 0,
                      itemsPerPage = getOption("gtexr.itemsPerPage"),
                      .verbose = getOption("gtexr.verbose"),
                      .return_raw = FALSE) {
  gtex_query(endpoint = "reference/gene")
}

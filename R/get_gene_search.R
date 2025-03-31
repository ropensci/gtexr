#' Get Gene Search
#'
#' @description Find genes that are partial or complete match of a gene_id
#'
#' - gene_id could be a gene symbol, a gencode ID, or an Ensemble ID
#' - Gencode Version and Genome Build must be specified
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Reference-Genome-Endpoints/operation/get_gene_search_api_v2_reference_geneSearch_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Reference Genome Endpoints
#'
#' @examples
#' \dontrun{
#' get_gene_search("CRP")
#' }
get_gene_search <- function(geneId,
                            gencodeVersion = "v26",
                            genomeBuild = "GRCh38/hg38",
                            page = 0,
                            itemsPerPage = getOption("gtexr.itemsPerPage"),
                            .verbose = getOption("gtexr.verbose"),
                            .return_raw = FALSE) {
  gtex_query(endpoint = "reference/geneSearch")
}

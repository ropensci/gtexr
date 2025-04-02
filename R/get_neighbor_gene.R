#' Get Neighbor Gene
#'
#' @description Find all neighboring genes on a certain chromosome around a
#' position with a certain window size.
#'
#' [GTEx API Portal
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Reference-Genome-Endpoints/operation/get_neighbor_gene_api_v2_reference_neighborGene_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Reference Genome Endpoints
#'
#' @examples
#' \dontrun{
#' get_neighbor_gene(pos = 1000000, chromosome = "chr1", bp_window = 10000)
#' }
get_neighbor_gene <- function(pos,
                              chromosome,
                              bp_window,
                              page = 0,
                              gencodeVersion = "v26",
                              genomeBuild = "GRCh38/hg38",
                              itemsPerPage = getOption("gtexr.itemsPerPage"),
                              .verbose = getOption("gtexr.verbose"),
                              .return_raw = FALSE) {
  gtex_query(endpoint = "reference/neighborGene")
}

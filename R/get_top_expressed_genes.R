#' Get Top Expressed Genes
#'
#' @description Find top expressed genes for a specified tissue.
#'
#' - Returns top expressed genes for a specified tissue in a dataset, sorted by median expression.
#' - When the optional parameter filterMtGene is set to true, mitochondrial genes will be excluded from the results.
#' By default, this service queries the latest GTEx release.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Expression-Data-Endpoints/operation/get_top_expressed_genes_api_v2_expression_topExpressedGene_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Expression Data Endpoints
#'
#' @examples
#' \dontrun{
#' get_top_expressed_genes(tissueSiteDetailId = "Artery_Aorta")
#' }
get_top_expressed_genes <- function(tissueSiteDetailId,
                                    datasetId = "gtex_v8",
                                    filterMtGene = TRUE,
                                    page = 0,
                                    itemsPerPage = getOption("gtexr.itemsPerPage"),
                                    .verbose = getOption("gtexr.verbose"),
                                    .return_raw = FALSE) {
  gtex_query(endpoint = "expression/topExpressedGene")
}

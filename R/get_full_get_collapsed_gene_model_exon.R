#' Get Full Get Collapsed Gene Model Exon
#'
#' @description This service allows the user to query the full Collapsed Gene
#' Model Exon of a specific gene by gencode ID
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_full_get_collapsed_gene_model_exon_api_v2_dataset_fullCollapsedGeneModelExon_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' \dontrun{
#' get_full_get_collapsed_gene_model_exon(gencodeId = "ENSG00000203782.5")
#' }
get_full_get_collapsed_gene_model_exon <- function(gencodeId,
                                                   datasetId = "gtex_v8",
                                                   page = 0,
                                                   itemsPerPage = getOption("gtexr.itemsPerPage"),
                                                   .verbose = getOption("gtexr.verbose"),
                                                   .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/fullCollapsedGeneModelExon")
}

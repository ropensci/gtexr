#' Get Collapsed Gene Model Exon
#'
#' @description This service returns the collapsed exons in the gene model of
#' the given gene. Gene-level and exon-level expression quantification were
#' based on the GENCODE annotation, collapsed to a single transcript model for
#' each gene using an algorithm developed by the GTEx analysis team.
#'
#' By default, this service queries the models used by the latest GTEx release.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_collapsed_gene_model_exon_api_v2_dataset_collapsedGeneModelExon_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' \dontrun{
#' get_collapsed_gene_model_exon(gencodeId = "ENSG00000132693.12")
#' }
get_collapsed_gene_model_exon <- function(gencodeId,
                                          datasetId = "gtex_v8",
                                          page = 0,
                                          itemsPerPage = getOption("gtexr.itemsPerPage"),
                                          .verbose = getOption("gtexr.verbose"),
                                          .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/collapsedGeneModelExon")
}

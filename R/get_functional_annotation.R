#' Get Functional Annotation
#'
#' @description This endpoint retrieves the functional annotation of a certain
#' chromosome location. Default to most recent dataset release.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_full_get_collapsed_gene_model_exon_api_v2_dataset_fullCollapsedGeneModelExon_get)
#'
#' @inheritParams gtexr_arguments
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' \dontrun{
#' get_functional_annotation(chromosome = "chr1", start = 192168000, end = 192169000)
#' }
get_functional_annotation <- function(datasetId = "gtex_v8",
                                      chromosome,
                                      start,
                                      end,
                                      page = 0,
                                      itemsPerPage = getOption("gtexr.itemsPerPage"),
                                      .verbose = getOption("gtexr.verbose"),
                                      .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/functionalAnnotation")
}

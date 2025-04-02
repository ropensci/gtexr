#' Get Exons
#'
#' @description
#' This service returns exons from all known transcripts of the given gene.
#'
#' - A versioned GENCODE ID is required to ensure that all exons are from a single gene.
#' - A dataset ID or both GENCODE version and genome build must be provided.
#' - Although annotated exons are not dataset dependent, specifying a dataset here is equivalent to specifying the GENCODE version and genome build used by that dataset.
#'
#' [GTEx Portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Reference-Genome-Endpoints/operation/get_exons_api_v2_reference_exon_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Reference Genome Endpoints
#'
#' @examples
#' \dontrun{
#' get_exons(gencodeIds = c("ENSG00000132693.12", "ENSG00000203782.5"))
#' }
get_exons <- function(gencodeIds,
                      gencodeVersion = NULL,
                      genomeBuild = NULL,
                      datasetId = "gtex_v8",
                      page = 0,
                      itemsPerPage = getOption("gtexr.itemsPerPage"),
                      .verbose = getOption("gtexr.verbose"),
                      .return_raw = FALSE) {
  gtex_query(endpoint = "reference/exon")
}
